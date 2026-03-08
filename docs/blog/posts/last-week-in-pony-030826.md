---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - March 8, 2026"
date: 2026-03-08T07:00:06-04:00
---

This week's theme song is ["Tennessee Quick Cash"](https://www.youtube.com/watch?v=-ST7bGYEjfo) by the incredible Charley Crockett. No secret meaning this time. I love Charley Crockett, I'm seeing him tonight, and I'm gifting you the love. A big week to go with it: a blog post about Pony's networking future, a massive ponylang/templates release, and the first release of ponylang/courier.

<!-- more -->

## Pony Networking, Take Two

I wrote a [blog post](https://www.ponylang.io/blog/2026/03/pony-networking-take-two/) about the design philosophy behind [ponylang/lori](https://github.com/ponylang/lori) and why we're building Pony's next generation of networking libraries on top of it. The short version: the standard library's notifier pattern puts your application code inside an actor you don't control, and that causes real problems when you need fine-grained backpressure, scheduler fairness, or mid-stream TLS upgrades. Lori flips that around. Your actor owns the connection.

The post covers the two patterns that make it work (Mixin and Embed & Delegate), walks through what the design unlocks, and surveys the ecosystem of libraries already built on lori. [Go read it.](https://www.ponylang.io/blog/2026/03/pony-networking-take-two/)

## ponylang/templates 0.3.0

[ponylang/templates](https://github.com/ponylang/templates) 0.3.0 is a big one. If you've been waiting for the template library to grow up, this is it.

The conditional system is real now. `if` blocks support `else` and `elseif`, `if` checks both existence and non-emptiness (which means `ifnotempty` is gone), and `ifnot` handles the "missing value" case as a first-class branch. You can write real branching logic without duplicating content under negated conditions.

Templates can compose. `include` inlines shared partials. `extends` and `block` give you template inheritance: define a base layout, override specific blocks in child templates, leave the rest at their defaults. If you've used Jinja2 or Django templates, the model will feel familiar.

The old function call syntax is replaced by filter pipes. `{{ name | upper | trim }}` flows left-to-right through transformations. Seven built-in filters ship out of the box (`upper`, `lower`, `trim`, `capitalize`, `title`, `default`, `replace`), custom ones are easy to add, and `default("fallback")` handles missing variables cleanly.

For generating whitespace-sensitive output like YAML, there are trim markers (`{{-` and `-}}`). Comments (`{{! ... }}`), raw blocks (`{{raw}}...{{end}}`), and string literals as pipe sources round out the syntax.

The headline addition is `HtmlTemplate`, a separate engine with contextual auto-escaping. It knows where your variables sit in the HTML structure and escapes them accordingly: entity escaping in text, URL filtering in `href` attributes, JavaScript escaping in event handlers. Variables in structurally invalid positions are caught at parse time. A deeper blog post is coming.

## ponylang/courier

[ponylang/courier](https://github.com/ponylang/courier) had its first release this week. It's an HTTP/1.1 client built on [ponylang/lori](https://github.com/ponylang/lori), following the same embed-and-delegate pattern as the rest of the lori ecosystem. Your actor implements `HTTPClientConnectionActor`, embeds the connection class, and handles response callbacks directly. Both plain HTTP and SSL connections are supported.

Check the [examples directory](https://github.com/ponylang/courier/tree/main/examples) to get started.

## Upgrade ponylang/lori to 0.10.0

If you're using lori, upgrade to 0.10.0. There are two bug fixes you want.

The accept loop in `TCPListener` was spinning on persistent errors like running out of file descriptors. Instead of backing off, it retried immediately in a tight loop, burning CPU forever. Fixed.

The POSIX read loop in `TCPConnection` wasn't yielding after hitting the byte threshold. It kept reading in the same behavior call, which meant per-actor GC never got a chance to run. Also fixed.

Beyond the fixes, 0.10.0 adds IPv4-only and IPv6-only support, changes `MaxSpawn` to a constrained type that rejects invalid values at construction, and sets the default connection limit to 100,000 (previously unlimited). Both 0.9.0 and 0.10.0 have breaking changes, so check the release notes for [0.9.0](https://github.com/ponylang/lori/releases/tag/0.9.0) and [0.10.0](https://github.com/ponylang/lori/releases/tag/0.10.0) for migration details.

If you're using [ponylang/stallion](https://github.com/ponylang/stallion), upgrade to 0.4.0 to pick up the lori fixes.

## Big FFI Change Coming

A heads-up for anyone writing FFI code. There are some unsafe patterns in Pony's FFI usage that never used to matter, but LLVM now notices them and does surprising things.

The core issue: if you're passing an object with an "immutable" reference capability to a C function that mutates it, that's been quietly unsafe for a while. LLVM didn't optimize around it before. Now it does. If you're passing a `Pointer[U8] tag` to something like `memset`, you'll need to switch to a `Pointer[U8] ref`.

We'll detail the full set of changes soon. I'll be addressing these in the standard library and ponylang organization code after the next ponyc release. You can start preparing now by auditing your FFI wrappers for reference capability mismatches. See [ponyc issue #4925](https://github.com/ponylang/ponyc/issues/4925) for details.

## LLVM 21

We merged the update of ponyc to LLVM 21. In the process, we found a couple of bugs on nightly that need to be addressed. If you're using ponyc nightly builds, be cautious until those are resolved. One has already been patched. The second has an [open PR](https://github.com/ponylang/ponyc/pull/4938). We won't be doing any ponyc releases until both are fixed.

## Items of Note

### Alpine 3.20 End of Life

Alpine 3.20 hits its end of life in April. Expect us to drop it as a testing target in ponyc CI around the same time.

### New FAQs

I pointed Claude at our [Zulip](https://ponylang.zulipchat.com) to find frequently asked questions that aren't in the FAQ. It found quite a few. The result: a bunch of new FAQs on the website. If you're reading Last Week in Pony, probably none of these will be useful for you beyond pointing other people at them when they ask. In the biz, that is what we call "audience-calibrating the content."

### `llms.txt` Support

We've added LLM-friendly content to [Pony Patterns](https://patterns.ponylang.io) and the [tutorial](https://tutorial.ponylang.io). Both now have `llms.txt` and `llms-full.txt` at their root. Happy markdown joy for your Claude to use to write you some good Pony.

We also added it to the [ponylang website](https://www.ponylang.io), limited to the Learn, Use, FAQ, and Discover categories.

### New Documentation

A bunch of new documentation landed on the website this week:

- [pony-lsp configuration for Zed](https://www.ponylang.io/use/pony-lsp/#zed) and [VS Code](https://www.ponylang.io/use/pony-lsp/#visual-studio-code) editors
- [Updated Pony Zed extension configuration](https://github.com/ponylang/ponylang-website/pull/1233) for compatibility with pony-zed v0.6.1
- [Documented ponyc `use=` build options for debugging](https://www.ponylang.io/use/debugging/custom-ponyc-builds/) — Valgrind, ASan, TSan, UBSan, DTrace probes, and systematic testing
- [Documented runtime options](https://www.ponylang.io/use/compiler/runtime-options/) for compiled Pony programs
- [Added "Building ponyc from Source"](https://www.ponylang.io/contribute/compiler/building-ponyc-from-source/) consolidating build system docs for contributors
- [Reorganized compiler-related docs](https://github.com/ponylang/ponylang-website/pull/1248) into "Working with the Compiler" sections under both Use and Contribute

### New Tutorial Sections

Two new sections were added to the tutorial: [Runtime Basics](https://tutorial.ponylang.io/runtime-basics/) and a [numeric fundamentals primer](https://tutorial.ponylang.io/expressions/arithmetic/).

### New Pony Patterns

Two new patterns were added to [Pony Patterns](https://patterns.ponylang.io):

- [Batch and Yield](https://patterns.ponylang.io/async/batch-and-yield)
- [Peek before Consume](https://patterns.ponylang.io/streaming/peek-before-consume)

### Name Mangling Change

In the process of fixing [ponyc issue #4102](https://github.com/ponylang/ponyc/issues/4102), we are changing how Pony methods are name-mangled. This was never part of the public contract, so we don't consider it a breaking change. However, if you happen to be relying on the name mangling scheme documented in the [LLDB cheat sheet](https://www.ponylang.io/use/debugging/pony-lldb-cheat-sheet/#method-name-mangling), you'll need to update once [PR #4944](https://github.com/ponylang/ponyc/pull/4944) is merged.

### Pony Development Sync

The [recording](https://vimeo.com/1170450087) of the March 4, 2026 Pony Development Sync is available.

The team reviewed several PRs including fixes for runtime crashes, the LLVM update, string literal concatenation optimization, and scheduler statistics output. A good chunk of the discussion was about a compiler crash related to object literals and traits. I shared plans to explore sequent calculus as an alternative type checking approach, inspired by Sylvan's work in Verona. Red reported new deprecation warnings appearing in the build after the LLVM update, which I agreed to investigate.

### Office Hours

Red and I talked package management, content-addressable hashing, and FFI. Then we got into [ponylang/stallion](https://github.com/ponylang/stallion) performance and an interesting memory difference based on workload.

## Releases

- [ponylang/courier 0.1.0](https://github.com/ponylang/courier/releases/tag/0.1.0)
- [ponylang/lori 0.9.0](https://github.com/ponylang/lori/releases/tag/0.9.0)
- [ponylang/lori 0.10.0](https://github.com/ponylang/lori/releases/tag/0.10.0)
- [ponylang/stallion 0.3.2](https://github.com/ponylang/stallion/releases/tag/0.3.2)
- [ponylang/stallion 0.4.0](https://github.com/ponylang/stallion/releases/tag/0.4.0)
- [ponylang/templates 0.3.0](https://github.com/ponylang/templates/releases/tag/0.3.0)

## RFCs

### Accepted

- [RFC 81: "json-ng"](https://github.com/ponylang/rfcs/blob/main/text/0081-json-ng.md)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
