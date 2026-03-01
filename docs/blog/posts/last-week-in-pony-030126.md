---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - March 1, 2026"
date: 2026-03-01T07:30:00-04:00
---

This week's theme song is Rawhide and it's so good, we are gracing you with [3](https://www.youtube.com/watch?v=YCGeeCIzBs4) [different](https://www.youtube.com/watch?v=rA74JYG8CRg) [versions](https://www.youtube.com/watch?v=RdR6MN2jKYs). And this week calls for multiple versions because it has been a big week:

- ponyc 0.61.0 shipped with a new `\exhaustive\` annotation for match expressions
- Three new libraries hit their first releases
- Eight Pony patterns were published
- The website got a top-to-bottom reorganization

<!-- more -->

## ponyc 0.61.0

[ponyc](https://github.com/ponylang/ponyc) 0.61.0 is out and it's packed.

The headliner is the new `\exhaustive\` annotation for match expressions. Without it, a non-exhaustive match silently compiles with an implicit `else None`. You get an indirect type error about the result type not matching. With `\exhaustive\`, the compiler tells you directly that your match is missing cases:

```pony
match \exhaustive\ p
| T1 => "t1"
| T2 => "t2"
end
// Error: match marked \exhaustive\ is not exhaustive
```

It's also useful on matches that are already exhaustive. If someone later adds a member to the union type and the match isn't updated, the compiler catches the missing case immediately instead of silently injecting `None`. Think of it as protecting your future self.

Other highlights: pony-lsp now finds the standard library on its own (no more `PONYPATH` workarounds), accepts editor-provided settings for `ifdef` defines and package paths, and passes along richer diagnostic information from the compiler. A stack overflow in the reachability pass on deeply nested ASTs was fixed by switching from recursive to iterative traversal. The persistent `HashMap` [bug fix](https://www.ponylang.io/blog/2026/02/last-week-in-pony---february-22-2026/#persistent-hashmap-fix) from last week is now in a release. And the Docker images moved to Alpine 3.23.

See the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.61.0) for the full list.

## pony-lint

Pony has a [linter](https://www.ponylang.io/use/linting/) now. It lives in the [ponyc](https://github.com/ponylang/ponyc) repo and ships with ponyc, so installing ponyc from source or via ponyup will get you pony-lint going forward. It codifies as much of the [Pony Style Guide](https://github.com/ponylang/ponyc/blob/main/STYLE_GUIDE.md) as was reasonable to automate, with more rules planned for future releases.

## pony-doc

[pony-doc](https://www.ponylang.io/use/documentation/) is a new standalone documentation generator that will eventually replace ponyc's built-in `--docs` pass. The big difference: it generates public-only documentation by default, which is what you almost always want. Pass `--include-private` if you need the internals too. It ships with ponyc.

Upgrade to [ponylang/ponyup](https://github.com/ponylang/ponyup) 0.12.2 to get support for installing both pony-lint and pony-doc.

## ponylang/stallion

[ponylang/stallion](https://github.com/ponylang/stallion) is a new HTTP server for Pony built on [ponylang/lori](https://github.com/ponylang/lori). I [mentioned it last week](https://www.ponylang.io/blog/2026/02/last-week-in-pony---february-22-2026/#building-on-lori) as just getting started, and it's already at four releases. Development is moving fast and early performance numbers have been very good.

See the release notes for [0.1.0](https://github.com/ponylang/stallion/releases/tag/0.1.0), [0.2.0](https://github.com/ponylang/stallion/releases/tag/0.2.0), [0.3.0](https://github.com/ponylang/stallion/releases/tag/0.3.0), and [0.3.1](https://github.com/ponylang/stallion/releases/tag/0.3.1).

## ponylang/hobby

[ponylang/hobby](https://github.com/ponylang/hobby) is a new HTTP web framework for Pony, inspired by [Jennet](https://github.com/Theodus/jennet) and powered by [ponylang/stallion](https://github.com/ponylang/stallion). If you've used Sinatra-style web frameworks before, you'll feel at home. Routes use a radix tree with named and wildcard parameters. Middleware runs in before/after phases. Route groups let you share prefixes and middleware across related endpoints. It also handles streaming responses and has built-in static file serving that automatically switches to chunked transfer for large files.

See the release notes for [0.1.0](https://github.com/ponylang/hobby/releases/tag/0.1.0) and [0.2.0](https://github.com/ponylang/hobby/releases/tag/0.2.0).

## ponylang/mare

[ponylang/mare](https://github.com/ponylang/mare) is a new WebSocket server for Pony. It's a full [RFC 6455](https://www.rfc-editor.org/rfc/rfc6455) implementation: upgrade handshake, frame parsing, masking, fragmentation, the close handshake, the whole thing. It does text and binary messages, WSS for encrypted connections, and backpressure so you know when to ease up on sending. You can also inspect upgrade requests and reject connections before they start.

See the [release notes](https://github.com/ponylang/mare/releases/tag/0.1.0).

## Pony Patterns

Eight new patterns went up on the [Pony Patterns](https://patterns.ponylang.io) site this week:

- [Object Algebra](https://patterns.ponylang.io/code-sharing/object-algebra) — add new data variants and operations without modifying existing code, using Pony's structural typing to solve the Expression Problem
- [Avoid Boxing](https://patterns.ponylang.io/performance/avoid-boxing) — use type parameters instead of `Any val` to eliminate heap allocations for primitive values
- [Error as Union Type](https://patterns.ponylang.io/error-handling/error-as-union-type) — use union types of error primitives instead of untyped `error` so callers can pattern match on specific failures
- [Embed and Delegate](https://patterns.ponylang.io/code-sharing/embed-and-delegate) — separate protocol logic into an embedded `class ref` for code reuse across actors and synchronous testing
- [Authority Hierarchy](https://patterns.ponylang.io/object-capabilities/authority-hierarchy) — narrow broad permissions into specific capabilities using stateless primitives, enforced at compile time
- [Constrained Types](https://patterns.ponylang.io/domain-modeling/constrained-types) — enforce validation at the type level so invalid data can't flow through the program
- [FFI Resource Lifecycle](https://patterns.ponylang.io/resource-management/ffi-resource-lifecycle) — safely manage C library resources with explicit `dispose()` and a `_final()` safety net
- [Typed Step Builder](https://patterns.ponylang.io/creation/typed-step-builder) — enforce mandatory fields and construction order at compile time using phase interfaces

That's more patterns than you can shake a stick at.

## Pony Website

The [Pony website](https://www.ponylang.io) got a top-to-bottom reorganization this week. I went through every major section and restructured it:

- **[Learn](https://www.ponylang.io/learn/)** gained a landing page with a guided learning path, ponyup-based install instructions, and a curated videos page
- **[Use](https://www.ponylang.io/use/)** was grouped into Development Environment, Development, Ecosystem, and Build & Release categories, with an expanded testing overview
- **[Community](https://www.ponylang.io/community/)** was organized into Connect, Events, and Stay Informed groups, with a new governance page
- **[Contribute](https://www.ponylang.io/contribute/)** was reorganized into Getting Started, Workflow, Project Operations, and Resources, with new pages for the contributor path, PR submission, and the RFC process
- **[FAQ](https://www.ponylang.io/faq/)** consolidated thin pages and moved questions to better-fitting categories
- **[Packages](https://www.ponylang.io/use/packages/)** was organized into categories with detailed descriptions

Documentation for [pony-lint](https://www.ponylang.io/use/linting/), [pony-doc](https://www.ponylang.io/use/documentation/), and [pony-lsp](https://www.ponylang.io/use/pony-lsp/) was also added. Hopefully it will be a better experience.

## Items of Note

### Pony Development Sync

The [recording](https://vimeo.com/1168283453) of the February 25th Pony Development Sync is available.

The sync covered PRs and issues in the Pony Patterns and ponyc repos, build warnings in ponyc, a corral build bug on Windows, updates on pony-doc and pony-lint, and the upcoming mare WebSocket server. Joe and Red approved moving the [json-ng RFC](https://github.com/ponylang/rfcs/pull/219) to final comment period.

### Office Hours

Red and I attended Office Hours. Most of the time went to [ponylang/stallion](https://github.com/ponylang/stallion) and [ponylang/hobby](https://github.com/ponylang/hobby) performance testing. The stallion numbers look really good. We also spent a while trying to figure out why wrk2 and siege were doing weird things to stallion, which led us down a runtime stats rabbit hole.

### NixOS corral Fix

The bug where the binary package for corral in Nixpkgs/NixOS would `SIGILL` on some x86-linux VMs has been [fixed](https://github.com/NixOS/nixpkgs/pull/493128).

### ponylang/corral 0.9.2

[ponylang/corral](https://github.com/ponylang/corral) 0.9.2 fixes intermittent build failures on Windows caused by missing CPU target flags. Important if you're a Windows user. Not interesting otherwise.

## Releases

- [ponylang/corral 0.9.2](https://github.com/ponylang/corral/releases/tag/0.9.2)
- [ponylang/hobby 0.1.0](https://github.com/ponylang/hobby/releases/tag/0.1.0)
- [ponylang/hobby 0.2.0](https://github.com/ponylang/hobby/releases/tag/0.2.0)
- [ponylang/mare 0.1.0](https://github.com/ponylang/mare/releases/tag/0.1.0)
- [ponylang/ponyc 0.61.0](https://github.com/ponylang/ponyc/releases/tag/0.61.0)
- [ponylang/ponyup 0.12.1](https://github.com/ponylang/ponyup/releases/tag/0.12.1)
- [ponylang/ponyup 0.12.2](https://github.com/ponylang/ponyup/releases/tag/0.12.2)
- [ponylang/stallion 0.1.0](https://github.com/ponylang/stallion/releases/tag/0.1.0)
- [ponylang/stallion 0.2.0](https://github.com/ponylang/stallion/releases/tag/0.2.0)
- [ponylang/stallion 0.3.0](https://github.com/ponylang/stallion/releases/tag/0.3.0)
- [ponylang/stallion 0.3.1](https://github.com/ponylang/stallion/releases/tag/0.3.1)

## RFCs

### Final Comment Period

- [Add json-ng to the standard library](https://github.com/ponylang/rfcs/pull/219)

### New

- [Redesign signal handling](https://github.com/ponylang/rfcs/pull/220)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
