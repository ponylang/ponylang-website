+++
draft = false
author = "seantallen"
description = "<< content >>"
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony February 19, 2023"
date = "2023-02-19T07:00:06-04:00"
+++

<< content >>

<!--more-->

## Items of Note

### `ponylang/postgres` Library

The first version of a pure Pony Postgres client library supported by the Pony core team has been released. It's very early days for `ponylang/postgres`. Except API churn, bugs, and a general lack of documentation. The [project README](https://github.com/ponylang/postgres/blob/main/README.md) details the current state of the project.

We'd love to have people trying to write programs using the library and joining us in the [pony postgres driver Zulip stream](https://ponylang.zulipchat.com/#narrow/stream/347592-pony-postgres-driver) to share their experiences.

Next up in the development of the library, documentation and support for [extended queries](https://www.postgresql.org/docs/current/protocol-flow.html#PROTOCOL-FLOW-EXT-QUERY).

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_02_14.m4a) from the February 14th, 2023 sync is available.

We had just about the shortest auto-generated agenda that we will probably ever have, so... mostly conversation about what Joe and Sean are going to be up to and how it won't generate a lot of agenda content for a while so Sync meetings might be a little light for a while.

If you are interested in attending a Pony Development Sync, please do! We have it on Zoom specifically because Zoom is the friendliest platform that allows folks without an explicit invitation to join. Every week, [a development sync reminder](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/Sync.20Reminder) with full information about the sync is posted to the [announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) on the Ponylang Zulip. You can stay up-to-date with the sync schedule by subscribing to the [sync calendar](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics). We do our best to keep the calendar correctly updated.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

Adrian Boyko reports that the February 17th Office Hours was:

Adrian, Nicolai, and Red attended so the discussion tended toward numeric and FFI issues. Adrian introduced Nicolai to his Pony SDR project, which is an example of a Pony program that does significant amounts of number crunching. We revisited the question of whether Pony should have primitive types for complex math and discussed why tuples and classes for complex math aren't sufficient for typical use-cases like signal processing. Discussion then shifted to questions concerning fixed-sized arrays in C structs and how to best represent them in Pony structs. Red demonstrated how the [CastXML](https://github.com/CastXML/CastXML) tool can be used to examine how members in structs are aligned. Finally, there was some discussion of the Pony compiler's `\packed\` annotation.

Does any or all of that sound interesting, if yes, you should join us some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

And if it doesn't sound interesting, you can join and steer the conversation in directions you find interesting, so really, there's no excuse to not attend!

## Releases

- [ponylang/http_server 0.4.4](https://github.com/ponylang/http_server/releases/tag/0.4.4)
- [ponylang/postgres 0.1.0](https://github.com/ponylang/postgres/releases/tag/0.1.0)

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week are are highlighting the [Pony Performance Cheatsheet](https://www.ponylang.io/reference/pony-performance-cheatsheet/), specifically [`error` versus error types](https://www.ponylang.io/reference/pony-performance-cheatsheet/#avoid-error).

The use of `error` in Pony is often confused for exceptions in other languages -- a critical difference is that, unlike exceptions, `error` contains no runtime information. (However, this does not mean `error` is free, there is a cost to unwind every time we hit `error`.) The alternative to `error` is an "error type" where we use a union of a successful return with an erroneous return, for example `(U64 | ZeroIsBad)`. In an error type, we always pay the cost of this union as we must match against this type to know if we have a `U64` or a `ZeroIsBad`. An added advantage of an error type is that we can extend it for more error cases. In the hypothetical function `Foo` in the linked section, if we later find that `1` is also "bad" we can redefine the return to be `(U64 | ZeroIsBad | OneIsAlsoBad)`. With this return type, we still pay the same cost to match against the type, but we can distinguish between `ZeroIsBad` and `OneIsAlsoBad`. This is not possible in the case of `error` where would only know that we hit an `error`, not specifically _what the error was_.

When should we use `error` versus an error type? It depends, but in general we can say two things: 1) prefer `error` when hitting the error is rare, 2) prefer error types when we need to distinguish between different erroneous situations.

## RFCs

Major changes in Pony go through a community driven process where members of the community can write up "requests for change" that detail what they think should be changed and why. RFCs can range from simple to complex. We welcome your participation.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
