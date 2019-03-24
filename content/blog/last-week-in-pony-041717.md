---
author: seantallen
categories:
- Last Week in Pony
date: 2017-04-18T07:11:02-04:00
description: Last week's Pony news, reported this week.
draft: false
title: Last Week in Pony - April 17, 2017
---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!--more-->


## Items of note

- After a bit of DNS wrangling and drama, the standard library documentation is back online at its new official home: [http://stdlib.ponylang.io](http://stdlib.ponylang.io)

- Several new ["easy to get started with"](https://github.com/ponylang/ponyc/issues?q=is:issue+is:open+label:%22difficulty:+1+-+easy%22) issues have recently been opened. They are a great way to get started with contributing to Pony. Interested in taking on one? Let us know on the issue.

- Andrew Turley opened a [PR](https://github.com/ponylang/ponyc/pull/1839) for [RFC #21](https://github.com/ponylang/rfcs/blob/master/text/0021-custom-serialization.md). When merged it will allow the programmer to specify custom serialization/deserialization that would be run as part of Pony's built-in serialization/deserialization process. The custom methods would run after the built-in serialization and deserialization and would allow the programmer to:

  > - specify the number of bytes to use for serialization
  > - write bytes to the serialization buffer
  > - read bytes from the serialization buffer

- Wojciech Migda has opened a [very exciting PR](https://github.com/ponylang/ponyc/pull/1840) to integrate [RapidCheck](https://github.com/emil-e/rapidcheck) into the Pony code base. It's very early on but the idea of having property based testing on the C codebase that drives the Pony runtime and compiler is very exciting.

## News and Blog Posts
  
- Audio from the April 12th Pony developer's sync is available at [https://sync-recordings.ponylang.io/r/2017_04_12.m4a](https://sync-recordings.ponylang.io/r/2017_04_12.m4a). The call was devoted mostly to addressing older issues that had started to back up. If you'd like to get involved with Pony development, feel free to stop by. We meet [weekly](https://calendar.google.com/calendar?cid=NTlqY3J1NmY1MG1ycHFibTdlbTRpY2xua2tAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ).

- Core team member [Sean T. Allen](https://twitter.com/seantallen) announced that he'll be giving two different Pony talks in the coming months. One at [PolyConf](https://polyconf.com) in July, the other at [QConNewYork](https://qconnewyork.com/ny2017/presentation/pony-fintech-experience-report) in June.

## RFCs

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
