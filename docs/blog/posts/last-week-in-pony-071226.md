---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - July 12, 2026"
date: 2026-07-12T07:00:00-04:00
---

This week's theme song is Van Morrison's ["Caravan"](https://www.youtube.com/watch?v=mVWwgf2F9L4). It's a banger. Turn it up. That's enough. So you know it's got soul. Does it tie in with anything in this issue of Last Week in Pony? I could probably invent something, but really, I just love to drop something I've been enjoying lately in here every week because why not? If I'm going to write all this stuff up every week, I deserve a few indulgences.

<!-- more -->

The TCP stress test I put into ponyc last week is paying dividends. It throws all sorts of variations of traffic and shape at a basic echo server, to hit the little-used and unlikely combinations of events in testing before a Pony user runs into them in production. This week I ported it over to [ponylang/lori](https://github.com/ponylang/lori), the TCP networking library a lot of the Pony ecosystem is built on. It found two bugs there. Fixing those put me in lori's read path, where I found two more. Chasing all of that took me into the Pony runtime and into [ponylang/ssl](https://github.com/ponylang/ssl), and there were bugs in both. ponyc's own nightly run of it found one in the standard library's `net` package. I've been hardening the runtime, `net`, ponylang/lori, and ponylang/ssl as a result. Expect more.

## ponyc 0.67.0

[0.67.0](https://github.com/ponylang/ponyc/releases/tag/0.67.0) is out. Two of the bugs fixed in it can hang your program so it never exits.

The nightly Windows run of the stress test found one of them, in the `net` package. A busy TCP connection would send off its queued writes and then stop receiving. It never received again, and the program hung. Reading and writing share one registration with the OS on Windows, and a write that drained everything queued could use the registration up and leave the read side without one. I fixed it in [PR #5683](https://github.com/ponylang/ponyc/pull/5683). If you do TCP on Windows, upgrade.

The other is in the runtime. I found it while working on lori. A read or a write on a socket could park a scheduler thread and never return, and then your program never exits. It takes a blocking socket to get there, and the sockets the runtime makes are never blocking, so one has to come from outside: a socket opened over the C FFI, or a descriptor number that a library closed and the kernel then reused for a blocking socket. lori was doing the second, reading one more time from a socket it had just closed. I fixed the lori side in [PR #307](https://github.com/ponylang/lori/pull/307), and then the runtime, in [PR #5718](https://github.com/ponylang/ponyc/pull/5718) for reads and [PR #5726](https://github.com/ponylang/ponyc/pull/5726) for writes. If you don't use lori and nothing in your program hands the runtime a socket over the C FFI, you never hit this one.

Socket writes go through a new `pony_os_sendv` as part of that fix. If you call `pony_os_writev` over the FFI to write to a socket, switch to `pony_os_sendv`.

`ArrayKeys.next()` is partial now, which matches `ArrayValues` and `ArrayPairs`. That's a breaking change. Iterating with `for` is unaffected. Call `next()` yourself and you need a `try` around it. Nisan Haramati did that one, and he added `rewind()` to `ArrayKeys` and `ArrayPairs` as well, so you can pass an iterator into another scope and run it a second time without passing the source array around too.

Runtime tracing builds on Windows now. Parsing deeply nested JSON no longer overflows the stack and crashes your program, which matters if you parse JSON you didn't write. And two of the fixes to the standard library's `term` package are for the terminal showing you something other than what you typed. An escape sequence that `term` didn't handle, Shift-Tab for one, leaked stray characters into your input. ctrl-k deleted to the end of the line but left the deleted text on screen.

There are twenty-five fixes in the release. The [release notes](https://github.com/ponylang/ponyc/releases/tag/0.67.0) have the rest of them.

## ponylang/ssl 3.0.0

ssl is our TLS and crypto library, and it's what lori does TLS with. Chasing a crash and a muting bug in lori's TLS connections, both of them below, put me in ssl, and I kept finding bugs once I was there. [3.0.0](https://github.com/ponylang/ssl/releases/tag/3.0.0) is the result, and it has six breaking changes. `Digest` and `HmacSha256` are partial now: they raise an error instead of returning a wrong answer. An `SSLContext` has to be `val` before you can make a session from it. The version primitives got renamed. Read the release notes before you upgrade. Every one of the six is in there with what to do about it.

That first change is there because `Digest` and `HmacSha256` were both discarding OpenSSL failures. `Digest.final` handed back the buffer it gave OpenSSL to write the hash into, unwritten, as a hash. The worse one is `HmacSha256`. When OpenSSL couldn't compute the authentication code, `HmacSha256` gave you no error. It returned thirty-two zero bytes. An attacker can send you thirty-two zero bytes as the code on a message, so any time your own computation failed, you'd compare their zeros against your zeros, find a match, and accept the forged message. And it didn't take an exotic failure to get there. An empty key and an empty message got you the zeros. If you use `HmacSha256`, upgrade. If you get ssl through lori, see below: you're on 2.0.1 until lori's next release.

## Items of Note

### Fixes and a breaking change coming in ponylang/lori

The stress test found two bugs in lori. A connection could hang under sustained write backpressure, where you write to it faster than the socket can send, so the connection has to wait ([PR #306](https://github.com/ponylang/lori/pull/306)). So could one that closed while it was handling data it had already received, which is the read-after-close above ([PR #307](https://github.com/ponylang/lori/pull/307)).

The read-path work turned up two more. A hard close tears a connection down on the spot instead of draining it first. Calling one from inside a callback on a TLS connection crashed the program ([PR #311](https://github.com/ponylang/lori/pull/311)). And `mute()`, which stops lori from delivering data to you, didn't take effect right away on a TLS connection: the messages already decrypted from the read in progress arrived anyway ([PR #314](https://github.com/ponylang/lori/pull/314)).

Those two have one cause. lori had two read loops, one for plaintext and a second one, written later, for TLS, and every control you have over reading had to be written twice with nothing making the two agree. Each bug is a guard the plaintext loop had and the TLS loop didn't. In [PR #315](https://github.com/ponylang/lori/pull/315) I collapsed the two loops into one read path where each of those controls is written once. Yielding, where your callback breaks out of the read loop so other actors get a turn, only took effect on a TLS connection after every message from the read in progress had already gone out. Collapsing the loops fixed that too.

The collapse is a breaking change for lori users. `yield_read()` is gone, and your `_on_received` returns a `ReadAction` now. If you never yielded, that's `KeepReading`.

None of that is released yet, and neither is a fix for `close()` dropping writes that were still queued under backpressure ([PR #322](https://github.com/ponylang/lori/pull/322)). It'll all be in lori's next release, along with OpenSSL 4.0.x support. The released lori is pinned to ssl 2.0.1, so if you use lori you get ssl 3.0.0 when we ship the next lori, not before. [ponylang/courier](https://github.com/ponylang/courier), [ponylang/stallion](https://github.com/ponylang/stallion), [ponylang/postgres](https://github.com/ponylang/postgres), and [ponylang/mare](https://github.com/ponylang/mare) all use lori directly, so we'll pick the fixes up in each of them as we move them to the new lori.

### Moving ponyc's build to CMake

ponyc's build is one CMake project now. It used to be two implementations of the same steps, a Makefile on Unix and a `make.ps1` on Windows, each with its own hand-written configure, build, test, and install steps wrapped around CMake. Both are gone. 0.67.0 is the first release built the new way. I did the move in [PR #5633](https://github.com/ponylang/ponyc/pull/5633). If you build ponyc yourself, [BUILD.md](https://github.com/ponylang/ponyc/blob/main/BUILD.md) has the commands, and the build instructions on this site are updated.

### Updating ponylang/llm-skills

I added two skills to [ponylang/llm-skills](https://github.com/ponylang/llm-skills), the skills we publish for working on Pony with an LLM, and changed nine of the ones already there.

`pony-comments` covers what earns a comment in the first place. Two kinds of bad comment come up over and over: a note claiming two far-apart pieces of code have to change together when they don't, and a note about something CI already checks for you.

`pony-prose` is the rulebook for how the words read, in a comment, a docstring, a release note, or a README. State a fact the reader can check. Don't invent jargon. Don't hand a bug or a test a mind of its own.

The change worth calling out is `pony-debug`, and lori's two read loops are why. It now has you work out how far a cause reaches before you pick the place to fix it. Hand an LLM that hard-close crash and you get a fix for that crash. It's small, the test passes, the issue gets closed, and from a diff that small you can't see that the scope was wrong. You're left with the second read loop still there, and you patch the next bug in it the same way.

If you use the skills, pull the latest.

### Office Hours

I was traveling for work on Monday the 6th and didn't make Office Hours. I have no idea whether it happened. Maybe it did! Maybe it didn't! I bet it was the best Office Hours ever, if it did happen.

### Pony Development Sync

There was no Pony Development Sync on the 8th and no recording. Joe had a personal thing come up. I hung around anyway, and about fifteen minutes in, Nisan turned up. I worked with him back at Wallaroo. We talked for forty-five minutes, caught up, went through the two ponyc PRs of his that are in 0.67.0, and got into a few things he'd like to write RFCs for.

### Scheduling notes

I have a work meeting during Office Hours on the 13th, so I won't be there. The week after that I'm traveling for work, so I'll miss Office Hours on the 20th and the Pony Development Sync on the 22nd, and there's a real chance that sync gets canceled. Then I'm taking a short personal break and won't be at Office Hours on the 27th.

Office Hours is still on all three of those Mondays. Red and Adrian are usually around and they're good company. Come by and ask your questions.

## Releases

- [ponylang/ponyc 0.67.0](https://github.com/ponylang/ponyc/releases/tag/0.67.0)
- [ponylang/ssl 3.0.0](https://github.com/ponylang/ssl/releases/tag/3.0.0)

## RFCs

### Ready for Vote

The ['Redesign signal handling' RFC](https://github.com/ponylang/rfcs/pull/220) is ready for a vote. It proposes letting more than one handler subscribe to a signal, settling the cross-platform behavior (today only the first handler registered runs on Linux, and only the last one runs on macOS), and putting signals behind an auth type the way the rest of the I/O primitives are. If you have thoughts on it, now's the time.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
