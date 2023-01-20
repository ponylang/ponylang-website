+++
draft = false
author = "seantallen"
description = "<< content >>"
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - January 22, 2023"
date = "2023-01-22T07:00:06-04:00"
+++

<< content >>

<!--more-->

## Items of Note

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

Office hours this week was a very low-key affair with Jason, Red, and Sean discussing a variety of topics. They decided the best summary of the meeting would be "we ended up discussing two different ways to hypnotize a chicken".

Hey, not every Office Hours is going to be a deep technical burner. The more folks who attend, the more likely it will be one though!

Interested in giving attending Office Hours sometime? There's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Releases

- [ponylang/ponyup 0.7.0](https://github.com/ponylang/ponylang/releases/tag/0.7.0)

## Highlighted Issues

Pony is a volunteer driven project. Nothing gets down without someone volunteering their time and helping to push things forward. Yes, there are folks who dedicate more time than others and a core team that dedicates time specifically for guiding Pony's development. Everyone's time is limited, so each week, we highlight a couple of issues that we hope will inspire someone to volunteer their time to help fix.

In addition to our highlighted issues, you can find more that we are looking for assistance on by visiting just about any [repository in the ponylang org](https://github.com/ponylang/) and looking for issues labeled with "help wanted".

If you are interested in working on either issue or any other issue from a Ponylang repository, you can get in touch on the issue in question or, even better, join us on the [Ponylang Zulip](https://ponylang.zulipchat.com/) to strike up a conversation.

This week's issues as selected by Ryan A. Hagenson are:

### Partial constructor application segfault

Partially applying a constructor can cause a segfault under certain conditions. The issue author did some initial investigation and Joe has posted notes from a previous Sync discussion on this issue. Someone taking this issue should read the notes posted by Joe and likely start their fix from there.

[ponyc #4240](https://github.com/ponylang/ponyc/issues/4240)

### Exceptions lack examples

Exceptions in Pony can be a tripping point and having concrete examples for why Pony has `error` rather than "exceptions" as many might know them. There is some existing content on the website about when to use `error` versus error types ([here](https://www.ponylang.io/reference/pony-performance-cheatsheet/#avoid-error)) so someone taking this issue is not starting from nothing. Unlike the website content, the Tutorial content should not weigh the performance trade-offs, but rather emphasize why Pony has the `error` that is does within the context of learning the language as a whole.

[pony-tutorial #292](https://github.com/ponylang/pony-tutorial/issues/292)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
