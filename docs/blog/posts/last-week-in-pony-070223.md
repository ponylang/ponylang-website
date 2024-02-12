---
draft: false
authors:
  - seantallen
  - ryan
description: "A slow lead up to a long weekend."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony July 2, 2023"
date: 2023-07-02T07:00:06-04:00
---

A slow lead up to a long weekend.

<!-- more -->

## Items of Note

### Pony Development Sync

There was no recorded development sync this past week although Sean, Adrian, Dipin, and Red did chat for a bit.

### July 4th Pony Development Sync Cancelled

Next week's Pony Development Sync would fall on a national holiday in the US. Given the likely very low turnout, we've cancelled the sync.

### No `ponyc` Release This June

Normally we have a monthly release of `ponyc`. However, there's not really any changes worth releasing at this point so, there won't be a June release of `ponyc`. The next release is tentatively scheduled for the end of July assuming that:

- No critical issues are fixed before the end of July
- Something worth releasing is merged is merged before the end of July

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week we are going to look at one of the papers available at <https://www.ponylang.io/community/#papers> -- specifically we are going to look at [A String of Ponies](https://www.ponylang.io/media/papers/a_string_of_ponies.pdf)!

This paper is focused on all aspects of what it would take to go from the Concurrent Pony of today to full-fledged Distributed Pony! It is well worth a full read, but today let's focus on Distributed Pony [Termination](https://www.ponylang.io/media/papers/a_string_of_ponies.pdf#section.3.8). As a reminder, Pony today terminates when it has reached a state of _quiescence_ whereby there is no remaining work (see [When do programs exit?](https://www.ponylang.io/faq/#program-exit) for more information). This presents a major problem in a distributed environment: how do we differentiate between locally running out of work and globally running out of work? This is far from easy to fix. This section includes two attempts at designing a solution, the first is broken while the second work. As with many aspects of Pony, the working solution leverages message causality. By defining a _termination detector_ and leveraging Pony's existing causal messaging we can identify when to terminate the program. The result of this emphasis on causal messaging in a distributed system is a tree network topology -- the chapter that directly follows from Termination, investigating this topic further is left as a exercise to the reader!

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
