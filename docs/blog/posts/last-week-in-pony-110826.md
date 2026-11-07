---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - November 8, 2026"
date: 2026-11-08T07:00:00-04:00
---

We are doing a double issue this week as I was away last weekend. And as I am clearly a creature of tradition, that means we need 2 theme songs. This week, let's do 2 from Gogol Bordello. Of course, that means we need to lead off with the classic [Stop Wearing Purple](https://www.youtube.com/watch?v=SkkIwO_X4i4) and pair that with the incredible [Not A Crime](https://www.youtube.com/watch?v=u9v1-1Op9bQ).

I don't know. I feel like, if you like Pony then assuredly you will like Gogol Bordello as well.

<!-- more -->

## Three Ponies for Sister Sara

The big news from the past two weeks is 3 releases of Pony. 0.77.2, 0.78.0, and a quick follow-on 0.78.1. But let's rewind for a moment. We are discussing 2 weeks of releases because a couple weeks back, I went to Virginia for a work event. As some of you know, I work at [Antithesis](https://antithesis.com). Antithesis is a software verification company — we build tools to validate that "software under test" works as specified. We have a new tool that will be released "soon" and I got to using it on Pony. If you look at the 0.77.1 and 0.77.2 release notes, you will see a ton of bug fixes. All those were found by that "to be released soon" tool. It's awesome and I plan to use it more on Pony. I expect it will find other issues.

Beyond those 0.77.2 bug fixes that made it into the past 2 weeks, we have a few other changes I want to highlight.

[Runtime tracing](https://www.ponylang.io/use/debugging/tracing/) has gotten a ton of love. A while back, Dipin Hora did what Dipin often does. He added the core of a really excellent feature. I've recently been improving it. I added a number of additional tracing events and most importantly, you no longer need to do special builds to get access to tracing. It's always available. You can turn it on at program startup or use the internal API to turn tracing on and off while your program is running. And then, a couple days ago, I found a timing bug that was introduced during those changes which is fixed in 0.78.1. So hey, lots more insight into what is going on with your Pony programs — just make sure you are using 0.78.1. One important note, when tracing is off, it has no impact on the performance of your application, but it will have an impact once you turn it on. So speed demons, proceed with caution.

There's also a couple of performance improvements that have been released recently. The Pony runtime bitcode that ships with our builds is now "machine agnostic". Previously, it was built for "lowest common denominator" CPUs so you didn't get the same level of performance you would if you built the runtime for your specific CPU. That is no longer the case. Anywhere we can use bitcode instead of a .a library for the runtime, CPU feature selection will be done at the time that Pony programs are compiled. For some folks, that could have a huge impact. But, it will vary. On the other hand, we have another performance improvement (that is also a breaking change) that should be nice for everyone.

The `Stringable` interface for Pony returned a `String iso^` from `string()`. Sadly this meant that most people were doing something like `"my-string".clone()` for their `string()`. They had to because just returning `"my-string"` wouldn't fulfill the interface. That really sucks because everyone was forced to add an allocation across "all their `string` calls". Not actually everyone, but across all ponylang organization code, I found 2 instances where the string call actually needed a mutable string. And everywhere else, extra, unneeded allocations were happening. So hey, there's a breaking change. You'll need to update for it and just remember when fixing those to remove the `.clone()` as well, cos you probably don't need it and if you do, you can add it in at the call site.

There's more changes as well including a new annotation and two new standard library packages but, you can learn all about them in the release notes.

## Items of Note

### Pony Development Sync - October 28

The [recording](https://vimeo.com/1242492014) is available. No overview for this one. I forgot to turn on the transcript.

### Pony Development Sync - November 4

What follows is an AI-generated summary. The [recording](https://vimeo.com/1243518763) is available if you'd rather watch it yourself.

Red, Joe, and Sean were there. Joe was hosting.

Two RFCs got approved. [`noalloc` annotations](https://github.com/ponylang/rfcs/pull/235) will let you guarantee at compile time that a method never allocates — useful for performance-critical code. The [`Range` redesign](https://github.com/ponylang/rfcs/pull/242) replaces `Range` and `Reverse` with a simpler API that's harder to misuse. If you use either of those today, your code will need updating.

A new [`binary_codec` package](https://github.com/ponylang/ponyc/pull/6284) for working with binary formats was merged into the standard library.

Sean is building [mutation testing](https://github.com/ponylang/ponyc/pull/6311) into the compiler — a way to find weak spots in your test suite by systematically breaking your code and checking whether the tests notice. Still in progress.

A few bugs were discussed, including `step_by` producing wrong results and array literals getting the wrong reference capability inside `recover` blocks.

The team also talked about improving the string and file handling APIs before 1.0.

## Releases

- [ponylang/appdirs 0.3.0](https://github.com/ponylang/appdirs/releases/tag/0.3.0)
- [ponylang/crdt 0.4.0](https://github.com/ponylang/crdt/releases/tag/0.4.0)
- [ponylang/github_rest_api 0.15.0](https://github.com/ponylang/github_rest_api/releases/tag/0.15.0)
- [ponylang/hobby 0.20.0](https://github.com/ponylang/hobby/releases/tag/0.20.0)
- [ponylang/livery 0.16.0](https://github.com/ponylang/livery/releases/tag/0.16.0)
- [ponylang/mare 0.13.0](https://github.com/ponylang/mare/releases/tag/0.13.0)
- [ponylang/msgpack 0.8.0](https://github.com/ponylang/msgpack/releases/tag/0.8.0)
- [ponylang/multipart_mime 0.4.0](https://github.com/ponylang/multipart_mime/releases/tag/0.4.0)
- [ponylang/peg 0.3.0](https://github.com/ponylang/peg/releases/tag/0.3.0)
- [ponylang/ponyc 0.77.2](https://github.com/ponylang/ponyc/releases/tag/0.77.2)
- [ponylang/ponyc 0.78.0](https://github.com/ponylang/ponyc/releases/tag/0.78.0)
- [ponylang/ponyc 0.78.1](https://github.com/ponylang/ponyc/releases/tag/0.78.1)
- [ponylang/postgres 0.16.0](https://github.com/ponylang/postgres/releases/tag/0.16.0)
- [ponylang/reactive_streams 0.3.0](https://github.com/ponylang/reactive_streams/releases/tag/0.3.0)
- [ponylang/semver 0.3.0](https://github.com/ponylang/semver/releases/tag/0.3.0)
- [ponylang/stallion 0.17.0](https://github.com/ponylang/stallion/releases/tag/0.17.0)
- [ponylang/web_link 0.3.0](https://github.com/ponylang/web_link/releases/tag/0.3.0)

## RFCs

### Accepted

- [Add `noalloc` annotation](https://github.com/ponylang/rfcs/pull/235)
- [Redesign Range, Remove Reverse](https://github.com/ponylang/rfcs/pull/242)
- [Add `byte_order` package to the standard library](https://github.com/ponylang/rfcs/pull/243)

### Implemented

- [Add `noalloc` annotation](https://github.com/ponylang/rfcs/pull/235)
- [Redesign Range, Remove Reverse](https://github.com/ponylang/rfcs/pull/242)
- [Add `byte_order` package to the standard library](https://github.com/ponylang/rfcs/pull/243)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang-website/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
