+++
draft = false
author = "seantallen"
description = "<< short description content >>"
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - December 04, 2022"
date = "2022-12-04T07:00:06-04:00"
+++

<< overview/intro content >>

<!--more-->

## Items of Note

### Dropping Rocky 8 support

We can no longer get ponyc building in our Rocky 8 CI environment. After spending several hours attempting to get it working, we were unable to. Rocky 8 prebuilt binaries was added at the request of a user in 2021. We said we would do our best to maintain support.

At this point, we don't feel able to support Rocky 8 and are dropping support. If anyone using ponyc on Rocky 8 wants to get the CI environment working and open a PR to re-add support, we'll happily accept it.

The current issue involves libatomic not being found during linking. If you would like to assist, hop into the [CI stream]() on the ponylang Zulip.

### FreeBSD 13.1 is our supported FreeBSD version

This week we merged support for FreeBSD 13.1 and moved our ponyc CI system to test against FreeBSD 13.1 rather than 13.0. All pre-built ponyc binaries will be built for FreeBSD 13.1 as of November 29. Corral and Ponyup will be moving soon but no date is set yet.

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2022_11_29.m4a) from the November 29th, 2022 sync is available.

Our weekly sync call was primarily dominated by conversation about two topics. A discussion of issues around [the fix](https://github.com/ponylang/ponyc/pull/4256) for [issue #1118](https://github.com/ponylang/ponyc/issues/1118) and discussion of options for [alerting to errors from StdStream](https://github.com/ponylang/rfcs/issues/205).

It was an excellent call. Not at all an ordinary "marching through tickets" sync. This would be one we recommend for folks who "listen to the recording sometimes".

If you are interested in attending a Pony Development Sync, please do! We have it on Zoom specifically because Zoom is the friendliest platform that allows folks without an explicit invitation to join. Every week, [a development sync reminder](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/Sync.20Reminder) with full information about the sync is posted to the [announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) on the Ponylang Zulip. You can stay up-to-date with the sync schedule by subscribing to the [sync calendar](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics). We do our best to keep the calendar correctly updated.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

<< office hours summary from ryan >>

Interested in giving attending Office Hours sometime? There's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Releases

- [ponyup 0.52.2](https://github.com/ponylang/ponyc/releases/tag/0.52.2)

## Highlighted Issues

Pony is a volunteer driven project. Nothing gets down without someone volunteering their time and helping to push things forward. Yes, there are folks who dedicate more time than others and a core team that dedicates time specifically for guiding Pony's development. Everyone's time is limited, so each week, we highlight a couple of issues that we hope will inspire someone to volunteer their time to help fix.

In addition to our highlighted issues, you can find more that we are looking for assistance on by visiting just about any [repository in the ponylang org](https://github.com/ponylang/) and looking for issues labeled with "help wanted"

If you are interested in working on either issue or any other issue from a Ponylang repository, you can get in touch on the issue in question or, even better, join us on the [Ponylang Zulip](https://ponylang.zulipchat.com/) to strike up a conversation.

This week's issues as selected by Ryan A. Hagenson are:

### stdlib documentation

We still have some stdlib packages with limited documentation. Someone taking this issue should feel comfortable writing documentation and have a general ability to read Pony code. However, it is by no means expected that a new contributor tackle all of stdlib's documentation so feel free to start small! A good example of good documentation in stdlib (in my, Ryan A. Hagenson's, opinion) is [pony_check](https://stdlib.ponylang.io/pony_check--index/), which has a good mix of usability focused examples and purpose-driven API explanations.

[ponyc issue #3280](https://github.com/ponylang/ponyc/issues/3280)

### Improve Range and Reverse

During the discussion of the [empty ranges RFC](https://github.com/ponylang/rfcs/pull/201), we noted there are still a considerable number of footguns in the ranges API that warrant a redesign. Someone taking this issue should read through the previous discussion, take previously mentioned concerns into mind, and write up an RFC proposing a new `Range` and `Reverse` to replace the current design.

[rfc issue #204](https://github.com/ponylang/rfcs/issues/204)

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
