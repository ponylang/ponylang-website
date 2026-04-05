---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - April 5, 2026"
date: 2026-04-05T07:00:06-04:00
---

This week's theme song was pulled directly from the pool of "things to appeal to Sean musically." I give you ["Apocalypse"](https://www.youtube.com/watch?v=LzcAYisf6J8) by The Darts. Man, this one is great. Big week to go with it. ponyc 0.63.0 is out and you need to update. ponylang/hobby threw out its middleware and rebuilt around interceptors. And there's a whole repo of Claude Code skills for Pony. Three big things and I'm excited about every one of them. Let's go.

<!-- more -->

## ponyc 0.63.0

[ponyc](https://github.com/ponylang/ponyc) 0.63.0 has a pile of bug fixes, a new testing feature, and a couple of breaking changes. Update as soon as possible.

The headliner is a segfault in `Generator.map`. If you used `map` to transform a generator's output type and a property test failed, shrinking would crash. The compiler bug was subtle: when a lambda appeared inside an object literal inside a generic method and was passed to another generic method, its `apply` was silently dropped from the vtable. That's the kind of bug that hides until exactly the wrong combination of generics lines up.

Windows safety work continues from 0.62.1. That release introduced a token mechanism to prevent IOCP callbacks from accessing freed events, but it missed two windows where raw pointers could outlive the event. Those are fixed. There was also a memory leak in the networking subsystem: an IOCP token's reference count wasn't decremented during backpressure, so under sustained traffic, memory just kept growing.

Beyond those, a few things that were quietly wrong for a while. `with (a, b) = (D.create(), D.create())` only generated a dispose call for the first binding — the rest were silently skipped, and `_` in a later position was incorrectly accepted. `FloatingPoint.frexp` was returning the exponent as `U32` when C's `frexp` writes a signed `int`, so negative exponents came back as large positive values (now `(A, I32)`). And float `min` and `max` gave different results depending on argument order because IEEE 754 comparisons with NaN return `false` and the conditional fell through inconsistently. Both now use LLVM intrinsics that propagate NaN properly. The `frexp` and NaN changes are technically breaking, but the old behavior was wrong.

If you've been working around the spurious error when assigning to a field on an `as` cast in a `try` block, you can drop the `match` workaround.

The docgen pass is removed. `--docs`, `-g`, and `--docs-public` are gone. Use [pony-doc](https://www.ponylang.io/use/documentation/) instead. It shipped in 0.61.0. If you were using `--docs-public`, pony-doc generates public-only docs by default. For private types, use `pony-doc --include-private`.

PonyTest has a new `--shuffle` option that randomizes test dispatch order. This catches bugs where test B only passes because test A ran first and left behind some state. Use `--shuffle` for a random seed or `--shuffle=SEED` for reproducibility. For CI, `--sequential --shuffle` is the recommended combination. This implements [RFC 82](https://github.com/ponylang/rfcs/blob/main/text/0082-shuffle-test-ordering.md).

Alpine 3.20 support is dropped. It hit end-of-life.

See the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.63.0) for the full list.

## ponylang/hobby 0.5.0 and 0.6.0

[ponylang/hobby](https://github.com/ponylang/hobby) shipped two releases this week, both breaking. The framework is better for it.

Middleware is gone. In its place: interceptors. hobby's model since 0.4.0 is that each request gets its own actor — your handler is an actor that receives the request, does whatever async work it needs, and responds when it's ready. Request interceptors run synchronously in the connection *before* that actor is spawned. If an interceptor responds, that's it. No handler, no actor allocation. This is where auth checks, rate limiting, and body size validation live. Response interceptors run after the handler responds but before bytes hit the wire. They get full read/write access to status, headers, and body. CORS headers, security headers, logging: response interceptor territory.

Both flavors register at the application, group, or route level and compose from broadest to narrowest scope. They run on error responses too. An auth interceptor on `/api` rejects unauthenticated requests to `/api/nonexistent` with a 401 instead of leaking your API structure with a 404. The router now distinguishes 404 from 405 and returns a proper `Allow` header.

The way you start a server changed. Route compilation and startup are separate steps now. `Application.build()` validates your routes and returns a `BuiltApplication`. `Server` (or `Server.ssl()` for HTTPS) accepts the validated routes and starts listening. Configuration errors like overlapping group prefixes, conflicting parameters, or segments after a wildcard are caught at build time. You get data back, not a runtime crash. Lifecycle events come through a `ServerNotify` interface instead of printing to an `OutStream`.

HTTPS works. Pass an `SSLContext` to `Server.ssl()` and you're done. If the context is misconfigured, connection failures are logged so you can see what went wrong instead of watching connections silently die.

## ponylang/llm-skills

Back in February I wrote about ["Teaching Claude to Write Pony"](https://www.ponylang.io/blog/2026/02/teaching-claude-to-write-pony/). A lot has happened since then. I've been iterating on skills to make Claude better at Pony development across the board, and [ponylang/llm-skills](https://github.com/ponylang/llm-skills) is where they live. There's plenty in there already and a lot more coming. Clone the repo, run the install script, and [Claude Code](https://docs.anthropic.com/en/docs/claude-code) picks them up automatically. Pull to update, no reinstall needed.

Several of the skills use an [ensemble approach](https://www.seantallen.com/posts/an-ensemble-of-claudes/). **pony-software-design** throws multiple agents at your design problem, each looking at it from a different angle, and synthesizes what they find. Use it when you're deciding what types to create, what a public interface looks like, or where ownership boundaries fall. **pony-code-review** does the same thing for code review, with specialized personas covering correctness, security, performance, and more. There's a full 8-persona mode and a lightweight 3-persona mode. **pony-test-design** does it for test planning, stress-testing the strategy for coverage gaps and weak assertions before you write a single test. The ensemble approach doesn't guarantee great results, but it produces better ones than letting a single agent run with its first instinct.

**pony-ref** is the Pony language reference. Load it at the start of a session and Claude has the actual capability rules, subtyping relationships, and common gotchas in context instead of guessing at them. When Claude needs to go deeper, there's a `references/` directory with the academic papers and distilled synopses of the type system and runtime.

**pony-debug** is a structured debugging protocol. Load it before forming any hypothesis about a bug, especially when you're chasing something subtle like a capability violation or an actor lifecycle issue where the symptoms don't point anywhere obvious. **pony-pbt-patterns** covers property-based testing patterns and maps directly onto PonyCheck.

The repo also includes **pony-release-notes**, **pony-library-readme**, and **pony-examples-readme** for project documentation conventions. Less exciting, but consistency is worth having.

If you're using Claude Code with Pony, [clone the repo](https://github.com/ponylang/llm-skills) and give them a shot.

## Releases

- [ponylang/hobby 0.5.0](https://github.com/ponylang/hobby/releases/tag/0.5.0)
- [ponylang/hobby 0.6.0](https://github.com/ponylang/hobby/releases/tag/0.6.0)
- [ponylang/ponyc 0.63.0](https://github.com/ponylang/ponyc/releases/tag/0.63.0)
- [ponylang/ponyup 0.15.1](https://github.com/ponylang/ponyup/releases/tag/0.15.1)
- [ponylang/release-bot-action 0.6.5](https://github.com/ponylang/release-bot-action/releases/tag/0.6.5)
- [ponylang/stallion 0.5.4](https://github.com/ponylang/stallion/releases/tag/0.5.4)

## RFCs

### Implemented

- [Add --shuffle option to PonyTest](https://github.com/ponylang/rfcs/blob/main/text/0082-shuffle-test-ordering.md)

### New

- [Explain the `\do_not_use\` source code annotation](https://github.com/ponylang/rfcs/pull/226)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
