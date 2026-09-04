---
date: 2026-04-25T08:00:00-04:00
title: "pony-lsp: An Actor and a Callback"
authors:
  - seantallen
categories:
  - ponyc
draft: false
---

[Embed You a ponyc for Great Good](/blog/posts/embed-you-a-ponyc-for-great-good.md) introduced libponyc-standalone, a static compiler library you can link your tools against, and a Pony wrapper called pony-ast that exposes the compiler as a callable function. We built a language server on top of it.

A quick disclaimer before I get going. Almost none of pony-lsp is my work. Matthias Wahl built it from scratch. He wrote the actor architecture, the message dispatch, and the original feature set. He also wrote pony-ast. Orien Madgwick has been pushing it forward; most of the new features over the past several months are his. My contribution is mostly fixing things that broke when I imported the project into ponyc, plus a small feature here and there. The clever stuff is theirs.

<!-- more -->

## Wrapping the compiler in an actor

pony-ast gives you the compiler as a function:

```pony
match Compiler.compile(source_dir, [pony_path] where limit = PassFinaliser)
| let p: Program => // walk the AST
| let e: Array[Error] val => // do something with errors
end
```

Call it, get a result, move on.

A language server is a different shape. The editor opens a file. The user types. The user saves. The user opens another file. Each event might need a fresh compile. But `Compiler.compile` runs once and returns — no queuing, no scheduling.

There's also a less obvious problem. libponyc isn't fully thread-safe. Two threads calling `Compiler.compile` at the same time is a race, and the result is a core dump you'll spend the afternoon reading.

The bridge between "function" and "service" in pony-lsp is an actor.

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

`PonyCompiler` is the actor. `CompilerNotify` is the callback interface the language server implements to receive results. Behaviors are asynchronous — the language server sends a compile request and goes back to handling editor messages. When the compile finishes, `notify.done_compiling(...)` pushes the result back.

Behaviors on the same actor run one at a time. If two `compile` requests arrive back-to-back, the second one waits in the mailbox while the first one runs. No locks. No mutex around libponyc. The runtime serializes the calls. The same property that makes Pony useful for distributed systems makes it useful for wrapping a single-threaded compiler.

Even with the threading sorted, you don't want to run codegen on every keystroke. That's what `limit = PassFinaliser` is for. The compiler is a pipeline of passes: parse, typecheck, finalize, codegen. A language server doesn't need codegen. All it needs from the compiler is whether the program is well-formed and what the types are. The wrapper lets you stop at any pass, so the LSP stops at finalize and only pays for what it uses.

## Yesterday's news

One more detail from the snippet: `run_id`. Each compile gets a fresh one:

```pony
let run_id = _run_id_gen = _run_id_gen + 1
notify.done_compiling(package, result, run_id)
```

The user types fast. By the time a compile finishes, the file might have changed three times and another compile is already queued. Diagnostics from the old compile are wrong. Inlay hints from the old compile are wrong. Anything calculated from a stale `Program` is wrong.

The run id tells the language server which compile a result came from. The language server tracks the latest id it dispatched and ignores anything older. The compile doesn't get faster, but the user stops seeing stale diagnostics.

## Errors as data

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

Errors come back as structured data, not strings. Each `Error` already has a file, a position, and a message. Translating that to an LSP `Diagnostic` is a few lines of mapping code. No regex over compiler output. No grep for "error:" prefixes.

Hover, go-to-definition, and the rest all run on the same `Program` tree. Each feature is a different walk over the AST.

## What's next

pony-lsp also has to deal with the LSP protocol itself and with editors that each implement it a little differently.

Next up: pony-lint. Same compiler wrapper, no protocol machinery. Just walking the AST looking for things you don't want to see.
