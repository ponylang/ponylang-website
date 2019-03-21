+++
draft = false
author = "mwahl"
description = "Last week's Pony news."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - January 21, 2018"
date = "2018-01-21T20:00:00+01:00"
+++
_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [users' mailing list](https://pony.groups.io/g/user).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!--more-->

## Pony 0.21.3 released

A new wonderful version Ponyc has been released last week: [0.21.3](https://www.ponylang.io/blog/2018/01/0.21.3-released/).

Next to various bug fixes it brought us [Dynamic Scheduler Scaling](https://www.ponylang.io/blog/2018/01/0.21.3-released/#disable-dynamic-scheduler-scaling).

Upgrading as soon as possible is recommended.


## Items of note

- *pony-fmt* which has been announces last week has been renamed to [pony-sform](https://github.com/krig/pony-sform), to not collide with the existing [ponyfmt](https://github.com/mfelsche/ponyfmt).
- [pony-cbor](https://github.com/ii8/pony-cbor), a Pony implementation of the [Concise Binary Object Representation](http://cbor.io/) format has been [announced on the mailinglist](https://pony.groups.io/g/user/message/1560).
- [OpenSSL 1.1 support](https://github.com/ponylang/ponyc/pull/2415) was merged to master. You'll see it in a release coming your way very soon.

## Pony Development Sync

Another Sync call took place on Wednesday January 17, 2018. Check out the [recorded audio](https://pony.groups.io/g/dev/files/Pony%20Sync/2018_01_17).

The next one is scheduled for Wednesday, January 24, 2018 at 03:30 PM (GMT-05:00) America/New York via zoom. Join the [Dev Mailing List](https://pony.groups.io/g/dev) to get all the details. We'd love to have you there.

## RFCs

### New and noteworthy

- [Improved Ponybench](https://github.com/ponylang/rfcs/pull/119)

### Old, but still usable

- [Remove HTTP server from the standard library](https://github.com/ponylang/rfcs/pull/117).

- [Remove existing case functions implementation from Pony](https://github.com/ponylang/rfcs/pull/118)

- [Rename Logger in net/http to HTTPLogger](https://github.com/ponylang/rfcs/pull/116) in order to avoid name clashes in the standard library.

### Accepted

- [Class and Actor field Docstrings](https://github.com/ponylang/rfcs/pull/115) has been merged and awaits its implementation.

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!

