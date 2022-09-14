+++
draft = false
author = "red"
description = ""
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - September 11th, 2022"
date = "2022-09-11T00:00:00-05:00"
+++

Lots of news this week!  New releases and new projects oh my!  So much that I'll be skipping a principle this week.

<!--more-->

## New Releases

### Version 0.51.2 of ponylang/ponyc has been released.

See the full [release notes](https://github.com/ponylang/ponyc/releases/tag/0.51.2) for full details but here are the highlights!

- New Features:
  - Support for RISC-V.
  - Enhanced runtime stats tracking.
  - Allow constructor expressions to be auto-recovered in assignments or arguments.

- Fixes
  - Fix compiler crash related to using private types as default arguments.
  - Fix "incorrect" atomics usage.

### Version 0.4.2 of ponylang/http\_server has been released.

See the full [release notes](https://github.com/ponylang/http_server/releases/tag/0.4.2) 

- Fixes
  - Updated default connection heartbeat to 1000ms

### Version 0.2.2 of seantallen-org/lori has been released.

See the full [release notes](https://github.com/seantallen-org/lori/releases/tag/0.2.2)

- Fixes
  - Corrected handling of failing outgoing connections.

## Items of note

One of your author's projects involves a substantial amount of pulling data from various network devices and pony has been exceptional at the task.  A task that would typically take days to execute using a common OpenSource tool wcan be performed in ten or so minutes.  Pony moved the bottleneck to the network, where it should be.

However, the challenge is then how to get that data into a database for the rest of the business processes to be able to analyze.  A look around found that there was a lack of a Pony driver for PostgreSQL, the database we used due to its excellent ipaddr and cidr data-types.

After a weekend or two your Author has written a Proof of Concept [Pure Pony driver for PostgreSQL](https://github.com/redvers/pony-pg). Given the importance of such a driver and after some discussion we have decided that the Ponylang Team will take my PoC and build it as an Official Ponylang Project.

Starting in a few weeks Sean Allen and myself will be working together during [Office Hours](https://ponylang.zulipchat.com/#narrow/stream/189934-general/topic/Office.20hours) to complete this task. I'm excited to have my Pony knocked into a more standard shape :)

## Issues of the Week

Each week, we will highlight "good first issues" from the Pony ecosystem that we're trying to motivate someone to spend a bit of time on closing. If we close the issue of the week every week, by the next week, it will really add up and help Pony move forward quicker. So hey, how about you make this week your week?

This week we have issues from both the ponyc and the pony-tutorial repositories:

- pony-tutorial
  - ["Making usage of `this` more apparent"](https://github.com/ponylang/pony-tutorial/issues/458)
  - ["Remove "person" from the Type Aliases description"](https://github.com/ponylang/pony-tutorial/issues/446)

- ponyc
  - ["cli.Arg silently ignores type casting errors"](https://github.com/ponylang/ponyc/issues/3244)
  - ["Improve type mismatch error message by providing hints when the solution might be guessable from the compiler"](https://github.com/ponylang/ponyc/issues/2083)

Until next week, Pony On!

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
