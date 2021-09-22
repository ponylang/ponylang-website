+++
draft = false
author = "theobutler"
description = "Pony 0.35.0 and 0.35.1 have been released! Stable, our little dependency manager that could, has been deprecated in favor of our new dependency manager, Corral."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - May 17, 2020"
date = "2020-05-17T11:54:44-04:00"
+++

Pony 0.35.0 and 0.35.1 have been released! Stable, our little dependency manager that could, has been deprecated in favor of our new dependency manager, Corral.
<!--more-->

## Items of note

- Audio from the May 12, 2020 Pony sync is available [here](https://sync-recordings.ponylang.io/r/2020_05_12.m4a).

- Stable, our little dependency manager that could, has been deprecated. It's being replaced by [Corral](https://github.com/ponylang/corral). The stable repo has been archived. No additional fixes, changes, or releases will be coming. Thank you to everyone who [contributed](https://github.com/ponylang/pony-stable/graphs/contributors).

- Work started to bring Pony Language support to IntelliJ platforms such as IDEA and CLion. See roadmap and vision at [https://github.com/niclash/pony-idea-plugin](https://github.com/niclash/pony-idea-plugin). Assistance greatly appreciated from Java developers to bring code navigation, code completion, quick fixes, intentions, doc lookup, debugger integration and much more.

- Ponyc release notes are moving!

    Previously, release notes for Ponyc were posted to [Ponylang website](https://www.ponylang.io/categories/release/). Starting today, they will be posted in the [release tab](https://github.com/ponylang/ponyc/releases) of the [ponyc repo](https://github.com/ponylang/ponyc).

    As a result of this, there will be no RSS feed for releases. Releases will still be announced in Last Week in Pony which still has an RSS feed.

    The release notes are moving as automating their creation on GitHub is easier to do and maintain than having them on the [ponylang website](https://ponylang.io).

## Releases

- Pony 0.35.0 has been released. Full details are in the [release notes](https://www.ponylang.io/blog/2020/05/0.35.0-released/). It was followed by 0.35.1. 0.35.1 fixes a bug introduced by 0.35.0 that only impacts Windows users. Windows users using 0.35.0 should update to 0.35.1. See the [release notes](https://www.ponylang.io/blog/2020/05/0.35.1-released/) for more details.

- Version 0.2.0 of semver has been released. See the [release notes](https://github.com/ponylang/semver/releases/tag/0.2.0) for more details.

- Version 0.3.5 of corral has been released. See the [release notes](https://github.com/ponylang/corral/releases/tag/0.3.5) for more details.

## RFCs

### Approved RFCs

- [RFC 65: env-root-not-optional](https://github.com/ponylang/rfcs/blob/main/text/0065-env-root-not-optional.md)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
