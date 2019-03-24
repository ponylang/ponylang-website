+++
draft = false
author = "jdhorwitz"
description = "Last week's Pony news, reported this week."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - July 15, 2018"
date = "2018-07-15T13:55:55-04:00"
+++

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

<!--more-->

## Items of note

- A new beginner-friendly issue has landed for the Pony compiler! Want to give it a shot: [Pony Issue 2821](https://github.com/ponylang/ponyc/issues/2821)

- Due to confusion caused by its name, we are going to rename our little package manager pony-stable to a new name. Got a name to nominate? Want to vote on options? Chime in on the issue: [Pony-Stable #75](https://github.com/ponylang/pony-stable/issues/75)

- Audio from the July 11th Pony Development Sync call is now available: [Pony Sync 07-11-2018](https://sync-recordings.ponylang.io/r/2018_07_11.m4a)

- A new beginner friendly issue with our little dependency manager that could "pony-stable". Interested in contributing? We have a flakey integration test, could you be the person to fix it? We think you could be: [Pony-Stable 76](https://github.com/ponylang/pony-stable/issues/76)

## News and Blog Posts

- With the merge of [Pull Request 2910](https://github.com/ponylang/ponyc/pull/2810), we now have automated CI for non x86-64 Linux platforms.

> The current working/passing new CI builds are:

> - arm - LLVM 3.9.1, 4.01, 5.0.1, 6.0.0
> - armhf - LLVM 3.9.1, 4.01, 5.0.1, 6.0.0
> - aarch64 - LLVM 3.9.1, 4.01, 5.0.1

> And currently failing new CI builds (and are either marked as allow_failures or commented out in travis.yml) are:

> - i686 - LLVM 3.9.1, 4.01, 5.0.1, 6.0.0 (for all LLVM versions: segfault in optimized version of stdlib tests regardless of debug or release build of pony; [Pony Issue 1576](https://github.com/ponylang/ponyc/issues/1576) has some more info)
> - aarch64 - LLVM 6.0.0 (Some sort of uncaught signal when running the debug stdlib tests; not sure what/why as I haven't dug into it)

> The failing builds might be a good way for folks to get involved (although the issues may or may not be "beginner friendly").

- I've been working on material for a Pony workshop that I've been giving (and will present at ICFP in September). It is now in a state where I think it is useful, and I'd love to get feedback on it. [Pony Workshop By Andrew Turley](https://github.com/aturley/pony-workshop)

- Apparently, Brian Callahan has Pony working on OpenBSD. Here's to hoping he opens a PR at some point. [Brian Callahans Tweet](https://twitter.com/__briancallahan/status/1018263079816134657)
