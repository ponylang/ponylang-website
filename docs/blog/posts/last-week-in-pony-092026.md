---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - September 20, 2026"
date: 2026-09-20T07:00:00-04:00
---

Here's how it is. AC/DC's *Back in Black* was one of the first albums I owned. I loved that sucker so much. It was sadly the only album of theirs I owned for quite some time. Fortunately my friend Gary had several, but his father was a very strict and religious man — a preacher in fact. Gary hid his AC/DC albums under the bed and I would go over to Gary's house when his father wasn't home and we'd each use a glorious set of old school over-the-ear headphones to listen to AC/DC. Dirty Deeds was far and away my favorite album that Gary had.

But today, we are not here to talk about Dirty Deeds (btw, get the Aussie version, it's so good). We are here to talk about Pony and the fact that I keep breaking stuff as I push towards version 1.0. It's still a long way off but, I'm making a lot of solid forward progress. And I feel like celebrating and I want you to feel it too, so this week, let me make up for basically never doing AC/DC as the theme song and give you some [Thunderstruck](https://www.youtube.com/watch?v=v2AC41dglnM).

<!-- more -->

## Compiler Rework

Sometime in August, we crossed a line. Prior to crossing that line, we were able to compile the standard library on our 32-bit Linux testing platforms. After crossing the line, we would die from an OOM. The initial diagnosis turned out to be incomplete and between when I found the issue earlier this month and when I started addressing it in the last few days, the problem had gotten worse.

Here's the fundamental problem: [ponylang/ponyc](https://github.com/ponylang/ponyc) from the beginning has been doing whole program optimization and doing it in the simplest way possible with LLVM. However, as the standard library has grown in size, it used more and more memory when optimizing it and eventually, that was enough that LLVM couldn't allocate enough memory to do its optimizations.

The solution at a high-level is to do most optimizations on a "per-module" basis and save whole program optimization for 64-bit systems where we have a lot more virtual address space available. So, I'm working on a change that makes ponyc compile each package into its own unit (like C for example) and optimize those individually. And then I'm moving our "whole program optimization" pass into a new link-time optimization (LTO) backend when linking.

If you do compilers, that should give you an idea of what is going on. If you don't do compilers, let me sum it up this way... "I'm redoing a ton of the internals of the compiler".

For users, very little should change externally except that there will be new `--thin-lto` and `--fat-lto` compiler options where thin uses less memory and does less optimizing and fat uses more memory (too much for large applications on 32-bit) and does more optimizing.

Additionally, you'll be able to combine either with `--debug` or `--release` which is a side-effect that will give you, the compiler user, a little more control. I'm writing this Friday afternoon, it is possible the work will land on main before this is published. If not, I hope to land it next week, modulo my discovering something that blows up the entire plan.

## Items of Note

### What's Coming

The last couple editions of Last Week in Pony, I've been giving you a bit of a hint into what is coming.

I have mentioned previously that I'm working on [PonyCheck](https://github.com/ponylang/ponyc/tree/main/packages/pony_check) improvements. There's one big one left: stateful testing support. I'm working through a plan for how it will work and good news: I think it will be awesome and the bad news: to make the API not shit, it will end up involving another round of breaking changes for PonyCheck.

I'm still working on the package system rework but I doubt it will land before sometime in October as I've been working on the compiler changes mentioned earlier that started to flow from problems compiling the standard library on 32-bit platforms.

Still also in the queue is the [method overloading work](https://github.com/ponylang/ponyc/discussions/6010). And same as last week, I don't have a plan on exactly when I'll start it, but I am still calling it "soon-ish".

And as usual, "expect a boatload of breaking changes".

### MacOS 27 Warning

Don't upgrade to MacOS 27 yet. Nisan is reporting that there are problems linking that are related to LLVM where we are waiting on fixes. See [Zulip](https://ponylang.zulipchat.com/#narrow/channel/189934-general/topic/linker.20errors.20after.20MacOS.2027.20upgrade) for more details.

### ponylang/ponyc 0.72.1

[ponylang/uri](https://github.com/ponylang/uri) and [ponylang/courier](https://github.com/ponylang/courier) have both graduated to the standard library. They aren't feature complete and will continue to be updated in the standard library. They were moved in because their functionality is needed by the new dependency manager that is in development that lives in the ponyc repo and needs the functionality of both.

`courier` is now known as `http_client`. `uri` kept the same package names.

There's also a fix for BSD users in this release. TCP connections on FreeBSD, OpenBSD, and DragonFly BSD could stall during backpressure cycling, dropping throughput to single-digit KB/s. Full release notes [here](https://github.com/ponylang/ponyc/releases/tag/0.72.1).

### ponylang/ssl Archived

[ponylang/ssl](https://github.com/ponylang/ssl) has been archived. All its functionality is now in the ponyc standard library: SSL/TLS networking support in the `net` package, cryptographic primitives in the `crypto` package.

### ponylang/llm-skills Updates

I updated [ponylang/llm-skills](https://github.com/ponylang/llm-skills) yet again. If you use them, time to update again! Party party. I know y'all just love all the text I put in your prompts. It's delicious and ooey gooey wonderful text.

### Schedule

Expect a ponyc release next week. Probably around the 26th. You can follow along with the changes in the [CHANGELOG](https://github.com/ponylang/ponyc/blob/main/CHANGELOG.md).

I'll probably be 30 minutes late to Office Hours on Monday. I have a work call that overlaps.

### Office Hours

I wasn't at Office Hours on September 14. Red reports that they discussed actor documentation, the observer pattern for Pony, and the cost tradeoffs between cheap actors, message overhead, and scheduler count.

## Releases

- [ponylang/github_rest_api 0.13.0](https://github.com/ponylang/github_rest_api/releases/tag/0.13.0)
- [ponylang/hobby 0.16.0](https://github.com/ponylang/hobby/releases/tag/0.16.0)
- [ponylang/livery 0.12.0](https://github.com/ponylang/livery/releases/tag/0.12.0)
- [ponylang/ponyc 0.72.1](https://github.com/ponylang/ponyc/releases/tag/0.72.1)
- [ponylang/stallion 0.14.0](https://github.com/ponylang/stallion/releases/tag/0.14.0)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang-website/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
