---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - March 22, 2026"
date: 2026-03-22T07:00:06-04:00
---

ponyc 0.62.0 is out and you should update. There are bug fixes in there that matter, including one that was quietly breaking SSL hostname verification. Beyond that, there's a new multipart MIME parser, four new patterns, and pony-lsp landed in Helix. Let's get into it, but first, fire up this week's theme song: ["Bloody Mary Morning"](https://www.youtube.com/watch?v=NbrB4B5FoBQ) by Willie Nelson. Bob Wills might still be the king, but Willie is certainly in the royal court. Oh, and be prepared for lots of homework.

<!-- more -->

## ponyc 0.62.0

[ponyc](https://github.com/ponylang/ponyc) 0.62.0 is a bug fix release. Update sooner rather than later. Expect another release next weekend with more important fixes in the pipeline.

The `make_might_reference_actor` optimization is back on. We'd disabled it a while back because of a memory leak in the garbage collector: when a behavior was called through a trait reference where the concrete actor's parameter had a different trace-significant capability, reference counts got out of sync and objects were leaked. That leak is fixed now, so the optimization is safe to re-enable. You get a real performance win on update.

Tuple literals in union-of-tuples types weren't matching correctly. If you constructed one inline, inner elements that should have been boxed as union values got stored wrong, and `match` would produce garbage. You had to bind the inner tuple to a variable first as a workaround. That's no longer necessary.

`pony_os_ip_string` had an inverted check on `inet_ntop`'s return value, so it was returning `NULL` for every valid IP address. That cascaded into the ssl library: `X509.all_names()` uses this function to convert IP SANs from certificates into strings, and the `NULL` results produced empty strings that broke hostname verification. More on that in the ssl section below.

A few more: the `#share` capability constraint was reporting non-empty intersections with `ref` and `box` when the result should have been empty. The `_final` pass was rejecting valid code that called methods on generic classes instantiated with concrete type arguments. OpenBSD's `CLOCK_MONOTONIC` constant was wrong (3, not 4), which meant `Time.nanos()` was reading CPU time instead of wall-clock time, causing timers to misfire. And `--path` could shadow standard library packages, which was [fixed for `PONYPATH` years ago](https://github.com/ponylang/ponyc/issues/3779) but never for the command-line flag.

See the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.62.0) for the full list.

## Pony Tools Fixed for Generic CPUs

pony-lint, pony-lsp, and pony-doc were crashing with `SIGILL` on some machines. The tool build commands weren't passing `--cpu` to ponyc, so the compiler targeted whatever CPU the CI machine happened to have. If your CPU was older than the CI machine's, you got illegal instructions.

If you've been hitting `SIGILL` in any of the distributed tools, update to ponyc 0.62.0.

## ponylang/ssl 2.0.1

