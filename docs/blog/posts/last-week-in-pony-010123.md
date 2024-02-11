---
draft: false
authors:
  - seantallen
description: "A bad bad bug was fixed."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - January 1, 2023"
date: 2023-01-01T07:00:06-04:00
---

The big news is that you should update your Pony version to 0.52.5. It's very important if you are using Pony 0.51.2 to 0.52.3 that you update as soon as possible.

<!-- more -->

## Items of Note

### Upgrade Your Pony Version

In the process of [improving auto-recovery for constructors](https://github.com/ponylang/ponyc/pull/4124), a very very very nasty bug was introduced Pony 0.51.2. The nasty bug is one where the compiler will allow you to mutate immutable objects thereby breaking the basic safety guarantees that Pony provides.

The bug was fixed in Pony 0.52.4 and a number of tests to assure that no such breakage happens in the future. Please update to Pony 0.52.5 to get the safety fix from 0.52.4 and a corresponding follow on in Pony 0.52.5.

### Some Instability Expected

In [Pony 0.52.3](https://github.com/ponylang/ponyc/releases/tag/0.52.3) we removed a sometimes unsafe garbage collection optimization. Runtime code that has been little used (or perhaps not at all used) over the years is now used a lot. Unfortunately, it appears that something in that code is suspect. Core team member Gordon Tisher has found that the unit tests for a project of his started segfaulting after the optimization was removed.

The bug in question is a very odd one and not obvious in its source. At the moment, we know there's clearly something in code that wasn't used prior to 0.52.3 that is causing a problem. It is possible that this problem or others might impact other Pony users.

All our tests including our nightly stress tests run without issue so we don't believe that any issues will be widespread. And, we suspect that any issues will probably share a root cause.

If you encounter any runtime segfaults with 0.52.3 or later that you didn't get prior to 0.52.3, please drop by the [runtime stream](https://ponylang.zulipchat.com/#narrow/stream/190365-runtime) in the [Ponylang Zulip](https://ponylang.zulipchat.com/) and let us know.

### New OpenSSL 3.0.7 builder image

We've added a new builder image with OpenSSL 3.0.7 installed. If you need a docker environment to test Pony programs with OpenSSL 3.0.7, you can use the new image.

It has two tags, `release` and `latest`. Release is updated with each new ponyc release, latest is updated every night with the most recent nightly version of ponyc.

See the [Docker Hub repository](https://hub.docker.com/r/ponylang/shared-docker-ci-x86-64-unknown-linux-builder-with-openssl_3.0.7/tags) for some additional information.

This is our first builder image to target the new OpenSSL 3.x API series and will be used to test various ponylang projects maintained by the core team for compliance with OpenSSL 3.x.

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

### Improve Range and Reverse

With the addition of empty Ranges nearing completion (see [pr #4280](https://github.com/ponylang/ponyc/pull/4280)), we once again want to highlight the official request to improve Range and Reverse in a consistent manner. During the RFC process for adding empty Ranges, we discussed potential traps within the current API which we would like to redesign out of possibility. A few different ideas were considered in the course of discussing the empty Ranges RFC, but we ultimately decided to accept the existing empty Ranges RFC in order to officially close _some_ of the known traps -- leaving the rest up to a new RFC to incorporate into a redesign. An example of a trap that will remain after empty Ranges are merged is that the type parameter to `Range` will still interact with numeric literals in an unexpected way so that `Range[ISize](0, 100, -1)` reasonably produces nothing (i.e., `[]`), but `Range[USize](0, 100, -1)` produces `[0]` -- this is because a `USize` literal of `-1` wraps around to the max `USize` value. Someone taking this issue should read the conversation around empty Ranges, consider the options presented there, and write up a new RFC that closes known traps in a consistent manner.

[rfcs #204](https://github.com/ponylang/rfcs/issues/204)

### Document use of `digestof`

We do not currently have a section or paragraph dedicated to helping new Pony developers learn the use of the `digestof` keyword. The first step to this issue is determining where it should go in the Tutorial, then deciding on the level of detail that should be included (i.e., should it be a section, a paragraph, a new page entirely, and so on). Someone taking this issue should have read through the Tutorial at least once (so you have an idea of all of its sections) and have used the `digestof` keyword. Ryan A. Hagenson (as the issue author and the writer here) is willing to help on this issue at any stage, reach out on the issue ticket or in Zulip.

[pony-tutorial issue #453](https://github.com/ponylang/pony-tutorial/issues/453)

## RFCs

Major changes in Pony go through a community driven process where members of the community can write up "requests for change" that detail what they think should be changed and why. RFCs can range from simple to complex. We welcome your participation.

The only RFC action this week was the ["Introduce Empty Ranges" RFC](https://github.com/ponylang/rfcs/blob/main/text/0076-introduce%20empty%20ranges.md) going into [PR review](https://github.com/ponylang/ponyc/pull/4280).

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
