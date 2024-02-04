+++
draft = false
author = "seantallen"
description = "Apple silicon support is back."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - February 4, 2024"
date = "2024-02-04T07:00:06-04:00"
+++

## Items of Note

### MacOS on Apple Silicon Support (Re-)Added

We've added MacOS on Apple Silicon as a supported platform. Prior to August of 2023, it was a supported platform. Unfortunately, we had to drop it as a fully supported platform when we migrated off of CirrusCI.

This week, GitHub introduced M1 based GitHub Actions runners. With the addition of those runners, we are once again able to fully support MacOS on Apple Silicon.

We will be providing prebuilt versions of ponyc, corral, and ponyup. Until the next respective releases of each program, only nightly builds are available.

### Fedora 39 Support Added

We've added Fedora 39 as a supported platform. We'll be providing ponyc builds for it until it hits its end of life in December of 2024. After that, we'll stop providing ponyc builds but you will continue to be able to install old versions using ponyup.

Until the next ponyc release, only nightly builds are available.

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2024_01_30.m4a) from the January 30th, 2024 sync is available.

Today's sync was a good one. Any sync that involves "live coding" where we go from triaged to fix for an issue is a good one. There's plenty of other content as well, but, the highlight is the working out of a fix for [ponyc issue #4479](https://github.com/ponylang/ponyc/issues/4479).

Beware if you listen along that Joe had some audio issues and for portions could hear anyone else talking. It will either make for hilarious or annoying listening at points. We aren't sure which.

### Office Hours

We have an open Zoom meeting every week for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try. The meeting is open to anyone. Stay up-to-date with the schedule by [subscribing to the Office Hours calender](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics). Hopefully, we'll see you at an Office Hours soon.

We had a rollicking good time at Office Hours this week. Very little grapefruit talk. It wasn't a grapefruit free meeting, but, it was relatively light compared to the previous week.

Attendees were Adrian Boyko, Red Davies, Sean Allen, and Sandro Covo.

Red went over some stuff from this [Zulip conversation](https://ponylang.zulipchat.com/#narrow/stream/189985-beginner-help/topic/Primitive.20function.20to.20read.20from.20Array.5BU8.5D.20iso).

Sandro joined part way through and he and Sean went over [this question](https://ponylang.zulipchat.com/#narrow/stream/189985-beginner-help/topic/Sandro.20asks.20about.20interfaces) together.

The solution to Sandro's problem was "less `Promise`s". Promises are useful in Pony, but if you are coming from a JavaScript background, you will almost assuredly overuse them.

Promises are great when the caller of your API needs an ad-hoc way to interact. The [Pony GitHub Rest API](https://github.com/ponylang/github_rest_api/) has a number of examples that demonstrate needing to ["interact in an ad-hoc way"](https://github.com/ponylang/github_rest_api/blob/main/examples/get-issue-comments/main.pony#L44).

If you don't need ad-hoc interaction, then Promises are not a good solution. That make the interactions between actors hard to follow. They obscure what is actually a fixed protocol. The [fork/join library](https://github.com/ponylang/fork_join) is an excellent one to study to learn more about the "fixed interaction" pattern that appears quite often in Pony programs.

I recommend checking out how [`_Coordinator`](https://github.com/ponylang/fork_join/blob/main/fork_join/_coordinator.pony), [`CollectorRunner`](https://github.com/ponylang/fork_join/blob/main/fork_join/collector_runner.pony), [`Job`](https://github.com/ponylang/fork_join/blob/main/fork_join/job.pony), and [`WorkerRunner`](https://github.com/ponylang/fork_join/blob/main/fork_join/worker_runner.pony) communicate.

## Releases

- [ponylang/corral 0.8.1](https://github.com/ponylang/corral/releases/tag/0.8.1)
- [ponylang/ponyup 0.8.1](https://github.com/ponylang/ponyup/releases/tag/0.8.1)
- [ponylang/ponyup 0.8.2](https://github.com/ponylang/ponyup/releases/tag/0.8.2)

## RFCs

### Final Comment Period

- [Constrained Types](https://github.com/ponylang/rfcs/pull/213)

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

Actors and classes and primitives, oh my! Pony has a lot of different object types, keywords, and concepts. Sometimes you may wish there was a simple one-page reference for it all. Well you are in luck; the [Pony Cheat Sheet](https://www.ponylang.io/media/cheatsheet/pony-cheat-sheet.pdf) is exactly such a reference!

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
