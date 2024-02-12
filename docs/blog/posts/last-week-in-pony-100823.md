---
draft: false
authors:
  - seantallen
  - ryan
description: "A Pony release is coming very soon..."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - October 8, 2023"
date: 2023-10-08T07:00:06-04:00
---

A Pony release is coming very soon...

<!-- more -->

## Items of Note

### Pony release coming

We've merged a PR that fixes a [bug that allowed unsafe data usage with `recover` blocks](https://github.com/ponylang/ponyc/pull/4458). We expect to release sometime in the next couple of days.

The release is a "breaking change release" in the sense that if you were doing unsafe things with `recover` blocks because the compiler was allowing it, you will need to fix your code.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

Office Hours this week was at a new time. 12:30 Eastern US. Attendees were Sean, Adrian, and Jason Carr. Conversation was definitely all over the place. Nothing of particular interest to report. Mostly just a good time had by all for 50 minutes.

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Releases

- [ponylang/github_rest_api 0.1.3](https://github.com/ponylang/github_rest_api/releases/tag/0.1.3)
- [ponylang/peg 0.1.5](https://github.com/ponylang/peg/releases/tag/0.1.5)
- [ponylang/templates 0.2.4](https://github.com/ponylang/templates/releases/tag/0.2.4)

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

We are going to look at a Pony Gotcha this week, [Function Call Side Effects](https://tutorial.ponylang.io/gotchas/side-effect-ordering-in-function-call-expressions)!

If you take a look at the code for this Gotcha, you may be initially confused by what you see. What is happening is that at first `x` is initialized and assigned a value of `0`, then, because expressions in a function call are evaluated prior to the function receiver, `x` is reassigned to a value of `42`. But there is also a caveat here that says "if `fn` were to be called, it would be called with `0`" -- what? To answer that, Pony returns the old value on assignment (see [Destructive Read](https://tutorial.ponylang.io/reference-capabilities/consume-and-destructive-read.html?h=destruc#destructive-read)). Initializing `x` to `0` then running `x = 42` returns the original value of `0`, while a subsequent read of `x` or reassignment of say `x = 84` would return `42`.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
