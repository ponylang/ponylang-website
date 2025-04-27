---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - April 27, 2025"
date: 2025-04-27T07:00:06-04:00
---

There's a new version of Pony on the block. Come and get it!

<!-- more -->

## Items of Note

### Pony 0.59.0 Released

Pony 0.59.0 has been released. It's the first breaking change release we have done in a long time. It is a rather small breaking change. All command line options starting with `pony` are now reserved for the runtime. If you were using any CLI flags with `pony` at the start, you'll need to adjust your program as it will no longer start. Curious about the change and the reasoning behind it? There's a [pull request for that](https://github.com/ponylang/ponyc/pull/4622).

Additionally, Dipin Hora put in a bunch of work to get the ability to trace runtime events into the Pony runtime. You'll need to do a custom build to enable the functionality as it isn't on by default. You can learn more on the [Pony website](https://www.ponylang.io/use/debugging/tracing/).

There's more in the release but those are the 2 bits I've chosen to highlight. You can learn about more in [the release notes](https://github.com/ponylang/ponyc/releases/tag/0.59.0).

### Ubuntu 20.04 End-of-Life

Ubuntu 20.04 is about to reach its end of life. Sometime in the next week or two, we will stop supporting it for Pony. We will no longer do any testing against Ubuntu 20.04 and will not build any version of Pony or associated programs for Pony.

We will not intentionally break support for 20.04 but you'll have to build from source in order to continue using Pony on it.

### Pony Development Sync

The [recording](https://vimeo.com/1077783077) of the April 22nd, 2025 sync is available.

### Office Hours

There was an Office Hours this past week, but I wasn't in attendance and no one else wrote up what happened so... "I guess you had to be there!"

## Releases

- [ponylang/ponyc 0.59.0](https://github.com/ponylang/ponyc/releases/tag/0.59.0)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
