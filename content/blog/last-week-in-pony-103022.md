+++
draft = false
author = "seantallen"
description = "Return of the Mack"
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - July 3, 2022"
date = "2022-10-30T07:00:06-04:00"
+++

Welcome to the latest issue of the "mostly weekly" Pony newsletter "Last Week in Pony". We've got a lot to catch up on as we've been a little remiss in keeping a regular LWIP schedule. We suggest the following soundtrack for this week's episode... ["Return of the Mack"](https://www.youtube.com/watch?v=uB1D9wWxd2w).

<!--more-->

## Items of Note

### Pony Development Sync

We're a little behind reporting the news of the week so, we have not 1 but 2
development syncs for you to catch up on:

- [Audio](https://sync-recordings.ponylang.io/r/2022_10_25.m4a) from the  October 25th, 2022 sync is available.
- [Audio](https://sync-recordings.ponylang.io/r/2022_10_18.m4a) from the October 18th, 2022 sync is available.

If you are interested in attending a Pony Development Sync, please do! We have it on Zoom specifically because Zoom is the friendliest platform that allows folks without an explicit invitation to join. Every week, [a development sync reminder](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/Sync.20Reminder) with full information about the sync is posted to the [announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) on the Ponylang Zulip. You can stay up-to-date with the sync schedule by subscribing to the [sync calendar](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics). We do our best to keep the calendar correctly updated.

### New Last Week in Pony Author

Sean T. Allen (that's me! I'm writing this but in the 3rd person like I'm Rickey Henderson) has taken over for Red Davies as the primary author of Last Week in Pony. Red's schedule was making it difficult for him keep up with the regular schedule that we want for Last Week in Pony.

Sean is rather busy with other Pony related volunteer work as well, so if you have the time and inclination (and writing and reporting chops) to take on Last Week in Pony ownership, please swing by the [Ponylang Zulip](https://ponylang.zulipchat.com/) let Sean know.

### Windows Support for Lori

Sean T. Allen has started work on adding Windows support to the [Lori networking library](https://github.com/seantallen-org/lori/).

Lori is an experimental Pony networking library based around [the mixin pattern](https://patterns.ponylang.io/code-sharing/mixin.html). The long-term goal with Lori is to have it incorporated into the Pony standard library.

Lori development has been mostly dormant for quite a while as Sean worked on other projects, however, Lori development has come back to life as it is being used as the networking library in the [Postgres library](https://github.com/ponylang/postgres) that Sean and Red Davies have been working on.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Lately, the meetings have been based around the work on getting a Postgres driver working and the corresponding work on Lori. Other office hours topics have been "open support time" where more experienced community member help others diagnose bugs or otherwise, get unstuck with the Pony projects they are working. And sometimes, it is just a gab fest. And sometimes, no one shows up!

Interested in giving attending a go? There's a [topic for that](https://ponylang.zulipchat.com/#narrow/stream/189934-general/topic/Office.20hours) in the Zulip.

This last week, the office hours was Sean working on adding Windows support to Lori while Adrian Boyko listened it. They did some actual work, found a bug in the existing Lori code, and spent a decent amount of time on Sean explaining the differences between IOCP and epoll/kqueue models for asynchronous network programming.

### New SSL builder images

The Pony core team makes images available to the community to do development &
testing of Pony programs. Our SSL images have been updated.

For testing and development that needs OpenSSL, a new image based on
OpenSSL 1.1.1q has been released. The 1.1.1n based image has been deprecated
and will be removed in 6 months. All previous OpenSSL builders are no longer
updated.

For testing and development that needs LibreSSL, a new image is also available.
The new LibreSSL image is based on version 3.5.3. The 3.5.2 image has been
deprecated and will be removed in 6 months. All previous LibreSSL builders are
no longer updated.

Each SSL builder has two tags, "release" and "latest". The release tag is
features an environment using the last ponyc release. The latest tag changes
daily and uses the last nightly ponyc.

To explore the various "shared docker" images that the core team makes
available, visit the [shared docker repository](https://github.com/ponylang/shared-docker).

## Releases

- Version 0.51.5 of ponylang/ponyc has been released. See the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.51.4) for more details.

## Highlighted Issues

Pony is a volunteer driven project. Nothing gets down without someone  volunteering their time and helping to push things forward. Yes, there are folks who dedicate more time than others and a core team that dedicates time specifically for guiding Pony's development. Everyone's time is limited, so each week, we highlight a couple of issues that we hope will inspire someone to volunteer their time to help fix.

In addition to our highlighted issues, you can find more that we are looking for assistance on by visiting just about any [repository in the ponylang org](https://github.com/ponylang/) and looking for issues labeled with "help wanted"
This weeks issues as selected by Ryan A. Hagenson are:

- Writing a Pony Pattern that addresses a regular beginner stumbling block using [generics and numbers](https://github.com/ponylang/pony-patterns/issues/46) together.
- Fixing [incorrect information in ponyc's `ponysuspendthreshold` help string](https://github.com/ponylang/ponyc/issues/3987).

The 2nd one is labeled as "good first issue" so, if you are interested in getting started with working on the Pony compiler, this is a good one to start with.

If you are interested in working on either issue or any other issue from a Ponylang repository, you can get in touch on the issue in question or even better, join us on the [Ponylang Zulip](https://ponylang.zulipchat.com/) strike up a conversation.

## RFCs

Major changes in Pony go through a community driven process were members of  the community can write up "requests for change" that detail what they think  should be changed and why. RFCs can range from simple to complex. We welcome your participation.

We have two RFCs that saw activity in the past week. The empty ranges RFC is  particularly good and it's clear that the author put a lot of work into it. If you are ever looking for a "model RFC", it's a good one to refer to.

### New

New RFCs that were introduced this week.

- [Inclusion of all erase codes in the Term package](https://github.com/ponylang/rfcs/pull/203)

### Final Comment Period

RFCs that are in a final comment period before they are either accepted or rejected.

- [Introduce Empty Ranges](https://github.com/ponylang/rfcs/pull/201)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
