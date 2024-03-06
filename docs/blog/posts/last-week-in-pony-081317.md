---
draft: false
authors:
  - seantallen
description: "Last week's Pony news, reported this week."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - August 13, 2017"
date: 2017-08-13T07:00:00-04:00
---
_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!-- more -->

## Pony Performance Cheat Sheet

Yesterday we added the first revision of the [Pony Performance Cheat Sheet](https://www.ponylang.io/reference/pony-performance-cheatsheet/) to the website. There's a **ton** of valuable information. Even if you aren't a Pony programmer, we think you'll get something out of it. And you Pony programmers who are interested in performance? It's a must read for you.

## Items of note

- [Pony Stable](https://github.com/ponylang/pony-stable) our little dependency manager that could now runs on Windows. Thank you Gordon Tisher! This is a big deal, it's the first step in stable's eventual conquest of the Pony universe.
- The ["Interrogating Actors with Promises" Pony Pattern](https://patterns.ponylang.io/async/actorpromise.html) updated to take advantage of new Promises methods introduced in [RFC #35](https://github.com/ponylang/rfcs/blob/main/text/0035-more-promise-methods.md).
- Audio from the [August 9, 2017 Pony development sync](https://vimeo.com/915149557) is available for your listening pleasure. If you wait til the end there's some interesting garbage collection stuff. Earlier, there is talk of documentation generation and code formatting tools along with the usual business. There's also some interesting discussion related to the ["Fix overly restrictive field reference rule in recover expressions" PR](https://github.com/ponylang/ponyc/pull/2043). There's a lot of good stuff at the end is what we are saying. Listen to the whole thing.

## News and Blog Posts

- Back in early July, Sean T. Allen travelled to Paris to talk Pony at [Polyconf 17](https://polyconf.com/). [Slides](https://speakerdeck.com/seantallen/why-pony) are now available for "Why Pony? Bleeding edge technology for your concurrency woes".
- Kevin Hoffman keeps rolling along with another Pony related blog post: ["Modeling Non-Blocking Interactions with Actors in Pony"](https://medium.com/@KevinHoffman/modeling-non-blocking-interactions-with-actors-in-pony-fae59151246a).
- Brian Sletten gave a talk on Pony at No Fluff Just Stuff. It wasn't recorded but slides are available. Sadly, they were eventually taken down.

## RFCs

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!

### Approved RFCs

- [Serialised Signature](https://github.com/ponylang/rfcs/blob/main/text/0047-serialise-signature.md)
- [Change `String.join` to take an `Iterable`](https://github.com/ponylang/rfcs/blob/main/text/0048-change-String-join-to-take-iterable.md)

### New RFCs

- [Improved Itertools API](https://github.com/ponylang/rfcs/pull/101)
