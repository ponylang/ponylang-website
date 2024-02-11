---
draft: false
authors:
  - seantallen
  - ryan
description: "Update your HTTP library related dependencies."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - January 21, 2024"
date: 2024-01-21T07:00:06-04:00
---

Update your HTTP library related dependencies.

<!-- more -->

## Items of Note

### Update your "HTTP related" dependencies

That week we discovered a [bug related to OpenSSL 3.2](https://www.ponylang.io/blog/2024/01/last-week-in-pony---january-14-2024/#openssl-3-2-related-bug).

This week, we released new versions of [ponylang/net_ssl](https://github.com/ponylang/net_ssl), [ponylang/http](https://github.com/ponylang/http), and [ponylang/http_server](https://github.com/ponylang/http_server) to fix the issue on the Pony side of things.

If you use any of those libraries, we advise updating as soon as possible.

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2024_01_16.m4a) from the January 16th, 2023 sync is available.

Today's sync featured a couple of interesting topics. We had a discussion about improvements that could be made to the [ponylang/http library](https://github.com/ponylang/http).

We also discussed whether a small "library" that Sean is working on should go through the RFC process to become part of the standard library or should be done as a library under the [ponylang organization](https://github.com/ponylang). It was eventually decided to open an RFC for inclusion in the standard library and for discussion of nuances of adding a "validation error" type. The audio mentions code that demonstrates the key principles of the validation library. You can find a gist of the code [here](https://playground.ponylang.io/?gist=7aadb11e921d000b5758cb424c707be1).

### Office Hours

We have an open Zoom meeting every week for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try. The meeting is open to anyone. Stay up-to-date with the schedule by [subscribing to the Office Hours calender](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics). Hopefully, we'll see you at an Office Hours soon.

There was no Office Hours this week. Sean was spending the holiday afternoon [candlepin bowling](https://en.wikipedia.org/wiki/Candlepin_bowling) and forgot it was a Monday aka Office Hours day.

## Releases

- [ponylang/http 0.5.5](https://github.com/ponylang/http/releases/tag/0.5.5)
- [ponylang/http_server 0.4.6](https://github.com/ponylang/http_server/releases/tag/0.4.6)
- [ponylang/net_ssl 1.3.2](https://github.com/ponylang/net_ssl/releases/tag/1.3.2)

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week let us look at a pattern in Pony code concerning the [Supply Chain](https://patterns.ponylang.io/creation/supply-chain) of dependencies. Due to Pony's asynchronous, actor model design we can find ourselves in situations where we might naively want to "communicate back" failure. This is not the best approach due to the way Pony error handling works and the requirement that constructors be total functions. Taken together, these two intentional design elements require rethinking how we handle creating objects that can fail creation. The short answer to this problematic situation is to fully initialize our dependencies -- allow us to handle their error scenarios separately -- then supply these fully initialized dependencies to the constructor. This pattern is called  __dependency injection__.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
