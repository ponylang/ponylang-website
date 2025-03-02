---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - March 2, 2025"
date: 2025-03-02T07:00:06-04:00
---

There's a new ponyc out in the wild, but unless you are doing lots of ["mix-in programming"](https://patterns.ponylang.io/code-sharing/mixin) with Pony like I am, you don't need to rush to update.

<!-- more -->

## Items of Note

### Ponyc 0.58.12 Released

Hey! Saturday [ponyc 0.58.12](https://github.com/ponylang/ponyc/releases/tag/0.58.12) was released.

This release was done "out-of-schedule" because, I want for the version of [ponylang/lori](https://github.com/ponylang/lori) that I'm going to release soon to be able to work with a ponyc build that isn't a nightly. So, I made a release.

The fixes in 0.58.12 are all about mix-ins. If you are doing a lot of mix-in programming, you should update. If you are not, you can wait until the next release unless you are planning on using lori or [ponylang/postgres](https://github.com/ponylang/postgres).

### Pony Development Sync

The recording from this week's Development Sync is now [available on Vimeo](https://vimeo.com/1060260421).

We mostly discussed issues and PRs in the [ponyc repo](https://github.com/ponylang/ponyc) including fixes for some implementation bugs with traits and default methods. We closed a couple old issues that "fixed themselves". And finally, we discussed how `strftime` is kind of an awful API and a fix for an edge case therein in the runtime.

### Office Hours

I was ill during Office Hours this week and didn't attend. Red sent along this summary:

Office Hours this week was attended by Red and Nate.  We covered quite a bit of ground with a number of pony related topics:

1. Why lori. When lori, and will lori end up in stdlib.  Red discussed why he was implementing a http library using lori as opposed to using the existing http_server which is based upon stdlib's "net" package.
2. We discussed performance and where pony would/should shine, and the type of real-world applications that pony was best suited for.
3. Language evolution and evangelism.

It was a good time, y'all should have been there.

## Releases

- [ponylang/ponyc 0.58.12](https://github.com/ponylang/ponyc/releases/tag/0.58.12)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
