+++
draft = false
author = "red"
description = "Sync Calls and No Sleep"
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - August 7, 2022"
date = "2022-08-07T00:59:59-04:00"
+++

This week we add a new section to This Week in Pony where your (currently nomadic) Author will highlight a language trait or principle that, if you are new to pony may surprise you.


<!--more-->

## Ponies can't sleep...

More accurately, pony doesn't have a sleep command or equivalent. In fact, Pony has zero blocking operations.

We don't block for IO.

We don't block for synchronous calls to actors (they don't exist).

We don't block waiting for locks (they don't exist either).

We don't block.

Pony's philosophy has performance second only to correctness. One does not get performance if one introduces unnecessary latency.

For those of us who came from languages that block, there's a section in the [pony patterns website](https://patterns.ponylang.io/async/index.html) that provides examples of how to perform functions that would typically block in other languages.


## Items of note

- Audio from the August 2nd Pony Development sync is available: [https://sync-recordings.ponylang.io/r/2022_08_02.m4a](https://sync-recordings.ponylang.io/r/2022_08_02.m4a)


---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
