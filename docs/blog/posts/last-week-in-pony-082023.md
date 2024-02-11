---
draft: false
author: "seantallen"
description: "Time to upgrade your ponyc."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony August 20, 2023"
date: 2023-08-20T07:00:06-04:00
---

## Items of Note

### Update to Pony 0.55.1 As Soon As Possible

We've fixed a "random memory error" bug that was introduced in Pony 0.54.1. You should update to 0.55.1 as soon as possible. It's a bad bug, fortunately, it only affects programs built with the `--debug` ponyc option.

### We've "Dropped" FreeBSD

FreeBSD is no longer a fully supported platform. We are in the process of [moving all our CI to GitHub Actions](https://www.ponylang.io/blog/2023/08/last-week-in-pony-august-13-2023/#the-great-ci-move-is-underway) and in the process, are losing our FreeBSD CI.

We are not removing FreeBSD support from the ponyc codebase, however, we are also not making any attempt to test any changes to verify that FreeBSD works. Any FreeBSD support going forward will have to come from interested community members who can provide patches as needed to address any issues.

There are no more nightly versions of ponyc for FreeBSD being built. The same will soon apply to ponyup and corral.

0.55.1 was the last ponyc release that we built for FreeBSD. No future releases of ponyup or corral will have FreeBSD support.

You can still build from ponyc and corral from source on FreeBSD.

### macOS on Intel is a Fully Supported Platform Again

With our move from CirrusCI to GitHub Actions, we again have an environment were we can test on MacOS for Intel. We've added macOS on Intel as a fully supported platform.

We plan to maintain support for as long as we continue a CI environment available and Apple continues to support new OS releases on x86 CPUs.

Nightly builds the Pony compiler are already available. Release builds will be available starting with the Pony 0.56.0 release at the end of August.

Nightly versions of corral and ponyup for macOS on Intel are available now. Once Pony 0.56.0 is released, release versions of corral and ponyup will follow shortly thereafter.

Enjoy!

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_08_15.m4a) from the August 16th, 2023 sync is available.

We mostly discussed [issue #4369](https://github.com/ponylang/ponyc/issues/4369). Primarily, the underlying bug that has existed for a long time and also how we accidentally triggered it as part of our upgrading from [LLVM 14 to LLVM 15](https://github.com/ponylang/ponyc/pull/4327).

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

In addition to "non-Pony" conversation, Red and Sean discussed the process for getting some additional functionality that Red added to his fork of [ponylang/net_ssl](https://github.com/ponylang/net_ssl) into the main branch. Beyond that, Sean also demonstrated to Red how to use the [Pony HTTP client](https://github.com/ponylang/http) to do `POST` and `PUT` operations.

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Releases

- [ponyc 0.55.1](https://github.com/ponylang/ponyc/releases/tag/0.55.1)

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week we highlight how to write platform dependent code! We have a [Tutorial page](https://tutorial.ponylang.io/appendices/platform-dependent-code) for this topic. There is also a [Platform](https://stdlib.ponylang.io/builtin-Platform/) primitive in `builtin`. And for those of you that want a peek behind the curtain, these flags are defined [here](https://github.com/ponylang/ponyc/blob/c393500e8f8222d648f803f78a705baf452bce05/src/libponyc/pkg/platformfuns.h) in the source tree. Beyond what is said in the Tutorial, you can use `ifdef` with the same flags to change smaller sections of code, see the definition of [`files/Path.sep()`](https://github.com/ponylang/ponyc/blob/c393500e8f8222d648f803f78a705baf452bce05/packages/files/path.pony#L27-L31) which provides '\\' when on `windows` and '/' for all other platforms.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
