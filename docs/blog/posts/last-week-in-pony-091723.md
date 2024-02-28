---
draft: false
authors:
  - seantallen
  - ryan
  - ryan
description: "Windows users, update your ponyc install."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - September 17, 2023"
date: 2023-09-17T07:00:06-04:00
---

Windows users, update your ponyc install.

<!-- more -->

## Items of Note

### Update your ponyc for Windows ASAP

We've released an important bug fix for Pony on Windows. You should update to 0.56.2 as soon as possible.

### Office Hours is Moving

Starting Friday October 6th, Office Hours is moving to a 12:30 Eastern start time. The calendar has been updated accordingly. Until then Office Hours will be at its normal time. It has been moved to accommodate Sean's new work schedule.

### Pony Development Sync

[Audio](https://vimeo.com/917349743) from the September 12th, 2023 sync is available.

This week's sync was a reasonably short affair. We ran through some PRs. Merged two important "want to get these out as soon as possible changes". We also discussed the ongoing permissions lockdown we've been doing around GitHub Actions to harden up our attack surface.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

Office Hours rather short this week. No Pony talk. We went for 15 minutes and learned a bit about Red's RV.

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Releases

- [ponylang/ponyc 0.56.1](https://github.com/ponylang/ponyc/releases/tag/0.56.1)
- [ponylang/ponyc 0.56.2](https://github.com/ponylang/ponyc/releases/tag/0.56.2)

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

One idea in Pony that may be unfamiliar to many is the concept of capabilities security. This is one of Pony's many "simple" ideas that have wider impact on Pony as a whole. To learn about capabilities, look at the [Object Capabilities](https://tutorial.ponylang.io/object-capabilities/object-capabilities) page of the Tutorial. The basic idea of object capabilities from a developer perspective is that they are unforgeable so having the reference **is** having the authority. But how do they appear in practice? As a package designer, you should define "authority objects" (e.g., [`FileAuth`](https://stdlib.ponylang.io/files-FileAuth/)) which then are required in your package to take certain actions (e.g., creating a file path via [FilePath.create](https://stdlib.ponylang.io/files-FilePath/#create)). As a package user, you should use the most specific authority object possible -- this is because you are handing authority to the package to do something, if you simply pass `AmbientAuth` (the root of all authority) to every package then you are giving complete authority to every package.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
