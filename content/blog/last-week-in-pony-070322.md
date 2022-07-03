+++
draft = false
author = "theobutler"
description = "Version 0.51.1 of ponyc has been released! @nogginly has started a package, github.com/nogginly/termax.pony, offering enhanced terminal application development APIs."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - July 3, 2022"
date = "2022-07-03T11:35:06-04:00"
+++

Version 0.51.1 of ponyc has been released! @nogginly has started a package, github.com/nogginly/termax.pony, offering enhanced terminal application development APIs.

<!--more-->

## Items of note

- Audio from the June 28th Pony Development sync is available: [https://sync-recordings.ponylang.io/r/2022_06_28.m4a](https://sync-recordings.ponylang.io/r/2022_06_28.m4a)

## Releases

- Version 0.51.1 of ponylang/ponyc has been released.
  See the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.51.1) for more details.

---

from @nogginly:

I've started an external package that offers enhanced terminal application development APIs. This offers compatibility with the `term` package's `ANSI`, `ANSITerm` and `ANSINotify` types while defining a core API that offers more advanced capability.

[https://github.com/nogginly/termax.pony](https://github.com/nogginly/termax.pony)

So far I have been testing on macOS using Terminal.app. I would love to get some help running the example apps on other platforms (Linux, Windows). In particular, there are two examples that I would like to get feedback on:

1. `examples/formatting` which can be used to test the various text formatting options supported.
2. `examples/mousing` which can be used to test mouse input handling

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
