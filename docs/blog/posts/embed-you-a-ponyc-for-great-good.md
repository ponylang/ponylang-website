---
date: 2026-04-14T08:00:00-04:00
title: "Embed You a ponyc for Great Good"
authors:
  - seantallen
categories:
  - Engineering
draft: false
---

The `ponyc` command you run every day is a `main()` function with a terminal-width detector glued to it. The actual compiler is a library called libponyc. ponyc is a wrapper around that library, and the wrapper is [149 lines of C](https://github.com/ponylang/ponyc/blob/main/src/ponyc/main.c).

That's the setup for this post. The Pony compiler is a library and you can link against it. And because you can link against it, you can build your own tools. And if you want your tool to be one binary instead of a ball of loose dependencies, you want libponyc-standalone.

<!-- more -->

## libponyc-standalone: the compiler in a bag

libponyc is the library ponyc wraps. On its own, it isn't enough to compile a Pony program. It pulls in LLVM. It pulls in the Pony runtime. It pulls in a handful of other things that ponyc would otherwise link in on its own. Build a tool against libponyc the hard way and you'd be reproducing ponyc's link line by hand, then keeping it in sync as the compiler's dependencies change. No thanks.

libponyc-standalone does the bundling for you. It's one static `.a` with everything you need inside it: libponyc, LLVM, the supporting libraries. Link against it and you get a self-contained binary[^1]. No shared libraries to ship alongside. No "works on my machine because I happen to have the right LLVM installed."

Static because self-contained binaries are next to godliness and dynamic linking is the Devil's plaything.

The API is C, which means the wrapper you put on top can be whatever you want. Write it in C. Write it in Rust. Write it in Go. Write it in Pony. The `.a` doesn't care.

What we wrote it in was Pony.

## The prettier half

libponyc-standalone is technically just the `.a`. The interesting part is what's on top of it. Call it the other half of libponyc-standalone: a Pony wrapper that gives you a real API to the compiler's internals.

The wrapper is Mathias's pony-ast. I'd started something similar years ago and never got it over the line. His was better.

It lives in the ponyc repo at [`tools/lib/ponylang/pony_compiler/`](https://github.com/ponylang/ponyc/tree/main/tools/lib/ponylang/pony_compiler). The basic shape looks like this:

```pony
match Compiler.compile(source_dir, [pony_path]
  where limit = PassFinaliser)
| let p: Program =>
  // walk packages → modules → AST
| let e: Array[Error] val =>
  // do something with the errors
end
```

The return type is `Program` on success, `Array[Error] val` on failure. Errors are a real type, with file, position, and a message. Not strings you grep. Not an `errno` you decode. Data.

`limit = PassFinaliser` is where you tell the compiler how far down the pipeline to run. The compiler is a sequence of passes — parse, typecheck, finalize, codegen — and not every tool wants the whole thing. A language server wants to stop after typecheck so it can surface errors fast. A documentation generator doesn't need codegen. The `limit` parameter says "stop here." Pick your pass, pay for what you use.

The `Program` itself is a tree: a program has packages, a package has modules, a module has an AST. Walk it however you like.

That's the whole entry point. Ten lines of it covers what most tools need to get started.

## Why it's still private

The wrapper is private today. You'll notice it's under `tools/lib/` in ponyc rather than in the standard library, which is where an API like this belongs long-term.

That's deliberate. The API is in flux. We're actively developing it while we build tools on top of it, and every tool we build surfaces something that should be different. Putting it in the standard library means committing to the API as it stands, and we're not ready to commit. Better to land it in stdlib once with something good than to land it three times while we figure out what good looks like.

The outer shape — the `Compiler.compile` / `Program` / `Error` layer the snippet above shows — is probably stable. The deeper bits, the parts you'd reach for if you were doing something the existing tools don't, are what's moving.

It'll migrate to the standard library eventually.

## What's next

The Pony ecosystem has three tools that need access to the Pony compiler:

- [pony-lsp](../../use/pony-lsp.md), a language server
- [pony-lint](../../use/linting.md), a linter
- [pony-doc](../../use/documentation.md), a documentation generator

Each of them gets its own post in the coming weeks. Each uses the wrapper a little differently. The LSP runs compilations as actors and reacts to what comes back. The linter walks ASTs looking for patterns. The doc generator walks typed declarations. The wrapper is common. But perhaps you won't find what each tool does with it so common now.

libponyc-standalone has been sitting in ponyc for a long time. We're finally doing something with it.

Before we close, let me address the elephant in the room. Some folks might have noticed this is the second "for great good" post I've done in a short period of time. Some people might say that's too much. I say [too much is never enough](https://www.youtube.com/watch?v=WY6vKtC695I).

[^1]: As much as possible on macOS.