[ponylang/ssl](https://github.com/ponylang/ssl) 2.0.1 fixes `X509.valid_for_host` accepting empty certificate names. An empty string in the certificate's name list would incorrectly match any hostname.

This is related to the `pony_os_ip_string` fix in ponyc 0.62.0. That function was returning `NULL` for valid IP addresses, which produced empty strings in `X509.all_names()`. The ssl fix ensures that even if an empty name ends up in the list, it won't match. Between the two fixes, hostname verification for IP SANs is solid again.

[Update both ponyc and ssl.](https://www.youtube.com/watch?v=ByiEnkXfDUw&list=PLDZmtI4GBWqyxIOsZMC47j0VQbXjjsBd4)

## ponylang/multipart_mime

[ponylang/multipart_mime](https://github.com/ponylang/multipart_mime) had its first release this week. It's a streaming multipart MIME parser implementing RFC 2046. You give it a boundary and chunks of data, and it delivers parsed parts as they arrive. There's a simple path that buffers everything in memory and a streaming path for large uploads. The parser is intentionally stricter than the RFC where the RFC is too permissive, with configurable size limits to prevent unbounded buffer growth. If you're building anything that handles file uploads or multipart form data in Pony, this is what you want.

## Persistent Data Structures for Concurrent Programs

I published a [blog post](https://www.ponylang.io/blog/2026/03/persistent-data-structures-for-concurrent-programs/) about persistent data structures and why they're a natural fit for Pony's concurrency model. The short version: when your data is immutable, sharing it across actors is free. No copies, no locks. Go read it.

## Pony Gets a New JSON Library

A [blog post](https://www.ponylang.io/blog/2026/03/pony-gets-a-new-json-library/) about the new `json` standard library package went up this week. It covers why the old `json` package needed replacing and the design decisions behind the new one. Go read that one too.

## New Pony Patterns

Four new patterns went up on the [Pony Patterns](https://patterns.ponylang.io) site:

- [Parser Combinators](https://patterns.ponylang.io/code-sharing/parser-combinators)
- [Disposable Actor](https://patterns.ponylang.io/resource-management/disposable-actor)
- [Value Classes](https://patterns.ponylang.io/domain-modeling/value-classes)
- [Recover for Isolated Return](https://patterns.ponylang.io/creation/recover-iso)

## Items of Note

### pony-lsp in Helix

Nightly builds of the [Helix](https://helix-editor.com) editor will now auto-detect pony-lsp as the language server for Pony. No configuration needed. See the [PR](https://github.com/helix-editor/helix/pull/15372).

### Docgen Pass Going Away

Expect the docgen pass to be removed from the compiler within a month. It's been replaced by [pony-doc](https://www.ponylang.io/use/documentation/), the standalone documentation generator that ships with ponyc. If you're still using `--docs`, switch to pony-doc.

### Pony Development Sync

The [recording](https://vimeo.com/1174948577) of the March 18, 2026 Pony Development Sync is available.

We spent a good chunk of time on RFC 223 (`JSON.print` in the standard library). RFC 224 for `--shuffle` in PonyTest came up too. On the ponyc side, we went through the memory leak fix and re-enabling the immutable-send GC optimization. Red joined later with some dependent type questions about encoding vector dimensions in the type system, and Joe and I dug into it with him.

### Office Hours

Red showed off some [notcurses](https://github.com/dankamongmen/notcurses) bindings he's been working on, complete with the notcurses demo running in the terminal. We settled the [pronunciation of pyrois](https://www.youtube.com/watch?v=XGIGgBQaADA) (peer-roy-iss), talked through the `SIGILL` issue in the distributed tools that's now fixed in 0.62.0, and caught up on the giant mass of work that's been landing across lori, pyrois, hobby, and the rest of the ecosystem.

## Releases

- [ponylang/courier 0.1.1](https://github.com/ponylang/courier/releases/tag/0.1.1)
- [ponylang/hobby 0.3.0](https://github.com/ponylang/hobby/releases/tag/0.3.0)
- [ponylang/lori 0.11.0](https://github.com/ponylang/lori/releases/tag/0.11.0)
- [ponylang/mare 0.2.1](https://github.com/ponylang/mare/releases/tag/0.2.1)
- [ponylang/multipart_mime 0.1.0](https://github.com/ponylang/multipart_mime/releases/tag/0.1.0)
- [ponylang/ponyc 0.62.0](https://github.com/ponylang/ponyc/releases/tag/0.62.0)
- [ponylang/ssl 2.0.1](https://github.com/ponylang/ssl/releases/tag/2.0.1)
- [ponylang/stallion 0.5.0](https://github.com/ponylang/stallion/releases/tag/0.5.0)
- [ponylang/stallion 0.5.1](https://github.com/ponylang/stallion/releases/tag/0.5.1)
- [ponylang/uri 0.3.0](https://github.com/ponylang/uri/releases/tag/0.3.0)

## RFCs

### Final Comment Period

- [Add --shuffle option to PonyTest](https://github.com/ponylang/rfcs/pull/224)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
