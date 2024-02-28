---
draft: false
authors:
  - seantallen
  - ryan
description: "A quiet week in Pony"
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - September 24, 2023"
date: 2023-09-24T07:00:06-04:00
---

A quiet week.

<!-- more -->

## Items of Note

### Pony Development Sync

[Audio](https://vimeo.com/917349906) from the September 19th, 2023 sync is available.

We kept a tight 20 minutes on this week's sync. Bang bang bang. Not a lot that would be of interest to the casual listening public, but, it's only 20 minutes, so heck. Give it a listen.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

There were no Office Hours this week while Sean was out on vacation.

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

Writing generics in Pony sometimes requires allowing for multiple reference capabilities. The solution to this are constraints, which we have a [page in the Tutorial about](https://tutorial.ponylang.io/generics/generic-constraints).

Looking at this page, we can see that constraints are applied to the type parameters. The most permissive combination is `class Foo[A: Any #any]` which is `Any` type with `#any` reference capability; this is also the default combination when both are left out so is equivalent to writing `class Foo[A]`.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
