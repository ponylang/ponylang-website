+++
draft = false
author = "mwahl"
description = "Last week's Pony news, reported this week."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - June 10, 2018"
date = "2018-06-10T20:30:00+02:00"
+++
_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](ponylang.org), our Twitter account [@ponylang](https://twitter.com/ponylang), our [users' mailing list](https://pony.groups.io/g/user) or join us [on IRC](https://webchat.freenode.net/?channels=%23ponylang). 

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!--more-->

## Pony Releases

Yes, indeed, we have a section for this now. And yes, it is plural. And yes, maybe we do it to prove we have tighter release cycles than java, now they switched to time-based versioning, because this is what it's all about after all, isn't it?

So, as with every good story, lets start at the beginning:

### Pony 0.22.4 - [Release Notes](https://www.ponylang.org/blog/2018/06/0.22.4-released/)

Two small bugfixes around union types with the same elements and the `cli` package.

### Pony 0.22.5 - [Release Notes](https://www.ponylang.org/blog/2018/06/0.22.5-released/)

High-priority bugfix for systems with NUMA enabled. Upgrading is highly recommended. 

### Pony 0.22.6 - [Release Notes](https://www.ponylang.org/blog/2018/06/0.22.6-released/)

This one fixes a performance regression introduced in the 0.22.X series and fixes a bug in tuple handling that could cause crashes during compilation. Here too, we recommend to upgrade.

### Pony 0.23.0 - [Release Notes](https://www.ponylang.org/blog/2018/06/0.23.0-released/)

Whoa! Minor version increase. Why is that? Breaking change, that's why! Blame [RFC 56](https://github.com/ponylang/rfcs/blob/master/text/0056-buffered-reader-line-iso.md). But it is actually mainly a bugfix release for several bugs around tuple handling, `Promise.join(...)` and writing big io-vectors to `File`. Upgrading is recommended.


## New Distribution Channels: PPA and COPR

We are very proud to present you two new distribution channels for both [ponyc](https://github.com/ponylang/ponyc) and [pony-stable](https://github.com/ponylang/pony-stable): We now also distribute via [Fedora COPR](https://copr.fedorainfracloud.org/coprs/ponylang/ponylang/) and [Ubuntu Launchpad PPA](https://launchpad.net/%7Eponylang/+archive/ubuntu/ponylang).

### Install `ponyc`:

* [via COPR](https://github.com/ponylang/ponyc/#linux-using-an-rpm-package-via-copr)
* [via PPA](https://github.com/ponylang/ponyc/#ubuntu-linux-using-a-deb-package-via-launchpad-ppa)

### Install `pony-stable`

* [via COPR](https://github.com/ponylang/pony-stable#linux-using-an-rpm-package-via-copr)
* [via PPA](https://github.com/ponylang/pony-stable#ubuntu-linux-using-a-deb-package-via-launchpad-ppa)

## News and Blog Posts

- Sean Allen and Sylvan Clebsch will be doing a [Pony tutorial at CodeMesh London](https://codesync.global/conferences/code-mesh-2018/training) on *November 7th*. Attend if you can! This is peak Pony teaching!

- [Generating Pony Coverage Reports](https://blog.m7w3.de/pony-coverage.html) by Matthias Wahl (That's me!!!)

## Pony Development Sync

The Pony developers met on their weekly sync call on Wednesday, June 6, 2018. Check out the [recorded audio](https://pony.groups.io/g/dev/files/Pony%20Sync/2018_06_06).

The next one is scheduled for Wednesday, June 13, 2018, at 03:30 PM (GMT-04:00) America/New York via zoom. Join the [Dev Mailing List](https://pony.groups.io/g/dev) to get all the details. We'd love to have you there.

## RFCs

### Accepted

- [Remove HTTP libraries from the standard library](https://github.com/ponylang/rfcs/pull/117)

- [Change buffered.Reader.line to return String iso^](https://github.com/ponylang/rfcs/pull/126)

### Final Comment Period

- [Add operators for partial integer arithmetic](https://github.com/ponylang/rfcs/pull/125)

- [Formal Viewpoint Adaptation](https://github.com/ponylang/rfcs/pull/122)

- [SSL ALPN](https://github.com/ponylang/rfcs/pull/127)

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
