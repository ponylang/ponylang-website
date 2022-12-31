+++
draft = false
author = "seantallen"
description = "A bad bad bug was fixed."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - January 1, 2023"
date = "2023-01-01T07:00:06-04:00"
+++

The big news is that you should update your Pony version to 0.52.5. It's very important if you are using Pony 0.51.2 to 0.52.3 that you update as soon as possible.

<!--more-->

## Items of Note

### Upgrade Your Pony Version

In the process of [improving auto-recovery for constructors](https://github.com/ponylang/ponyc/pull/4124), a very very very nasty bug was introduced Pony 0.51.2. The nasty bug is one where the compiler will allow you to mutate immutable objects thereby breaking the basic safety guarantees that Pony provides.

The bug was fixed in Pony 0.52.4 and a number of tests to assure that no such breakage happens in the future. Please update to Pony 0.52.5 to get the safety fix from 0.52.4 and a corresponding follow on in Pony 0.52.5.

### Some Instability Expected

In [Pony 0.52.3](https://github.com/ponylang/ponyc/releases/tag/0.52.3) we removed a sometimes unsafe garbage collection optimization. Runtime code that has been little used (or perhaps not at all used) over the years is now used a lot. Unfortunately, it appears that something in that code is suspect. Core team member Gordon Tisher has found that the unit tests for a project of his started segfaulting after the optimization was removed.

The bug in question is a very odd one and not obvious in its source. At the moment, we know there's clearly something in code that wasn't used prior to 0.52.3 that is causing a problem. It is possible that this problem or others might impact other Pony users.

All our tests including our nightly stress tests run without issue so we don't believe that any issues will be widespread. And, we suspect that any issues will probably share a root cause.

If you encounter any runtime segfaults with 0.52.3 or later that you didn't get prior to 0.52.3, please drop by the [runtime stream](https://ponylang.zulipchat.com/#narrow/stream/190365-runtime) in the [Ponylang Zulip](https://ponylang.zulipchat.com/) and let us know.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

We took a break from discussing distributed cycle detection, the topic of our last couple Office Hours, and returned to a previous topic. Adrian, Sean, and Red spent a couple hours going over the problems with compile times that Red can into with his GTK wrapper library. After a lot of discussion to make sure the issue was fully understood, Sean suggested a slightly different design for Red to try that should greatly improved compile times.

Sean says... "It was nice to return to the using office hours to help solve a problem for a community member. Variety is after all, the spice of life."

Interested in giving attending Office Hours sometime? There's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Releases

- [ponyc 0.52.4](https://github.com/ponylang/ponyc/releases/tag/0.52.4)
- [ponyc 0.52.5](https://github.com/ponylang/ponyc/releases/tag/0.52.5)

## Highlighted Issues

Pony is a volunteer driven project. Nothing gets down without someone volunteering their time and helping to push things forward. Yes, there are folks who dedicate more time than others and a core team that dedicates time specifically for guiding Pony's development. Everyone's time is limited, so each week, we highlight a couple of issues that we hope will inspire someone to volunteer their time to help fix.

In addition to our highlighted issues, you can find more that we are looking for assistance on by visiting just about any [repository in the ponylang org](https://github.com/ponylang/) and looking for issues labeled with "help wanted"

If you are interested in working on either issue or any other issue from a Ponylang repository, you can get in touch on the issue in question or, even better, join us on the [Ponylang Zulip](https://ponylang.zulipchat.com/) to strike up a conversation.

This week's issues as selected by Ryan A. Hagenson are:

### fu

bar

### fu

bar

## RFCs

Major changes in Pony go through a community driven process where members of the community can write up "requests for change" that detail what they think should be changed and why. RFCs can range from simple to complex. We welcome your participation.

The only RFC action this week was the ["Introduce Empty Ranges" RFC](https://github.com/ponylang/rfcs/blob/main/text/0076-introduce%20empty%20ranges.md) going into [PR review](https://github.com/ponylang/ponyc/pull/4280).

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
