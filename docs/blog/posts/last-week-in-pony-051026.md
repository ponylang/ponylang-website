---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - May 10, 2026"
date: 2026-05-10T07:00:06-04:00
---

This week's theme song is ["My Bucket's Got a Hole in It"](https://www.youtube.com/watch?v=Ix05FkvG944) by Tim Timebomb. Looks like Pony's bucket has sprung a leak this week, doesn't it? It hasn't.

You've been getting a steady drumbeat of Pony news for months now. That drumbeat goes quiet this week, and it'll stay quiet for a stretch. Don't read it as the momentum dropping off. The water's all running into one place — a big job that's eaten most of my coding hours, more on it below.

<!-- more -->

## Sean, Where's All That Momentum Gone?

It hasn't gone anywhere. There's a really big job going on, and it's eaten the visible output. [PR 5246](https://github.com/ponylang/ponyc/pull/5246) on ponyc. The finite recursive type aliases work. Third PR in a series. 56 commits in this one alone, with more to come. The original [issue](https://github.com/ponylang/ponyc/issues/267) has been open since July 2015 — almost eleven years on the books, and currently the oldest open issue on ponyc. It got there because implementing finite recursive type aliases is a huge undertaking to begin with, and an even bigger one when you have to do it without tanking compiler performance. Changes like this don't show up in a news list while they're underway. They show up when they ship. The momentum's still there. Click the PR if you want to see where it's all going.

And while I've been buried in PR 5246, Orien has kept pony-lsp rolling. Several improvements have already landed on main since the last release: [call hierarchy support](https://github.com/ponylang/ponyc/pull/5300), hover-behavior fixes, a range-end fix, and a stack of smaller refinements. None of it has shipped yet. If you're really into pony-lsp, this is a stretch where living on main, or grabbing nightlies regularly, might be worth considering.

## Items of Note

### New Blog Post: pony-lint: Codifying the Style Guide

I put up a new blog post, ["pony-lint: Codifying the Style Guide"](https://www.ponylang.io/blog/2026/05/pony-lint-codifying-the-style-guide/). It's about why we've been rolling pony-lint into ponylang org repos and where the lint goes from here. The short version: LLMs generate code at a volume the manual review process couldn't keep up with, the lint catches the rules consistently, and we're starting to add lint rules for footguns. Patterns that compile and run fine but bite you when something else changes. If you've got a footgun idea, drop a note in the [pony-lint discussion category](https://github.com/ponylang/ponyc/discussions/categories/pony-lint).

And before anyone asks — "Sean, why are you writing blog posts if the finite recursive aliases work is so important?" Because it also gets mind-numbing. And boring. And exhausting. Blog posts are a nice mental break.

### Pony Development Sync

The [recording](https://vimeo.com/1189883528) of the May 6, 2026 Pony Development Sync is up. I was traveling and couldn't attend. According to the summary, the team worked through three RFCs. They opened with [RFC 223](https://github.com/ponylang/rfcs/pull/223) (the proposed `Json.print` API), which is still parked waiting on me. Next was [RFC 227](https://github.com/ponylang/rfcs/pull/227), which proposes withdrawing RFC 53 (compile-time expressions). The group agreed to withdraw. RFC 53 was accepted in 2018, never implemented, and leaves several core questions open about capabilities, error handling, floating-point semantics, and which subset of Pony is actually permitted. A future RFC can pin those down alongside a working implementation. The longest discussion went to [RFC 229](https://github.com/ponylang/rfcs/pull/229) (type layout functions for C-FFI). The team agreed to rename "type info" to "ABI memory layout" to dodge namespace collisions, and worked through how embedded fields and offset calculations should be handled. Red has [a related ponyc PR](https://github.com/ponylang/ponyc/pull/5267) for the type-information-size piece; Joe reviewed it and approved the approach.

## RFCs

### Final Comment Period

- [Withdraw RFC 53: Compile-Time Expressions](https://github.com/ponylang/rfcs/pull/227)
- [Socket runtime three-state result](https://github.com/ponylang/rfcs/pull/228)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
