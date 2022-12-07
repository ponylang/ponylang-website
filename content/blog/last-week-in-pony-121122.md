+++
draft = false
author = "seantallen"
description = "<< content >>"
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - December 11, 2022"
date = "2022-12-11T07:00:06-04:00"
+++

<< content >>

## Items of Note


### A Performance Hit is Coming

There's a performance hit coming. It will be fairly bad at first and will be mitigated as much as possible over the course of time.

Currently, there's an unsafe optimization in the Pony runtime. The optimization is detailed in the ORCA paper on the garbage collection protocol and is usually safe, but sadly not always.

The optimization cuts down on the amount of tracing that is done when an object is sent from one actor to another. It is based on the observation that for the sake of reference counting, we don't need to count every object in a graph that is sent from actor A to actor B so long as the root of the graph being sent is immutable. This optimization provides a large performance boost over tracing all objects sent from one actor to another. It also will from time to time, introduce a segfault that takes down the runtime.

[Issue #1118](https://github.com/ponylang/ponyc/issues/1118) is the most obvious instance of the bug caused by the optimization. The core of the problem is that when an actor's reference count hits 0, it should be able to be reaped. However, if a reference to an actor is sent to another actor inside an immutable object, the actor will not be traced on send and might get reaped while references to it exist. Once that happens, a segfault is guaranteed.

[PR #4256](https://github.com/ponylang/ponyc/pull/4256) fixes the safety problem by tracing every object sent between actors. In not very rigorous testing using a modified version of [message-ubench](https://github.com/ponylang/ponyc/tree/main/examples/message-ubench), Sean T. Allen saw a 1/3 drop in performance compared to running with the safety problem/optimization enabled. It should be noted that the 1/3 drop in performance is probably the high-end in terms of performance hit and many Pony programs will see little to no performance change.

Our plan is to merge #4256 and then start getting compiler infrastructure in place so we can turn the optimization back on where it is safe. In #4256, we add a new field to all pony type descriptors that holds a boolean for whether a given type might contain a reference to an actor. If it might, we have to trace. If the compiler can prove that it doesn't, then sending an immutable version of the class inter-actor won't require tracing.

#4256 will be merged sometime this week and will be in the next ponyc release that will be coming shortly thereafter.

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2022_12_06.m4a) from the December 6th, 2022 sync is available.

Aside from normal sync business, there was some interesting discussion towards the beginning of the call. It's a little hard to summarize, so, you'll just have to listen if you want to know more!

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

### fu

bar

### fu

bar

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
