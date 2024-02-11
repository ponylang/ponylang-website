---
draft: false
author: "theobutler"
description: "Sean T. Allen's recent PWL on Deny Capabilities for Safe, Fast Actors Talk is available. Microsoft's Project Verona is now open source."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - January 19, 2020"
date: 2020-01-19T10:50:42-05:00
---

Sean T. Allen's recent PWL on Deny Capabilities for Safe, Fast Actors Talk is available. Microsoft's Project Verona is now open source.
<!-- more -->

## News and Blog Posts

- Sean T. Allen's recent Papers We Love talk on [Deny Capabilities for Safe, Fast Actors](https://www.ponylang.io/media/papers/fast-cheap.pdf) is now [available](https://www.seantallen.com/talks/deny-capabilities/).

- Microsoft's Project Verona is now open source and [on GitHub](https://github.com/microsoft/verona)! See the brief overview below, and take a look at [their documentation](https://github.com/microsoft/verona/blob/master/README.md).

## Project Verona

Verona is a research language for exploring a new programming model for concurrent ownership. The language and runtime are designed around data-race freedom, concurrent owners, and linear regions. In this model, concurrent mutation is given up in order to provide scalable memory management. This is achieved through immutable regions that may be shared or isolated regions that may have their ownership transferred. This transfer of isolated regions between concurrent owners is similar to sending objects with the `iso` capability in Pony. There is no restriction on topology within a region and an entire isolated region is collected when the owning reference is no longer reachable. Systematic testing is also embedded into the runtime, allowing developers to thoroughly test and debug concurrent algorithms.

Pony core team members are very excited to integrate some of the ideas from Verona into the Pony language and runtime. Verona, as a language, is in a very early stage of development and we encourage everyone to learn from it and keep an eye on how it develops.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
