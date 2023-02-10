+++
draft = false
author = "seantallen"
description = "In which we introduce a new feature: Community Resource Highlight"
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony February 12, 2023"
date = "2023-02-12T07:00:06-04:00"
+++

This week, we are introducing a new regular entry for Last Week in Pony: ["Community Resource Highlight"](#community-resource-highlight). The new section is replacing our previous "Highlighted Issues" section.

Ryan Hagenson and I discussed "Highlighted Issues" and decided that given how little traction we saw from the community picking up issues to work on the time he invests in each Last Week in Pony would be better spent on other content; our first stab at that content is "Community Resource Highlight".

We'd love to hear your feedback in the [Last Week in Pony stream on the Ponylang Zulip](https://ponylang.zulipchat.com/#narrow/stream/352355-last-week-in-pony). Do you think the "Community Resource Highlight" will bring you value? Is there something else you'd rather see? Heck, perhaps even something you want to contribute? Let us know. If you aren't getting value from LWIP then, it's kind of pointless for us to spend time working on it. So, let us know and in the meantime, kick back, relax, put on [John Lee Hooker's "The Real Folk Blues"](https://www.youtube.com/watch?v=5DsIl6bJrwY&list=PL9M2VK15IQq4abOtlMkrcqBulS9PNUO-N) and get ready for the [Super Bowl](https://www.youtube.com/watch?v=sS0qhHiyrfI) later today.

<!--more-->

## Items of Note

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_02_07.mp4) from the February 7th, 2023 sync is available.

Sync had a short agenda this week. Only a couple PRs and new issues to go over. Most of the time was spent going over an interesting Pony LLVM IR hacking problem that Nicolai Stawinoga joined the call to discuss. It's an interesting project he has going on and if LLVM IR spelunking is your thing, have a watch.

Yup, "a watch" because this week's sync comes with video so you can see all the shared screen fun that is the LLVM IR spelunking that starts sometime around 11 minutes into the call.

If you are interested in attending a Pony Development Sync, please do! We have it on Zoom specifically because Zoom is the friendliest platform that allows folks without an explicit invitation to join. Every week, [a development sync reminder](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/Sync.20Reminder) with full information about the sync is posted to the [announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) on the Ponylang Zulip. You can stay up-to-date with the sync schedule by subscribing to the [sync calendar](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics). We do our best to keep the calendar correctly updated.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

<< content >>

You should join us some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Releases

- [ponylang/changelog-bot-action 0.3.5](https://github.com/ponylang/changelog-bot-action/releases/tag/0.3.5)
- [ponylang/json 0.1.0](https://github.com/ponylang/json/releases/tag/0.1.0)
- [ponylang/release-notes-bot-action 0.3.6](https://github.com/ponylang/release-notes-bot-action/releases/tag/0.3.6)

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week, we are highlighting the [Pony Pattern](https://patterns.ponylang.io/) a cookbook style guide to solving problem via common code patterns. Today we are looking at [Accessing an Actor with Arbitrary Transactions](https://patterns.ponylang.io/async/access.html).

This pattern solves the problem of needing arbitrary transactions on a Pony actor. Because Pony actors communicate asynchronously it is possible for messages to be interleaved in situations where atomic access is needed. The solution is shockingly simple once it "clicks", but deceptively difficult to understand at first. It may be helpful for someone first looking at this pattern to understand that: 1) messages are always sent **asynchronously** from an actor to an actor, and 2) that all actors process their **queue of messages** in order. For an "Arbitrary Transaction", we need to have **synchronous** access that avoids the queue. There is only one way to do this: we need a message type that views the actor as it view itself. Therefore this pattern defines a behavior (i.e., message type) that takes a lambda function argument that accepts a `ref` to the implementing actor type. This lambda will have synchronous access to the implementing actor for the duration of one message.

## RFCs

Major changes in Pony go through a community driven process where members of the community can write up "requests for change" that detail what they think should be changed and why. RFCs can range from simple to complex. We welcome your participation.

This week, a [PR](https://github.com/ponylang/ponyc/pull/4323) for the "remove `json` package from standard library" RFC was opened and merged.

### Implemented

- [Remove `json` package from standard library](https://github.com/ponylang/rfcs/blob/main/text/0078-remove-json-package-from-stdlib.md)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
