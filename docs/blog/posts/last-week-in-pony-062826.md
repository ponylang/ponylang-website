---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - June 28, 2026"
date: 2026-06-28T07:00:06-04:00
---

This week's theme song is The Shallaras' ["I Put Something in Your Drink"](https://www.youtube.com/watch?v=Sj9OtRWfmtM). The Shallaras are two people. One plays drums and guitar at the same time. The other plays sax and sings. Two people, and they sound like a whole band. I think about that a lot, how much a small group can get done. That was this week.

<!-- more -->

ponyc 0.65.0 is out. It's a big release, and most of what's in it I've covered here over the last few weeks: C shim compilation, a pile of fixes, and one breaking change to the standard library's `json` package. But next week is the bigger deal. We're taking IOCP out of the Windows runtime, dropping Windows 10 support with it, and shipping ponyc 0.66.0 right after so all the libraries get updated. A stack of libraries shipped releases this week too, off a single bug fix in lori. Plenty to get to.

## Removing IOCP from Windows Next Week

A couple of weeks back I put up a proposal to fix a problem in how Pony does networking on Windows, and I [went through the why in detail](https://www.ponylang.io/blog/2026/06/last-week-in-pony---june-14-2026/). The short version: we do socket I/O two different ways, depending on the platform. Everywhere but Windows, we use readiness notifications. The kernel tells you a socket is ready, and you do the read or write yourself, into your own buffer. Windows uses IOCP instead. You give the kernel a buffer, the call returns before the work is done, and the kernel fills your buffer and tells you later, when it's finished. The main reason to drop the Windows way is memory safety. The kernel writes into your buffer after your call has already returned, and Pony's reference capabilities can't describe a write that happens then. There's no way to make it safe.

Next week we do it. [PR #5556](https://github.com/ponylang/ponyc/pull/5556) switches Windows over to readiness, the same way every other platform already works. It's stress-tested and ready. I wanted 0.65.0 out the door before landing a change this big, and now it is. Once the merge is in, we update [lori](https://github.com/ponylang/lori), the TCP library a lot of the ecosystem is built on, and then everything built on lori. After some testing, ponyc 0.66.0 goes out so you get all the new versions. We're not going to sit on it.

There's a cost. The clean way to do readiness on Windows uses a Winsock API that showed up in Windows 11 and Windows Server 2022, so using it makes those the minimum. That means dropping Windows 10. We already only support Windows 11, and CI runs Server 2025, so nothing changes for the platforms we support. But we'd been making a best effort to keep Windows 10 working, and that's done. If you're on Windows 10, this week's 0.65.0 is the last release for you.

## ponyc 0.65.0

Most of what's in 0.65.0 you've already read about here. It's the work that piled up on main while we waited for this release. The big one is C shim compilation, which I've been talking about for two weeks. ponyc compiles C shims now. Drop a `.c` file next to your `.pony` files and ponyc builds it with an embedded clang and links it in. No second build system, and nothing extra for the people who build against your library. The [whole story is here](https://www.ponylang.io/blog/2026/06/look-ma-i-put-a-compiler-in-the-compiler/), with an example and the design behind it.

The one new thing worth a stop is a breaking change to the `json` package. `JsonObject` and `JsonArray` are no longer `Stringable`. Their `string()` and `pretty_string()` methods are now `print()` and `pretty_print()`. There's a new `JsonPrinter` primitive that serializes any `JsonValue`, scalars included, which the old code couldn't do right: it printed `None` as `None` instead of `null`, and it didn't escape strings. So "how do I turn my data into JSON" finally has one clean answer. Build a `JsonValue` and give it to `JsonPrinter`. If you serialized JSON before, your `string()` and `pretty_string()` calls need the new names. That's what sent livery and github_rest_api out with their own updates this week.

The rest is a long list. A run of compiler crash fixes, the external linker gone for good, multicast and UDP socket-option fixes, a crash on types with 128-bit fields, scheduler timing fixes, the small-`String` reallocation fix, Alpine 3.24 added as a supported platform, and the supported OpenBSD and FreeBSD versions bumped to 7.9 and 15.1. It's all in [the release notes](https://github.com/ponylang/ponyc/releases/tag/0.65.0).

## Items of Note

### A lori Bug Hit a Lot of Libraries

lori is the TCP library a lot of our libraries are built on. courier, stallion, postgres, and mare use it directly. hobby is built on stallion, livery on mare and hobby, github_rest_api on courier. A bug in lori is a bug in all of them.

There was one. A connection could go quiet after a big write, if the application kept sending without pausing its reads. The data was there. The TCP layer had it. But it never got handed up to the application, and the connection just sat there until someone closed it. An earlier fix handled the apps that pause their reads under backpressure. [lori 0.15.1](https://github.com/ponylang/lori/releases/tag/0.15.1) finishes it for the ones that don't, which is what a server streaming a response does.

lori shipped the fix, and everything built on it shipped too. courier, stallion, postgres, and mare picked up the new lori. hobby got it through stallion. livery and github_rest_api got it as well, folded in with the `json` changes they needed for 0.65.0. One fix in lori, and all of them are fixed.

### Improving Runtime Test Coverage

I wrote a post this week about the runtime's stress tests. They run in CI and hammer the runtime looking for concurrency bugs, the kind that turn up once in a blue moon. The problem is they'd gone stale. Same setup every run, the same few paths, nothing new found in a long time. So I made them dynamic. Every run now varies the workload and the runtime options, so over time they cover a lot more ground. Making that work turned up two bugs in the runtime itself, and one of them I did not see coming. The [whole story is here](https://www.ponylang.io/blog/2026/06/improving-runtime-test-coverage/).

### Office Hours

Office Hours on June 22, with Red and me. Two topics kept coming up. One was embedding binary blobs in Pony programs, big ones. The other was Unicode, and how big it gets once you start digging in. We went back and forth between them all session.

### Pony Development Sync

The June 24 [Pony Development Sync](https://vimeo.com/1204359115) had two of my pull requests heading toward merge. One is the Windows readiness work from up top, [PR #5556](https://github.com/ponylang/ponyc/pull/5556). The other, [PR #5558](https://github.com/ponylang/ponyc/pull/5558), is a streaming JSON parser. A normal parser needs the whole document before it gives you anything. This one takes bytes as they come in and hands back complete values one at a time, as soon as each is done. Red's going to run it and see what it does to memory use.

Then we talked design. [Issue #4088](https://github.com/ponylang/ponyc/issues/4088) is a quiet correctness bug. Call a method through a union type and the wrong default argument can get applied, so a call that should be a compile error slips through and runs with a default it should never have. We agreed on the fix. Instead of picking the default from how the value is typed at the call site, each concrete type carries its own. The right default gets used, and a call with no valid default gets rejected like it should have all along. The [full plan](https://github.com/ponylang/ponyc/discussions/4977) recasts default arguments as type-level method overloads.

The last thing was networking, and it had some urgency. The plan has long been to retire the standard library's `net` package and use lori instead, because lori tells you when a send fails instead of dropping the data quietly. Right now that's more than housekeeping. `net` can silently drop a UDP message, no error, the data just gone. We can't move to lori yet, it's TCP-only today, but a silent data-loss bug like that is what turns finishing the switch from someday into soon.

Unicode came up here too. Red mentioned he's working on a Unicode library.

## Releases

- [ponylang/ponyc 0.65.0](https://github.com/ponylang/ponyc/releases/tag/0.65.0)
- [ponylang/lori 0.15.1](https://github.com/ponylang/lori/releases/tag/0.15.1)
- [ponylang/courier 0.3.1](https://github.com/ponylang/courier/releases/tag/0.3.1)
- [ponylang/github_rest_api 0.6.0](https://github.com/ponylang/github_rest_api/releases/tag/0.6.0)
- [ponylang/hobby 0.8.3](https://github.com/ponylang/hobby/releases/tag/0.8.3)
- [ponylang/livery 0.4.0](https://github.com/ponylang/livery/releases/tag/0.4.0)
- [ponylang/mare 0.4.1](https://github.com/ponylang/mare/releases/tag/0.4.1)
- [ponylang/postgres 0.6.1](https://github.com/ponylang/postgres/releases/tag/0.6.1)
- [ponylang/stallion 0.7.3](https://github.com/ponylang/stallion/releases/tag/0.7.3)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
