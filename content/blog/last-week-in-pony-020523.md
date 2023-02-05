+++
draft = false
author = "seantallen"
description = "A week with a minimal amount of reported items."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony February 5, 2023"
date = "2023-02-05T07:00:06-04:00"
+++

This past week, there was no sync and no RFC activity and no big announcements. It was also a week that your author was very busy at work and so, put all that together and this week's Last Week in Pony is a light one.

<!--more-->

## Items of Note

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

We had a reasonably large crowd for Office Hours this week. Sean Allen, Adrian Boyko, Jason Carr, Red Davies, and Andrew Harris were all in attendance. A decent amount of time was spent with Red and Sean discussing the recent work on adding ["query support"](https://github.com/ponylang/postgres/tree/simple-query) to the official ponylang [Postgres driver](https://github.com/ponylang/postgres).

While query support work is ongoing, Sean was looking for Red to test-drive the API some and report back on any issues he might encounter so they could discuss them. All that aside, Sean reported he is moving at a regular clip towards having a 0.1.0 version released in the "not immediate, but also not distant future".

In addition to driver conversation, a wide variety of other topics were covered including a spirited debate about "let it crash" and if/when a program should exit if it encounters states that violate basic axioms of the program.

You should join us some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Highlighted Issues

Pony is a volunteer driven project. Nothing gets down without someone volunteering their time and helping to push things forward. Yes, there are folks who dedicate more time than others and a core team that dedicates time specifically for guiding Pony's development. Everyone's time is limited, so each week, we highlight a couple of issues that we hope will inspire someone to volunteer their time to help fix.

In addition to our highlighted issues, you can find more that we are looking for assistance on by visiting just about any [repository in the ponylang org](https://github.com/ponylang/) and looking for issues labeled with "help wanted".

If you are interested in working on either issue or any other issue from a Ponylang repository, you can get in touch on the issue in question or, even better, join us on the [Ponylang Zulip](https://ponylang.zulipchat.com/) to strike up a conversation.

This week's issues as selected by Ryan A. Hagenson are:

### Assign Param Syntax

We have an accepted RFC in need of implementation! Someone taking this issue should read through the RFC and reach out on the issue or Zulip before getting started.

[ponyc #4318](https://github.com/ponylang/ponyc/issues/4318)

### Add Parameterization Pattern

The Pony Patterns are an immensely helpful resource that has a few open issues for expansion. One pattern we need to write up a complete entry for is avoiding boxing via use of function parameterization. Reach out on the issue or Zulip before getting started.

[pony-patterns #15](https://github.com/ponylang/pony-patterns/issues/15)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
