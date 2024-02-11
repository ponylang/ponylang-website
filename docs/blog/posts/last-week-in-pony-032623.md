---
draft: false
author: "seantallen"
description: "A slow week in Pony"
categories:
  - "Last Week in Pony"
title: "Last Week in Pony March 26, 2023"
date: 2023-03-26T07:00:06-04:00
---

## Items of Note

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_03_21.mp4) from the March 21th, 2023 sync is available.

The call revolved around a single issue ticket: [ponyc #4329](https://github.com/ponylang/ponyc/issues/4329). And how to deal with the bug that arises from the implementation of `iftype` that results in the following code generating bad LLVM IR:

```pony
use "debug"

actor Main
  new create(env: Env) =>
    Debug(foo[U8]())
    Debug(foo[U16]())

  fun foo[A: Any val](): String =>
    iftype A <: U16 then
      Debug("U16 is a match")
      return "u16"
    else
      Debug("no match")
    end
    "default"
```

If you are interested in attending a Pony Development Sync, please do! We have it on Zoom specifically because Zoom is the friendliest platform that allows folks without an explicit invitation to join. Every week, [a development sync reminder](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/Sync.20Reminder) with full information about the sync is posted to the [announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) on the Ponylang Zulip. You can stay up-to-date with the sync schedule by subscribing to the [sync calendar](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics). We do our best to keep the calendar correctly updated.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week we are highlighting perhaps the best community resource around: [Ponylang Zulip](https://ponylang.zulipchat.com/)! You may have seen the many mentions of the Ponylang Zulip throughout these Last Week In Pony postings, but if you have not joined yet we wanted to take a moment to give you a brief tour.

Zulip is organized into streams, which are broken down into topics. This style of organization lets us keep everything tidy. Often times within a community like Pony's there are related conversations happening and this is where a "stream" is used to organize what is related. Meanwhile the individual conversations themselves are "topics" within that "stream."

Even if you do not want to join right now, you can still read many of the most streams because back in July 2022 we had a conversation ([on Zulip](https://ponylang.zulipchat.com/#narrow/stream/189934-general/topic/Making.20the.20Zulip.20public)) about making most streams public! Now there is no need to sign up if all you need to do is read past message. You still have to join in order to participate in the conversations though!

If you do join, perhaps the most useful streams to start a topic in are:

+ [#general](https://ponylang.zulipchat.com/#narrow/stream/189934-general): The "catch all" stream for conversations (however your topic might be moved to a more relevant stream by a Zulip admin)
+ [#beginner help](https://ponylang.zulipchat.com/#narrow/stream/189985-beginner-help): The stream for asking Pony questions (not always beginner, but always helpful)
+ [#tutorial](https://ponylang.zulipchat.com/#narrow/stream/190368-tutorial): The stream for discussing aspects about the [Pony Tutorial](https://tutorial.ponylang.io/)

That is the brief overview of the Ponylang Zulip. We hope you join us on there! If you join and want to introduce yourself, we have a stream called [#new members](https://ponylang.zulipchat.com/#narrow/stream/189935-new-members) specifically for that reason!

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
