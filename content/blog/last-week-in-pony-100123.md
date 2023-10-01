+++
draft = false
author = "ryan"
description = "A new month in Pony!"
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - October 1, 2023"
date = "2023-10-01T10:24:02-04:00"
+++

It was another quiet week in Pony as Sync was fairly short, Office Hours has moved, and Sean is still out on vacation.

## Items of Note

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_09_26.m4a) from the September 26th, 2023 sync is available.

We kept it fairly short. We reviewed some PRs, and spent some time talking through [a type system issue causing a compiler crash](https://github.com/ponylang/ponyc/issues/4451).

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

There were no office hours this week. Please note that the time of Office Hours has changed; refer to the calendar (link below) to keep track of the schedule.

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week we are highlighting a much broader topic: [types](https://tutorial.ponylang.io/types/)!

Pony is an object-oriented language, but there are different kinds of objects. There are [classes](https://tutorial.ponylang.io/types/classes), which are the "normal objects" someone familiar with object-oriented languages are familiar with. Next, [Primitives](https://tutorial.ponylang.io/types/primitives), which are like classes with the exception of containing no fields and there being a single instance of each user-defined primitive. [Actors](https://tutorial.ponylang.io/types/actors) are asynchronous objects that have a mailbox and will process messages in the order they are received. The two abstract types in Pony are [Traits and Interfaces](https://tutorial.ponylang.io/types/traits-and-interfaces) which are nominal and structural typing, respectively. [Structs](https://tutorial.ponylang.io/types/structs) are objects for interaction with C-FFI. We also have the option to create [Type Aliases](https://tutorial.ponylang.io/types/type-aliases). Lastly, there are [type expressions](https://tutorial.ponylang.io/types/type-expressions#intersections) such as unions and intersections.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
