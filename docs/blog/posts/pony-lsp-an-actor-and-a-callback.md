---
date: 2026-04-25T08:00:00-04:00
title: "pony-lsp: An Actor and a Callback"
authors:
  - seantallen
categories:
  - ponyc
draft: false
---

[Embed You a ponyc for Great Good](/blog/posts/embed-you-a-ponyc-for-great-good.md) introduced libponyc-standalone, a static compiler library you can link your tools against, and a Pony wrapper called pony-ast that exposes the compiler as a callable function. This post is about the Pony language server we built on top of it.

A quick disclaimer before I get going. Almost none of pony-lsp is my work. Matthias Wahl built it from scratch. He wrote the actor architecture, the message dispatch, and the original feature set. He also wrote pony-ast. Orien Madgwick has been pushing it forward; most of the new features over the past several months are his. My contribution is mostly fixing things that broke when I imported the project into ponyc, plus a small feature here and there. The clever stuff is theirs.

<!-- more -->

## A compiler is a function. An LSP is a service.

pony-ast hands you the compiler as a function:

```pony
match Compiler.compile(source_dir, [pony_path] where limit = PassFinaliser)
| let p: Program => // walk the AST
| let e: Array[Error] val => // do something with errors
end
```

Call it. Get a result. Done.

A language server is a different shape entirely. The editor opens a file. The user types. The user saves. The user opens another file. Each event might want a fresh look from the compiler. The compiler doesn't care that ten requests are queued behind it; it only knows how to compile once, return, and get out of the way.

There's also a less obvious problem. libponyc isn't fully thread-safe. So if a language server tried to call `Compiler.compile` from two threads at the same time, you'd get a sad afternoon and possibly a very interesting core dump.

The bridge between "function" and "service" in pony-lsp is an actor.

## The compiler as an actor

The actor lives at [`tools/pony-lsp/compiler_notify.pony`](https://github.com/ponylang/ponyc/blob/main/tools/pony-lsp/compiler_notify.pony). Here's the heart of it:

```pony
actor PonyCompiler is LspCompiler
  be compile(
    package: FilePath,
    paths: Array[String val] val,
    notify: CompilerNotify tag)
  =>
    let result =
      Compiler.compile(
        package,
        paths
        where limit = PassFinaliser)
    let run_id = _run_id_gen = _run_id_gen + 1
    notify.done_compiling(package, result, run_id)
```

`PonyCompiler` is the actor. `CompilerNotify` is the callback interface the language server implements to receive results. Behaviors are asynchronous, so instead of "call the compiler and block until it answers," the language server says "please compile this" and goes back to handling editor messages. The compiler delivers the result by calling `notify.done_compiling(...)` when it's done.

The actor model gets you the threading story for free. Behaviors on the same actor run one at a time. If two `compile` requests arrive back-to-back, the second one waits in the mailbox while the first one runs. No locks. No mutex around libponyc. Pony's runtime serializes calls because that's just what actors do. The same property that makes Pony nice for distributed systems makes it nice for wrapping a compiler that's allergic to concurrency.

Even with threading sorted, you don't want to run codegen on every keystroke. That's what `limit = PassFinaliser` is for. The compiler is a pipeline of passes: parse, typecheck, finalize, codegen. A language server doesn't want codegen. It wants to know whether the program is well-formed and what the types are. The wrapper lets you stop where you want, so the LSP stops at finalize and pays for what it uses.

## Yesterday's news

One more detail from the snippet matters: `run_id`. Each compile gets a fresh one:

```pony
let run_id = _run_id_gen = _run_id_gen + 1
notify.done_compiling(package, result, run_id)
```

The user types fast. By the time a compile finishes, the file might have changed three times and another compile is already queued. Diagnostics from the old compile are wrong. Inlay hints from the old compile are wrong. Anything calculated from a stale `Program` is wrong.

The run id tells the language server which compile a result came from. The language server tracks the latest id it dispatched and ignores any earlier results that come back. It doesn't get faster, but it stops showing you yesterday's news.

## Errors come back as data

When a compile fails:

```pony
match result
| let p: Program => // hand off to feature handlers
| let errors: Array[Error] val =>
  for err in errors.values() do
    // err.file, err.position, err.msg → LSP Diagnostic
  end
end
```

Errors come back as data, not strings. The LSP layer is where that matters. Each `Error` already has a file, a position, and a message. The translation to an LSP `Diagnostic` is a few lines of mapping code. No regex over compiler output. No grep for "error:" prefixes. The shape was already what we needed.

Hover, go-to-definition, all the rest. They run on that same `Program` tree. The AST is the substrate.

## What's next

pony-lsp has to deal with the LSP protocol and editors and clients that disagree about what year it is.

Next time, pony-lint. Take the same wrapper, throw away most of the machinery, walk the AST looking for things you don't want to see.

Same wrapper. Different tool. Smaller surface. Smaller post.
