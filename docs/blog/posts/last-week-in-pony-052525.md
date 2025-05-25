---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - May 25, 2025"
date: 2025-05-25T07:00:06-04:00
---

Full corral and ponyup support with binaries is close for Linux and Windows. "Above the surface" this week, Windows for Arm support landed in ponyc. Under the surface, much work continues on Arm64 binaries for Linux.

<!-- more -->

## Items of Note

### Windows for Arm support

We've merged the Windows Arm64 support pull request for the ponylang/ponyc repository. We are working on adding corral and ponyup prebuilt binaries for Windows Arm64. ponyc binaries are available for direct download from [Cloudsmith](https://cloudsmith.io/~ponylang/repos/). Right now, only [nightly builds](https://cloudsmith.io/~ponylang/repos/nightlies/packages/) are available since we haven't done a release yet.

### Pony Development Sync

The [recording](https://vimeo.com/1086232541) of the May 20th, 2025 sync is available.

### Office Hours

Office Hours this past week was myself and Adrian.

We spent most of our time discussing Adrian's "leasable buffer" idea and what it would take to get it into the standard library. I outlined various ways Adrian could present it via an RFC. The idea is interesting and needs to be in the standard library's builtin package. Hopefully Adrian decides to write up an RFC for it.

We ended our hour talking about stream processing tools, mainly ones under the Apache Software Foundation. Adrian wasn't familiar with most of them, so I gave him short "unfair but accurate" summaries. For those who don't know, I ran Apache Storm in production for years, wrote a book about it, and worked at a startup on a [high-performance stream processing engine in Pony](https://github.com/seantallen/wallaroo).

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
