---
draft: false
authors:
  - seantallen
description: "Last week's Pony news, reported this week."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - September 17, 2017"
date: 2017-09-17T07:11:57-04:00
---
_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!-- more -->

## Pony 0.19.1 Released

Last Thursday, Pony 0.19.1 was released. It's a non-breaking change **and** includes a hot new feature so we think you should update soon. The highlight of 0.19.1 is definitely the implementation of [RFC #45: "Lambda and Array Inference"](https://github.com/ponylang/rfcs/blob/main/text/0045-lambda-and-array-inference.md). It's an incredibly useful feature that greatly improves Pony's programmer ergonomics. Check out the [blog post announcing the release](https://github.com/ponylang/ponyc/releases/tag/0.19.1) for full details.

## Items of note

- [Pony-stable](https://github.com/ponylang/pony-stable), the Pony dependency manager, is now available via [Homebrew](https://brew.sh/). Prebuilt binaries for Windows and Linux are [coming soon](https://github.com/ponylang/pony-stable/issues/26).
- [Wallaroo Labs](https://www.wallaroolabs.com/), formerly Sendence, released their in-progress [Pony Kafka client](https://github.com/WallarooLabs/pony-kafka). The client currently only works with their [custom ponyc fork](https://github.com/wallaroolabs/ponyc), but they announced that it should be ported to mainline ponyc "soon".
- Sean T. Allen (that's me!) announced the 0.1 release of a pure Pony [MessagePack](http://msgpack.org/index.html) client called [pony-msgpack](https://github.com/SeanTAllen/pony-msgpack/releases/tag/0.1). It's still feature incomplete but will becoming more full featured over time.
- Audio from the [September 13, 2017 Pony development sync](https://vimeo.com/915151279) is available for your listening pleasure.

## News and Blog Posts

- [A Framework for Gradual Memory Management](https://drive.google.com/file/d/0B_4wx_3dTGICWG1Ddk81Rnh0YzA/view) proposes a way for a language's compiler to allow a single program to use multiple memory management strategies optimized for performance, with compile-time safety guarantees. The Pony community might be interested because it adopts Pony's reference capabilities as part of its proposed mechanisms.
- Jorge Díaz wrote a blog post about his first experience with Pony- [Go through this concurrent world in the company of a Pony](https://medium.com/@jdia/go-through-this-concurrent-world-in-the-company-of-a-pony-f24bcf501855).

## RFCs

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
