+++
draft = false
author = "seantallen"
description = "<< content >>"
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony March 26, 2023"
date = "2023-03-26T07:00:06-04:00"
+++

<< content >>
<!-- more -->

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

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

This past Friday's office hour was attended by Adrian Boyko, Nicolai Stawinoga,Red Davies, and Sean T. Allen. The primary topic of discussion was the ASIO subsystem in the Pony runtime and possible issues in how Red had started using it for his "raw socket" implementation and how in general Adrian should approach using it to work with SFML from Pony.

Given that we generally don't have a super detailed accounting of Office Hours (unless Adrian Boyko has the time to do an awesome write-up), you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

And if it doesn't sound interesting, you can join and steer the conversation in directions you find interesting, so really, there's no excuse to not attend!

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

<< content >>

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
