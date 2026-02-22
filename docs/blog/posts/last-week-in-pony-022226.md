---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - February 22, 2026"
date: 2026-02-22T07:30:00-04:00
---

Crank up [this week's theme song](https://www.youtube.com/watch?v=ljPFZrRD3J8) — Horse Outside by the Rubberbandits — and settle in. Big week. We welcomed a new committer, shipped three brand-new libraries, and put out ten releases across five projects. There's also a persistent `HashMap` bug fix that enabled json-ng to drop its custom null type, three new Pony patterns, and a blog post about teaching Claude to write Pony.

<!-- more -->

## Welcome Orien Madgwick

We have a new Pony committer. Orien Madgwick has been given commit access to the ponylang organization. Welcome aboard, Orien. You've been doing great work so far. We look forward to seeing what you do next.

## ponylang/uri

[ponylang/uri](https://github.com/ponylang/uri) is a new URI library for Pony. Two releases landed this week.

0.1.0 shipped with RFC 3986 parsing, reference resolution, normalization, and RFC 6570 URI template expansion at all four levels. If you need to parse URIs, resolve relative references, or expand URI templates, this is your library.

0.2.0 followed the next day with URI reference resolution per RFC 3986 section 5, IRI support per RFC 3987, `URITemplateBuilder` for one-shot template expansion, and `URIBuilder` for fluent URI construction with automatic percent-encoding.

See the release notes for [0.1.0](https://github.com/ponylang/uri/releases/tag/0.1.0) and [0.2.0](https://github.com/ponylang/uri/releases/tag/0.2.0).

## ponylang/crdt

[ponylang/crdt](https://github.com/ponylang/crdt) is a new library for conflict-free replicated data types in Pony, based on delta-state replication. It's mostly an update of Joe's original [jemc/pony-crdt](https://github.com/jemc/pony-crdt), brought up to date and moved into the ponylang org.

The initial release includes counters (`GCounter`, `PNCounter`, `CCounter`), sets (`GSet`, `P2Set`, `TSet`, `AWORSet`, `RWORSet`), registers (`TReg`, `MVReg`), and collections (`TLog`, `CKeyspace`). Each type supports convergent merging of concurrent updates. All replicas reach the same state without coordination.

If you're building distributed systems in Pony and need data structures that merge without coordination, this is what you want.

See the [release notes](https://github.com/ponylang/crdt/releases/tag/0.1.0).

## ponylang/web_link

[ponylang/web_link](https://github.com/ponylang/web_link) is a new library for parsing [RFC 8288](https://www.rfc-editor.org/rfc/rfc8288) Web Linking HTTP Link headers. It implements the link-value grammar from Section 3 including quoted-string parameters, whitespace handling, and multi-link comma-separated headers. If you're working with HTTP Link headers (pagination, API discovery, resource relationships), this parses them.

See the [release notes](https://github.com/ponylang/web_link/releases/tag/0.1.0).

## ponylang/json-ng

Two releases of [ponylang/json-ng](https://github.com/ponylang/json-ng) this week.

0.2.0 adds JSONPath filter expressions, function extensions, and slice-with-step support per RFC 9535. Filters let you select array elements or object values matching a condition: comparisons, existence tests, logical operators. All five built-in function extensions are implemented: `match`, `search`, `length`, `count`, and `value`. Two naming changes: `JsonType` is now `JsonValue`, and `NotFound` is now `JsonNotFound`.

0.3.0 replaces `JsonNull` with Pony's built-in `None`. This was made possible by a [fix](https://github.com/ponylang/ponyc/pull/4839) to Pony's persistent `HashMap` that previously used `None` as an internal sentinel (more on that below). That fix hasn't shipped in a ponyc release yet, so 0.3.0 requires the latest nightly ponyc builds.

See the release notes for [0.2.0](https://github.com/ponylang/json-ng/releases/tag/0.2.0) and [0.3.0](https://github.com/ponylang/json-ng/releases/tag/0.3.0).

## ponylang/lori

Four releases of [ponylang/lori](https://github.com/ponylang/lori) this week.

0.8.2 adds `local_address()` to `TCPListener` — essential when binding to port 0 and needing to discover the actual port. 0.8.3 widens `send()` to accept `(ByteSeq | ByteSeqIter)` for multi-buffer `writev` sends and fixes incorrect FFI declarations for `exit()` and `pony_os_stderr()`. 0.8.4 adds per-connection idle timeouts using ASIO timer events, no extra actors needed. 0.8.5 fixes an overflow in `IdleTimeout` where large millisecond values silently wrapped when converted to nanoseconds.

See the release notes for [0.8.2](https://github.com/ponylang/lori/releases/tag/0.8.2), [0.8.3](https://github.com/ponylang/lori/releases/tag/0.8.3), [0.8.4](https://github.com/ponylang/lori/releases/tag/0.8.4), and [0.8.5](https://github.com/ponylang/lori/releases/tag/0.8.5).

## Persistent `HashMap` Fix

A [PR](https://github.com/ponylang/ponyc/pull/4839) was merged to fix a bug in the standard library's persistent `HashMap`. The internal HAMT node lookup used `None` as a sentinel for "key not found," which collided with user types that include `None`. If your map's value type was `(String | None)`, `apply` would raise instead of returning the stored `None`, and `contains` would return `false` for keys mapped to `None`.

The fix replaces the `None` sentinel with `error`. It's a breaking change, but a localized one. It will ship in the next ponyc release.

## Teaching Claude to Write Pony

I wrote up how I've been teaching Claude Code to write Pony: [Teaching Claude to Write Pony](https://www.ponylang.io/blog/2026/02/teaching-claude-to-write-pony/). If you're interested in using AI tools with Pony, give it a read.

## Items of Note

### Pony Development Sync

The [recording](https://vimeo.com/1166146720) of the February 18th Pony Development Sync is available.

The sync covered the [json-ng RFC](https://github.com/ponylang/rfcs/pull/219). Joe and Red provided feedback on naming, suggesting `JsonValue` over `JsonType` and considering `None` instead of "JSON null." The persistent `HashMap` bug was discussed and classified as a bug worth fixing. There was also conversation about including a panic pattern in the standard library.

### Office Hours

Red and I attended Office Hours this week. We discussed [ponyc issue #4838](https://github.com/ponylang/ponyc/issues/4838), a bug where PonyCheck's mapped generators segfault during shrinking. Then Red taught me about NixOS.

### Pony Patterns

Three Pony patterns were published this week:

- [Boolean Short-Circuit](https://patterns.ponylang.io/performance/boolean-short-circuit)
- [Mutable and Sendable](https://patterns.ponylang.io/data-sharing/mutable-and-sendable)
- [State Machine](https://patterns.ponylang.io/behavioral/state-machine)

### Building on Lori

I've started repositories for a [pure Pony Redis client](https://github.com/ponylang/redis) and an [HTTP server called Stallion](https://github.com/ponylang/stallion), both built on [ponylang/lori](https://github.com/ponylang/lori). They're part of a project to build five different protocols on top of lori: Redis, SMTP, HTTP client, HTTP server, and WebSocket server. The goal is to find commonalities that can be moved into lori itself. No releases yet. Just getting started.

## Releases

- [ponylang/crdt 0.1.0](https://github.com/ponylang/crdt/releases/tag/0.1.0)
- [ponylang/json-ng 0.2.0](https://github.com/ponylang/json-ng/releases/tag/0.2.0)
- [ponylang/json-ng 0.3.0](https://github.com/ponylang/json-ng/releases/tag/0.3.0)
- [ponylang/lori 0.8.2](https://github.com/ponylang/lori/releases/tag/0.8.2)
- [ponylang/lori 0.8.3](https://github.com/ponylang/lori/releases/tag/0.8.3)
- [ponylang/lori 0.8.4](https://github.com/ponylang/lori/releases/tag/0.8.4)
- [ponylang/lori 0.8.5](https://github.com/ponylang/lori/releases/tag/0.8.5)
- [ponylang/uri 0.1.0](https://github.com/ponylang/uri/releases/tag/0.1.0)
- [ponylang/uri 0.2.0](https://github.com/ponylang/uri/releases/tag/0.2.0)
- [ponylang/web_link 0.1.0](https://github.com/ponylang/web_link/releases/tag/0.1.0)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
