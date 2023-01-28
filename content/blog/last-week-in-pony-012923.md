+++
draft = false
author = "seantallen"
description = "Two RFCs were accepted."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - January 29, 2023"
date = "2023-01-29T07:00:06-04:00"
+++

That week, we accepted two RFCs that will result in changes to Pony syntax and the standard library respectively.

<!--more-->

## Items of Note

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_01_24.m4a) from the January 24th, 2023 sync is available.

The January 24th development was a pretty brisk affair. We voted on two RFCs, both of which were accepted and we went through a few issues and PRs across a few repositories. The entire thing clocked in at around 30 minutes; quite a bit less than our usual hour.

If you are interested in attending a Pony Development Sync, please do! We have it on Zoom specifically because Zoom is the friendliest platform that allows folks without an explicit invitation to join. Every week, [a development sync reminder](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/Sync.20Reminder) with full information about the sync is posted to the [announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) on the Ponylang Zulip. You can stay up-to-date with the sync schedule by subscribing to the [sync calendar](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics). We do our best to keep the calendar correctly updated.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

This past week's office hours was a very casual affair. During most of it, Sean was screensharing and working on the [postgres library](https://github.com/ponylang/postgres). While he was doing that, there was a decent amount of conversation, some computer related, some not, with Jason Carr and Adrian Boyko driving most of it.

There was a decent amount of discussion about object capabilities, Rust, Scala and effects that was as Jason put it, him being "vaguely coherent" on the topic.

If you are interested in computer science or Pony, we suggest you join us sometime. There's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Highlighted Issues

Pony is a volunteer driven project. Nothing gets down without someone volunteering their time and helping to push things forward. Yes, there are folks who dedicate more time than others and a core team that dedicates time specifically for guiding Pony's development. Everyone's time is limited, so each week, we highlight a couple of issues that we hope will inspire someone to volunteer their time to help fix.

In addition to our highlighted issues, you can find more that we are looking for assistance on by visiting just about any [repository in the ponylang org](https://github.com/ponylang/) and looking for issues labeled with "help wanted".

If you are interested in working on either issue or any other issue from a Ponylang repository, you can get in touch on the issue in question or, even better, join us on the [Ponylang Zulip](https://ponylang.zulipchat.com/) to strike up a conversation.

This week's issues as selected by Ryan A. Hagenson are:

### Inconsistency on embedded Array literal

There is currently an inconsistency around the handling of embedded Array literals where an empty literal compiles, while a non-empty literal fails to compile. There is an associated Zulip conversation for this issues so something taking this issue should read that conversation and work from there.

[ponyc #4170](https://github.com/ponylang/ponyc/issues/4178)

### Flesh out intro to types chapter

Chapter intros should give the reader the "why" of the chapter and, if relevant, give a high-level overview of the chapter content. This is missing from the Types intro. Someone taking this issue should feel comfortable giving a high-level overview of the types within Pony. Feel free to reach out to Ryan A. Hagenson on the issue ticket or on Zulip for additional questions.

[pony-tutorial #73](https://github.com/ponylang/pony-tutorial/issues/73)

## RFCs

Major changes in Pony go through a community driven process where members of the community can write up "requests for change" that detail what they think should be changed and why. RFCs can range from simple to complex. We welcome your participation.

### Accepted RFCs

- [Assign Param Syntax](https://github.com/ponylang/rfcs/blob/main/text/0077-assign-param-syntax.md)
- [Remove `json` package from standard library](https://github.com/ponylang/rfcs/blob/main/text/0078-remove-json-package-from-stdlib.md)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
