+++
draft = false
author = "seantallen"
description = "Remember Remember that fateful Pony November"
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - November 6, 2022"
date = "2022-11-06T07:00:06-04:00"
+++

<!--more-->

## Items of Note

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2022_11_01.m4a) from the November 1st, 2022 sync is available.

If you are interested in attending a Pony Development Sync, please do! We have it on Zoom specifically because Zoom is the friendliest platform that allows folks without an explicit invitation to join. Every week, [a development sync reminder](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/Sync.20Reminder) with full information about the sync is posted to the [announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) on the Ponylang Zulip. You can stay up-to-date with the sync schedule by subscribing to the [sync calendar](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics). We do our best to keep the calendar correctly updated.

### Windows Support for Lori

The work to add support for Windows in the Lori networking library that we [highlighted last week](https://www.ponylang.io/blog/2022/10/last-week-in-pony---october-30-2022/#windows-support-for-lori) has been released.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Lately, the meetings have been based around the work on getting a Postgres driver working and the corresponding work on Lori. Other office hours topics have been "open support time" where more experienced community member help others diagnose bugs or otherwise, get unstuck with the Pony projects they are working. And sometimes, it is just a gab fest. And sometimes, no one shows up!

Interested in giving attending a go? There's a [topic for that](https://ponylang.zulipchat.com/#narrow/stream/189934-general/topic/Office.20hours) in the Zulip.

## Releases

- Version 0.5.0 of seantallen-org/lori has been released. See the [release notes](https://github.com/seantallen-org/lori/releases/tag/0.5.0) for more details.

## Highlighted Issues

Pony is a volunteer driven project. Nothing gets down without someone volunteering their time and helping to push things forward. Yes, there are folks who dedicate more time than others and a core team that dedicates time specifically for guiding Pony's development. Everyone's time is limited, so each week, we highlight a couple of issues that we hope will inspire someone to volunteer their time to help fix.

In addition to our highlighted issues, you can find more that we are looking for assistance on by visiting just about any [repository in the ponylang org](https://github.com/ponylang/) and looking for issues labeled with "help wanted"
This weeks issues as selected by Ryan A. Hagenson are:

### base64 decode over allocating buffer space

`encode/base64` currently over-allocates space during decoding, wasting memory in a stdlib method. Someone taking this issue will have to think carefully about edge cases and the order of multiplication/division given the size of the encoded data. There is an existing [Zulip thread](https://ponylang.zulipchat.com/#narrow/stream/192795-contribute-to-Pony/topic/base64.20.28too.20long.3F.29) on the topic.

[Ponyc issue #4051](https://github.com/ponylang/ponyc/issues/4051)

### Remove "person" from Type Aliases description

Our Tutorial used a `Person` type to introduce type aliases, however in the process we made an oversight suggesting that every person has a home. This original oversight has been fixed, but we would like to rewrite the section to use something like animal classification instead. Ryan A. Hagenson, having worked on the Tutorial and animal classification before, is willing to help anyone who wishes to jump in on this issue. (Bonus points if the rewrite include lemur classification as that is what Ryan worked with in a previous life...oddly enough that classification work is what he was doing when he discovered Pony!)

[Pony tutorial issue #446](https://github.com/ponylang/pony-tutorial/issues/446)

If you are interested in working on either issue or any other issue from a Ponylang repository, you can get in touch on the issue in question or even better, join us on the [Ponylang Zulip](https://ponylang.zulipchat.com/) strike up a conversation.

## RFCs

Major changes in Pony go through a community driven process where members of the community can write up "requests for change" that detail what they think should be changed and why. RFCs can range from simple to complex. We welcome your participation.

We have two RFCs that saw activity in the past week.

The empty ranges RFC is going into its second week in "final comment period". Some excellent points have been raised on the RFC and in all likelihood, it is either going to be adopted as a "short-term change" on the way to something larger, or, it is going to expand into something much bigger than it currently is with a large breakage radius. Lots of good stuff going on there.

The ANSI erase codes RFC was new last week and, being rather simple, has moved quickly into "final comment period".

### New

New RFCs that were introduced this week.

### Final Comment Period

RFCs that are in a final comment period before they are either accepted or rejected.

- [Inclusion of all erase codes in the Term package](https://github.com/ponylang/rfcs/pull/203)
- [Introduce Empty Ranges](https://github.com/ponylang/rfcs/pull/201)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
