---
draft: false
authors:
  - seantallen
description: "The 'Constrained Types' RFC was accepted."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - February 11, 2024"
date: 2024-02-11T07:00:06-04:00
---

The 'Constrained Types' RFC was accepted.

<!-- more -->

## Items of Note

### We have a Bluesky Account

[Come say hi](https://bsky.app/profile/ponylang.bsky.social).

### Pony Development Sync

[Audio](https://vimeo.com/917352867) from the February 6th, 2024 sync is available.

We had a fairly short agenda this week. The highlight was the approval of the [Constrained Types RFC](https://github.com/ponylang/rfcs/pull/213).

### Office Hours

We have an open Zoom meeting every week for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try. The meeting is open to anyone. Stay up-to-date with the schedule by [subscribing to the Office Hours calender](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics). Hopefully, we'll see you at an Office Hours soon.

Office hours this week was mostly spent on discussing what looks like a memory clobbering bug that Sandro Covo managed to uncover. Sean has been working away at it, trying to figure out what is going on for quite some time. Every avenue he has explored so far has ended up "nope that doesn't appear to be it".

Unfortunately, the "minimal reproduction" is quite large. Fortunately, the "workaround" is a change that would have been suggested to Sandro for clarity and performance.

Sean has sometimes tracked such issue down quickly, sometimes it has taken months. Fortunately, they are a very rare occurrence. If anyone wants to take a swing at it, drop by Zulip and start chatting Sean up.

Memory clobbering bugs (or things that look like them) are especially tough because, you can't trust anything you see in the debugger. Everything interesting might not be interesting, it might just be something that got clobbered earlier.

It takes a certain sort to enjoy investigating memory corruption.

## RFCs

### Accepted

- [Constrained Types](https://github.com/ponylang/rfcs/pull/213)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
