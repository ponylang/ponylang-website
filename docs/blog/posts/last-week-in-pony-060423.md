---
draft: false
authors:
  - seantallen
description: "A week with an off-topic intro."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony June 4, 2023"
date: 2023-06-04T07:00:06-04:00
---

This intro has absolutely nothing to do with Pony. I've been listening to a lot of Dale Watson this past week and think you should too while you are reading this issue of Last Week in Pony:

- [Dale Watson: Flat Tire](https://www.youtube.com/watch?v=KDx39DlAF0w)

<!-- more -->

## Items of Note

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_05_30.m4a) from the May 30th, 2023 sync is available.

We had a short sync this past week. A quick zoom over some issues which was pretty much "nothing to do here". And a bit of question from Nicolai Stawinoga who was looking for guidance on using LLVM C++ APIs from inside Pony that mostly uses LLVM C APIs.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

We had another fun Office Hours with Sean T. Allen, Adrian Boyko, Red Davies, and Dipin Hora in attendance.

Your humble narrator sadly managed to forget most of what we talked about. There was definitely conversation about 90's "Free Software/Open Source" luminaries and how we felt they could have better served their cause.

Red and Adrian had a fairly long conversation around amateur radio that seemed to get them really geeked but was all Greek to me.

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

We start today's highlight with a deceptively complex problem: When do (Pony) programs exit? This may seem like a strange question because the answer may seem to be obviously "when there is nothing left to do" but parts of that obvious conclusion are more difficult to decide. What does "when" mean in an asynchronous system? How do we know there is "nothing left to do" -- how does the system decide this? Thankfully, we have an FAQ for that! Simply called [When do programs exit?](https://www.ponylang.io/faq/#program-exit) -- let's take a look at it together!

In this FAQ we are first introduced to a possibly new term: _quiescence_. This is the state of being calm. The program exists when quiescence is reached. With Pony being made up of independently executing entities called actors, we can think of there being two levels of quiescence: 1) individual actor, 2) whole program/system of actors. There are also two levels preventing quiescence: 1) current work, 2) possible future work. From these emerges the strategy to determine when quiescence is reached at the program level. Each actor has work it is currently doing and the possibility of future work in its message queue. An individual actor is quiescent when it has no remaining work in its queue (no current work) and no references to it remaining (no possible future work). Once all individual actors are quiescent then we can say that the program itself is quiescent -- at which point the program exits.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
