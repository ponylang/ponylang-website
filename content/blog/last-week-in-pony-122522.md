+++
draft = false
author = "seantallen"
description = "<< content >>"
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - December 25, 2022"
date = "2022-12-25T07:00:06-04:00"
+++

<< content >>

<!--more-->

## Items of Note

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2022_12_20.mp4) from the December 20th, 2022 sync is available.

And o my, what a long sync it was. So normally, sync runs up to an hour in length and then we end. This week the meeting ran for at least a couple hours.

There was a short 20 minutes or so of getting through the normal agenda to deal with various issues and PRs that have had activity during the last week and then, then the fun began. Over the next couple of hours, various approaches to the new distributed cycle detection protocol was discussed.

If you are interested in cycle detection and distributed algorithms then you might find it all interesting however, a lot of the conversation requires background reading of the [Zulip stream](https://ponylang.zulipchat.com/#narrow/stream/361692-distributed-cycle-detection) as the content from it wasn't always restated during the conversation.

For additional background, we suggest reading the [summary of the December 16th Office Hours meeting](https://www.ponylang.io/blog/2022/12/last-week-in-pony---december-18-2022/#office-hours).

If you are interested in attending a Pony Development Sync, please do! We have it on Zoom specifically because Zoom is the friendliest platform that allows folks without an explicit invitation to join. Every week, [a development sync reminder](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/Sync.20Reminder) with full information about the sync is posted to the [announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) on the Ponylang Zulip. You can stay up-to-date with the sync schedule by subscribing to the [sync calendar](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics). We do our best to keep the calendar correctly updated.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

<< content >>

Interested in giving attending Office Hours sometime? There's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Releases

<< content >>

## Highlighted Issues

Pony is a volunteer driven project. Nothing gets down without someone volunteering their time and helping to push things forward. Yes, there are folks who dedicate more time than others and a core team that dedicates time specifically for guiding Pony's development. Everyone's time is limited, so each week, we highlight a couple of issues that we hope will inspire someone to volunteer their time to help fix.

In addition to our highlighted issues, you can find more that we are looking for assistance on by visiting just about any [repository in the ponylang org](https://github.com/ponylang/) and looking for issues labeled with "help wanted"

If you are interested in working on either issue or any other issue from a Ponylang repository, you can get in touch on the issue in question or, even better, join us on the [Ponylang Zulip](https://ponylang.zulipchat.com/) to strike up a conversation.

This week's issues as selected by Ryan A. Hagenson are:

### Incorrect array inference

An interesting type inference issue was raised this week. This issue will require some additional investigation prior to fixing. Anyone looking to get their hands dirty with a compiler fix might want to give this issue a look! Someone taking this issue should feel comfortable with said investigation, which may entail looking at IR at different stages in compilation to isolate where the compiler is applying the wrong information.

[ponyc issue #4281](https://github.com/ponylang/ponyc/issues/4281)

### Add "wrapping it up" end for Capabilities chapter

Currently the Tutorial is a great resource for a "tour of Pony in pieces" however to make it into a complete resource for learning good Pony practices we need to add helpful wrap-ups that ties relevant pieces together. This issue shows one such location where a wrap-up would be helpful. Because this is a fairly open-ended issue where it can be unclear what _exactly_ is needed, Ryan A. Hagenson (hello!) is willing to help anyone who wishes to take this issue. Reach out to him on the issue ticket itself or over on the Ponylang Zulip in the [#tutorial stream](https://ponylang.zulipchat.com/#narrow/stream/190368-tutorial).

[pony-tutorial issue #70](https://github.com/ponylang/pony-tutorial/issues/70)

## RFCs

Major changes in Pony go through a community driven process where members of the community can write up "requests for change" that detail what they think should be changed and why. RFCs can range from simple to complex. We welcome your participation.

This week's RFC related activity was Ryan Hagenson working on the ["Introduction of Empty Ranges"](https://github.com/ponylang/ponyc/issues/4255) RFC. It should be ready to merge soon.

The "proposal syntax else ... then for else keyword in conditional branches" [user request issue](https://github.com/ponylang/rfcs/issues/207) also saw some activity in the comments, mostly Pony committers stating their lack of support for the requested change.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
