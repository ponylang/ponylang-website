+++
draft = false
author = "seantallen"
description = "<< content >>"
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony May 21, 2023"
date = "2023-05-21T07:00:06-04:00"
+++

<< content >>

## Items of Note

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

<< content >>

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week we are diving back into the [Pony Tutorial](https://tutorial.ponylang.io/), specifically we are going to look at [Object Capabilities](https://tutorial.ponylang.io/object-capabilities/).

For those among us who are unfamiliar, Pony's object capabilities are part of its security design. Simply put, having a reference to an object in Pony implies authority to use that object. Put with more nuance, since Pony has no pointer arithmetic and is both type-safe and memory-safe it is not possible to create objects out nothing -- all objects must be created from some lineage of authority. Practically speaking this results in a pattern whereby a package designer will define reasonable levels of authority and users should use the most restrictive authority necessary. Why? From a package design perspective, we want to allow users options that match their needs (see [`net/auth.pony`](https://github.com/ponylang/ponyc/blob/c41393ce8e3003feeda8e0bd3aa20d019b191505/packages/net/auth.pony) for a good example of this). From a user perspective, we want to restrict what a package has the authority to do -- if we never restrict authority we end up with `AmbientAuth` everywhere which is effectively "no capability security" at all (looking again at [`net/auth.pony`](https://github.com/ponylang/ponyc/blob/c41393ce8e3003feeda8e0bd3aa20d019b191505/packages/net/auth.pony) you will see the "baseline" authority is `NetAuth` named after `net` itself).

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
