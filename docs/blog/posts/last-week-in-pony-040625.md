---
draft: false
authors:
  - seantallen
  - red
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - April 6, 2025"
date: 2025-04-06T07:00:06-04:00
---

Office Hours was the most happening thing in Pony this week. At least as far as your fearless author knows.

<!-- more -->

## Items of Note

### Pony Development Sync

The [recording](https://vimeo.com/1071549031) of the April 1st, 2025 sync is available.

### Office Hours

I was late joining Office Hours this past week and left before the end, so Red is the author for your recap (with some editing from our handy AI editor overlord):

This week's Office Hours was one of the most comprehensive yet. We covered a lot of ground, both Pony-related and not.

Unfortunately, your author left his "comprehensive notes"™ about 500 miles North, but here's a list of the conversations as I remember them from my miserable hotel room with pitiful internet access:

While waiting for the meeting to start, we had a brief discussion about C and [Zig](https://ziglang.org/) to give some foundation for those not familiar with the Zig project. Your author expressed his complete unwillingness to do memory management, as he doesn't trust himself to do it competently. LordMZTE talked about how Zig had different memory allocators and language constructions similar to Pony's `with` keyword that I've dutifully forgotten, which help make this easier.

It was at this point your author may have committed to learning Zig. Hold me accountable!

When the meeting proper started, LordMZTE gave us a tour of his project [schuppenpferd](https://git.mzte.de/LordMZTE/schuppenpferd), a module for [Zig's](https://ziglang.org) build system that extends it to compile Pony projects. It looks interesting and even has the ability to do dependency graphing of Pony libraries as long as the Pony projects also encode their dependencies in a `.zig format.

Questions came up about how much work would be needed to give it functional parity to corral.

We discussed how to integrate `libponyrt` into Zig programs (you can't, really), and how to link Zig libraries into Pony programs (trivially). We talked about a project that wanted to port Pony to GPUs, and how the authors were planning to use Zig as that bridge.

I hypothesized that this may be linked to the [neutron-star](https://github.com/phase/neutron-star) project. Even if it isn't, that project still makes for an interesting read.

Alex returned and we discussed distributed Game of Life. I don't remember all the specifics around the implementation and different ways to do performant syncing of state - but it happened. A branch-off of this conversation went into how Pony programs could communicate over the network, and whether that should be a runtime thing.

We discussed the joys of working for corporations and how American corporations always hold the well-being of their employees above everything else, including profit - and how they're always fully ethical in all cases.

After hours, we wandered completely off the reservation and talked about different forms of government, and how everyone on the call completely agreed that a Constitutional Monarchy, with a separate Head of Executive and Head of State was the most stable and resolutely superior form of government.

We had a great time, learned a lot, and you should have been there.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
