---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - March 15, 2026"
date: 2026-03-15T07:00:06-04:00
---

What a great week in Pony! So much fun! Let's have two [happy time](https://www.youtube.com/watch?v=XMl6HnhFFIA) [theme songs](https://www.youtube.com/watch?v=dBBh4N8-coc) for this week! We've got a packed ponyc release, BSDs are back in CI, json-ng landed in the standard library, and there's a brand new library for building LiveView UIs. This bunch is ripe for the picking.

<!-- more -->

## ponyc 0.61.1

[ponyc](https://github.com/ponylang/ponyc) 0.61.1 is out. The headliner is a milestone we've been working toward for a while: ponyc now uses its own embedded LLD linker on all three major platforms. Linux, macOS, and Windows builds no longer shell out to an external compiler driver or system linker. You don't need a target-specific GCC cross-compiler installed just for linking, and the whole build pipeline is under our control. If the embedded linker causes issues, `--linker=<command>` is your escape hatch back to the old behavior.

It passes in all our CI, but this is a big change. If you run into problems, let us know.

Beyond the linker work, this release is packed with bug fixes. Two soundness holes were closed: one where generic `recover` blocks could launder non-sendable data into sendable capabilities, and another where sending a union of tuple types could SEGV when one variant had a class reference where another had a machine word. The first is the kind of bug where existing code might be silently wrong. The second will crash your program. Either way, update sooner rather than later.

There's also an exhaustive match fix. If you've been using `\exhaustive\` on tuple matches, the compiler now correctly recognizes concrete types like `(None, None)` as covering the remaining cases. No more `(_, _)` workarounds. The pool allocator got two fixes (AVX alignment crash and large allocation memory return), pony-lsp startup compilation ordering was fixed, and several compiler crashes were resolved.

On the feature side, `json` and `iregex` are now standard library packages (more on that below), there's a new `safety/exhaustive-match` lint rule in pony-lint, and compile-time string literal concatenation means `"a" + "b" + x + "c" + "d"` folds down to `"ab".add(x).add("cd")` with no runtime cost for the literal parts.

See the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.61.1) for the full list. There's a lot more in there.

## json-ng Lands in the Standard Library

[RFC 81](https://github.com/ponylang/rfcs/blob/main/text/0081-json-ng.md) is implemented. The `json` and `iregex` packages are now part of the standard library, shipping with ponyc.

The `json` package gives you immutable JSON values backed by persistent collections, a parser, `JsonNav` for chained reads, `JsonLens` for composable get/set/remove paths, and `JsonPath` for RFC 9535 queries with filters and function extensions. The `iregex` package provides I-Regexp (RFC 9485) pattern matching, a constrained regex syntax designed for interoperability. It powers the JSONPath `match()` and `search()` filter functions, but it's available as a standalone package too.

With this, [ponylang/json](https://github.com/ponylang/json) and [ponylang/json-ng](https://github.com/ponylang/json-ng) have been archived. If you were depending on them as corral packages, switch to the stdlib `use "json"` and `use "iregex"` imports.

## BSDs Are Back

We have FreeBSD CI again. It only runs once a week because we're running in a VM and it takes at least two hours start to finish, but it's better than nothing. Remarkably, both the FreeBSD 14 and 15 tests pass even though we haven't run any CI for them in over two years. I guess we managed to keep our "won't intentionally break" promise.

We've also added OpenBSD 7.8 and DragonFly BSD 6.4.2 as tier 3 targets on the same weekly schedule. The OpenBSD port was particularly smooth. The only changes needed were in the newer tools (pony-lsp, pony-lint, pony-doc) that were added since the last time we touched the OpenBSD code.

## ponylang/livery

[ponylang/livery](https://github.com/ponylang/livery) had its first release this week. It's a library for building interactive, server-rendered LiveView UIs over WebSocket in Pony. You define a `LiveView` class with `mount`, `handle_event`, and `render` callbacks, wire up routes through a `Router`, and livery handles the WebSocket connection, DOM diffing, and event dispatch. Templates use [ponylang/templates](https://github.com/ponylang/templates) with `HtmlTemplate` for contextual auto-escaping, and events flow through `lv-click` style attributes on your HTML elements.

Livery is part of a larger effort. We're building toward a Phoenix-like web framework that will live in [ponylang/pyrois](https://github.com/ponylang/pyrois). That's still early days, but livery is the first piece of the puzzle to ship on its own. The whole thing is bananas in the best possible way.

## Stallion Blog Post

I wrote a [blog post](https://www.ponylang.io/blog/2026/03/stallion-an-http-server-built-different/) about [ponylang/stallion](https://github.com/ponylang/stallion), our HTTP server built on lori. It covers how the embed-and-delegate pattern stacks from TCP through HTTP, how the type system catches response construction mistakes at compile time, and how backpressure works with per-chunk delivery confirmation. There are benchmark numbers in there too. Go read it.

## Pony LLM Skills

We've added a repo of Pony LLM skills for [Claude Code](https://docs.anthropic.com/en/docs/claude-code). Two skills so far:

- **pony-ref**: Pony language reference. Capabilities table, subtyping rules, key patterns, common gotchas, PonyCheck, stdlib pitfalls, and the mort pattern. Also includes the full text of all nine Pony academic papers and website content snapshots as deep reference material.
- **pony-ffi-audit**: Audit methodology for finding dangerous FFI usage. Teaches Claude how to systematically find C-FFI calls that mutate data through pointers with non-mutable reference capabilities.

Check out [ponylang/llm-skills](https://github.com/ponylang/llm-skills) if you want to feed your AI some better Pony context.

## Items of Note

### Pony Development Sync

The [recording](https://vimeo.com/1172735900) of the March 11, 2026 Pony Development Sync is available.

The team reviewed PRs for signal handling redesign, the JSON and IRegex stdlib additions, compiler crash fixes, and type system improvements. A chunk of the discussion focused on error handling through return flags versus unwinding. Performance testing showed the return-flag approach is about 5% faster than the previous method. Joe provided detailed feedback on lambda de-sugaring and tuple type handling challenges. The meeting wrapped up with updates on the embedded LLD migration (now complete across all platforms) and discussion of future work on soundness holes and recursive type aliases.

### Office Hours

Red and I spent most of Office Hours on eBPF and the "pony perf" work Red has been doing, plus some tracing conversations. We also talked about the coming FFI breakage I [mentioned last week](https://www.ponylang.io/blog/2026/03/last-week-in-pony---march-8-2026/#big-ffi-change-coming).

## Releases

- [ponylang/hobby 0.2.1](https://github.com/ponylang/hobby/releases/tag/0.2.1)
- [ponylang/livery 0.1.0](https://github.com/ponylang/livery/releases/tag/0.1.0)
- [ponylang/mare 0.1.1](https://github.com/ponylang/mare/releases/tag/0.1.1)
- [ponylang/mare 0.2.0](https://github.com/ponylang/mare/releases/tag/0.2.0)
- [ponylang/peg 0.1.7](https://github.com/ponylang/peg/releases/tag/0.1.7)
- [ponylang/ponyc 0.61.1](https://github.com/ponylang/ponyc/releases/tag/0.61.1)
- [ponylang/templates 0.3.1](https://github.com/ponylang/templates/releases/tag/0.3.1)
- [ponylang/templates 0.3.2](https://github.com/ponylang/templates/releases/tag/0.3.2)
- [ponylang/zulip-action 0.1.0](https://github.com/ponylang/zulip-action/releases/tag/0.1.0)

## RFCs

### Implemented

- [RFC 81: "json-ng"](https://github.com/ponylang/rfcs/blob/main/text/0081-json-ng.md)

### New

- [Json.print() API in stdlib json package](https://github.com/ponylang/rfcs/pull/223)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
