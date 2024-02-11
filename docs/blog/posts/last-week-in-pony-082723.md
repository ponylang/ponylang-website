---
draft: false
author: "seantallen"
description: "More migrations than you can shake a stick at."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony August 27, 2023"
date: 2023-08-27T07:00:06-04:00
---

Holy holy dear reader. So much activity from a variety of different migrations and a great bug hunt continues. There's plenty to read about and you might just lose track of time while you absorb it all. Fortunately, [there's a song for that](https://www.youtube.com/watch?v=WuXwSyahgW4).

## Items of Note

### We've "Temporarily Dropped" MacOS on Apple Silicon

MacOS on Apple Silicon is no longer a fully supported platform. We are in the process of [moving all our CI to GitHub Actions](https://www.ponylang.io/blog/2023/08/last-week-in-pony-august-13-2023/#the-great-ci-move-is-underway) and in the process, are losing our Apple Silicon CI environment.

According to their roadmap, GitHub should be adding Apple Silicon macOS runners sometime in Q4 of this year. Once they are added, we plan on bringing back support for macOS on Apple Silicon. In the meantime, we have added [macOS on Intel as a fully-supported platform](https://www.ponylang.io/blog/2023/08/last-week-in-pony-august-20-2023/#macos-on-intel-is-a-fully-supported-platform-again).

Hopefully, between our Arm CI jobs and our macOS on Intel CI jobs, we don't inadvertently break macOS on Apple Silicon. If you run into any issues or breakage while [building from source](https://github.com/ponylang/ponyc/blob/main/BUILD.md#macos), let us know.

### We're Migrating Container Images from DockerHub to GitHub Container Registry

Quite some time ago, we decided to migrate from DockerHub to GitHub Container Registry and then...we did nothing. For a really, really, really long time. Until this week.

We've started the migration. Keep an eye on Last Week in Pony for news of what has been migrated. During "the migration period", migrated images will continue to be available from "their usual locations" on DockerHub.

We'll stop publishing all images to DockerHub on or shortly after December 1st, 2023 which should give everyone plenty of time to switch over to GitHub Container Registry.

So, what does that switch involve?

Where previously you referenced our images as `ponylang/ponyc:0.55.1` with the implicit 'DockerHub' as part of the identifier, you will have to supply the registry `ghcr.io/ponylang/ponyc:0.55.1`.

Note, we are not migrating old images, those will continue to exist on DockerHub and will not be moved. Only new images for any given repository after it has been migrated will exist in the GitHub Container Registry.

### `shared-docker` Images Migrated to GitHub Container Registry

The images in our [shared-docker](https://github.com/ponylang/shared-docker) repository have been migrated to publish to GitHub Container Registry. Images will continue to be published to DockerHub until December 1st, 2023.

### CirrusCI Migration Update

We've migrated pretty much everything from CirrusCI to GitHub Actions except our ponyc Windows CI which is being...problematic. Until we got to the Windows support, everything was humming along like a [Joe Walsh song](https://www.youtube.com/watch?v=ss9VZ1FHxy0). Now? Well, let's say that if you wanted to [declare war](https://www.youtube.com/watch?v=iUxkFCBPgx4) on those Windows CI jobs, Sean wouldn't blame you.

We spent a good amount of time getting any Windows CI at all to work. We temporarily paused getting CI jobs to run in LLDB (a handy trick we have that makes crashes much more useful) as it was being a [PITA](https://www.youtube.com/watch?v=ic3g8Xnf7LI). For a while, we were stuck with debug runtime builds that are either [hanging](https://www.youtube.com/watch?v=I_3gLp6k7ZE) or are so damn slow. Needless to say, Sean [had got frustration](https://www.youtube.com/watch?v=9G-AtMVXmPM).

For whatever reason, we get a lot of weird TCP test errors running on the GitHub Windows Runners. Searching the internet says we aren't alone in some of what we are seeing. Because we need to be off CirrusCI soon, we've decided to turn off the TCP tests in CI as doing that seems to make all our problems go away. When the switch PR is merged, we'll be opening an issue for investigating the Windows TCP test issue. We'd **love** assistance. Really, really, really [love](https://www.youtube.com/watch?v=I1e4qhHOIQA) assistance.

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_08_22.m4a) from the August 22nd, 2023 sync is available.

We ran through a bunch of PRs. Most of them were related to our ongoing move from CirrusCI to GitHub Actions, but we had a few other things we covered including the infamous [issue #4369](https://github.com/ponylang/ponyc/issues/4369).

The issue that multiple people including Sylvan have classified as "WTF!".

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

We had a 2 hour Office Hours this week. All Pony; the entire time. [Good stuff](https://www.youtube.com/watch?v=_F4dmI8KsEk).

The first half was a discussion between Red and Sean about some slightly esoteric design issues for the additional API surface that Red [will be adding](https://github.com/ponylang/net_ssl/pull/89) to [ponylang/net_ssl](https://github.com/ponylang/net_ssl).

The second half was Dipin and Sean working with Victor to give advice helping track down a segfault in the C code he has written for his in-progress Pony QUIC library. We covered lots of stuff including some basics of the area where the problems are, looking at his locking strategy, a quick look at some mallocs, and a quick look at his queue implementation. All looked ok at first glance but Sean suspects the bug(s) will be found in one of those.

We ended with Dipin taking Victor through a quick tour of using memory address sanitizers and tools like Valgrind that help you track down memory issues in C code.

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

Let's look at the [Pony Performance Cheatsheet](https://www.ponylang.io/reference/pony-performance-cheatsheet/) this week! Specifically let us look at the advice to [Watch your allocations](https://www.ponylang.io/reference/pony-performance-cheatsheet/#avoid-allocations)!

This section of the Performance Cheatsheet discusses avoiding allocations in the context of `String` objects, but the exact same advice can apply to `Array` objects. In order to maximize performance, you have to watch your allocations. The compiler can optimize away additional allocations in some scenarios, but not relying on these optimizations in performance-critical code is necessary.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
