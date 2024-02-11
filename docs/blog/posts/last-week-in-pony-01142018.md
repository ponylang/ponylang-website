---
draft: false
author: "mwahl"
description: "Last week's Pony news."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - January 14, 2018"
date: 2018-01-14T12:00:00+01:00
---
_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!--more-->

## Items of note

- [pony-fmt](https://github.com/krig/pony-fmt), an alternate string formatting library for pony. Kristoffer, its author, is looking for feedback.
- [pony-benchmark](https://github.com/Theodus/pony-benchmark) is the new micro-benchmark framework, written by [Theodus](https://github.com/Theodus). For those of you not in the know, [PonyBench](https://stdlib.ponylang.io/pony_bench--index) is/was a micro-benchmarking framework for Pony and [pony-benchmark](https://github.com/Theodus/pony-benchmark) is going to be its successor. Theo had this to say about the new version:

  > I've finished most of the work on a new micro-benchmark framework to replace ponybench. The new framework allows benchmarks to be run with GC and provides more fine-grained control over the statistics generated. See the bottom of the README for charts created from the CSV output.

- The [Pony library starter pack](https://github.com/ponylang/library-project-starter) has gotten an update. It now includes CircleCI instead of TravisCI for default CI setup. The CircleCI configuration involves fewer manual setup steps so we decided to move to it for the default.

## Pony Development Sync

Another Sync call took place on Wednesday January 10, 2018. Check out the [recorded audio](https://sync-recordings.ponylang.io/r/2018_01_10.m4a).

The next one is scheduled for Wednesday, January 17, 2018 at 03:30 PM (GMT-05:00) America/New York via zoom. We'd love to have you there.

## RFCs

### New and noteworthy

- [Remove HTTP server from the standard library](https://github.com/ponylang/rfcs/pull/117).

- [Remove existing case functions implementation from Pony](https://github.com/ponylang/rfcs/pull/118)

### Old, but still usable

- [Rename Logger in net/http to HTTPLogger](https://github.com/ponylang/rfcs/pull/116) in order to avoid name clashes in the standard library.

### Final Comment Period

- [Class and Actor field Docstrings](https://github.com/ponylang/rfcs/pull/115)

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
