---
draft: false
authors:
  - seantallen
  - ryan
description: "May Santa bring you much awesome tonight."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - December 24, 2023"
date: 2023-12-24T07:00:06-04:00
---

May Santa bring you much awesome tonight.

<!-- more -->

## Items of Note

### Holidays

We are taking a break for the holidays. There will be no Office Hours or Pony Development Sync meetings the next two weeks. The next meeting will be Office Hours on January 8th.

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_12_19.m4a) from the December 19th, 2023 sync is available.

It was a very short sync. We ran through the agenda which was one pull request and one issue.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

Perhaps the most useful community resource of all is the documentation your fellow developers wrote so that you may use the code they wrote. Documentation for the Pony Standard Library is published at <https://stdlib.ponylang.io/>. The ability to generate documentation is built into `ponyc` so you can build documentation for your own code by running either `ponyc path/tp/your/package --docs` (for all types) or `ponyc path/tp/your/package --docs-public` (for public types). This will generate the documentation in a new directory which you can then build into a website using `mkdocs build`. Note that you can also limit which pass the compiler generates the documentation from. For example, the Pony Standard Library documentation is built using `ponyc packages/stdlib --docs-public --pass expr`.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
