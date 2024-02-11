---
draft: false
author: "theobutler"
description: "Last week's Pony news, reported this week."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - July 21, 2019"
date: 2019-07-21T16:48:46+02:00
---
_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!--more-->

## Items of note

- Recording of the July 16, 2019 Pony developer sync is available [here](https://sync-recordings.ponylang.io/r/2019_07_16.m4a).

- Four "new" Pony libraries came into exist this week. Really, they've existed for a while, but they are now "off on their own". The four new libraries are:

    - [crypto](https://github.com/ponylang/crypto)
    - [glob](https://github.com/ponylang/glob)
    - [net-ssl](https://github.com/ponylang/net-ssl)
    - [regex](https://github.com/ponylang/regex)

    Each of the four relies on an external C library for the core of its functionality. As part of a move towards an easier to maintain release process (more on that coming soon!), they've been moved out of the standard library into their own repositories. Version 0.30.0 of Pony which will be released by early August will be the first release that the libraries aren't in. You should expect to see "version 1.0" versions of the four libraries tagged prior to that date.

    If you are interested in more details now, you can check out the Pony development sync from July 9, 2019 for more details.

- Sean T. Allen has transferred control of his 4 Emacs related Pony repositories to the Ponylang organization. If you are interested in contributing to them, please let us know in the Pony community Zulip. The repositories in question are:

    - [flycheck-pony](https://github.com/ponylang/flycheck-pony)
    - [pony-snippets](https://github.com/ponylang/pony-snippets)
    - [ponylang-mode](https://github.com/ponylang/ponylang-mode)
    - [spacemacs-ponylang-layer](https://github.com/ponylang/spacemacs-ponylang-layer)

## RFCs

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
