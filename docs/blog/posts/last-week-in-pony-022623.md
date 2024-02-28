---
draft: false
authors:
  - seantallen
  - ryan
description: "A release delayed and more..."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony February 26, 2023"
date: 2023-02-26T07:00:06-04:00
---

Time keeps on ticking into the future and Pony continues rolling on. We'd like to open today's Last Week in Pony with a thank you to all the volunteers (including ourselves), who've kept it moving. Bless you all. Here's to more gradual improvements!

In the meantime, put on some [Black Sheep](https://www.youtube.com/watch?v=K9F5xcpjDMU) and dig into this week's news including the delay of the Pony 0.54.0 release.

<!-- more -->

## Items of Note

### Release coming soon

The Pony 0.54.0 release was going to happen this morning but has been delayed as CirrusCI is reporting that a Google Cloud issue might impact on CirrusCI jobs (such as the ones we use to build Pony releases).

The release will be coming "soon" where "soon" is a product of Sean's heavy work schedule in the coming couple of weeks. Most likely the release will be within a couple days although, in the worst case, it could be a week or two.

### Pony Development Sync

[Audio](https://vimeo.com/917346147) from the February 21st, 2023 sync is available.

The February 21st development sync had only one ticket on the agenda to review, which was then followed by group discussion on a few topics related to the internals and build process of the Pony compiler and runtime. Among the major topics discussed were:

- Building Clang and compiling Pony with the built Clang: [PR #4196](https://github.com/ponylang/ponyc/pull/4196)
- An arcane possible C spec violation related to `pthread_create:` [Issue #4324](https://github.com/ponylang/ponyc/issues/4324)

If you are interested in attending a Pony Development Sync, please do! We have it on Zoom specifically because Zoom is the friendliest platform that allows folks without an explicit invitation to join. Every week, [a development sync reminder](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/Sync.20Reminder) with full information about the sync is posted to the [announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) on the Ponylang Zulip. You can stay up-to-date with the sync schedule by subscribing to the [sync calendar](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics). We do our best to keep the calendar correctly updated.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

Red Davies' report for Friday 24th February Office Hours:

Adrian, Jason, and Red attended and the discussion did not disappoint.

Red brought the question "How should we structure flexible Async APIs in pony?" and a trivial example to experiment with during the call.  Several different implementations were discussed, implemented, and experimented with (interspersed with 'Good Humored' observations about Red's obsession with (now unnecessary) recover blocks).

Many times during the call Red muttered "These should be in pony patterns…".

Later in the call, discussions moved into the internals of X11 event handling, Window Managers, Toolkits and ASIO.

A great time was had by most.

Does any or all of that sound interesting, if yes, you should join us some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

And if it doesn't sound interesting, you can join and steer the conversation in directions you find interesting, so really, there's no excuse to not attend!

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week we are looking at Pony [Frequently Asked Questions (FAQs)](https://www.ponylang.io/faq/), in particular whether a [ref can become a val](https://www.ponylang.io/faq/code/#ref-to-val).

It is not uncommon to start learning Pony by using a lot of implicit and explicit `ref` reference capabilities. This is because `ref` is perhaps the most familiar capability when coming from other languages. With a `ref` we are creating a mutable, local reference; we can locally alias this `ref` as many times as we want. Joy! But wait...what if we want to mutate up to a point and then "lock" that data into being immutable? This is usually what someone who wants to go from a `ref` to a `val` is trying to do -- start with a locally mutable `ref` which is then "locked" into being a globally immutable `val`. However this does not work and they get frustrated. The quick solutions are:

1. Start from an `iso` or `trn` then `consume` it in order to return your desired `val`
2. Use a `recover` block to isolate the mutation and return your desired `val`

Why do these work? Reference capabilities are not themselves references, nor do they apply to the data. Having a `ref` does not mean the **data** is mutable, it means the **reference** can be used for mutation. A `ref` can be used to create another `ref` and either `ref` can be used for mutation. Because of this, when we use a `ref` we are allowing any number of ways to mutate the data. Meaning in order to guarantee that it is safe to go from a `ref` to a `val` we would have to know all other ways the data could be mutated -- this is a lot of work. However in 1 above, using an `iso` or a `trn`, we are stating there is only ever one way to mutate the data so when we consume that one way to mutate we know for certain there is no longer a way to mutate the referenced data so a `val` is safe. Meanwhile in 2 above, using a `recover` block, that region of references cannot "leak" mutable references so when exiting the recover block we once again know for certain there is no longer a way to mutate the referenced data so a `val` is safe.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
