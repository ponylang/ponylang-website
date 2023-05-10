+++
draft = false
author = "seantallen"
description = "<< content >>"
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony May 14, 2023"
date = "2023-05-14T07:00:06-04:00"
+++

<< content >>

## Items of Note

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_05_09.m4a) from the May 9th, 2023 sync is available.

<< content >>

If this sort of thing interests you, please feel free to attend a Pony Development Sync. We have it on Zoom specifically because Zoom is the friendliest platform that allows folks without an explicit invitation to join. Every week, [a development sync reminder](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/Sync.20Reminder) with full information about the sync is posted to the [announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) on the Ponylang Zulip. You can stay up-to-date with the sync schedule by subscribing to the [sync calendar](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics). We do our best to keep the calendar correctly updated.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

<< content >>

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Releases

<< content >>

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week we are going to look at [Pony Arithmetic within the Tutorial](https://tutorial.ponylang.io/expressions/arithmetic.html). Specifically, I want to draw your attention to the [default (safe) arithmetic](https://tutorial.ponylang.io/expressions/arithmetic.html#ponys-default-integer-arithmetic) being safe while there is also an option for [unsafe arithmetic](https://tutorial.ponylang.io/expressions/arithmetic.html#unsafe-integer-arithmetic). What is the difference? By default, Pony arithmetic properly handles overflow, underflow, and division by zero (the last of which is defined to return zero). If raw performance is desired and you can guarantee safety yourself, use the unsafe arithmetic. What should you do if you want something in between? Arithmetic that errors on overflow, underflow, and division by zero rather than the default safety decisions or undefined behavior: we also have [partial arithmetic](https://tutorial.ponylang.io/expressions/arithmetic.html#partial-and-checked-arithmetic) operators. Pony has many ways to conduct arithmetic operations, choose the one that is correct for your use case!

If you have questions, feel free to visit the [Ponylang Zulip](https://ponylang.zulipchat.com), where the best place to ask questions about Pony arithmetic is the [beginners-help channel](https://ponylang.zulipchat.com/#narrow/stream/189985-beginner-help).

## RFCs

Major changes in Pony go through a community driven process where members of the community can write up "requests for change" that detail what they think should be changed and why. RFCs can range from simple to complex. We welcome your participation.

<< content>>

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
