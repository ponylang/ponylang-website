---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - October 11, 2026"
date: 2026-10-11T07:00:00-04:00
---

Once upon a time, I was in a band with a righteous man named Josh. Josh's day job was at "one of the big museums" in New York City. They had an exhibit of "punk fashion" or something ridiculous like that. The sort of thing that folks should want to take a piss out of.

John Lydon (aka Johnny Rotten) was going to be a guest at the opening but the museum muckity-mucks were worried he "might misbehave". Their concern was Josh's win. Josh was assigned to be John's shepherd for the evening and got to spend the entire night with a hilarious rock legend. We had a large blown up version of their end of night selfie in our practice space and I would regularly look at it and laugh.

What's that got to do with Pony? Well, if we want to stretch it, let's talk about how both Sylvan and I are very important to the history of Pony and we both love the Pistols and Public Image Limited. O and, because Sylvan sent me a link to [Rise](https://www.youtube.com/watch?v=jPj-8_wOZcA) this week and I thought, "fuck yeah... that's a good theme song for the week".

<!-- more -->

## Recent Pony Changes

No Pony releases this past week. No need for one. You got two just a couple weeks back. Greedy gets you nowhere; at least not with ponies. But no releases doesn't mean "nothing is going on". We've had some exciting stuff merged since the last release. So let's get into what those are...

First off, we just updated to LLVM 23.1.3 which should come with a fix for LLVM's linking not working on the most recent MacOS version. Thanks to Nisan Haramati who kept an eye on LLVM progress and let me know as soon as a fix was released so I could get Pony updated as soon as possible.

There's a new language feature that's merged to main: `iftype` specialization. A method on a generic type can have multiple bodies, each guarded by a constraint on the type parameter. The compiler selects the matching body when it knows the concrete types.

What does that actually do for you? Let's look at the changes that I did right after for cloning collections. If you had an `Array[U32] val` and wanted to send a clone to another actor, you used to need to use `recover`:

```pony
let cloned: Array[U32] iso = recover iso arr.clone() end
other_actor.accept(consume cloned)
```

`clone()` returned `ref` regardless of what the elements were. If the elements are `val`, a fresh array of them is perfectly safe to isolate, but there was no way to express "return `iso` when the elements are `val` and `ref` otherwise" in the type system. That's what `iftype` specialization is for.

Now `clone()` on `Array`, `List`, `HashSet`, and `HashMap` return `iso^` when element types are `val`:

```pony
let cloned: Array[U32] iso = arr.clone()
other_actor.accept(consume cloned)
```

I'm too lazy to go look up when the request for this was first filed. Let's leave it at "quite some time ago" and move on to some other fun stuff.

I spent some time on runtime performance — I do like to go fast after all. Let's talk first about "guarded devirtualization". It's a fancy term for "sometimes we can go faster". When an interface has only a handful of concrete types, the compiler now emits direct calls instead of a vtable lookup. Direct calls can be inlined; vtable lookups can't. The biggest win is on iterator-heavy code. If you're using fold, map, or the other itertools combinators, Iterator usually has two concrete implementations, and the compiler inlines straight through them. In benchmarks, fold's overhead over a raw loop dropped from 2.5x to 1.5x. Along with some other changes, I got fold and raw loops to being equal. Nice. The "other changes" required more control over inlining so, now everyone gets more control over inlining. Yes, that means you now have direct control via three new annotations: `inline`, `inline(N)`, and a `noinline`.

`inline` attempts to force a function to be inlined. `inline(N)` raises the cost threshold which allows you to "attempt even harder" to have a function inlined. And then if you want to go slow, we have `noinline`. Ok that last bit is kind of a joke. Usually inlining will make things go faster but sometimes because modern computers are "complicated", it can actually make things worse.

There's more of course, I'm a busy busy man. This has just been a sampling. You can head over to the [pony repo](https://github.com/ponylang) and check out the [CHANGELOG](https://github.com/ponylang/ponyc/blob/main/CHANGELOG.md) if you want to learn about all the rest of the goodness.

## Items of Note

### LLM Skills Updated

The [llm-skills](https://github.com/ponylang/llm-skills) have been updated again. If you are using them, it is once again time to update. I put a decent amount of work into trying to improve the advice for debugging. I watched some agents repeatedly flail with "experienced engineer" debugging tasks and set about trying to fix that. There's some other changes in there as well, but the debugging stuff is the highlight.

### M-Tesla/pony-ml

I asked Claude to write this one up for me because, well because...

M-Tesla announced [pony-ml](https://github.com/M-Tesla/pony-ml) on the Zulip. It's a Pony program that runs ONNX and TensorFlow SavedModel inference. You hand it a model file, it reads the input and output declarations, and you feed it data and get results back. The ONNX side uses ONNX Runtime with GPU support via CUDA. TensorFlow runs on CPU via the C library.

### MacOS Golden Gate

The latest nightlies fix problems with linking on MacOS Golden Gate. You should feel ok upgrading to the latest MacOS. Well, at least as far as Pony is concerned. I'm not making any guarantees about anything else.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang-website/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
