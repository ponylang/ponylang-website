---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - August 2, 2026"
date: 2026-08-02T07:00:00-04:00
---

This week's theme song is ["This Corrosion"](https://www.youtube.com/watch?v=aArkIaPqV3c) by The Sisters of Mercy. No reason. I do so love it, and that's reason enough. I've been at it hard, and there's a lot to show for it. This is a big one.

<!-- more -->

## ponyc 0.68.0

[0.68.0](https://github.com/ponylang/ponyc/releases/tag/0.68.0) is out and we recommend upgrading as soon as possible. It has a "you really need" runtime crash fix as well as a couple other seriously big improvements. The three changes we want to highlight:

Signal handling was replaced from scratch, implementing the ['Redesign signal handling' RFC](https://github.com/ponylang/rfcs/pull/220) in [PR #4984](https://github.com/ponylang/ponyc/pull/4984). The old system had enough edge-case bugs that almost anyone using signals seriously would run into one eventually. It's a breaking change; the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.68.0) have the migration details.

Sending an object through a union type containing both `iso` and `val` variants of the same class could abort in the garbage collector when the sender consumed the object. I thought I'd found all of the union-type-related runtime crashes. I hadn't. Minghan2005 found and fixed this one in [PR #5799](https://github.com/ponylang/ponyc/pull/5799).

Red sped up the compiler for large array literals. Type checking one was quadratic in the number of elements — a 2000-element literal went from about 93 seconds to under half a second ([PR #5790](https://github.com/ponylang/ponyc/pull/5790)).

There are twelve entries in the release. The [release notes](https://github.com/ponylang/ponyc/releases/tag/0.68.0) have the rest.

## ponylang/lori 0.17.0

[ponylang/lori](https://github.com/ponylang/lori) [0.17.0](https://github.com/ponylang/lori/releases/tag/0.17.0) is out. lori is the TCP networking library a lot of the Pony ecosystem is built on. The big change is send tracking.

`_on_sent` used to fire only when the whole write queue drained, and it reported a single send. Under backpressure, the usual move is to send again while an earlier send is still in flight. You never got a callback for those earlier sends. If the connection dropped, only the most recent send got `_on_send_failed`. You had no way to tell how much of your data had actually left.

`send()` returns a `SendToken` or a `SendError` now. Every token gets exactly one completion callback, and the callback carries the token, so you can match each callback to the send it came from. `_on_sent` means the bytes were written into the kernel's send buffer. `_on_send_failed` means the connection dropped first ([PR #305](https://github.com/ponylang/lori/pull/305)).

One caveat. Bytes in the kernel buffer when a connection drops may never reach the peer. `_on_sent` is an upper bound on what got through, not proof it arrived. Delivery end to end is still your job.

The read path change and the bug fixes from the [July 12 post](last-week-in-pony-071226.md) are in 0.17.0 too. `yield_read()` is gone. `_on_received` returns a `ReadAction` now: `YieldReading` or `KeepReading`, default `KeepReading` ([PR #315](https://github.com/ponylang/lori/pull/315)). The bugs: closing inside `_on_received` producing a stray read ([PR #307](https://github.com/ponylang/lori/pull/307)), the `hard_close()` crash on SSL connections ([PR #311](https://github.com/ponylang/lori/pull/311)), the write backpressure stall ([PR #306](https://github.com/ponylang/lori/pull/306)), and `close()` dropping queued writes instead of draining them first ([PR #322](https://github.com/ponylang/lori/pull/322)).

You'll need ponyc 0.67.0 for 0.17.0. A write could hang under load, and fixing that required a socket call added in 0.67.0 ([PR #338](https://github.com/ponylang/lori/pull/338)). It's fixed on Linux, FreeBSD, OpenBSD, and DragonFly. macOS and Windows are unchanged. lori is on [ponylang/ssl](https://github.com/ponylang/ssl) 3.0.0 now; the ssl [release notes](https://github.com/ponylang/ssl/releases/tag/3.0.0) have the API changes. You can build lori against OpenSSL 4.0.x now, with `-Dopenssl_4.0.x` ([PR #321](https://github.com/ponylang/lori/pull/321)).

## 32-bit ARM Linux is a best-effort platform now

We stopped testing 32-bit ARM in CI ([PR #5795](https://github.com/ponylang/ponyc/pull/5795)). We cross-compiled the tests on x86-64 and ran them under qemu. That came apart. Linaro retired the server we pulled the cross-toolchain from. Once I moved to a current toolchain and qemu, the standard library tests started crashing with a bus error the old ones never produced. Running down whether that's a real 32-bit ARM bug or an artifact of the emulation is work. So is standing up a full ARM virtual machine, which is so slow that building LLVM in it takes hours. Both cost more than that coverage was worth.

So 32-bit ARM is best-effort now. It still builds, we don't intend to break it, and I'll run the tests by hand on a 32-bit Raspberry Pi once a month. Between one of those runs and the next, someone can break the 32-bit build and no CI run will report it.

## Items of Note

### ponylang/vscode-extension 0.5.0

[ponylang/vscode-extension](https://github.com/ponylang/vscode-extension) [0.5.0](https://github.com/ponylang/vscode-extension/releases/tag/0.5.0) is out. Between bugs in the extension and bugs in pony-lsp, the language server wasn't starting on Windows, wasn't starting against ponyc 0.67.0, and couldn't find a newly installed pony-lsp without a full VS Code restart. If any of that was hitting you, update now — you need both vscode-extension 0.5.0 and ponyc 0.68.0. Even if it wasn't, there are other improvements in the release, so update soon.

### The new allocator

I've been building a new memory allocator for the Pony runtime. The current pool allocator can't reclaim freed memory for other sizes or threads, so memory use climbs without bound in some workloads. Traveling for work has slowed me down, but I'm hoping to land it before September. The code is in [PR #5768](https://github.com/ponylang/ponyc/pull/5768).

### Porting Pony to Haiku

Haiku is an open source operating system, and ahwayakchih is porting Pony to it in [PR #5358](https://github.com/ponylang/ponyc/pull/5358). The port continues. I'm still excited to see it land. Feel free to watch and cheer him along. Haiku might not have a lot of usage but it has a truly glorious heritage as a descendent of the greatest consumer OS.

### Office Hours

Office Hours was on the calendar for Monday July 20 and Monday July 27. I was traveling for work on the 20th and taking a short personal break on the 27th, so I missed both. If either one happened, I'm unaware of it.

### Pony Development Sync

The sync on July 22 was canceled. On the 29th, Red and I had an informal conversation. There's no recording, I didn't write anything down, and I don't remember what we covered.

### Scheduling notes

I'm traveling for work again, so I won't be at Office Hours on August 3rd or August 10th. Office Hours happens if people turn up, and I won't be one of them.

I won't be at the development syncs on August 5th or August 12th either. It's highly unlikely Joe would make either one, so I'm canceling both.

## Releases

- [ponylang/ponyc 0.68.0](https://github.com/ponylang/ponyc/releases/tag/0.68.0)
- [ponylang/lori 0.17.0](https://github.com/ponylang/lori/releases/tag/0.17.0)
- [ponylang/mare 0.6.0](https://github.com/ponylang/mare/releases/tag/0.6.0)
- [ponylang/postgres 0.8.0](https://github.com/ponylang/postgres/releases/tag/0.8.0)
- [ponylang/vscode-extension 0.5.0](https://github.com/ponylang/vscode-extension/releases/tag/0.5.0)

## RFCs

### New

The ['Redesign the process monitor' RFC](https://github.com/ponylang/rfcs/pull/237) is open for comment.

### Accepted

The ['Redesign signal handling' RFC](https://github.com/ponylang/rfcs/pull/220) was accepted, and it's implemented and shipped in ponyc 0.68.0.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
