---
draft: false
authors:
  - theobutler
description: "We have landed a fix to the underlying time source for `Time.nanos()` on Apple Silicon."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - November 14, 2021"
date: 2021-11-14T11:16:57-05:00
---

We have landed a fix to the underlying time source for `Time.nanos()` on Apple Silicon.

<!-- more -->

## Items of note

- Audio from the [2021-11-09](https://sync-recordings.ponylang.io/r/2021-11-09.m4a) Pony development sync call is available.

- We have landed [a fix to the underlying time source for `Time.nanos()`](https://github.com/ponylang/ponyc/pull/3921) on Apple Silicon. Without this fix, users of the `timers` package would observe timers firing with significant delay. If you're using `ponyc` on ARM macOS, we recommend you upgrade by building from source from the `main` branch.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
