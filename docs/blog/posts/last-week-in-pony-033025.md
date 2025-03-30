---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - March 30, 2025"
date: 2025-03-30T07:00:06-04:00
---

Want some Zig in your Pony? If yes, LordMZTE is your new hero.

<!-- more -->

## Items of Note

### Schuppenpferd

Want some Zig in your Pony? You're in luck. [LordMZTE](https://github.com/LordMZTE) wrote in to announce a project of theirs:

> [https://git.mzte.de/LordMZTE/schuppenpferd](https://git.mzte.de/LordMZTE/schuppenpferd)
>
> Schuppenpferd is a library for the Zig build system that allows building pony programs.
>
>Features include:
>
> - Building Pony projects by declaring build instructions in build.zig
> - Caching to avoid rebuilds when nothing's changed
> - Code generation for imports
> - Managing Pony dependencies with the Zig package manager
> - Importing other libraries built with build.zig (in Zig, C or C++)

### Pony Development Sync

The [recording](https://vimeo.com/1069343282) of the March 25th, 2025 sync is available.

### Office Hours

Another week, another Office Hours that most of you Last Week in Pony readers didn't attend. You should be ashamed. Have you no shame? Clearly not, as it was just some of "the regulars" again.

Attendees this week were myself, Dipin, and Adrian.

We talked about garbage collection and what overhead the [ORCA protocol](https://tutorial.ponylang.io/appendices/garbage-collection.html) adds. I need to note that while ORCA "has overhead," it's also much faster for almost all cases than alternatives that wouldn't change "what Pony is." ORCA adds "communication overhead" but removes "coordination point of contention overhead" you'd get from locking. Interestingly, part of what led to the start of [Verona](https://github.com/microsoft/verona/blob/master/docs/faq.md) was a series of conversations between myself and Sylvan about "how Pony garbage collection could be faster."

If you want to talk garbage collection, stop by. I love to talk about it and I seem to collect friends who feel the same. So if you love the nuances of garbage collection, memory management, and aren't a prick, come on by! Let's become [bosom buddies](https://www.dailymotion.com/video/x6sq52r).

From there, Dipin and I had several specific "GC edge case" conversations about how we might address certain scenarios that the current garbage collection triggering doesn't handle well.

Eventually we wondered what was up with [Alex's Game of Life implementation](https://www.ponylang.io/blog/2025/03/last-week-in-pony---march-23-2025/#office-hours) and wished he had joined this week to let us know. He was probably busy partying with the highly successful University of Florida basketball team.

From there we revisited Adrian's ["quiescence as control flow"](https://www.ponylang.io/blog/2025/03/last-week-in-pony---march-23-2025/#office-hours) conversation. We got into Erlang supervision and how it has some similarities to Adrian's idea. That led to a conversation about the Pony [Custodian](https://stdlib.ponylang.io/bureaucracy-Custodian/) and how it differs. We finished up discussing runtime changes that would have to occur to bless `Custodian` as "special" and allow it or something like it to power Adrian's idea.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
