---
draft: false
authors:
  - seantallen
description: "Barrelling downhill towards death because we didn't attend Office Hours."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony July 23, 2023"
date: 2023-07-23T07:00:06-04:00
---

Barrelling downhill towards death because we didn't attend Office Hours.

<!-- more -->

## Items of Note

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_07_18.m4a) from the July 18th, 2023 sync is available.

We discussed and merged 2 PRs. It was a pretty quick call.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

I think there was an Office Hours this week. I got a notification that both Red and Joe joined, however, I was sick and didn't attend, so... **shrug**. Let's assume that we all missed the greatest Office Hours ever and that our lives are going to be downhill towards death from here on out. You know, something cheery.

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week let us look at a few [Pony program examples](https://github.com/ponylang/ponyc/tree/e0ead702cccbd97fec53ade927e940e9c13cd763/examples) in the main `ponyc` repository. These examples all include a `README` describing the program, walking you through how the compile it, what it will do, and most will also suggest how you might modify the program to learn different aspect of Pony. Let's walk through the [`pony_bench`](https://github.com/ponylang/ponyc/tree/e0ead702cccbd97fec53ade927e940e9c13cd763/examples/pony_bench) example a bit further.

It may seem "strange" to some that Pony has its own microbenchmarking framework, but the reason is simple: benchmarking is difficult and especially do under asynchronicity. As `pony_bench` is in the standard library, a minimal Pony installation is all you need. Using a standard installation, simply change into the `examples/pony_bench` directory and run `ponyc` to compile it. This produces an executable named the same thing as the directory by default so you will now have a file at `examples/pony_bench/pony_bench`. If you run this file (`./pony_bench`), you will see a print out of a handful of benchmarks for calculating Fibonacci numbers. Now for the really fun part! This benchmark does not use the `Fibonacci` primitive from the `math` package (also in the standard library). By adding the correct "use" statement and a `MicroBenchmark` that calls this primitive you will have run a real microbenchmark comparing two implementations of the same thing!

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
