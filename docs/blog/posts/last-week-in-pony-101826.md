---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - October 18, 2026"
date: 2026-10-18T07:00:00-04:00
---

Into every life, from time to time, a little "pop" must enter. Must I tell you. Must.

And so this week, I am having a little pop enter into your life via our [theme song](https://www.youtube.com/watch?v=oQyFFTh_YGc).

Why Tessa Violet's "I Like (the idea of) You"? Well, see the aforementioned "pop must enter", but also because I was listening to it and enjoying it as I do and I thought "this would be a good theme song" and then I thought "how am I going to justify it" and I said "self... you can talk about how you feel about 'Open Source'".

So ya, let's talk about "Open Source". I like the idea of working with people. Of collaborating with them. But you know a lot of people, they just toss... toss... "low effort stuff" your way and expect a "thank you sir". It's even worse lately. It's the worst of Hacktober all across the internet. And that got me to thinking, I really like the idea of "Open Source" but honestly the actuality has never been my bag. But hey that's just me.

Anyway, damn Sean, that was a lot of words on an intro and you haven't even told us anything about what went on in Pony this past week. And right you would be skippy. Right you would be indeed.

So what did happen this past week? Well, because I'm going to be away for work this coming week, I tried to keep my "breaking things" to relatively manageable so, three ponyc releases this past week, each with small breaking changes before a giant breaking change comes down the pike.

Expect some work from me next week, but work will keep me pretty busy so my usual schedule of "spend the evening prepping work for agents to do during the next day" is likely to be disrupted and it will only be a "stuff I can do in a couple hours during the evening" kind of week. Let's see how much I can get done. And with that, phew finally Sean, let's get on with the rest of the show.

<!-- more -->

## Inter-actor backpressure refresh

Here's how it was.

Years and years ago, Sylvan and I noticed a problem. Well-meaning people would get started with Pony and they would create applications with unbalanced message flows. They'd have high fan-in on a single actor that would result in it being unable to keep up with the influx of messages. The actor's queue would grow and eventually — an OOM.

There's no way around the fact that actors are single-threaded and if you have a ton of threads sending work to 1 other thread, eventually that thread will be overwhelmed. So we set about working on fixing it. Where fixing it meant "prevent the OOM". Sylvan tried 2 or 3 approaches and none of them worked. Eventually, I decided to build it directly into [Wallaroo](https://github.com/SeanTAllen/wallaroo) as we needed it there. I came up with a credit-based system that worked for balancing work and preventing OOMs but it was really slow. Too slow to use.

I knew that any backpressure type system couldn't be implemented at the application level. Adding at the application level resulted in tons of extra message passing and all that message passing was duplicating information that the Pony runtime already knew.

I set out to put a new system into the runtime with a couple key points that had to be hit. The biggest, any application that didn't trigger the system should see no observable change in performance. Any impact had to register as noise in a high-performance application. The only other design constraint was that it had to prevent OOMs for all but the most aberrant of messaging patterns.

I succeeded, but there was a cost. The system I put in was very coarse in how it worked. It didn't play nice with the tenets of queuing theory. It could have a rather large impact on the performance of applications that did trigger it. Performance could become very herky jerky. We noticed this at Wallaroo, but I never did anything about it until this past week. [ponyc PR #6285](https://github.com/ponylang/ponyc/pull/6285) makes the situation way better. It is a massive performance improvement win for probably every application that triggers inter-actor messaging backpressure. Here's a quickie highlight:

### Benchmarks (16-core, 32 GB)

| Benchmark | Baseline (0.75.0) | Graduated |
|---|---|---|
| Sustained overload (10K senders → 1 receiver) | ~6.5M msg/s | ~22M msg/s |
| Fan-in (100s → 2K analyzers, 10ms workload) | 39M → **119 msg/s** collapse | 40M msg/s stable |
| Fan-in (100s → 2K analyzers, 5ms workload) | 39M ↔ 99 msg/s alternating | 41M msg/s stable |
| Fan-in (100s → 2K analyzers, 1ms workload) | 38M msg/s stable | 42M msg/s stable |
| Fan-in (500s → 2K analyzers, 10ms workload) | 40M → **181 msg/s** collapse | 44M msg/s stable |

Note the change: a workload going from alternating between 39M and 99 messages a second to one that becomes 41M messages a second without any oscillation. That is what I call an awesome performance win. Even better, there were some cases I found when benchmarking where performance would simply collapse with the old system. Currently, benchmarking for the new system can't find any that lead to a collapse. I fucking love it. But I will admit that I'm lazy. I had the idea for this years ago, I just never did it until this past week.

## Other Pony release notes highlights

Other folks probably would have picked something else or perhaps nothing at all to highlight from this week's three Pony releases, but me, I think you can see why I chose to spend so much time on backpressure. That said, there are a number of other goodies in there too.

There's a couple more performance fixes and a few bug fixes plus some fun breaking changes that I want to highlight for you right quick.

All paths within the Pony `files` package now take advantage of Windows supporting both `/` and `\` as path separators. We now normalize all paths to `/`. There's 1 tiny caveat on that. If you are passing a path to `cmd.exe`, you'll need to jump through one small hoop. Other than that, probably a lot of joy in mudville.

After sitting around for years, I acted on the `Seq` audit that was done a while ago. The audit found there were several places where the `Seq` interface was overly restrictive and could be loosened by breaking it up some. There's now `ReadSeq`, `Seq`, and `ResizableSeq`. You'll probably need to make some small changes to your code to adjust to that. Even without an agent to do it, it should be pretty painless.

Lastly, there was a bug that was allowing shadowing of variables via inherited methods from interfaces and traits. That was fixed and in the process, probably a lot of folks' code got broken. We had several ponylang organization packages that needed updating. You probably will as well. Fortunately, again, it's a pretty painless fix.

## Items of Note

### Office Hours

Red, Adrian, and I got together on the 12th. We talked about the distributed cycle detector — its failure, what comes next with a hybrid approach, and people who "cheat with benchmarks."

### Pony Development Sync

What follows is an agent summary of the meeting. The [recording](https://vimeo.com/1235977037) is available if you'd rather watch it yourself.

This week's sync mixed a pass through the review queue with a handful of longer-running design conversations.

We started with [ponylang/rfcs #235](https://github.com/ponylang/rfcs/pull/235), the `noalloc` annotation RFC. The central question is whether it's still feasible given how the compiler has changed. A `noalloc` check would need to run after `heap2stack`, which used to be an earlier compiler pass but now runs during LTO. Feasibility was already uncertain before that move — more so now.

From there we revisited [ponylang/rfcs #112](https://github.com/ponylang/rfcs/issues/112), the long-open request for stateless byte-order conversion on `ReadSeq[U8]`. The conclusion: build it as a standalone package rather than try to extract anything from `buffered.Reader`. The byte-assembly logic is straightforward shifts and ORs, and `Reader`'s internals are too tied to its chunk-walking to lift out cleanly.

We merged [ponylang/ponyc #6276](https://github.com/ponylang/ponyc/pull/6276), the forward-slash path separator change covered above.

A couple of forward-looking items came up. [ponylang/ponyc #1138](https://github.com/ponylang/ponyc/issues/1138) is the copy idiom implementation — an RFC accepted in 2016, still pending compiler work. Sean hopes to get it to feasible by April of next year; important, but not at the top of the list right now. He also mentioned plans to propose a breaking change to how ranges work, building on the from/to naming from [ponylang/ponyc #5979](https://github.com/ponylang/ponyc/pull/5979) in PonyCheck. That [RFC](https://github.com/ponylang/rfcs/pull/242) has since been filed.

Last, Sean walked Joe through [ponylang/ponyc #6285](https://github.com/ponylang/ponyc/pull/6285), the backpressure overhaul covered above.

### LibreSSL Builder Update

A new LibreSSL 4.3.3 builder image is now available. The prior LibreSSL 4.2.1 image will be removed during the next SSL builder update, so any project still using 4.2.1 should plan to migrate.

### Next Week

I won't be at Office Hours this coming week. I'm away for work. The meeting will be open as usual for community members to get together and chat.

The October 21st Development Sync is canceled. Joe and I decided to proactively cancel as we are the only two regular attendees.

## Releases

- [ponylang/appdirs 0.2.0](https://github.com/ponylang/appdirs/releases/tag/0.2.0)
- [ponylang/glob 2.0.0](https://github.com/ponylang/glob/releases/tag/2.0.0)
- [ponylang/hobby 0.19.0](https://github.com/ponylang/hobby/releases/tag/0.19.0)
- [ponylang/livery 0.15.0](https://github.com/ponylang/livery/releases/tag/0.15.0)
- [ponylang/logger 2.0.0](https://github.com/ponylang/logger/releases/tag/2.0.0)
- [ponylang/msgpack 0.7.0](https://github.com/ponylang/msgpack/releases/tag/0.7.0)
- [ponylang/peg 0.2.0](https://github.com/ponylang/peg/releases/tag/0.2.0)
- [ponylang/ponyc 0.75.0](https://github.com/ponylang/ponyc/releases/tag/0.75.0)
- [ponylang/ponyc 0.76.0](https://github.com/ponylang/ponyc/releases/tag/0.76.0)
- [ponylang/ponyc 0.77.0](https://github.com/ponylang/ponyc/releases/tag/0.77.0)
- [ponylang/ponyup 0.16.3](https://github.com/ponylang/ponyup/releases/tag/0.16.3)
- [ponylang/postgres 0.15.0](https://github.com/ponylang/postgres/releases/tag/0.15.0)
- [ponylang/regex 2.0.0](https://github.com/ponylang/regex/releases/tag/2.0.0)
- [ponylang/stallion 0.16.0](https://github.com/ponylang/stallion/releases/tag/0.16.0)

## RFCs

### New

- [Redesign Range, Remove Reverse](https://github.com/ponylang/rfcs/pull/242)
- [Add byte_order package to the standard library](https://github.com/ponylang/rfcs/pull/243)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang-website/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
