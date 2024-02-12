---
draft: false
authors:
  - seantallen
  - ryan
  - ryan
description: "Ponyc 0.54.0 was released."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony March 5, 2023"
date: 2023-03-05T07:00:06-04:00
---

There was no Pony development sync this week due to low attendance and a small agenda. Beyond that, dig in a read what we have for Pony news this week. It's a little light in part because, the job that pays me is taking up a lot of my time at the moment leaving very little time for the job that doesn't pay me.

<!-- more -->

## Items of Note

### LLVM 15 support has begun

Joe and Gordon have started working on moving Pony to LLVM 15. You can follow along with the [draft PR](https://github.com/ponylang/ponyc/pull/4327).

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

What happened during Office Hours this week is a mystery to me. I wasn't there and didn't get much of a summary. It sounds like folks had fun (as usual) though.

Given that we generally don't have a super detailed accounting of Office Hours (unless Adrian Boyko has the time to do an awesome write-up), you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

And if it doesn't sound interesting, you can join and steer the conversation in directions you find interesting, so really, there's no excuse to not attend!

## Releases

- [ponylang/ponyc 0.54.0](https://github.com/ponylang/ponyc/releases/tag/0.54.0)

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

Today we are highlighting the talks from the [Virtual Users Group](https://vimeo.com/search/sort:latest?q=pony-vug)! Specifically, we are looking at [Pony VUG #10: Pony vs Rust](https://vimeo.com/574893226).

In this talk, Matthias Wahl gives a high-level view of how Rust and Pony handle memory safety and data race freedom. He briefly discusses Rust's use of the (in)famous borrow checker and lifetimes, as well as Pony's reference capabilities -- two ways to handle the temporal nature of mutable data.

Not discussed in the talk, but a way Ryan A. Hagenson (your friendly community resource highlight writer) has found helped him understand the difference: Rust's system leverages uniqueness of reference, while Pony's system leverages isolation of reference. Rust tracks the borrowing and lifetime of unique reference to data, see [The Rules of Reference](https://doc.rust-lang.org/stable/book/ch04-02-references-and-borrowing.html?highlight=rules#the-rules-of-references) from the Rust book -- at most there are be one (unique) mutable reference. Meanwhile, Pony tracks the capabilities of references to ensure isolated mutable references, see the [Viewpoint adaptation](https://tutorial.ponylang.io/reference-capabilities/combining-capabilities.html#viewpoint-adaptation) matrix. In Rust, we cannot say "look through this mutable reference" because that would not be unique, but in Pony we can do exactly that because the data is still isolated! In particular, look at how looking through a `ref` gives exactly the same reference capabilities of whatever you are viewing. A `ref` cannot be shared across actors so it is always isolated to a single actor and therefore nothing changes. Sharable, mutable data has to be an `iso`, which literally means **isolated**!

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
