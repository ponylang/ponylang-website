---
draft: false
author: "seantallen"
description: "A fairly regular week."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - January 15, 2023"
date: 2023-01-15T07:00:06-04:00
---

Most of the "above ground" Pony activity this week was our usual weekly development sync meeting and our weekly office hours.

<!--more-->

## Items of Note

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_01_10.m4a) from the January 10th, 2023 sync is available.

So here's the story, Sean is supposed to write up the summary of what happened, but he waited until Friday to do it and.... HE DOESN'T REMEMBER. So, no summary for you. You'll just have to listen and find out.

If you are interested in attending a Pony Development Sync, please do! We have it on Zoom specifically because Zoom is the friendliest platform that allows folks without an explicit invitation to join. Every week, [a development sync reminder](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/Sync.20Reminder) with full information about the sync is posted to the [announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) on the Ponylang Zulip. You can stay up-to-date with the sync schedule by subscribing to the [sync calendar](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics). We do our best to keep the calendar correctly updated.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

The first half of office hours was spent helping Jairo figure out what he needed to do to get [mfelsche/pony-ast](https://github.com/mfelsche/pony-ast/) and its dependency on libponyc-standalone working on MacOS. At the moment, libponyc-standalone is only being built on Linux platforms. Getting it working on other platforms was left "to a future user". It was initially thought that "future user" would be Sean Allen who got it building for Linux. However, time has intervened and Sean hasn't been working on the project that used it which means that Jairo who is doing development for his [pony-language-server](https://github.com/kidandcat/pony-language-server) on MacOS is now the "future user" (at least in terms of getting libponyc-standalone working on MacOS).

libponyc is the library that the Pony compiler uses to provide all its "actual compiler functionality". libponyc can be used by other applications that need to provide "compiler like functionality" such as Jairo's language server.

libponyc-standalone is a version of libponyc that contains all its dependencies statically linked which makes linking and distribution much much easier to do than trying to get a shared library version working. Without a working libponyc-standalone, in order to link to libponyc, a user needs to do a lot of setup to replicate the environment that is used to build the Pony compiler.

The second half of office hours was sans Sean and according to Adrian Boyko: "We talked a bit about schedulers and generational references".

Interested in giving attending Office Hours sometime? There's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Highlighted Issues

Pony is a volunteer driven project. Nothing gets down without someone volunteering their time and helping to push things forward. Yes, there are folks who dedicate more time than others and a core team that dedicates time specifically for guiding Pony's development. Everyone's time is limited, so each week, we highlight a couple of issues that we hope will inspire someone to volunteer their time to help fix.

In addition to our highlighted issues, you can find more that we are looking for assistance on by visiting just about any [repository in the ponylang org](https://github.com/ponylang/) and looking for issues labeled with "help wanted".

If you are interested in working on either issue or any other issue from a Ponylang repository, you can get in touch on the issue in question or, even better, join us on the [Ponylang Zulip](https://ponylang.zulipchat.com/) to strike up a conversation.

This week's issues as selected by Ryan A. Hagenson are:

### Runtime crash caused by capture before initialization

Found this week! It is currently possible to capture an object in a lambda before it is initialized, leading to a runtime crash when this should be a compile-time error. Someone taking this issue should feel comfortable working with the compiler and understand how reference capabilities interact with the ability to capture objects.

[ponyc #4301](https://github.com/ponylang/ponyc/issues/4301)

### Finalisers not run under certain conditions

Under specific circumstances finalisers on an actor are not being run. When a program is run using `--ponynoblock`, actors in a cycle do not have their finalization procedure run before quiescence and program exit. Someone taking this issue should feel comfortable working with the compiler and understand how the current runtime and cycle detector cause the incorrect order of events under these conditions.

[ponyc #4257](https://github.com/ponylang/ponyc/issues/4257)

## RFCs

Major changes in Pony go through a community driven process where members of the community can write up "requests for change" that detail what they think should be changed and why. RFCs can range from simple to complex. We welcome your participation.

### Final Comment Period

- [Remove json package from the standard library](https://github.com/ponylang/rfcs/pull/208)
- [Parameter assignment syntax](https://github.com/ponylang/rfcs/pull/174)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
