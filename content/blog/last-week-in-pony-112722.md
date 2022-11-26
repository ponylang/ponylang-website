+++
draft = false
author = "seantallen"
description = "<<content>>"
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - November 27, 2022"
date = "2022-11-27T07:00:06-04:00"
+++

<<content>>

<!--more-->

## Items of Note

### Ending MacOS on Intel as a fully supported platform

Our CI provider, CirrusCI is ending support for MacOS on Intel at the end of the year. At that time, we will be dropping "full support" for MacOS on Intel and moving it to "best effort".

"Full support" means that all changes are run through CI on the platform and we provide binaries of ponyc and other tools. When MacOS on Intel becomes "best effort", we will no longer be providing binaries of the various pony tools and we will no longer be doing CI on MacOS on Intel. We will continue to do MacOS CI on Apple Silicon and provide binaries for Apple Silicon as well.

If anyone is interested in keeping some level of MacOS on Intel going, you can use Nix or look into becoming a maintainer for the various Pony tools using Homebrew. It appears that ponyc is being kept up-to-date with our releases. We're not sure about corral and we don't believe that Homebrew is currently supporting ponyup.

### New Pony Version Coming Soon

Sean T. Allen merged a fix for variety of race conditions in cycle detector/actor interactions. The fixed issues were marked as "triggers release". "Triggers release" is a tag we have on a number of issues that means "we should do a release soon after this".

Sean has been holding back doing an immediate release in hopes of getting [a fix](https://github.com/ponylang/ponyc/pull/4256) for [issue #1118](https://github.com/ponylang/ponyc/issues/1118) in as well. Either way, expect a new version of ponyc to be released by December 1st.

## Distributed Cycle Detector Work Underway

Sean T. Allen has started working on replacing Pony's [centralized cycle detector](https://github.com/ponylang/ponyc/blob/main/src/libponyrt/gc/cycle.c) with a [distributed one](https://ponylang.zulipchat.com/#narrow/stream/190365-runtime/topic/new.20.22cycle.20detector.22) that works on local knowledge and message passing.

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2022_11_22.m4a) from the November 22nd, 2022 sync is available.

This week's sync went from one where Sean was expecting to do a solo sync going over issues and record the process to a fairly "group-oriented sync". Attendees this week were: Sean T. Allen, Joe Eli McIlvain, Jason Carr, Red Davies, and Adrian Boyko.

We covered a number of issues and PRs across the RFC and ponyc repos. A decent amount of time was spent giving a quick history of the cycle detector as it relates to a PR from Sean that fixed a couple of race conditions in actor/cycle detector interactions and some live triaging of a nasty type system bug by Jason and Joe.

Some sync meetings aren't very exciting. This is a good one, and if you don't often listen to the recordings, we would give this a rating of: "worth your time".

If you are interested in attending a Pony Development Sync, please do! We have it on Zoom specifically because Zoom is the friendliest platform that allows folks without an explicit invitation to join. Every week, [a development sync reminder](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/Sync.20Reminder) with full information about the sync is posted to the [announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) on the Ponylang Zulip. You can stay up-to-date with the sync schedule by subscribing to the [sync calendar](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics). We do our best to keep the calendar correctly updated.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

Most of Office Hours this week was dedicated to helping Adrian Boyko in his investigation of [ponyc issue #3658](https://github.com/ponylang/ponyc/issues/3658). Adrian had made decent progress on the issue and came into Office Hours with some questions related to code in `subtype.c`. Sean helped him a bit with some understanding and then Jason Carr joined in with a proposed solution to the bug that Adrian will be implementing and testing.

We finished up this week with a series of conversations between the various attendees: Sean T. Allen, Adrian Boyko, Jason Carr, and Ryan A. Hagenson.

Interested in giving attending Office Hours sometime? There's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Releases

- [ponyup 0.6.8](https://github.com/ponylang/ponyup/releases/tag/0.6.8)

## Highlighted Issues

Pony is a volunteer driven project. Nothing gets down without someone volunteering their time and helping to push things forward. Yes, there are folks who dedicate more time than others and a core team that dedicates time specifically for guiding Pony's development. Everyone's time is limited, so each week, we highlight a couple of issues that we hope will inspire someone to volunteer their time to help fix.

In addition to our highlighted issues, you can find more that we are looking for assistance on by visiting just about any [repository in the ponylang org](https://github.com/ponylang/) and looking for issues labeled with "help wanted"

If you are interested in working on either issue or any other issue from a Ponylang repository, you can get in touch on the issue in question or, even better, join us on the [Ponylang Zulip](https://ponylang.zulipchat.com/) to strike up a conversation.

This week's issues as selected by Ryan A. Hagenson are:

### Introduction of Empty Ranges (accepted RFC)

After much community discussion, we have a new accepted RFC! Someone taking this issue should read through the accepted RFC text and implement the changes according to that content. The discussion around this RFC included additional conversation which became a [new open request](https://github.com/ponylang/rfcs/issues/204). This conversation will continue, but the accepted RFC content is ready for implementation!

[ponyc issue #4255](https://github.com/ponylang/ponyc/issues/4255)

### Explain Numerics in Greater Details

One advantage the Pony community has been lucky to experience is being the first language for some developers wherein they must consider numeric widths, signed versus unsigned integers, and overflow/underflow of numeric types. Someone taking this issue should should read the existing ticket and feel comfortable address how these aspects of numeric interact. Since the issue itself is fairly succinct, please feel free to reach out to Ryan A. Hagenson either within the issue itself or on Zulip for any additional clarity.

[pony tutorial issue #486](https://github.com/ponylang/pony-tutorial/issues/486)

## RFCs

Major changes in Pony go through a community driven process where members of the community can write up "requests for change" that detail what they think should be changed and why. RFCs can range from simple to complex. We welcome your participation.

This week, we've had a couple of requests for RFCs. Requests for RFC means that either the Pony core team or a community member is requesting that someone write an RFC to solve a specific problem.

In addition to our two RFC requests, the "introduce empty ranges" RFC was accepted and is ready for someone to implement it.

### Official Requests

Requests for someone to create an RFC for "issue X" from the Pony core team.

- [Improve Range and Reverse](https://github.com/ponylang/rfcs/issues/204)

### User Requests

Requests for someone to create an RFC for "issue X" from a Pony user.

- [Add StdStream error reporting mechanism](https://github.com/ponylang/rfcs/issues/205)

### Accepted RFCs

RFCs that have been accepted and can be now be implemented.

- [Introduce Empty Ranges](https://github.com/ponylang/rfcs/pull/201)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
