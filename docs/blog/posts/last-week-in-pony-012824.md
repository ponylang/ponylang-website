---
draft: false
author: "seantallen"
description: "More fun than a trip to Buc-ee's."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - January 28, 2024"
date: 2024-01-28T07:00:06-04:00
---

## Items of Note

### New Pony Pattern

A new Pony Pattern ["Static Constructor"](https://patterns.ponylang.io/creation/static-constructor) has been added.

### Lori Joins The Ponylang Organization

Sean T. Allen's [Lori](https://github.com/ponylang/lori) project has become a [ponylang org](https://github.com/ponylang/) project.

Its new home is [https://github.com/ponylang/lori](https://github.com/ponylang/lori).

The plan is for it to someday provide the functionality of our standard library TCP classes as well as a set of drop-in replacement classes so that it can be moved into the standard library.

Interested in help? Drop by the [Zulip's 'contribute to Pony' stream](https://ponylang.zulipchat.com/#narrow/stream/192795-contribute-to-Pony) and let's chat.

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2024_01_23.m4a) from the January 23rd, 2024 sync is available.

We had a short agenda. Most of it was spent discussing the new [Constrained Types RFC](https://github.com/ponylang/rfcs/pull/213) which underwent some naming revisions as a result.

### Office Hours

We have an open Zoom meeting every week for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try. The meeting is open to anyone. Stay up-to-date with the schedule by [subscribing to the Office Hours calender](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics). Hopefully, we'll see you at an Office Hours soon.

Adrian and Sean talked about grapefruit. If you had shown up and asked some Pony questions, we would have talked about Pony. If you had shown up and asked "does dynamic scoping have an undeserved bad reputation", we would have talked about dynamic scoping. But you didn't so here we are.

[.](https://www.youtube.com/watch?v=I1ds5KfglWE)

## Releases

- [ponylang/github_rest_api 0.1.4](https://github.com/ponylang/github_rest_api/releases/tag/0.1.4)
- [ponylang/http 0.6.0](https://github.com/ponylang/http/releases/tag/0.6.0)
- [ponylang/ponyc 0.58.1](https://github.com/ponylang/ponyc/releases/tag/0.58.1)

## RFCs

### New RFCs

- [Constrained Types](https://github.com/ponylang/rfcs/pull/213)

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week we are going to draw our attention to the new ["Static Constructor"](https://patterns.ponylang.io/creation/static-constructor) pattern. This pattern is one that you can use if you want to construct objects that may fail construction or return a helpful error upon failure. By default Pony constructors either return a fully initialized instance of their class or, if the constructor is partial, fail completely via `error` handling. If instead we want insight into _why_ construction failed we should use the new ["Static Constructor"](https://patterns.ponylang.io/creation/static-constructor) pattern!

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
