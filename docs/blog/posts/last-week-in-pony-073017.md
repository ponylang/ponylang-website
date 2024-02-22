---
draft: false
authors:
  - seantallen
description: "Last week's Pony news, reported this week."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - July 30, 2017"
date: 2017-07-30T06:00:00-04:00
---
_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!-- more -->

## Pony 0.16.0 and 0.16.1

On Friday we released version 0.16.0. There are no critical bug fixes so you can hold off upgrading if you want to. However, please be aware that there is a breaking change in 0.16.0 that will impact just about every Pony codebase there is. It has the potential to be a painful upgrade, so we put together some tools to help update your codebase. See the [release post](https://github.com/ponylang/ponyc/releases/tag/0.16.0) for more details.

At this time this "Last Week in Pony" was published, we were in [the process of releasing 0.16.1](https://github.com/ponylang/ponyc/issues/2101). It addresses a couple of high priority bugs. We suggest upgrading once it's released.

## Items of note

- Matthias Wahl announced [Ponycheck](https://github.com/mfelsche/ponycheck)- a property based testing tool for Pony. For more details, check out the [announcement on the mailing list](https://pony.groups.io/g/user/message/1263).
- Stewart Gebbie announced [Pony Watcher](https://github.com/sgebbie/pony-watcher). Some scripts he uses to speed up his development cycle. Learn more from his [mailing list announcement](https://pony.groups.io/g/user/message/1264).
- The [Pony Playground](https://playground.ponylang.io/) now compiles your programs in debug mode. This change makes `Debug.out("foo")` now result in output. [Enjoy](https://playground.ponylang.io/?gist=66aab8cfb7fb9be14b7d2c2b9b91b617)!
- We're looking for help putting together documentation on how to cross-compile Pony programs. If you have experience and can help, [please respond on the mailing list](https://pony.groups.io/g/user/message/1254).
- The Pony Virtual Users' Group needs you! [Get involved today!](https://pony.groups.io/g/user/message/1280)
- Audio from the [July 26, 2017, Pony development sync](https://vimeo.com/915146055) is available for your listening pleasure.

## News and Blog Posts

- [The Promise of Pony's Future](https://medium.com/@KevinHoffman/the-promise-of-ponys-future-44040a0b64ff)
- New Pony Pattern! [Interrogating Actors with Promises](https://patterns.ponylang.io/async/actorpromise.html)

## RFCs

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!

### Approved RFCs

- [Lambda and Array inference](https://github.com/ponylang/rfcs/blob/main/text/0045-lambda-and-array-inference.md)
- [Match Iterator](https://github.com/ponylang/rfcs/blob/main/text/0044-match-iter.md)

### Final Comment Period

- [More `Random` methods](https://github.com/ponylang/rfcs/pull/97)

### New RFCs

- [Change String.join to take an Iterable instead of a ReadSeq](https://github.com/ponylang/rfcs/pull/98)
