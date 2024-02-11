---
draft: false
author: "seantallen"
description: "A relatively uneventful week."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony March 12, 2023"
date: 2023-03-12T07:00:06-04:00
---

Not a ton of above ground activity with Pony this last week, so this is a fairly short LWIP. Sean's work project crunch is winding down so expect more activity from him over the next few months.

<!--more-->

## Items of Note

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_03_07.m4a) from the March 7th, 2023 sync is available.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

Adrian and Red attended Office Hours this week and discussed the syntax and implementation of pony Structs. There was some confusion around how structs in pony map to C, so we wrote some examples to test our understanding.  For example, (constructors not included):

```pony
struct StructA
  var x: U64 = U64(42)

struct StructB
  var xa: StructA
  embed xb: StructA
  var xc: NullablePointer[StructA]
  var xd: Pointer[StructA]
```

In our example we created a single StructA and then used that to populate all of the fields in StructB. Then, using lldb we examined the address in each of the fields to see what they pointed to.

A somewhat esoteric Office Hours this week, but one that was interesting and did surprise. A good time was had by most.

You should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

And if it doesn't sound interesting, you can join and steer the conversation in directions you find interesting, so really, there's no excuse to not attend!

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week we go to space! In a galaxy not so far away, there is a planet inhabited entirely by actors, where ponies run wild without exception. Off to [Planet Pony](https://www.ponylang.io/community/planet-pony/)! Planet Pony is the manually curated list of Pony-related talks, papers, and blog posts.

Today we are going to look at 2020's [Pony, Actors, Causality, Types, and Garbage Collection](https://www.infoq.com/presentations/pony-types-garbage-collection/). This talk by Sophia Drossopoulou -- who was part of the original Pony team -- discusses many aspects of Pony. Sophia covers a wide breadth of Pony and its design decisions. Specifically, she discusses: actors (concurrent objects), causality (message passing and delivery), the type system (reference capabilities), and garbage collection (ORCA). Anyone in the Pony community who has not yet seen this talk should watch it.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
