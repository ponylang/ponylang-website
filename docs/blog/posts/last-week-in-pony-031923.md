---
draft: false
authors:
  - seantallen
description: "A wild mention of Pony appears."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony March 19, 2023"
date: 2023-03-19T07:00:06-04:00
---

A wild mention of Pony appears.

<!-- more -->

## Items of Note

### Pony mentioned in "Context Free"

Adrian Boyko writes:

Tom's YouTube channel ["Context Free"](https://www.youtube.com/@contextfree) posted a video in December that YouTube finally recommended to one of us this last week. Titled ["Int overflow (or not) in C++, Ruby, Zig, Rust, & Pony"](https://www.youtube.com/watch?v=dizO_5g3K5Q), it compares how integer math is handled in these five languages. When he gets to Pony, Tom reviews ["The Pony Philosophy"](https://www.ponylang.io/discover/#the-pony-philosophy) before delving into examples of the "default", "unsafe", and "checked" [math operations in Pony](https://tutorial.ponylang.io/expressions/arithmetic.html). Highlighted is the fact that Pony allows the programmer to choose the best trade-off between performance and safety, on a case-by-case basis. On a tangent, Tom mentions that he definitely needs to look at Pony's approach to concurrency in a future video, so we're looking forward to seeing what he has to say about that!

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_03_14.m4a) from the March 14th, 2023 sync is available.

After briefly running through the open items on the agenda, Joe, Adrian, and Red talked through FFI pain points and possible solutions.

If you are interested in attending a Pony Development Sync, please do! We have it on Zoom specifically because Zoom is the friendliest platform that allows folks without an explicit invitation to join. Every week, [a development sync reminder](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/Sync.20Reminder) with full information about the sync is posted to the [announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) on the Ponylang Zulip. You can stay up-to-date with the sync schedule by subscribing to the [sync calendar](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics). We do our best to keep the calendar correctly updated.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

This past Friday's office hour was attended by Adrian Boyko, Nicolai Stawinoga,Red Davies, and Sean T. Allen. The primary topic of discussion was the ASIO subsystem in the Pony runtime and possible issues in how Red had started using it for his "raw socket" implementation and how in general Adrian should approach using it to work with SFML from Pony.

Given that we generally don't have a super detailed accounting of Office Hours (unless Adrian Boyko has the time to do an awesome write-up), you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

And if it doesn't sound interesting, you can join and steer the conversation in directions you find interesting, so really, there's no excuse to not attend!

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week we are highlighting the [Papers](https://www.ponylang.io/community/#papers) portion of the Pony website! Specifically, we are going to look at [ORCA: GC and Type System Co-Design for Actor Languages](https://www.ponylang.io/media/papers/orca_gc_and_type_system_co-design_for_actor_languages.pdf). This 2017 paper discusses ORCA or Ownership and Reference Counting-based garbage collection in the Actor World -- it may be a bit of a force acronym, but it is a killer whale of a reason to use Pony!

The entire paper is worth a read, but here we want to highlight the invariants list from section 4.1 that ORCA maintains:

1. At any point, if an actor may write to an object, then no other actor can read from or write to this object’s fields. Thus, ORCA can avoid write barriers and tracing needs no synchronisation.
2. Immutability is persistent (i.e. an immutable object will never be seen as mutable) and deep (i.e. no object accessible from an immutable object is seen an mutable).
3. Any live object is protected at its owner.
4. Any object reachable from a foreign actor is protected at this actor.
5. The owner’s reference count for an object is consistent with the state of the system.

Invariant 1 means there can only ever be one mutable owner at a time -- mutability is isolated to a single actor. Invariant 2 means that once an object is marked as immutable it cannot be later used to mutate, nor can it be used to extract something mutable from within it. Invariant 3 and 4 work together to mean that an object is protected from garbage collection by its owner -- the owner decides when the reference count to any object is 0 and as such can be garbage collected. Invariant 5 means that the owner of an object has a view of the state of that object that agree with other entities in the system.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
