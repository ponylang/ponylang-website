---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - June 21, 2026"
date: 2026-06-21T07:00:06-04:00
---

This week's theme song is Willie Nelson's ["Midnight Rider"](https://www.youtube.com/watch?v=qVv1lvs76gM). There's no clever reason behind it. It's a great song, it brims with energy, and this was a week with energy to spare. Sometimes a theme is just a vibe, a feel. This one fits.

<!-- more -->

No ponyc release went out, but main was anything but quiet. The headline is C shims. When a C library won't map cleanly onto Pony's FFI, you write a shim: a little piece of C that bridges the gap. Building it always meant a second build system standing outside Pony. Now ponyc compiles it for you, and I wrote a whole post about how that came together. Away from that, the years-long hunt for ARM bugs finally hit zero, a runtime timing bug that had been quietly off by half got straightened out, and a steady run of fixes piled up on main waiting for the release at the end of the month. A good week. A good week indeed.

## Compiling C Shims with an Embedded clang

ponyc carries a C compiler now. Leave a `.c` file next to your `.pony` files and ponyc compiles it with an embedded copy of clang and links the result into your program. No Makefile, no `use "lib:..."`, nothing extra for the people who build against your library. The clang was there all along, inside the LLVM that ponyc already vendors; this week it got switched on, and the second build system every shim used to drag behind it is gone.

What I care about most is that none of this loosens Pony's safety story. A shim is your package doing C, so `--safe` governs it exactly like an FFI call. If a package isn't cleared to do C FFI, dropping a `.c` into it is an error, the same one you'd get for calling C from there. The compiler-in-the-compiler opens no side door around the FFI boundary.

It isn't free. Bundling clang makes the ponyc binary noticeably bigger, and I think that's a trade well worth making. It's on main now and ships at the end of the month. The full story, a worked example, and the design behind it are in [Look Ma, I put a compiler in the compiler](https://www.ponylang.io/blog/2026/06/look-ma-i-put-a-compiler-in-the-compiler/).

## Items of Note

### The ARM Bug Hunt Hits Zero

Years ago, Sylvan did the original ARM port. The ARM landscape has grown enormously since then, and we've spent the years since fixing what turned up after the port: bugs in the original work, and the quirks that came with each new ARM platform. This week the last open ARM-specific issue closed. As of now, we have no known ARM-specific bugs. Everything is clean. Until one of you goes looking for ARM bugs just 'cause.

### The Next ponyc Keeps Filling Up

The other fixes this week were the ordinary between-release kind, and they came in two sorts, the loud and the quiet. The loud ones are crashes. A directory inside a package named like a Pony source file, something ending in `.pony`, used to make ponyc run out of memory and abort instead of building; it skips such directories now, like any other non-source entry ([PR #5514](https://github.com/ponylang/ponyc/pull/5514)). And a runtime built with tracing on would crash the instant a message was scheduled from a thread that wasn't running an actor, like the ASIO thread handling a network event or the cycle detector, so any program that did I/O or simply ran long enough would reliably hit it ([PR #5522](https://github.com/ponylang/ponyc/pull/5522)).

The quiet ones don't crash anything. The program runs fine and does the wrong thing anyway. `NetAddress.scope()` returned the IPv6 zone identifier with its bytes reversed on little-endian machines, so interface index 2 read back as 33554432 ([PR #5511](https://github.com/ponylang/ponyc/pull/5511)). `UDPSocket.set_broadcast` should do nothing on IPv6, since IPv6 has no broadcast to toggle, but instead it ignored its argument and joined a multicast group; it's a proper no-op now ([PR #5497](https://github.com/ponylang/ponyc/pull/5497)). And `--ponysuspendthreshold`, which sets how long an idle scheduler thread waits before parking, ran at half scale on x86, so asking for 100 ms got you 50 ([PR #5535](https://github.com/ponylang/ponyc/pull/5535)); if you tuned that number, halve it to land where you were.

One more, and this one started in Office Hours. A small `String` or `Array` grown a few elements at a time used to reallocate and copy itself again and again, even while it still fit inside the block the allocator first handed it. It records that block's capacity now and stays put until it truly outgrows that block ([PR #5518](https://github.com/ponylang/ponyc/pull/5518)), which is exactly the pattern JSON parsing leans on, building strings from nothing one character at a time.

### Office Hours

Office Hours on June 15, with Red and me. Two threads. The first was about when Claude can't be trusted: Claude hallucinating things that aren't there, and the ways to deal with it, ensemble methods among them. The second was a string optimization, and it didn't stay theoretical. The idea we kicked around became [PR #5518](https://github.com/ponylang/ponyc/pull/5518) above, merged a couple of days later.

### Pony Development Sync

Design talk carried the June 17 [Pony Development Sync](https://vimeo.com/1202277044). Two big threads opened it. The first was the `Pointer`/`UnsafePointer` spike and where it led: a soundness hole in Windows socket I/O, and a proposal to close it by moving Windows off its IOCP completion model and onto the readiness model the rest of the platforms already use. I covered both in depth in [last week's post](https://www.ponylang.io/blog/2026/06/last-week-in-pony---june-14-2026/), so I won't rehash them here. The second was C shim compilation, which the team agreed to take with one rename. `cinclude:` became `cincludedir:`, because what it takes is a directory and the name ought to say so. It merged the next day.

Two smaller items closed things out. The `String` and `Array` reallocation fix from Office Hours got its review and went in. And we talked through [issue #3395](https://github.com/ponylang/ponyc/issues/3395), a compiler crash on arrow types over unions that's been open since 2019. The direction we're leaning is to reject the union shapes that trigger it on the left side of an arrow, heading off the crash without giving up soundness.

## Releases

- [ponylang/ponyup 0.15.5](https://github.com/ponylang/ponyup/releases/tag/0.15.5)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
