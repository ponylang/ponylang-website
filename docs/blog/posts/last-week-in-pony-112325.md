---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - November 23, 2025"
date: 2025-11-23T20:00:00-04:00
---

Work this week focused on embedding LLVM's lld linker into the Pony compiler to remove the C toolchain dependency. We're starting with Linux and will move to other OSes later. MacOS CI is blocked by a GitHub Actions "hashFiles" issue, so there are no macOS nightly builds. Office Hours met twice—on November 10 and 17—to cover planning and progress for the embedded lld work.

<!-- more -->

## Embedded Linker Development Continues

Red joined me in working on embedding LLD in the Pony compiler. When this is done, it will eliminate the need for a C compiler to link Pony programs. This will make Pony easier to use in more environments.

We plan to release support for Linux first, then move on to other OSes.

## No MacOS Builds

We're experiencing a "hashFiles" issue on GitHub Actions that's impacting others as well. It's keeping us from doing anything on MacOS for CI. There will be no MacOS nightly ponyc builds until the issue is resolved.

## Items of Note

### Office Hours

Office Hours met twice since we last reported. On November 10, Red and I discussed how Red would help with the embedded lld work. On November 17, we reviewed progress and adjusted our plans.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
