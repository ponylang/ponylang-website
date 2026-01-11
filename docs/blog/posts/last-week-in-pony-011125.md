---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - January 11, 2026"
date: 2026-01-11T13:30:00-04:00
---

Sorry for the long delay between issues of Last Week in Pony. Life got in the way. I was down with the flu for several weeks. Then I fell out of rhythm and forgot a couple times that I write this thing up on Sundays.

<!-- more -->

## Embedded Linker Development

I need to sync up with Red to discuss cross compilation. It appears to be the last major hurdle before we can start using an embedded LLD for linking on Linux systems and then expand to other systems.

## Items of Note

### Herdsim

Red wrote in with news of a blog post he came across. Red quoted the author, Mirko:

> [herdsim](https://www.mirkomariotti.it/repos_herdsim/) is a distributed systems simulator written in [Pony](https://www.ponylang.io/). It is a rewrite of [dssim](https://www.mirkomariotti.it/repos_dssim/), a simulator I wrote several years ago in C. It allows the user to define the network topology, the nodes, and the behavior of the nodes as Pony code.
>

Check out [the full blog post](https://www.mirkomariotti.it/posts/2026-01-05-herdsim/).

### Ponylang Support in the Zed Editor

Orien Madgwick announced a [Pony extension](https://github.com/orien/pony-zed) for the [Zed editor](https://zed.dev/).

### Development Sync - December 9, 2025

The [recording of the Pony Development Sync from December 9, 2025](https://vimeo.com/1145281622) has been available for quite some time, but was only announced in the [#sync channel on the Ponylang Zulip](https://ponylang.zulipchat.com/#narrow/channel/190591-sync).

### Office Hours

Before I got sick, we had Office Hours on November 24 and December 2nd.

I have minimal notes from each, so nothing to report.

## Releases

- [redvers/pony-libxml2 1.0.3](https://github.com/redvers/pony-libxml2/releases/tag/1.0.3)
- [redvers/libxml2 1.1.1](https://github.com/redvers/libxml2/releases/tag/1.1.1)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
