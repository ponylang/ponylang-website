---
draft: false
authors:
  - seantallen
  - ryan
description: "A long and extensive Office Hours."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony June 25, 2023"
date: 2023-06-25T07:00:06-04:00
---

A long and extensive Office Hours.

<!-- more -->

## Items of Note

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_06_20.m4a) from the June 20th, 2023 sync is available.

The sync this week was so short that this summary is almost as long. Seriously, check it out for yourself. It's about 5 minutes.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

We had a long one this week and a fairly large number of attendees (for us). Over the course of almost 2 hours, we covered two topics.

The first was at the request of Niclas. We talked about [viewpoint adaptation](https://tutorial.ponylang.io/reference-capabilities/arrow-types.html?h=viewpoint) and why without it in the Pony type system, Pony wouldn't be particularly useful.

Joe and Sean took the audience through the problem from a few different angles. This led to Victor Morrow saying he didn't feel like he really understood what each of the reference types were for.

Conversation centered around "the easy but incorrect" way of talking about reference capabilities: by saying what they allow and "the hard but correct" way: by saying what they deny.

We started by covering `val`, `ref`, `iso`, and `tag` with everyone pretty much able to describe talking about "what they allowed". However, when we got to `box` and `trn`, folks started struggling. Sean then brought up this as a point about "easy but incorrect". From there, we jumped into talking about capabilities as Sylvan envisioned them, as "deny capabilities". We reviewed portions of [Deny Capabilities for Safe, Fast Actors](https://www.ponylang.io/media/papers/fast-cheap-with-proof.pdf) and discussed `trn` and `box` in terms of what they deny to aliases.

While you can't go back in time and attend Office Hours to experience for yourself, if you are interested in hearing Sean talk about the paper, you can watch a [video](https://www.seantallen.com/talks/deny-capabilities/) of his [Papers We Love NYC](https://paperswelove.org/chapter/newyork/) from January 2020.

The second half of Office Hours was a discussion of a crash that Victor Morrow was getting from his QUIC implementation that he has been working on. The issue was tracked down to being unable to allocate Pony memory on a non-Pony thread. Conversation then turned to how to address this. Victor and Sean discussed with Sean going over how the existing ASIO subsystems work in the Pony runtime.

Victor is going to review and attend this coming week's Office Hours to discuss ways that Victor thinks doing QUIC as a new ASIO subsystem wouldn't work. The plan is for Sean and Victor to try and find a way to make it work.

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week we are taking a look at the [Pony Playground](https://playground.ponylang.io/)!

The Playground is a publicly available web interface to a stable Pony installation that allows community members to share code snippets usually for testing or demonstration. The interface is kept simply to a basic code editor to write/edit the code, three buttons for **Run**, **ASM**, and **LLVM IR** to interact with the `ponyc` compiler, a **Share** button to generate a permalink, and a dropdown to change editor settings. This resource is perfect if you have a question about Pony as you can paste the minimal example into the Playground then share the link alongside your question in the community Zulip in the [#beginner-help](https://ponylang.zulipchat.com/#narrow/stream/189985-beginner-help) stream.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
