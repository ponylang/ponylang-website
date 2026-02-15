---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - February 15, 2026"
date: 2026-02-15T07:30:00-04:00
---

Crank up [this week's theme song](https://www.youtube.com/watch?v=lvO13EprlMM) — George Jones doing "Hey Good Lookin'" — and settle in. Read fast, though. It's not a long song and this week's issue is longer than most. We've got thirteen releases across six projects. Major new versions of [ponylang/ssl](https://github.com/ponylang/ssl), [ponylang/lori](https://github.com/ponylang/lori), and [ponylang/ponyup](https://github.com/ponylang/ponyup), plus a preview of what's been piling up in [ponylang/postgres](https://github.com/ponylang/postgres).

<!-- more -->

## ponylang/ssl

[ponylang/ssl](https://github.com/ponylang/ssl) had three releases this week. The headline is 2.0.0.

Two big changes. First, OpenSSL 0.9.0 support has been dropped. It was old, buggy, and holding things back. Second, LibreSSL is now a first-class supported SSL library. LibreSSL users previously had to build with `-Dopenssl_0.9.0`, which silently disabled ALPN negotiation, PBKDF2, and the modern EVP APIs that LibreSSL actually supports. The new define is `-Dlibressl`.

Also in 2.0.0: `SSLConnection` now properly propagates the wrapped notify callback's `received` return value, so backpressure signaling through SSL connections actually works. And SHAKE digest constructors accept a `size` parameter for variable-length output on OpenSSL 3.0.x.

The earlier releases added useful pieces too. 1.0.2 fixed hostname verification not being disabled by `set_client_verify(false)`. 1.0.3 added three new crypto primitives: `HMAC-SHA-256`, `PBKDF2-SHA-256`, and `RandBytes`. See the release notes for [1.0.2](https://github.com/ponylang/ssl/releases/tag/1.0.2), [1.0.3](https://github.com/ponylang/ssl/releases/tag/1.0.3), and [2.0.0](https://github.com/ponylang/ssl/releases/tag/2.0.0).

## ponylang/lori

Five releases of [ponylang/lori](https://github.com/ponylang/lori) this week. Yes, five. I did three of them in a single day and would like you to know I'm aware of how that looks.

0.7.0 is the big one. The send system was redesigned. `send()` now returns `(SendToken | SendError)` instead of silently accepting data. The library no longer queues data during backpressure — that's your responsibility now. On success, you get a `SendToken` that's later delivered to `_on_sent` when the data reaches the OS. New callbacks `_on_send_failed` and `_on_start_failure` round out the notification story. The SSL connection API was also redesigned with new `ssl_client` and `ssl_server` constructors on `TCPConnection`, replacing the old wrapper approach. And lifecycle event receiver chaining was removed.

0.7.1 picked up the ssl 1.0.2 hostname verification fix. 0.7.2 added STARTTLS support — you can upgrade a plaintext TCP connection to TLS mid-stream, which is what protocols like PostgreSQL and SMTP need.

0.8.0 added LibreSSL support via ssl 2.0.0, dropped OpenSSL 0.9.0, and fixed `close()` and `hard_close()` being no-ops during the Happy Eyeballs connecting phase. However, **0.8.0 has a regression** — `_on_connection_failure()` can fire spuriously after `hard_close()`. Don't use 0.8.0. Use 0.8.1.

See the release notes: [0.7.0](https://github.com/ponylang/lori/releases/tag/0.7.0), [0.7.1](https://github.com/ponylang/lori/releases/tag/0.7.1), [0.7.2](https://github.com/ponylang/lori/releases/tag/0.7.2), [0.8.0](https://github.com/ponylang/lori/releases/tag/0.8.0), [0.8.1](https://github.com/ponylang/lori/releases/tag/0.8.1).

## ponylang/ponyup 0.12.0

Two new commands in [ponylang/ponyup](https://github.com/ponylang/ponyup) that have been missing for a while.

`ponyup find` queries Cloudsmith to show available versions of a package. No more guessing what's out there before you install.

`ponyup remove` lets you uninstall package versions. Installed versions used to accumulate on disk with no way to clean them up. It won't let you remove the currently selected version — use `ponyup select` to switch first.

See the [release notes](https://github.com/ponylang/ponyup/releases/tag/0.12.0) for usage details.

## What's Coming in ponylang/postgres

[ponylang/postgres](https://github.com/ponylang/postgres) hasn't cut a new release yet, but the unreleased changelog is substantial.

The driver now supports parameterized queries via the extended query protocol, named prepared statements, and query cancellation. SSL/TLS negotiation is in. SCRAM-SHA-256 authentication is in — so you're no longer limited to md5 or trust.

On the features side: LISTEN/NOTIFY, COPY IN and COPY TO STDOUT, transaction status tracking, notice response messages, bytea type conversion, and `ParameterStatus` tracking. Callbacks now take `Session` as a first parameter, so you can issue follow-up queries from within `ResultReceiver` and `PrepareReceiver` callbacks.

Bug fixes include zero-row SELECTs producing the wrong result type, double-delivery of failure notifications, unsupported authentication types causing silent hangs, and several others.

Watch for a release soon.

## ponylang/json-ng 0.1.0

[ponylang/json-ng](https://github.com/ponylang/json-ng) 0.1.0 is out. This is a new JSON library for Pony. There's also an [RFC](https://github.com/ponylang/rfcs/pull/219) open to add it to the standard library.

## seantallen-org/msgpack 0.3.1

[seantallen-org/msgpack](https://github.com/seantallen-org/msgpack) now supports streaming. That's the big news across the 0.3.x releases. The library didn't have streaming support before — now it does. 0.3.1 hardens that new streaming decoder for production use: size limits to protect against oversized values, container depth limits to prevent stack overflow, a `skip` method for advancing past values without decoding, and opt-in UTF-8 validation for str format values.

This will probably be the last msgpack release for a while. My attention is shifting to [ponylang/postgres](https://github.com/ponylang/postgres) and [ponylang/lori](https://github.com/ponylang/lori). If you're interested in areas of open research, check out the [research discussions](https://github.com/seantallen-org/msgpack/discussions/categories/research).

See the [release notes](https://github.com/seantallen-org/msgpack/releases/tag/0.3.1) for details.

## ponylang/github_rest_api 0.3.0

[ponylang/github_rest_api](https://github.com/ponylang/github_rest_api) 0.3.0 adds pagination for search results, organization repository listing, repository issue listing with label and state filters, proper URL query parameter encoding, and an `IssuePullRequest` model for distinguishing PRs from true issues in API results. Several `Repository` fields are now nullable to match what the GitHub API actually returns.

See the [release notes](https://github.com/ponylang/github_rest_api/releases/tag/0.3.0) for examples.

## Pony Language Server

The pony-lsp was included in ponyc starting with 0.60.5, but it couldn't locate the standard library unless you were using the VS Code extension. That's been fixed. The language server now works with any editor that has LSP support. The fix is in the nightly builds and will ship with the next ponyc release.

Separately, Orien Madgwick updated the ponyc Homebrew formula to include the newly integrated pony-lsp.

## Items of Note

### Office Hours

Office Hours was attended by Red, Matthias Wahl, and me.

Matthias and I discussed [dependency and package discovery using corral.json](https://ponylang.zulipchat.com/#narrow/channel/556572-pony-lsp/topic/dependency.20and.20package.20discovery.20using.20corral.2Ejson) for the language server — in person rather than async — and worked out a miscommunication.

Red walked through a clever approach to finding bugs in ponyc. He had Claude go through every ponyc commit, classify fixes by root cause, and identify the most common bug patterns. Then he pointed Claude at the current codebase to find code matching those patterns. LLMs are great at pattern matching. Expect bug fixes from Red to land regularly for a while.

### Pony Development Sync

The recording of the February 11th Development Sync is available on [Vimeo](https://vimeo.com/1164129472). Red, Nisan Haramati, and I attended.

We reviewed PRs and issues across appdirs, corral, ponyc, and ponyup — including the new `remove` command for ponyup and various SSL-related improvements. There was a discussion about a potential Clang format implementation that would touch 53,577 lines of code. We also talked through performance concerns with union matching and the state of the Postgres driver. The conversation wrapped up with a discussion about using Claude for code review and development.

### Claude Code and Pony

I've been working with Claude Code and have gotten it to be a solid Pony programmer and a pretty good engineer. A blog post about it is coming this week. In the meantime, if you're curious, drop by [Office Hours](https://www.ponylang.io/community/office-hours/) and I'd be happy to chat about it.

### Pony Patterns

Four Pony Patterns PRs are open — two new patterns and two updates to older ones that needed work before they could be merged:

- [#13](https://github.com/ponylang/pony-patterns/pull/13)
- [#86](https://github.com/ponylang/pony-patterns/pull/86)
- [#87](https://github.com/ponylang/pony-patterns/pull/87)
- [#88](https://github.com/ponylang/pony-patterns/pull/88)

### Pony Stickers

Did you know you can get Pony stickers?

- [Main, our galloping mascot](https://www.stickermule.com/item/2421090c47beca439db7e840497ed5e4)
- [Logo](https://www.stickermule.com/item/2421090c47beca439dbfeb4c407ad9e6)

## Releases

- [ponylang/corral 0.9.1](https://github.com/ponylang/corral/releases/tag/0.9.1)
- [ponylang/github_rest_api 0.3.0](https://github.com/ponylang/github_rest_api/releases/tag/0.3.0)
- [ponylang/json-ng 0.1.0](https://github.com/ponylang/json-ng/releases/tag/0.1.0)
- [ponylang/lori 0.7.0](https://github.com/ponylang/lori/releases/tag/0.7.0)
- [ponylang/lori 0.7.1](https://github.com/ponylang/lori/releases/tag/0.7.1)
- [ponylang/lori 0.7.2](https://github.com/ponylang/lori/releases/tag/0.7.2)
- [ponylang/lori 0.8.0](https://github.com/ponylang/lori/releases/tag/0.8.0)
- [ponylang/lori 0.8.1](https://github.com/ponylang/lori/releases/tag/0.8.1)
- [ponylang/ponyup 0.12.0](https://github.com/ponylang/ponyup/releases/tag/0.12.0)
- [ponylang/ssl 1.0.2](https://github.com/ponylang/ssl/releases/tag/1.0.2)
- [ponylang/ssl 1.0.3](https://github.com/ponylang/ssl/releases/tag/1.0.3)
- [ponylang/ssl 2.0.0](https://github.com/ponylang/ssl/releases/tag/2.0.0)
- [seantallen-org/msgpack 0.3.1](https://github.com/seantallen-org/msgpack/releases/tag/0.3.1)

## RFCs

### New

- [Add json-ng to the standard library](https://github.com/ponylang/rfcs/pull/219)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
