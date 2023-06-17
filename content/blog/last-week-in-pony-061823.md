+++
draft = false
author = "seantallen"
description = "<< content >>"
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony June 18, 2023"
date = "2023-06-18T07:00:06-04:00"
+++

<< content >>

## Items of Note

### Pony Development Sync

[Audio & Video](https://sync-recordings.ponylang.io/r/2023_06_13.mp4) from the June 13th, 2023 sync is available.

In today's sync, we chatted through some rough ideas for macro systems, how it's done in other languages, how it might be done in Pony. Te concept of macros covers a very wide set of possible use cases (some of them potentially with conflicting requirements). We only talked through a few use case examples today, and also hinted at the need to gather more use cases together to start to coherently generalize the need.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week we are highlighting the [`ponylang/fork_join`](https://github.com/ponylang/fork_join) library.

There was a time when many folks would sign up for the [Pony Zulip](https://ponylang.zulipchat.com/) and ask how they could use Pony to concurrently process a large array or something similar and collect the results. This class of problems falls under the [fork-join model](https://en.wikipedia.org/wiki/Fork%E2%80%93join_model).

The `ponylang/fork_join` library handles the "boilerplate" needed for doing the basic bookkeeping needed to split up a job into multiple parts and collect the results. By default, work done using the `fork_join` will be split up across X `Worker` actors where X is equal to the number of scheduler threads available to the program.

The library allows for programs to be written in either a batch or streaming style where results are collected iteratively as each `Worker` processes chunks of data.

To learn more about `ponylang/fork_join` check out the [API documentation](https://ponylang.github.io/fork_join/fork_join--index/) and [the examples](https://github.com/ponylang/fork_join/tree/main/examples).

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
