---
draft: false
authors:
  - theobutler
description: "The Flynn project aims to bring a Pony-like actor-model implementation to Swift using a modified version of the Pony runtime. New releases of ponyc, ponyup, and some bots."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - August 30, 2020"
date: 2020-08-30T17:39:32-04:00
---

The Flynn project aims to bring a Pony-like actor-model implementation to Swift using a modified version of the Pony runtime. New releases of ponyc, ponyup, and some bots.
<!-- more -->

## Items of note

- Audio from the August, 25 2020 Pony Development sync is available: [https://vimeo.com/916250064](https://vimeo.com/916250064)

- The "docker-builder" shared docker container is being deprecated and not being replaced. If you are using for anything, be aware that there will be no further updates. The existing image will continue to work via being pulled from docker hub.

- [Flynn](https://github.com/KittyMac/flynn) aims to bring a Pony-like actor-model implementation to Swift. It is powered by a modified version of the [Pony Runtime](https://www.ponylang.io/faq/runtime/) and utilizes a custom linter to enforce actor-model safety at compile time.

- We will no longer be announcing Pony compiler releases on Twitter.
You can get information about releases either here in Last Week in Pony or by subscribing to the RSS feed for ponyc releases on GitHub: [https://github.com/ponylang/ponyc/releases.atom](https://github.com/ponylang/ponyc/releases.atom)

## Releases

- Version 0.37.0 of ponylang/ponyc has been released.
See the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.37.0) for more details.

- Version 0.6.1 of ponylang/ponyup has been released.
See the [release notes](https://github.com/ponylang/ponyup/releases/tag/0.6.1) for more details.

- Version 0.3.0 of ponylang/release-notes-bot-action has been released.
See the [release notes](https://github.com/ponylang/release-notes-bot-action/releases/tag/0.3.0) for more details.

- Version 0.3.1 of ponylang/release-notes-bot-action has been released.
See the [release notes](https://github.com/ponylang/release-notes-bot-action/releases/tag/0.3.1) for more details.

- Version 0.1.0 of ponylang/action-readme-version-updater has been released.
See the [release notes](https://github.com/ponylang/action-readme-version-updater/releases/tag/0.1.0) for more details.

- Version 0.1.1 of ponylang/action-readme-version-updater has been released.
See the [release notes](https://github.com/ponylang/action-readme-version-updater/releases/tag/0.1.1) for more details.

- Version 0.3.3 of ponylang/release-bot-action has been released.
See the [release notes](https://github.com/ponylang/release-bot-action/releases/tag/0.3.3) for more details.

## RFCs

### New RFCs

- [Recover blocks with receiver](https://github.com/ponylang/rfcs/pull/182)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
