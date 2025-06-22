---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - June 22, 2025"
date: 2025-06-22T07:00:06-04:00
---

There will be no Last Week in Pony next week.

<!-- more -->

## Items of Note

### Last Week in Pony - June 29, 2025

There will be no Last Week in Pony post next week. I'll be traveling and can't write it. The next post will be on July 6th.

### Pony 0.60.0 Release

We're still working toward the Pony 0.60.0 release. We've hit some serious oddness when trying to build and test `ponyup` on Windows for Arm. You can follow the progress in the [PR](https://github.com/ponylang/ponyup/pull/325). Once we sort that out, [a few tasks remain](https://github.com/ponylang/ponyc/issues/4690).

At this point, we should be doing a release sometime in July or by August at the latest.

### Office Hours

This past Office Hours was Red, Adrian, and me. We went over some generics issues that line up with the FAQ question [How can I write code that works for every kind of Number in Pony?](https://www.ponylang.io/faq/code/#code-for-all-numbers). The given solutions didn't work because Adrian needed `pi` to be defined on `FloatingPoint`, which it currently isn't. This will be a topic of discussion at a future sync.

We all agreed that we don't see any reason the methods that F32 and F64 share shouldn't all be defined on `FloatingPoint`.

A note about the June 30th Office Hours: I'll be traveling and won't be able to host Office Hours. The Zoom link will still work, so you can meet with fellow Pony users without me.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
