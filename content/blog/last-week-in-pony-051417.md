---
author: seantallen
categories:
- Last Week in Pony
date: 2017-05-14T13:05:12-04:00
description: Last week's Pony news, reported this week.
draft: false
title: Last Week in Pony - May 14, 2017
---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!--more-->


## Items of note

- The Alpine Linux folks have offered to make Pony distributable via their normal channels. In order to take advantage of this, we need someone to step forward as a maintainer. Could it be you? We certainly hope so. See [the comments on PR #1844](https://github.com/ponylang/ponyc/pull/1844) for more details. If you are interested, drop us a line on the [developer mailing list](https://pony.groups.io/g/dev), [on twitter](https://twitter.com/ponylang), or leave a comment on [PR #1844](https://github.com/ponylang/ponyc/pull/1844).

- [RFC #40: exhaustive match](https://github.com/ponylang/rfcs/blob/master/text/0040-exhaustive-match.md) was merged to master on Wednesday. Thanks Joe for your hard work on this. As noted later on the [PR](https://github.com/ponylang/ponyc/pull/1891), there are a couple of issues that we still need to address. Learn more about them [#1892: Union of tuples / tuple of unions](https://github.com/ponylang/ponyc/issues/1892) and [#1893: Exhaustive match does not work for case methods](https://github.com/ponylang/ponyc/issues/1893)

- At a previous developer sync meeting, Theo Butler volunteered to take on the task of writing up a Pony style guide based on existing patterns in the standard library. He's opened a [PR](https://github.com/ponylang/ponyc/pull/1894) for feedback.

- Carl Quinn opened a [PR](https://github.com/ponylang/ponyc/pull/1897) for initial feedback on [RFC #38](https://github.com/ponylang/rfcs/blob/master/text/0038-cli-format.md). It aims to replace the existing `Options` package and provide a standard command line argument syntax for Pony tools and other programs, and a corresponding package named cli to be provided in the standard library.

- [Audio from the May 10, 2017 Pony Development Sync](https://sync-recordings.ponylang.io/r/2017_05_10.m4a) is available for your listening pleasure. We had a light attendence and as such, the meeting only ran about 30 minutes instead of the usual 60.

## News and Blog Posts
  
- "Funky Bob" aka Curtis Maloney has recently started learning Pony and has a [short blog post about his experience so far](http://musings.tinbrain.net/blog/2017/may/11/learning-pony/).

## RFCs

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
