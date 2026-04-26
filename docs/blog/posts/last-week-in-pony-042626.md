---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - April 26, 2026"
date: 2026-04-26T07:00:06-04:00
---

This week's theme song is from the man himself, Johnny Cash: ["Take Me Home"](https://www.youtube.com/watch?v=ibxXywM85XE). I've been on the road for two weeks and I'm finally back home, so this one fits.

Plenty to dig into. ponyc 0.63.3 ships another round of pony-lsp work and tightens the runtime's memory ordering on its hottest queues. ponylang/ssl picked up OpenSSL 4.0.x support and the matching builder image is live. There's also Ubuntu 26.04 support, a new blog post on the design of pony-lsp, and a couple of RFC moves to chew on. Let's get into it.

<!-- more -->

## ponyc 0.63.3

[ponyc](https://github.com/ponylang/ponyc) 0.63.3 lands more pony-lsp capability, a defensive change to runtime memory ordering, and fixes for two crashes you don't want to hit.

The runtime change is the one to know about even if you'll never notice it directly. Pony's actor message queues and scheduler MPMC queues used to lean on a C11 release-sequence rule to establish happens-before across threads. C++20 narrowed that rule, and the old code was riding on a compiler interpretation that was getting more fragile over time. It's also a candidate contributor to the rare aarch64 stress-test crashes we've been chasing for years. The push paths now establish happens-before directly via acquire-release atomics. On x86, the generated machine code is mostly identical because x86 atomic read-modify-writes are full barriers regardless of the requested ordering. On aarch64 and other weakly-ordered platforms, the codegen changes but performance shouldn't move. Stronger ordering, no new bugs, less reliance on a brittle reading of the standard. Worth taking.

Two crashes worth naming. The compiler used to fall over with an internal assertion when you passed an array literal directly to anything expecting a `ByteSeqIter`, like `env.out.writev`. Element-type inference was leaving viewpoint arrows on the inferred type, and they reached codegen and tripped the assertion. Fixed. And destructive-reading an `iso` field whose union type also contained a `val` member would corrupt GC tracing and segfault on what should be safe code. Also fixed.

pony-lsp picks up two more capabilities. `textDocument/selectionRange` walks up the AST from the cursor through enclosing expressions, function, class body, and file. Hit Alt+Shift+→ in VS Code and the selection grows by one syntactic unit at a time. `workspace/symbol` does case-insensitive substring search across every type and member in the workspace. Cmd+T in VS Code, "Go to Symbol in Workspace" in others. An empty query returns everything.

A pile of LSP range fixes too. Document outlines used to reject the entire response with "selectionRange must be contained in range" because of a range-semantics mismatch, and they used to include synthesized default constructors and inherited trait methods that were nowhere in the source you were looking at. Symbol ranges in `documentSymbol` and `workspace/symbol` covered only the keyword or only the identifier instead of the whole declaration. `textDocument/definition` and `textDocument/typeDefinition` had the same problem. All fixed: the outline shows what you wrote, and ranges cover the whole declaration so highlighting and jumping select the entity you meant.

See the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.63.3) for the full list.

## OpenSSL 4.0.x

[ponylang/ssl](https://github.com/ponylang/ssl) 2.1.0 adds OpenSSL 4.0.x as a supported backend. Pick it at compile time with `-Dopenssl_4.0.x`, or pass `ssl=4.0.x` to `make` when building the library itself. The library's API is unchanged, so existing code keeps working without modification. The matching shared-docker builder image with OpenSSL 4.0.0 is live, and because it's our first OpenSSL 4.x image, nothing is being retired alongside it. If you've been waiting to try OpenSSL 4 with Pony, you're set.

The same ssl release also drops the `libs` command from `make.ps1` on Windows. CI now downloads prebuilt LibreSSL static libraries from the [LibreSSL GitHub releases](https://github.com/libressl/portable/releases) instead of building from source. If you were running `make.ps1 -Command libs` to build LibreSSL locally, grab the prebuilt binaries from the same place. x86-64 and arm64 are both there.

## Items of Note

### New Blog Post: pony-lsp: An Actor and a Callback

I put up a new blog post, ["pony-lsp: An Actor and a Callback"](https://www.ponylang.io/blog/2026/04/pony-lsp-an-actor-and-a-callback/). It's a writeup of how pony-lsp bridges the synchronous JSON-RPC world that LSP clients expect with Pony's asynchronous actor model. If you've ever wondered how an actor-based language server actually works, give it a read.

### Ubuntu 26.04 Support

[ponylang/ponyup](https://github.com/ponylang/ponyup) 0.15.4 adds Ubuntu 26.04 as a supported platform for ponyc and ponyup. Prebuilt binaries are available via ponyup. We'll keep building releases for it until 2031, when its upstream security support ends.

The same release drops Alpine 3.20, which is about to hit end of life. New ponyup installs on Alpine 3.20 won't recognize the platform, and you'll have to set it manually. ponyc releases past 0.62.1 aren't built for Alpine 3.20, so if you're staying there, you'll need to build from source.

### contact-red/odbc 0.0.3

[contact-red/odbc](https://github.com/contact-red/odbc) 0.0.3 picked up `Statement.parameter_types()` and `Statement.column_types()` for reading prepare-time metadata without executing the statement. Useful when you want a build-time tool to validate SQL against a live database. The release also fixes a use-after-free where closing a statement after its connection was already closed would call `SQLFreeHandle` on a dangling handle.

### Pony Development Sync

The [recording](https://vimeo.com/1186213816) of the April 22, 2026 Pony Development Sync is up. I wasn't able to make this one. According to the AI note taker, the team spent most of the meeting working through RFCs and open pull requests. [RFC 225](https://github.com/ponylang/rfcs/pull/225), which removes the `serialise` package from the standard library, was approved and has moved to its final comment period. [RFC 223](https://github.com/ponylang/rfcs/pull/223), the proposed printing API for the new JSON package, was left in the queue because the team wants me in the room for that one. On [PR 5226](https://github.com/ponylang/ponyc/pull/5226), the "do-not-use" annotation work, the author signaled they'd rather withdraw it and come back with a broader type-hierarchy redesign proposal.

On the PR side, the team reviewed fixes for LSP symbol range semantics, file resolution, and a couple of compiler crashes around match exhaustiveness and `iso` field handling. [PR 5192](https://github.com/ponylang/ponyc/pull/5192), the array-literal-to-`writev` crash fix, was approved and merged in time for 0.63.3. [PR 5147](https://github.com/ponylang/ponyc/pull/5147) was discussed but not merged. There are open concerns about introducing fixtures into the test setup, and the group wants to work through those first.

## Releases

- [contact-red/odbc 0.0.3](https://github.com/contact-red/odbc/releases/tag/0.0.3)
- [ponylang/ponyc 0.63.3](https://github.com/ponylang/ponyc/releases/tag/0.63.3)
- [ponylang/ponyup 0.15.4](https://github.com/ponylang/ponyup/releases/tag/0.15.4)
- [ponylang/ssl 2.1.0](https://github.com/ponylang/ssl/releases/tag/2.1.0)

## RFCs

### Final Comment Period

- [Remove serialise package from stdlib](https://github.com/ponylang/rfcs/pull/225)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
