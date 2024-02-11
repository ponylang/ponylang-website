---
draft: false
authors:
  - red
description: ""
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - August 21st, 2022"
date: 2022-08-21T00:00:00-05:00
---

This week was a little bit quiet on the official front. I don't want to start any [rumours](https://github.com/exercism/pony/pull/125) about anything else going on in the community so I'll say nothing ;-)

Developer Sync, another Principle, and the return of Issues of the Week!

<!-- more -->

## Ponies don't crash

To be more accurate, ponies _should_ never crash.  In fact, if you can write a pony program that crashes, we want to hear about it because it's likely a bug in the compiler or the runtime.

Unfortunately, there are some things that are beyond our control like running out of memory or tomfoolery using the C-FFI… but in the main, if you crash - we want to know.

How does Pony achieve this?

* Applying strong type guarantees.
* Implementing concurrent, per-actor garbage collection.
* Not allowing any null or uninitialized values.
* Not allowing uncaught exceptions.
* Extending the type system with additional qualifiers (called reference capabilities) making it safe to work on data with multiple actors, while avoiding data-races and deadlocks.

## Items of note

* Audio from the [August 16th](https://sync-recordings.ponylang.io/r/2022_08_16.m4a) Pony development sync is available.

## Issues of the Week

Each week, we will highlight "good first issues" from the Pony ecosystem that we're trying to motivate someone to spend a bit of time on closing. If we close the issue of the week every week, by the next week, it will really add up and help Pony move forward quicker. So hey, how about you make this week your week?

This week's issues are:

* ["Confusing compiler error when a field's field is assigned within a fun box"](https://github.com/ponylang/ponyc/issues/4148) from the [ponyc](https://github.com/ponylang/ponyc) repository.
* ["Confusing type name on error messages with function lookup on lambda types ponyc"](https://github.com/ponylang/ponyc/issues/4015), also from the [ponyc](https://github.com/ponylang/ponyc) repository.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
