---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - July 13, 2025"
date: 2025-07-13T07:00:06-04:00
---

Catch up on the latest Pony developments! This week we have the July 8th sync recording available, and a recap of our Office Hours where we discussed monitoring and debugging Pony applications, including DTrace support, runtime tracing, and performance bottleneck identification.

<!-- more -->

## Items of Note

### Pony Development Sync

The [recording](https://vimeo.com/1100923821) of the July 8th, 2025 sync is available.

### Office Hours

Office Hours this past week was attended by myself, Adrian, and Red.

We talked a lot about how Adrian could get visibility into certain aspects of his Pony Radio Project. We covered some of the existing functionality that Pony has built in that might help him. In particular, the [DTrace](https://en.wikipedia.org/wiki/DTrace)/[SystemTap](https://sourceware.org/systemtap/) support and the [runtime tracing](https://www.ponylang.io/use/debugging/tracing/) that was added in the last year.

We discussed [Pony method name mangling](https://www.ponylang.io/use/debugging/pony-lldb-cheat-sheet/#method-name-mangling). How to build a version of the Pony runtime [with DTrace enabled](https://github.com/ponylang/ponyc/blob/main/BUILD.md#dtrace). And I pointed Adrian at the spot in the Pony Makefile where you can turn on [runtime tracing](https://github.com/ponylang/ponyc/blob/main/Makefile#L147).

Adrian was particularly interested in how he could identify which actors were bottlenecks in his code. We discussed the backpressure system in the Pony runtime and how we would be interested in "actor overloaded" events from either DTrace or from the tracing.

We also looked at Erlang's [Observer](https://www.erlang.org/doc/apps/observer/observer.html) tool and how much of its functionality is available in Pony, but there's no nice GUI to pull the information together. Red hinted that perhaps that's something he might work on in the future.

Finally we ended up discussing metrics and the [high-performance metrics library](https://github.com/SeanTAllen/wallaroo/tree/2b985a3e756786139316c72ebcca342346546ba7/lib/wallaroo/core/metrics) we built into Wallaroo.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
