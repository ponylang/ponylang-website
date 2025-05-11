---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - May 11, 2025"
date: 2025-05-11T07:00:06-04:00
---

LLVM 18 support is on the way. Ditto for Linux Arm support and Alpine prebuilt binaries for ponyc. [It's an exciting time](https://www.youtube.com/watch?v=cZ6pYhjjP7I).

<!-- more -->

## Items of Note

### LLVM 18

A couple weeks back, Red decided to step out of his comfort zone and start working on LLVM 18. He got the basic patches in place pretty quickly, but then hit a wall with a couple of nasty segfaults in the ponyc test suite.

Over the last couple weeks, Joe and I worked together to figure out what was going on. We're classifying both issues as "existing bugs." That might be a bit unfair of us.

Here's the story:

LLVM has been doing a lot of work to improve pointer related support. In LLVM 15 and earlier, the memory alignment of pointers was pretty simplistic. Those simplistic rules were hardcoded in a couple places in the Pony codebase. When we got to LLVM 18, the LLVM team made changes that improved things overall but broke those assumptions. The result was unaligned attempts to access memory. Not a good thing.

You can sort of follow along with [this Zulip thread](https://ponylang.zulipchat.com/#narrow/channel/190360-LLVM/topic/LLVM.2018.2E1.2E8.20-.20aka.2C.20biting.20off.20more.20than.20I.20can.20chew.2E). However, note that at times, Joe and I were working together on the problem using the thread as a way to share files, so the thread is sometimes a bit confusing. Still, there's a lot of good information in there.

The end result is that I was able to run the full test suite without issue in my personal X86 glibc based Linux environment. I've provided Red with the patches and we look forward to him updating his pull request and getting it in shape to be merged.

If you join us at Office Hours tomorrow, you can probably join in as I walk Red through an explanation of what was fixed for the second issue we had to fix.

### Windows for Arm support

As I reported last week, we have started working on making Windows for Arm a supported platform. That work is on hold while we wait for an Arm-based Windows laptop to arrive. Gordon says the machine is expected in late May. Hopefully that means sometime in the first half of June, you'll see Windows for Arm support in Pony.

### Linux for Arm64 support

Work continues on providing prebuilt binaries for Linux on Arm64. Expect us to add support before the next release. Our initially supported platforms will be Ubuntu 24.04 and Alpine 3.21.

We will also be adding prebuilt corral binaries and support for installing on our supported Arm64 platforms with ponyup.

### New Supported Platforms

We've added prebuilt ponyc binaries for Alpine 3.20 and Alpine 3.21 on X86. We'll add corral and ponyup support for these platforms in the next release.

### Pony Development Sync

The [recording](https://vimeo.com/1081945262) of the May 6th, 2025 sync is available.

### Office Hours

Office Hours this past week was myself, Red, and Adrian. We spent almost all the time discussing the work on LLVM 18 that Red has been doing. I explained to Red the root cause of one of the segfaults he was seeing and walked him through the fix that Joe and I had come up with.

We also discussed the second segfault he had found which Joe and I had yet to look at too closely. I did some live debugging during the call to make progress on the issue, so there was a lot of rambling and watching me work through the problem.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
