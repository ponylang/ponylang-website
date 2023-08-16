+++
draft = false
author = "seantallen"
description = "Time to upgrade your ponyc."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony August 20, 2023"
date = "2023-08-20T07:00:06-04:00"
+++

## Items of Note

### Update to Pony 0.55.1 As Soon As Possible

We've fixed a "random memory error" bug that was introduced in Pony 0.54.1. You should update to 0.55.1 as soon as possible. It's a bad bug, fortunately, it only affects programs built with the `--debug` ponyc option.

### We've "Dropped" FreeBSD

FreeBSD is no longer a fully supported platform. We are in the process of [moving all our CI to GitHub Actions](https://www.ponylang.io/blog/2023/08/last-week-in-pony-august-13-2023/#the-great-ci-move-is-underway) and in the process, are losing our FreeBSD CI.

We are not removing FreeBSD support from the ponyc codebase, however, we are also not making any attempt to test any changes to verify that FreeBSD works. Any FreeBSD support going forward will have to come from interested community members who can provide patches as needed to address any issues.

There are no more nightly versions of ponyc for FreeBSD being built. The same will soon apply to ponyup and corral.

0.55.1 was the last ponyc release that we built for FreeBSD. No future releases of ponyup or corral will have FreeBSD support.

You can still build from ponyc and corral from source on FreeBSD.

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_08_15.m4a) from the August 16th, 2023 sync is available.

We mostly discussed [issue #4369](https://github.com/ponylang/ponyc/issues/4369). Primarily, the underlying bug that has existed for a long time and also how we accidentally triggered it as part of our upgrading from [LLVM 14 to LLVM 15](https://github.com/ponylang/ponyc/pull/4327).

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

<< content >>

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

<< content >>

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
