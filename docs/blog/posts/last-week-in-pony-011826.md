---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - January 18, 2026"
date: 2026-01-18T09:30:00-04:00
---

Not a lot of visible activity this week in Pony land, but there’s a lot going on and you can expect a few things to land in the not-so-distant future.

<!-- more -->

## Pony Language Server

We are close to moving the Pony Language Server out of its own repository and distributing it with ponyc. This will address a couple of technical issues that would result in a poor user experience.

Distributing with the compiler will make it easy to keep compiler and language server features in sync. It will also make sure that, when using tools like `ponyup`, the standard library used by the compiler and the language server is the same.

## Items of Note

### Office Hours

Office Hours was myself and Red. We discussed:

- Claude Code, test coverage, and [mutation testing](https://en.wikipedia.org/wiki/Mutation_testing)
- Vector space and hallucinations
- What is a promise?
- [Constrained types in the standard library](https://stdlib.ponylang.io/constrained_types--index/)
- [Antithesis](https://antithesis.com/) and [FoundationDB](https://www.foundationdb.org/)
- Cross-compilation and the [embedded lld work](https://github.com/ponylang/ponyc/pull/4767)
- Claude Code and Git access

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There’s a GitHub issue for that. Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
