+++
draft = false
author = "seantallen"
description = "<< content >>"
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - October 29, 2023"
date = "2023-10-29T07:00:06-04:00"
+++

## Items of Note

### SSL Builder Updates

It's that time of the year! Our twice a year update of our the SSL builder images we use for testing/building Pony organization projects and that we make available to the you for the same purpose.

Every time around, we add a new builders, stop updating the oldest ones and let you know which ones we are deprecating. Deprecated builders will stop being updated the next time around.

Each image is updated with a new version of the Pony compiler and other tools after each nightly ponyc build and after each ponyc release.

We've added:

- x86-64-unknown-linux-builder-with-libressl-3.7.3
- x86-64-unknown-linux-builder-with-openssl_1.1.1w
- x86-64-unknown-linux-builder-with-openssl_3.1.3

We've deprecated:

- x86-64-unknown-linux-builder-with-libressl-3.7.2
- x86-64-unknown-linux-builder-with-openssl_1.1.1t
- x86-64-unknown-linux-builder-with-openssl_3.1.0

We've stopped updating:

- x86-64-unknown-linux-builder-with-libressl-3.5.3
- x86-64-unknown-linux-builder-with-openssl_1.1.1q
- x86-64-unknown-linux-builder-with-openssl_3.0.7

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_10_24.m4a) from the October 24th, 2023 sync is available.

We briefly ran through some open pull requests. No special topics or extended discussions.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

Office Hours this week was a fun one even if Red and Sean were the only participants.

A little while back someone open an issue on the ponyc repo that boils down to "someone wrote code on the Internet that is slower than other code on the Internet". In particular, years ago someone made a repository with "ring program" examples designed to benchmark different language against one another. Someone ran the Elixir and Pony examples on their machine and reports that the Elixir version was 4 times faster than the Pony one.

The core team isn't much for entertaining such issues. They aren't actionable and aren't interesting. It is very easy to write slow code in any language if you don't know what you are doing. Red on the other hand was curious and took a look at the Pony code as an exercise of "how would I make this faster".

Red came up with an initial version that was:

```pony
use "time"
use @exit[None](ec: I32)
use @printf[U32](fmt: Pointer[U8] tag, ...)

actor Main
  let env: Env
  var ringsize: U32 = 0
  var count: U32 = 0
  let firstring: Ring

  fun @runtime_override_defaults(rto: RuntimeOptions) =>
    rto.ponynoblock = true

  new create(env': Env) =>
    try
      ringsize = env'.args(1)?.u32()?
      count = env'.args(2)?.u32()?
      env = env'
      firstring = Ring(ringsize - 1, Time.millis(), this)
      firstring.ping(count, Time.millis())
    else
      @printf("Please provide correct numerical arguments\n".cstring())
      @exit(-1)
      env = env'
      firstring = Ring(0, 0, this)
    end

  be next(count': U32, ts: U64) =>
    if (count' > 0) then
      firstring.ping(count', ts)
    else
      @printf("%u %d %d\n".cstring(), Time.millis() - ts, ringsize, count)
      @exit(0)
    end


actor Ring
  let id: U32
  let next: Ring
  let main: Main

  new create(id': U32, ts: U64, main': Main) =>
    id = id'
    main = main'
    if (id > 0) then
      next = Ring(id - 1, ts, main)
    else
      next = this
      @printf("%u ".cstring(),(Time.millis() - ts))
    end

  be ping(count: U32, ts: U64) =>
    if (id > 0) then
      next.ping(count, ts)
    else
      main.next(count - 1, ts)
    end
```

One of key differences between his code and "the code in that random repository on the Internet" was to change the type of `next` from `(Ring | None)` to `Ring`. Thereby removing a ton of branching where each `ping` call would have to do a `match` on next to prove that it was of type `Ring`.

Red's solution however, isn't actually a ring. It's a string of Ring actors where the last one sends a message to `Main` rather than another `Ring` and `Main` then continues "the ring" by sending a message to the first member of the "string of Rings".

Red's question for Office Hours was "how can I redesign this to not have a `match` and also actually be a ring?"

Sean after a bit of thinking and backtracking gave Red the following "shell" he could plug additional logic into:

```pony
use "collections"

actor Main
  new create(env: Env) =>
    let first = Node

    var neighbor = first
    let ring_size: U32 = 200_000
    for k in Range[U32](0, ring_size - 1) do
      neighbor = Node(neighbor)
    end

    first.boss(neighbor, env.out)

actor Node
  var _boss: Bool = false
  var _out: (OutStream | None) = None
  var _prev: Node

  new create(prev: (Node | None) = None) =>
    match prev
    | None => _prev = this
    | let n: Node => _prev = n
    end

  be boss(n: Node, out: OutStream) =>
    _boss = true
    _prev =  n
    _out = out
```

There's still a match here, but it is only on the creation of each `Node` rather than each time one has a message sent to it. Additionally, when output needs to be done "after all work is complete", there's only a single actor "the boss" that will do the printing. And it will do a single, one time match on `_out` to prove that it has been set to `OutStream` instead of `None`.

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

<< content >>

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
