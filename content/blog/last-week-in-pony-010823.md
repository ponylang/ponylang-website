+++
draft = false
author = "seantallen"
description = "<< content >>"
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - January 8, 2023"
date = "2023-01-08T07:00:06-04:00"
+++

<< content >>

<!--more-->

## Items of Note

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_01_03.m4a) from the January 3rd, 2023 sync is available.

A decent amount of time at sync was spent discussing a couple of older RFCs. Sean had started up conversation on them again. We decided to move forward with [one](https://github.com/ponylang/rfcs/pull/174) and table [another](https://github.com/ponylang/rfcs/pull/173) due to a lack of consensus.

There was some conversation around named arguments and our desire to see one or more RFCs proposing improvements. Both Sean and Joe encouraged folks to try coming up with proposals because they feel that improvements could be made, but they both also stated that they would be unlikely to support any given change and instead were looking for RFCs more to get the conversation going rather than one that would be accepted right away.

If you are interested in attending a Pony Development Sync, please do! We have it on Zoom specifically because Zoom is the friendliest platform that allows folks without an explicit invitation to join. Every week, [a development sync reminder](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/Sync.20Reminder) with full information about the sync is posted to the [announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) on the Ponylang Zulip. You can stay up-to-date with the sync schedule by subscribing to the [sync calendar](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics). We do our best to keep the calendar correctly updated.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

What an office hours! 2 and half hours of discussion and teaching across a range of topics. The four attendees Adrian, Jairo, Red, and Sean decided that the summary would be...

"That was great! OMG we covered so much. You should have been here."

Interested in giving attending Office Hours sometime? There's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Releases

- [ponylang/ponyc 0.53.0](https://github.com/ponylang/ponylang/releases/tag/0.53.0)
- [ponylang/net_ssl 1.3.0](https://github.com/ponylang/net_ssl/releases/tag/1.3.0)
- [ponylang/http 0.5.3](https://github.com/ponylang/http/releases/tag/0.5.3)
- [ponylang/http_server 0.4.3](https://github.com/ponylang/http_server/releases/tag/0.4.3)
- [ponylang/crypto 1.2.0](https://github.com/ponylang/crypto/releases/tag/1.2.0)
- [ponylang/crypto 1.2.1](https://github.com/ponylang/crypto/releases/tag/1.2.1)

## Highlighted Issues

Pony is a volunteer driven project. Nothing gets down without someone volunteering their time and helping to push things forward. Yes, there are folks who dedicate more time than others and a core team that dedicates time specifically for guiding Pony's development. Everyone's time is limited, so each week, we highlight a couple of issues that we hope will inspire someone to volunteer their time to help fix.

In addition to our highlighted issues, you can find more that we are looking for assistance on by visiting just about any [repository in the ponylang org](https://github.com/ponylang/) and looking for issues labeled with "help wanted"

If you are interested in working on either issue or any other issue from a Ponylang repository, you can get in touch on the issue in question or, even better, join us on the [Ponylang Zulip](https://ponylang.zulipchat.com/) to strike up a conversation.

This week's issues as selected by Ryan A. Hagenson are:

### Vague error messages when it is not safe to write

Currently, the error message produced when writing values only mentions the right-hand side. This can be really confusing when it is the left-hand side -- and its reference capabaility -- that is the cause of an error as ihe message diverts attention. Improving this error message would greatly improve debugging, especially for newer Pony developers who may not think to check the reference capabilities of both sides of an assignment.

[ponyc #4290](https://github.com/ponylang/ponyc/issues/4290)

### Missing index check in deserialization

There is currently a missing index check in deserialization. Someone looking for a way to contribute to the compiler should give this issue a look!

[ponyc #4297](https://github.com/ponylang/ponyc/issues/4297)

## RFCs

Major changes in Pony go through a community driven process where members of the community can write up "requests for change" that detail what they think should be changed and why. RFCs can range from simple to complex. We welcome your participation.

We had a decent level of "RFC movement" this week. One new RFC was introduced; another was implemented, merged, and released; and two more were picked up again for some additional conversation leading to [one](https://github.com/ponylang/rfcs/pull/174) starting to move toward a final comment period and [another](https://github.com/ponylang/rfcs/pull/173) being put aside as lacking consensus.

### New

- [Remove json package from the standard library](https://github.com/ponylang/rfcs/pull/208)

### Implemented

- [Introduce Empty Ranges](https://github.com/ponylang/rfcs/blob/main/text/0076-introduce%20empty%20ranges.md)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
