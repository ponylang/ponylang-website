+++
draft = false
author = "seantallen"
description = "Looking for some Xcode 15 testing help."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - October 22, 2023"
date = "2023-10-22T07:00:06-04:00"
+++

## Items of Note

### Xcode 15 Testing Help Needed

A few weeks back, [an issue](https://github.com/ponylang/ponyc/issues/4454) with linking Pony programs with Xcode 15 was reported by a MacOS user.

We have a fix that needs testing but haven't been able to get the assistance of anyone with Xcode 15 installed. If you can help, please contact us on Zulip or [visit the issue](https://github.com/ponylang/ponyc/issues/4454).

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_10_17.m4a) from the October 17th, 2023 sync is available.

This week's sync was focused on issues and PRs in the ponyc repo. Some of the issues were new, some were old. And then we were on discussing GitHub's support for MacOS on Apple Silicon.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

Sean, Dipin, and Red got together and talked about a wide variety of things. Most of which weren't Pony related, but a few were. They missed you.

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week let us look at [Program Annotations](https://tutorial.ponylang.io/appendices/annotations). Pony supports a select few annotations that are listed on this page. They are `packed`, `likely`, `unlikely`, `nodoc`, and `nosupertype`. `packed` removes padding in a `struct`. `likely` and `unlikely` are opposites that can be used independently in order to give optimization hints to the compiler about likely and unlikely code paths, respectively. `nodoc` will remove an object/method and its children from generated documentation. `nosupertype` removes an object from the type hierarchy, including no longer being a subtype of `Any`.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
