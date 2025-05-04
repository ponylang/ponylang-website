---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - May 4, 2025"
date: 2025-05-04T07:00:06-04:00
---

I don't have a good summary for this past week. Most work focused on getting Pony working with LLVM 18, which I haven't written about yet. Here's some [Loretta Lynn](https://www.youtube.com/watch?v=8_wwP8UZR1o) for you to listen to while you read the rest of this week's issue.

<!-- more -->

## Items of Note

### GCC 15 and LLVM 17

Our currently supported LLVM version, LLVM 17, doesn't compile with GCC 15. We've [added a patch](https://github.com/ponylang/ponyc/pull/4699) to our "vendored" version of LLVM to fix this.

### musl libc on Arm support

I've opened a [pull request](https://github.com/ponylang/ponyc/pull/4692) to work toward making musl libc on Arm a fully supported platform.

### Windows for Arm support

I started [getting Windows for Arm working](https://github.com/ponylang/ponyc/pull/4689). I reached the limit of what I can accomplish using only CI. We [decided](https://ponylang.zulipchat.com/#narrow/channel/200978-administrative/topic/Arm.20Windows.20Machine) to use some of the Pony organization funds to buy an Arm-based Windows laptop for Gordon. He'll be our primary Windows on Arm support person, just like he handles Windows on x86 support.

### Pony Development Sync

The [recording](https://vimeo.com/1080013335) of the April 29th, 2025 sync is available.

### Office Hours

I took notes for this week's Office Hours, but after a long week of hacking on LLVM 18 with Joe and Red and figuring out Hot Chocolate, F#, and Open Telemetry stuff at work, I'm fuzzy on what these notes mean.

I didn't write down all attendees, but it included myself, Adrian, Red, and Alex.

We talked about LLVM and vendoring. These conversations usually revolve around why the Pony core team decided years ago to support only one version of LLVM at a time, leading us to use a git submodule to "vendor" LLVM with a patch system for bug fixes.

The conversation shifted to Python wheels, which always prompts my complaint that wheels are only available for glibc, not musl.

Then we discussed performance tuning. Red brought this up because he saw worse performance using many cores than fewer cores in a program he wrote. We explored possible causes. During this, I shared the history of performance issues we encountered building [Wallaroo](https://github.com/seantallen/wallaroo) that led us to introduce scheduler scaling into the Pony runtime.

The performance talk centered on Red's HTTP server, which led us to search for a comprehensive test suite for validating HTTP server spec conformance. The only one we found was SPECweb99, a long-retired commercial offering.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
