---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - November 9, 2025"
date: 2025-11-09T11:30:00-04:00
---

I asked "AI" to write a witty introduction for this week's Last Week in Pony, and here's what it came up with:

Welcome to another thrilling edition of Last Week in Pony! This week, we're talking about embedded link development, future clang integration, and some enlightening Office Hours discussions. I'd say we're really putting the "link" in "Pony links" with our LLD embedding work! Plus, there's a brief hiatus coming up next week—even Ponies need vacation time.

<!-- more -->

## No Last Week in Pony Next Week

I'll be traveling. There will be no Last Week in Pony next week (November 16, 2025). See you on the 23rd!

## Upcoming Pony Development Syncs

Upcoming Pony Development Syncs will be sparse. Expect them to end quickly without a recording unless folks show up with topics to discuss. There's Pony work underway, but nothing that will hit the sync agenda often.

## Embedded Link Development Has Started

I've started work on embedding LLD in the Pony compiler. When this is done, it will eliminate the need for a C compiler to link Pony programs. This will make Pony easier to use in more environments.

## Embedded clang Development Is Planned

We're discussing embedding clang in the Pony compiler. This would allow compiling C code as part of the Pony build process without a C compiler installed. It will simplify the build process for Pony programs that depend on C libraries. In particular, it will make writing C shims easier and make it easier to wrap C libraries for use in Pony.

## Items of Note

### Office Hours

At Office Hours this week, we had Red, myself, and Alex Webber.

This was mostly a good old-fashioned Q&A session. We covered a variety of topics, including:

- Alex and I talking about the basics of performance with Pony and its runtime
- Distributed algorithms for coordination
- The `Array` API
- The backpressure system in Pony's runtime

We also discussed what causes people to start using a language. Alex is interested in contributing to Pony's growth. My advice at the end of the conversation was "do things that interest you" with Pony or in Pony itself and share that with others. Keep your code up-to-date and whenever you stop working on Pony, you will have made the language and its ecosystem better for the next person.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
