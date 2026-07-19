---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - July 19, 2026"
date: 2026-07-19T07:00:00-04:00
---

Pony might be great but Bob Wills is still the king. Sometimes though, sometimes George Jones comes along and does one of your songs even better than you did, like ["Roly Poly"](https://www.youtube.com/watch?v=Q6KapL0SnKg). Just so good. That's it. That's the intro. On with the news!

<!-- more -->

## ponylang/ponyup 0.16.1

Installing ponyup on Windows added its bin directory to your user PATH, and corrupted the rest of that PATH on the way. Every entry in the system PATH got copied into the user PATH, so you came away with duplicates of all of them. Entries that use variables like `%USERPROFILE%` stopped expanding. And sometimes there was an empty entry left behind when it was done.

In [0.16.1](https://github.com/ponylang/ponyup/releases/tag/0.16.1) the installer adds its bin directory and nothing else, and leaves the rest of your PATH untouched ([PR #461](https://github.com/ponylang/ponyup/pull/461)). It doesn't repair a PATH an earlier install already damaged, though. That stays a manual fix. If you installed ponyup on Windows before now, upgrading gets you the right behavior going forward, but you'll be cleaning up what's already in there yourself.

There's a question underneath all of this that I'd like Windows users to weigh in on. On Unix, ponyup doesn't touch your PATH. It suggests a change and the change is yours to make. There are a lot of shells out there and no single way to update PATH across all of them, which is why it works that way. Windows is different. There is one way to do it, and from the time Windows support went in, ponyup has been doing it for you. That's the behavior that was corrupting things, and it's what we fixed in 0.16.1. But maybe it shouldn't be there at all. Should ponyup on Windows work the way it does on Unix and leave your PATH alone? I don't have an answer to that one. If you're a Windows user, come to [Zulip](https://ponylang.zulipchat.com) and tell me what you think.

## Items of Note

### A new allocator for the runtime

I've been working on a new memory allocator for the Pony runtime.

The one we have now hands your program memory out of a pool. Once a piece of that memory is freed, the pool can only hand it back out for the same size, on the same thread, in the same place it came from. That means memory sitting in the pool can end up unusable. Your program isn't using it, and nothing else can have it either, so memory use climbs, and it keeps climbing. A TCP stress test I put into ponyc kills a program that way. Run it certain ways and the address space grows without bound until the program dies under a memory cap. Most ways of running it don't.

There's one cause under that. Nothing owns a region of the pool's memory, so nothing gathers up what gets freed inside it. An owner is a thread that's responsible for a region and does that gathering. Give every region an owner and this is fixable. Without one, it isn't. I tried a patch first. It wasn't enough. That's why this is a new allocator and not a fix to the one we have.

Today it's as fast as the old pool, sometimes faster, and memory usage is much better. There's also a new `--ponymemoryprofile` runtime option for trading memory usage against throughput. It takes low-memory, balanced, or throughput.

The old pool stays available as an option for a while after this lands. I plan on dropping it before too long, ideally three months at the most. We shall see.

The design is written up in [discussion #5735](https://github.com/ponylang/ponyc/discussions/5735) and the code is in [PR #5768](https://github.com/ponylang/ponyc/pull/5768). Figure two to three weeks. It would be sooner if I weren't traveling for work.

### Redesigning ProcessMonitor

Speaking of things I've been up to (which if we are honest is mostly what LWIP is, an accounting of what I've been up to). Right, right, I got distracted. Anyway, I haven't just been working on a new memory allocator, I've also been redesigning the standard library's Process Monitor.

`ProcessMonitor` runs a child process for you and reports back two things: the child's output, and the exit status once the child is done. It has problems that can't be fixed given the way it works now. Most of them are edge cases, which doesn't make them any less real. It can lose track of children, and when it does, they hang. There's no patching the existing thing to get out of that, which is why this is a redesign and not a fix. When it lands it's a breaking change for anyone using the `process` package.

The design is in [discussion #5769](https://github.com/ponylang/ponyc/discussions/5769) and the code is in [PR #5770](https://github.com/ponylang/ponyc/pull/5770). Expect it in two to four weeks.

### ponylang/lori

And I keep forgetting, but I also spent time this last week working on lori. The lori stress tests turned up a number of interesting edge cases that needed fixing. I landed a number of them on main.

[ponylang/lori](https://github.com/ponylang/lori) is the TCP networking library a lot of the Pony ecosystem is built on. None of those fixes is released yet, and you're unlikely to run into any of the bugs in the wild right now unless you're unfortunate.

A release is coming soon. Before I cut it, there are a couple more issues I want addressed. Once a lori release rolls out, a pile of downstream libraries get updated behind it, so every release I cut is work in a lot of other repositories, and I'm trying to keep that churn down. When that release does go out, it will require ponyc 0.67.0.

### Updating ponylang/llm-skills

[ponylang/llm-skills](https://github.com/ponylang/llm-skills) is the set of skills we publish for working on Pony with an LLM, and it got a batch of changes last week ([PR #63](https://github.com/ponylang/llm-skills/pull/63), [PR #64](https://github.com/ponylang/llm-skills/pull/64), [PR #66](https://github.com/ponylang/llm-skills/pull/66), [PR #67](https://github.com/ponylang/llm-skills/pull/67), [PR #69](https://github.com/ponylang/llm-skills/pull/69)). If you use the skills, you should update ASAP.

A couple of those changes came out of LLMs being overly verbose when they write. Comments, AGENTS.md additions, that sort of thing. Those took most of my time. There were other fixes in there as well.

### Office Hours

I had a work meeting during Office Hours on the 13th, so I missed it and Red filled me in afterwards. He was there along with Adrian and "A Visitor from Pony-Past"™. They covered a wide range of subjects, the new allocator among them. "As always, a good time was had by most."

### Scheduling notes

I'm traveling for work, so I won't be at Office Hours on the 20th. I'm away across the 26th and the 27th as well. The 26th is a Last Week in Pony day, so there's no post that week and we'll pick back up the week after, and I'll miss Office Hours on the 27th.

Office Hours happens on the 20th and the 27th regardless. Red and Adrian are usually around and they're good company, so come by.

## Releases

- [ponylang/ponyup 0.16.1](https://github.com/ponylang/ponyup/releases/tag/0.16.1)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
