+++
draft = false
author = "mwahl"
description = "Last week's Pony news."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - January 07, 2018"
date = "2018-01-07T17:30:00+01:00"
+++
_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang). 

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!--more-->


## Items of note

- LLVM 3.7.1 and 3.8.1 support has been deprecated with the merge of PR [2461](https://github.com/ponylang/ponyc/pull/2461).
- We are testing out moving some of our CI processing from TravisCI over to a container based one running on CircleCI. The first step? [Moving our Linux LLVM 5.0.1 testing to CircleCI](https://github.com/ponylang/ponyc/pull/2462). If that goes well, we'll be moving other Linux jobs from TravisCI to CircleCI. MacOS CI jobs will remain on TravisCI and Windows jobs will remain on Appveyor.
- The Pony [changelog tool](https://github.com/ponylang/changelog-tool) had two new versions released: [0.2.1](https://github.com/ponylang/changelog-tool/releases/tag/0.2.1) and [0.2.2](https://github.com/ponylang/changelog-tool/releases/tag/0.2.2). Amongst other fixes those releases made it available via [Docker Hub](https://hub.docker.com/r/ponylang/changelog-tool/)!

## Pony Development Sync

The first Development Sync Call this year happened on January 3rd this year, just in time. Check out the [audio recording](https://pony.groups.io/g/dev/files/Pony%20Sync/2018_01_03).

The next one is scheduled for Wednesday, January 10, 2018 at 03:30 PM (GMT-05:00) America/New York via zoom. We'd love to have you there.

## RFCs

### New and noteworthy

- [Rename Logger in net/http to HTTPLogger](https://github.com/ponylang/rfcs/pull/116) in order to avoid name clashes in the standard library.

### Old, but still usable

- [Class and Actor field Docstrings](https://github.com/ponylang/rfcs/pull/115)

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!

