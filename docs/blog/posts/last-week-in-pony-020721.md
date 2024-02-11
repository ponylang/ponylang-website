---
draft: false
author: "theobutler"
description: "@ergl, also know as Borja o'Cook on the Ponylang Zulip, has become a Pony committer. Also, we have started the process of renaming the default branches on our repos from master to main."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - February 7, 2021"
date: 2021-02-07T19:36:37-05:00
---

@ergl, also know as Borja o'Cook on the Ponylang Zulip, has become a Pony committer. Also, we have started the process of renaming the default branches on our repos from master to main.
<!-- more -->

## Items of note

- @ergl, also know as Borja o'Cook on the Ponylang Zulip, has become a Pony committer. Being a Pony committer means that you have a high-level of access to all the Ponylang GitHub repositories with the ability to merge PRs and what-not. Welcome to the team Borja!

- Audio from the February 2nd, 2021 Pony development sync is available: [https://sync-recordings.ponylang.io/r/2021_02_02.m4a](https://sync-recordings.ponylang.io/r/2021_02_02.m4a)

## Releases

- Version 0.4.2 of ponylang/corral has been released.
See the [release notes](https://github.com/ponylang/corral/releases/tag/0.4.2) for more details.

- Version 0.1.3 of ponylang/library-documentation-action has been released.
See the [release notes](https://github.com/ponylang/library-documentation-action/releases/tag/0.1.3) for more details.

- Version 0.1.4 of ponylang/library-documentation-action has been released.
See the [release notes](https://github.com/ponylang/library-documentation-action/releases/tag/0.1.4) for more details.

- Version 1.1.2 of ponylang/net_ssl has been released.
See the [release notes](https://github.com/ponylang/net_ssl/releases/tag/1.1.2) for more details.

- Version 1.1.1 of ponylang/regex has been released.
See the [release notes](https://github.com/ponylang/regex/releases/tag/1.1.1) for more details.

- Version 0.4.0 of ponylang/release-bot-action has been released.
See the [release notes](https://github.com/ponylang/release-bot-action/releases/tag/0.4.0) for more details.

---

## The great default branch renaming

A while ago, GitHub switched the default branch for newly created repos to be `main`. To keep all our repos in-sync and to work more easily with tools in the future, we've been preparing to switch our existing repositories to having the default branch be `main`.

The renaming will start this week. It will be a slow roll-out. If you visit a repo after its branch has been changed, you will be prompted with a notice on what you need to do to adapt.

```bash
git branch -m master main
git fetch origin
git branch -u origin/main main
```

Should pretty much be what you have to do. We'll be announcing the changed repos as they happen in the [administrative stream](https://ponylang.zulipchat.com/#narrow/stream/200978-administrative) on Zulip and also in upcoming issues of Last Week in Pony.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
