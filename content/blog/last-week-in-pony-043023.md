+++
draft = false
author = "seantallen"
description = "<< content >>"
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony April 23, 2023"
date = "2023-04-30T07:00:06-04:00"
+++

<< content >>

## Items of Note

### SSL Builder Updates

The ponylang organization SSL builder docker images are being updated this week. Every few months we add new builders to support the latest versions of various OpenSSL and LibreSSL API versions.

#### OpenSSL builder changes

- 3.1.0 builder added
- 3.0.7 deprecated. It will stop receiving updates the next time we add a new 3.x OpenSSL builder.
- 1.1.1t builder added
- 1.1.1n builder deprecated. It will stop receiving updates the next time we add a new 1.x Open SSL builder.
- 1.1.1b builder will no longer receive updates

#### LibreSSL builder changes

- 3.7.2 builder added
- 3.5.3 builder deprecated. It will stop receiving updates the next time we add a new 3.x LibreSSL builder.
- 3.5.2 builder will no longer receive updates

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_04_25.m4a) from the April 25th, 2023 sync is available.

Phew! That was a long one. If you listen to this week's sync recording, strap in. It's 2 hours long. The breakdown is thus...

- About 30 minutes on the [Static arrays of numbers RFC](https://github.com/ponylang/rfcs/pull/209)
- About 20 minutes on the [With block doesn't call dispose on an object if its name is _ ponyc bug](https://github.com/ponylang/ponyc/issues/4345)
- 55 minutes on the [Segmentation fault when capturing Env via lambda](https://github.com/ponylang/ponyc/issues/4343) and [Runtime crash when accessing a field that was captured before it was initialized](https://github.com/ponylang/ponyc/issues/4301) ponyc bugs.

There's an awful lot that went on. We have no idea how much you will be able to follow along at home. Hopefully it's rewarding.

As a bonus, core team member Matthias Wahl who usually can't make it to sync ended up joining shortly after we started. It was great to have Matthias contributing during the call. Hopefully we can continue attending.

If this sort of thing interests you, please feel free to attend a Pony Development Sync. We have it on Zoom specifically because Zoom is the friendliest platform that allows folks without an explicit invitation to join. Every week, [a development sync reminder](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/Sync.20Reminder) with full information about the sync is posted to the [announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) on the Ponylang Zulip. You can stay up-to-date with the sync schedule by subscribing to the [sync calendar](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics). We do our best to keep the calendar correctly updated.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

<< content >>

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Releases

- [ponylang/corral 0.7.0](https://github.com/ponylang/corral/releases/tag/0.7.0)

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

<< content >>

## RFCs

Major changes in Pony go through a community driven process where members of the community can write up "requests for change" that detail what they think should be changed and why. RFCs can range from simple to complex. We welcome your participation.

### New

- [Static arrays of numbers](https://github.com/ponylang/rfcs/pull/209)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
