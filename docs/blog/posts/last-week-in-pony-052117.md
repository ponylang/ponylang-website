---
author: seantallen
categories:
- Last Week in Pony
date: 2017-05-21T17:19:03-04:00
description: Last week's Pony news, reported this week.
draft: false
title: Last Week in Pony - May 21, 2017
---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!--more-->

## A Call for Help!

- Anyone interested in porting Pony to work on 64-bit ARM? If yes, we could use a maintainer, chime in on [issue #1719](https://github.com/ponylang/ponyc/issues/1719).

## Items of note

- A new version of [Ponylang-mode](https://github.com/SeanTAllen/ponylang-mode), the Emacs mode for Pony, was released. [Release notes](https://github.com/SeanTAllen/ponylang-mode/releases/tag/0.0.9) are available.
- [Audio from the May 10, 2017, Pony Development Sync](https://sync-recordings.ponylang.io/r/2017_05_10.m4a) is available for your listening pleasure. Lots of type system and some wonderful discussion of the fun that is computers and dates.
- [RFC:34 Bare methods and lambdas](https://github.com/ponylang/rfcs/blob/main/text/0034-bare-ffi-lambdas.md) has been [merged to main](https://github.com/ponylang/ponyc/pull/1858). RFC 34 is going to be a great boon to interfacing with some libraries via C-FFI that wasn't previously possible. Want to work with a C library that uses function pointers as callbacks? Awesome, because now we have you covered.

## RFCs

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!

### New RFCs

- [String concatenation syntax](https://github.com/ponylang/rfcs/pull/90): A new syntax for concatenating `String`s (and `Stringable`s) that generates efficient code for creating the final `String`.
