---
draft: false
authors:
  - seantallen
description: "In which we celebrate Shaft Day."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony May 14, 2023"
date: 2023-05-14T07:00:06-04:00
---

Although not a ton happened in the world of Pony this week, this is still a very special day. One of my favorite days of the year: "Shaft Day". That glorious day that we all gather together with our loved ones and listen to the music of Isaac Hayes and celebrate his glorious musical legacy.

And remember, Isaac pairs well with Pony so... be sure to program some Pony today while you are working on getting to Phoenix.

<!-- more -->

## Items of Note

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_05_09.m4a) from the May 9th, 2023 sync is available.

The May 16th development sync has been cancelled as no core team members are available to host.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

We had a few attendees for Friday's Office Hours. Most of the time that your reporter was in attendance were spent helping Victor Morrow get the FFI interface for an application of his correct.

The important takeaways for others? On "the C-side" of the Pony/C FFI boundary, a Pony `struct` is always a pointer to the struct. And if you want to pass an array of `Fu` `struct`, you want a pointer to a pointer on the "C-side".

We love Office Hours were we help people solve problems. Learning Pony? Otherwise stuck on something, come on by!

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week we are going to look at [Pony Arithmetic within the Tutorial](https://tutorial.ponylang.io/expressions/arithmetic.html). Specifically, I want to draw your attention to the [default (safe) arithmetic](https://tutorial.ponylang.io/expressions/arithmetic.html#ponys-default-integer-arithmetic) being safe while there is also an option for [unsafe arithmetic](https://tutorial.ponylang.io/expressions/arithmetic.html#unsafe-integer-arithmetic). What is the difference? By default, Pony arithmetic properly handles overflow, underflow, and division by zero (the last of which is defined to return zero). If raw performance is desired and you can guarantee safety yourself, use the unsafe arithmetic. What should you do if you want something in between? Arithmetic that errors on overflow, underflow, and division by zero rather than the default safety decisions or undefined behavior: we also have [partial arithmetic](https://tutorial.ponylang.io/expressions/arithmetic.html#partial-and-checked-arithmetic) operators. Pony has many ways to conduct arithmetic operations, choose the one that is correct for your use case!

If you have questions, feel free to visit the [Ponylang Zulip](https://ponylang.zulipchat.com), where the best place to ask questions about Pony arithmetic is the [beginners-help channel](https://ponylang.zulipchat.com/#narrow/stream/189985-beginner-help).

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
