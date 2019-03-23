+++
draft = false
author = "seantallen"
description = "Last week's Pony news, reported this week."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - September 3, 2017"
date = "2017-09-03T07:11:00-04:00"
+++
_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!--more-->

## Pony 0.19.0 Released

Yesterday Pony 0.19.0 was released. The release contains breaking changes. If you don't use the `Itertools` package then upgrading should be painless. If you do use `Itertools`, the process should be relatively straightforward. MacOS, FreeBSD and Dragonfly BSD users are recommended to upgrade as soon as possible to fix a race condition on the kqueue event system. More details information is available in the [release notes](https://www.ponylang.io/blog/2017/09/0.19.0-released/).

## Items of note

- The ["Improve `Iterools` API" RFC](https://github.com/ponylang/rfcs/blob/master/text/0049-improved-itertools-api.md) has been implemented and released. See the [Pony 0.19.0 release notes](https://www.ponylang.io/blog/2017/09/0.19.0-released/) for how to update for the breaking API change.
- Audio from the [August 30, 2017, Pony development sync](https://pony.groups.io/g/dev/files/Pony%20Sync/2017_08_30) is available for your listening pleasure.
- Andrew Turley has started a [project](https://github.com/aturley/pony-lldb) that collects together helpful commands for usage with Pony and LLDB. Check it out and contribute today!

## News and Blog Posts
  
- Sean T. Allen's QCon New York talk on Pony is now available. [Pony: How I learned to stop worrying and embrace an unproven technology"](https://www.infoq.com/presentations/pony-wallaroo). [Slides](https://speakerdeck.com/seantallen/pony-how-i-learned-to-stop-worrying-and-embrace-an-unproven-technology).

## RFCs

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
