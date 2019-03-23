+++
draft = false
author = "seantallen"
description = "Last week's Pony news, reported this week."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - August 6, 2017"
date = "2017-08-06T07:00:00-04:00"
+++
_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!--more-->

## 0.17.0 and 0.16.1 Released!

Last Sunday, we released Pony 0.16.1. It featured a couple of high-priority bug fixes. As such we recommend upgrading as soon as possible. However, 0.16.0 featured a large breaking change so we suggest you check out the release notes for both before proceeding.

- [0.16.1](https://www.ponylang.io/blog/2017/07/0.16.1-released/)
- [0.16.0](https://www.ponylang.io/blog/2017/07/0.16.0-released/)

Yesterday, we released Pony 0.17.0. It is highlighted by support for GCC 7 on Linux. Prior to this release, you weren't able to build Pony with GCC 7 due to a GCC bug. That isn't all you get with this release though. There's some nice additional features in there. Check it out!

- [0.17.0](https://www.ponylang.io/blog/2017/08/0.17.0-released/)

## Items of note

- [RFC #35: "More Promise Methods"](https://github.com/ponylang/rfcs/blob/master/text/0035-more-promise-methods.md) has been implemented and is on master. It made Kevin Hoffman really happy. Hopefully he isn't the only one. Thank you Theo Butler for the implementation.

- [RFC #44: "Match Iterator"](https://github.com/ponylang/rfcs/blob/master/text/0044-match-iter.md) has been implemented and is on master. Thanks to Kevin Hoffman for the implementation.

- [RFC #46: "More Random Methods"](https://github.com/ponylang/rfcs/blob/master/text/0046-more-random-methods.md) was both approved and implemented this quick. Joe Eli McIlvain is to thank for the quick turn around on that one.

- Audio from the [August 2nd, 2017 Pony development sync](https://pony.groups.io/g/dev/files/Pony%20Sync/August%202,%202017) is now available.

## News and Blog Posts
  
- Chris Double has written some excellent Pony blogposts. His new one included: ["Reference Capabilities, Consume and Recover in Pony"](https://bluishcoder.co.nz/2017/07/31/reference_capabilities_consume_recover_in_pony.html). If you have trouble figuring out when and how to use `consume` and `recover`, give this post a read.

- Video of Sophia Drossopoulou's PLISS'17 talk "Pony: Actors and Objects" is now available. It's split into two parts. [Part 1](https://www.youtube.com/watch?v=FSu8mBm3iJs). [Part 2](https://www.youtube.com/watch?v=ypCF34YVtRE).

## RFCs

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!

### Approved RFCs
  
- [RFC #46: "More Random methods"](https://github.com/ponylang/rfcs/blob/master/text/0046-more-random-methods.md)

### Final Comment Period
  
- [Change String.join to take an Iterable instead of a ReadSeq](https://github.com/ponylang/rfcs/pull/98)
