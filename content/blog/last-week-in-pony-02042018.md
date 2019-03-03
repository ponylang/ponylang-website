+++
draft = false
author = "mwahl"
description = "Last week's Pony news."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - February 04, 2018"
date = "2018-02-04T18:00:00+01:00"
+++
_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [users' mailing list](https://pony.groups.io/g/user).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!--more-->


## Items of note

- The folks over at Wallaroo Labs have a post about why they decided to write their own [Kafka client in Pony](https://github.com/WallarooLabs/pony-kafka) rather than simply wrapping the C library. While Wallaroo specific, the general thinking could apply to your Pony project as well: https://blog.wallaroolabs.com/2018/01/why-we-wrote-our-kafka-client-in-pony/

- A new JSON parser for Pony has been announced on reddit: https://github.com/Krognol/ponyjson

- [PR #2439](https://github.com/ponylang/ponyc/pull/2439) for embedding source code listings into generated documentation has been merged to master. With this change, we now own a new theme for mkdocs, [mkdocs-ponylang](https://github.com/mfelsche/ponylang-mkdocs-theme). We needed this to make the necessary changes for [PR #2439](https://github.com/ponylang/ponyc/pull/2439) but we are not yet happy with its current state (visually and code-wise). We want to reach out to you folks for help on this project. In case you are interested, please drop us a line via the [Pony mailing list](https://pony.groups.io/g/user/). Any help is much appreciated!


## Pony Development Sync

Another Sync call took place on Wednesday January 31, 2018. Check out the [recorded audio](https://pony.groups.io/g/dev/files/Pony%20Sync/2018_01_31).

The next one is scheduled for Wednesday, February 7, 2018 at 03:30 PM (GMT-05:00) America/New York via zoom. Join the [Dev Mailing List](https://pony.groups.io/g/dev) to get all the details. We'd love to have you there.

## RFCs

### Pending

- [Remove HTTP server from the standard library](https://github.com/ponylang/rfcs/pull/117).

- [Rename Logger in net/http to HTTPLogger](https://github.com/ponylang/rfcs/pull/116) in order to avoid name clashes in the standard library.

### Final Comment Period

- [Improved Ponybench](https://github.com/ponylang/rfcs/pull/119)

- [Remove existing case functions implementation from Pony](https://github.com/ponylang/rfcs/pull/118)

### Active (Waiting for Implementation)

- [Class and Actor field Docstrings](https://github.com/ponylang/rfcs/pull/115)

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!

