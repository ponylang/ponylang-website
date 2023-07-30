+++
draft = false
author = "seantallen"
description = "A mention of Pony 'in the wild'."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony July 23, 2023"
date = "2023-07-30T07:00:06-04:00"
+++

## Items of Note

### A Blog Post Mentioning Pony

Niclas [pointed out](https://ponylang.zulipchat.com/#narrow/stream/189934-general/topic/Pony.20in.20article) on the [Pony Zulip](https://ponylang.zulipchat.com/#all_messages) a [recent article that mentions Pony](https://hackernoon.com/the-new-wave-of-programming-languages-exploring-the-hidden-gems). It's nothing particularly in-depth. If you are reading this Last Week in Pony, you probably won't get anything from the article, but hey, it's an item of note!

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_07_25.m4a) from the July 25th, 2023 sync is available.

We discussed 1 PR from Dipin Hora ["Move heap ownership info from chunk to pagemap"](https://github.com/ponylang/ponyc/pull/4368). The PR when finished should improve performance of the Pony runtime at the cost of an additional bit of memory usage.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

There was an Office Hours this week. I know because I was there for the first few minutes before I had to go help grade the dirt road I live on. Clearly, I'm a good neighbor, but I'm a bad reporter. To make it up to you, here's some awesome Western Swing for you to bop about to:

[If Tommy Duncan's Voice Was Booze](https://www.youtube.com/watch?v=R3FDeoXMyKc)

Before I took off, Red and I quickly discussed a plan for picking up work on adding extended queries to the [official Pony Postgres Driver](https://github.com/ponylang/postgres).

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

Today we look at a blog post that is listed in the [Planet Pony](https://www.ponylang.io/community/planet-pony/) section of the website. The post we are looking at today is [Borrowing in Pony](https://bluishcoder.co.nz/2016/07/18/borrowing-in-pony.html).

Pony has an explicit reference capability for object with only one reference: `iso`, as in `isolated`. If we have an `iso` object with a `ref` field, this can cause some headaches when combined with viewpoint adaptation as a `ref` field will appear as `tag` from outside the `iso` origin (see the [viewpoint adaptation table](https://tutorial.ponylang.io/reference-capabilities/combining-capabilities.html#viewpoint-adaptation)). Is everything lost!? Is this some fatal flaw of Pony?! No! The trick, as explained in the blog post, is to wrap our access to the `ref` field in a `recover` block, `consume` our `iso` into a `ref`, then access this field (a `ref` object with a `ref` field is still `ref`), then return our `iso` via another `consume`. Read through the blog post for more details! (If it still does not make sense feel free to drop into the Ponylang Zulip to have a conversation with a helpful community member.)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
