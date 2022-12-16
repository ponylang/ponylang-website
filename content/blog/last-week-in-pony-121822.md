+++
draft = false
author = "seantallen"
description = "A long standing pony runtime safety issue was fixed and along with it, came a performance hit. We'll be working on incrementally decreasing that performance hit."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - December 18, 2022"
date = "2022-12-18T07:00:06-04:00"
+++

The big news for this week is that we merged and release a safety fix that can have a large impact on performance for applications that send lots of messages that need to be traced by the garbage collector. We'll be incrementally adding back in performance as we make the compiler smarter.

<!--more-->

## Items of Note

### The Performance Hit is Here

[The fix](https://github.com/ponylang/ponyc/pull/4256) for [ponyc issue #1118](https://github.com/ponylang/ponyc/issues/1118) and with it, the performance hit covered in [last week's Last Week in Pony](https://www.ponylang.io/blog/2022/12/last-week-in-pony---december-11-2022/#a-performance-hit-is-coming) is here.

The fix was merged on the afternoon of the 13th. Nightlies starting from the 14th and the [0.52.3 release](https://github.com/ponylang/ponyc/releases/tag/0.52.3) from Friday have the safety fix in place.

### MacOS on Intel is no longer a fully supported platform

A few weeks back, we [announced that we would be dropping support for MacOS on Intel](https://www.ponylang.io/blog/2022/11/last-week-in-pony---november-27-2022/#ending-macos-on-intel-as-a-fully-supported-platform). At the time, we said that we would be doing it "before the end of the year", well, "before the end of the year is here". On December 12th, we merged the changes to drop MacOS on Intel support from ponyc, corral, and ponyup.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

<<content>>

Interested in giving attending Office Hours sometime? There's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Releases

- [ponyc 0.52.3](https://github.com/ponylang/ponyc/releases/tag/0.52.3)

## Highlighted Issues

Pony is a volunteer driven project. Nothing gets down without someone volunteering their time and helping to push things forward. Yes, there are folks who dedicate more time than others and a core team that dedicates time specifically for guiding Pony's development. Everyone's time is limited, so each week, we highlight a couple of issues that we hope will inspire someone to volunteer their time to help fix.

In addition to our highlighted issues, you can find more that we are looking for assistance on by visiting just about any [repository in the ponylang org](https://github.com/ponylang/) and looking for issues labeled with "help wanted"

If you are interested in working on either issue or any other issue from a Ponylang repository, you can get in touch on the issue in question or, even better, join us on the [Ponylang Zulip](https://ponylang.zulipchat.com/) to strike up a conversation.

This week's issues as selected by Ryan A. Hagenson are:

### Windows releases contain unneeded files

The Windows PowerShell script that builds `ponyc` includes files that are not needed. As we have very few Pony on Windows experts around, someone familiar with PowerShell could be a real help to us! Someone taking this issue should feel comfortable working with PowerShell -- other than that, follow what the issue says.

[ponyc issue #4272](https://github.com/ponylang/ponyc/issues/4272)

### Update Windows LibreSSL version

Calling all Pony on Windows users! If you want a relatively easy way to contribute to Pony, we need someone to update the version of LibreSSL that `crypto` is built against. We currently are building against 3.5.3 (released May 18th, 2022) with the latest release being 3.7.0 (December 12th, 2022). Someone taking this issue should feel comfortable working with PowerShell and build systems.

[ponylang crypto issue #72](https://github.com/ponylang/crypto/issues/72)

## RFCs

Major changes in Pony go through a community driven process where members of the community can write up "requests for change" that detail what they think should be changed and why. RFCs can range from simple to complex. We welcome your participation.

This week, we've had a couple of requests for RFCs. Requests for RFC means that either the Pony core team or a community member is requesting that someone write an RFC to solve a specific problem.

In addition to our two RFC requests, the "introduce empty ranges" RFC was accepted and is ready for someone to implement it.

### User Requests

Requests for someone to create an RFC for "issue X" from a Pony user.

- [proposal syntax else ... then for else keyword in conditional branchs](https://github.com/ponylang/rfcs/issues/207)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
