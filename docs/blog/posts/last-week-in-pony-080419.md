---
draft: false
authors:
  - theobutler
description: "Last week's Pony news, reported this week."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - August 4, 2019"
date: 2019-08-04T10:42:46+02:00
---
_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!-- more -->

## Items of note

- Recording of the July 30, 2019 Pony developer sync is available [here](https://sync-recordings.ponylang.io/r/2019_07_30.m4a).

- [Version 0.3.0](https://github.com/ponylang/changelog-tool/releases/tag/0.3.0) of the Pony [changelog-tool](https://github.com/ponylang/changelog-tool) has been released.

- [Version 0.2.2](https://github.com/ponylang/http/releases/tag/0.2.2) of the [http library](https://github.com/ponylang/http) has been released. This release contains a bug fix and compatibility with ponyc 0.30.0.

- @rkallos is now a Pony committer! Welcome to the team Richard.

- The Makefile that is included with our [library-project-starter](https://github.com/ponylang/library-project-starter) has been greatly enhanced. After the recent changes, the Makefile will now:

    - only rebuild test binary if source files have changed
    - supports compiling example applications
    - supports release and debug configurations for building
    - using pony stable or ponyc to compile

    See the [USAGE](https://github.com/ponylang/library-project-starter/blob/master/USAGE.md) document for more information.

- Sean T. Allen:

    We need you to help test out the nightly builds of ponyc and stable.

    The ponyc nightly is a .tar.gz archive that should work on any x86-64 glibc based Linux.
    stable is a static binary that should work on any x86-64 Linux.

    We need your help in verifying that they work without issue. Please download them and put em through their paces. Please report any issues on their respective repos.

    The nightlies are available in this temporary testing repo and once will be moved to a more official one later. In the meantime, please help out and give em a try:

    [https://cloudsmith.io/~ponylang/repos/nightlies/packages/](https://cloudsmith.io/~ponylang/repos/nightlies/packages/)

    New packages are uploaded every day around midnight UTC.

    Some members of the community have already joined in and reported some issues for the ponyc nightly builds. Please lend a hand as well.

    Thanks!

- Sean T. Allen:

    main.actor needs you! Yes, you! (If you are a JS/CSS wielding lover of Pony)

    main.actor, our package discovery website (kind of like Ruby gems) is going to go live with an early version in August. The site is powered by a Gatsby website that @ChristopherBiscardi put together. It's an excellent starting point. Going forward, we are going to want to add a lot of additional functionality and features.

    Most of the active Pony committers are not JavaScript people. We could really use a couple of CSS/JavaScript people who are interested in becoming Pony committers and working on main.actor. If you are interested, let's talk. We really need you. You will be making a massive contribution to the Pony community and go down in history as a righteous person. I know there's got to be at least a couple of CSS/JS folks here who want to join in.

    Interested? Drop my the [main.actor stream](https://ponylang.zulipchat.com/#narrow/stream/190361-main.2Eactor) on the [Pony Zulip](https://ponylang.zulipchat.com/) and let's chat.

## News and Blog Posts

- John Mumm's CurryOn London talk "Safely Sharing Data: Reference Capabilities in Pony" has gone up on YouTube here [https://www.youtube.com/watch?v=u1JfYa413fY](https://www.youtube.com/watch?v=u1JfYa413fY).

## RFCs

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!

### Final Comment Period

- [Rename MaybePointer](https://github.com/ponylang/rfcs/pull/152)

### New RFCs

- [LLVM command line options integrations](https://github.com/ponylang/rfcs/pull/153)
