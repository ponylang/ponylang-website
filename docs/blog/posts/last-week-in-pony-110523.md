---
draft: false
authors:
  - seantallen
  - ryan
description: "A not particularly scary week in the land of Pony."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - November 5, 2023"
date: 2023-11-05T07:00:06-04:00
---

A not particularly scary week in the land of Pony.

<!-- more -->

## Items of Note

### Pony Development Sync

[Audio](https://vimeo.com/917350851) from the October 31st, 2023 sync is available.

We had a short agenda that we ran through pretty quickly.

### Office Hours

We have an open Zoom meeting every week for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try. The meeting is open to anyone. Stay up-to-date with the schedule by [subscribing to the Office Hours calender](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics). Hopefully, we'll see you at an Office Hours soon.

This week we held Office Hours at our new time: 4 PM Eastern on Mondays. We had a better attendance than we did with the previous and short-lived Friday mid-day slot.

There was some discussion of C++ co-routines. A lot about Go's concurrency model. Some about the differences between Erlang and Pony. Most of the conversation flowed from a discussion of how silly we found it that there's a repository on the Internet that is trying to compare an Erlang actor model implementation of a toy problem to other concurrency models. In particular, that it attempts to compare performance when in many languages like Go, it's an entirely different program and the toy problem doesn't even make sense in Go.

We had a good time. You should join us on the 6th.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

Let us look at [partial application](https://tutorial.ponylang.io/expressions/partial-application) this week.

Pony has the ability to partially apply a function, which then returns a new function that takes the remaining arguments. This is done by using a tilde (`~`) rather than a dot (`.`) when calling the function. For example, if we have some `Bar.mul(x, y)` which takes two `F64` arguments contains the body `x * y` we can apply the function fully via `Foo.mul(4, 8)` which becomes `4 * 8` or `32`. If instead we partially apply the function via `Foo~mul(4)` we will get a function that is equivalent to the lambda `{(y: F64): F64 => 4 * y }`. It is also possible for us to apply the arguments out of order by using `where` via `Foo.mul(where y = 8)` which would return a function that is equivalent to the lambda `{(x: F64): F64 => x * 8 }`.

For those who have some experience with functional languages, these above might sound like currying, however partial application and currying are distinct. By default, Pony does not curry functions. If you want to transform a multi-argument function into a series of unary functions (i.e., currying) you need to do so via partially applying functions yourself. For example, with a function `Foo.mulall(x, y, z)` which has a body of `x * y * z` it is possible to manually curry via `Foo~mulall(4)~apply(8).apply(16)` -- the original function is partially applied via `Foo~mulall(4)`, the resulting function is then partially applied via `~apply(8)`, and the final `.apply(16)`. Why `apply`? See how [lambdas](https://tutorial.ponylang.io/expressions/object-literals.html?h=lambda#lambdas) work.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
