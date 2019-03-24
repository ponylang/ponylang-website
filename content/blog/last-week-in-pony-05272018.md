+++
draft = false
author = "mwahl"
description = "Last week's Pony news, reported this week."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - May 27, 2018"
date = "2018-05-27T22:00:00+02:00"
+++
_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!--more-->

## Pony Releases !!!

There have been so many releases this week, we got one for everybody!

### 0.22.0 - [Release Notes](https://www.ponylang.io/blog/2018/05/0.22.0-released/)

We do have a new Pony release with lots and lots of goodness added and badness fixed: [**0.22.0**](https://www.ponylang.io/blog/2018/05/0.22.0-released/). Upgrading is highly recommended, but you might need to adapt your codebase as it contains some breaking changes. For full details check out the [Release notes](https://www.ponylang.io/blog/2018/05/0.22.0-released/).

Get your `ponyc` package via docker, rpm, deb, homebrew, gentoo ebuild or compile from source. Detailed installation instructions can be found in the [ponyc repo README](https://github.com/ponylang/ponyc/blob/master/README.md).

### 0.22.1 - [Release Notes](https://www.ponylang.io/blog/2018/05/0.22.1-released/)

We also had to release **0.22.1** only for getting a broken docker image build to work. Thus there is no `ponylang/ponyc:0.22.0` docker image, but one tagged as `ponylang/ponyc:0.22.1`.

If you are using Pony **0.22.0**, there is no need to upgrade.


### 0.22.2 - [Release Notes](https://www.ponylang.io/blog/2018/05/0.22.2-released/)

And we had yet another release, this time with only one single bug fix. We used this one to validate our new release process. Upgrading is nonetheless recommended.


That has been quite a busy week, especially for Sean T. Allen. Big thanks for doing all the work to get these releases out, we all been waiting for!


## Items of Note

- Andrew Turley has been so kind to put together an incredibly useful [Pony Cheatsheet](https://www.ponylang.io/media/cheatsheet/pony-cheat-sheet.pdf), especially for learning Pony.

- Version **0.1.2** of [Pony Stable](https://github.com/ponylang/pony-stable) has been released. It is a bugfix release that fixes a bug that could cause issues if you were using a dependency whose commit was on a non-master branch. Upgrading is recommended. [Release Notes](https://www.ponylang.io/blog/2018/05/pony-stable-0.1.2-released/).


## Pony Development Sync

The Pony developers met on their weekly sync call on Wednesday, May 23, 2018. Check out the [recorded audio](https://sync-recordings.ponylang.io/r/2018_05_23.m4a).

The next one is scheduled for Wednesday, May 30, 2018, at 03:30 PM (GMT-04:00) America/New York via zoom. We'd love to have you there.

## RFCs

### New

- [Add operators for partial integer arithmetic](https://github.com/ponylang/rfcs/pull/125)

### Under Discussion

- [Formal Viewpoint Adaptation](https://github.com/ponylang/rfcs/pull/122)

- [Use Site Variance and Implicit Interfaces for Generic Types.](https://github.com/ponylang/rfcs/pull/123)

- [Trust boundary specification](https://github.com/ponylang/rfcs/pull/124)

### Final Comment Period

- [Remove HTTP libraries from the standard library](https://github.com/ponylang/rfcs/pull/117)

- [Change buffered.Reader.line to return String iso^](https://github.com/ponylang/rfcs/pull/126)

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
