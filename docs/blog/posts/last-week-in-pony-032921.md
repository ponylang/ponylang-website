---
draft: false
author: "theobutler"
description: "The 'Force declaration of FFI functions' RFC has entered final comment period. OpenSSL and LibreSSL builders have been updated. There are also some releases from last week."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - March 29, 2021"
date: 2021-03-29T12:39:21-04:00
---

The 'Force declaration of FFI functions' RFC has entered final comment period. OpenSSL and LibreSSL builders have been updated. There are also some releases from last week.
<!-- more -->

## Items of note

- Audio from the [March 23, 2021](https://sync-recordings.ponylang.io/r/2021_03_23.m4a) Pony development sync call is available.

- @mfelsche writes: Again we met and worked on our roaring bitmap implementation (baby-steps) but I tried to sneak in some valuable pony development knowledge. Give it a shot here if you missed the call: [https://sync-recordings.ponylang.io/roaring-bitmap/2021_03_25.mp4](https://sync-recordings.ponylang.io/roaring-bitmap/2021_03_25.mp4)

- A [new "with OpenSSL" builder has been added](https://github.com/ponylang/shared-docker/tree/main/x86-64-unknown-linux-builder-with-openssl_1.1.1k) for use by projects that need a Pony builder image with OpenSSL. The new image includes OpenSSL1.1.1k. The existing builder with OpenSSL1.1.1g will be deprecated on a date after May 1st, 2021. After that date. it will stop receiving updates although, the previous versions of the builder will continue to exist.

- A [new "with LibreSSL" builder has been added](https://github.com/ponylang/shared-docker/tree/main/x86-64-unknown-linux-builder-with-libressl-3.2.5) for use by projects that need a Pony builder image with LibreSSL. The new image includes LibreSSL 3.2.5. The existing builder with LibreSSL 3.1.2 will be deprecated on a date after May 1st, 2021. After that date. it will stop receiving updates although, the previous versions of the builder will continue to exist.

- [pony-templates](https://github.com/Trundle/pony-templates), a text-based template engine, saw the light of day.

## Releases

- Version 0.1.2 of ponylang/appdirs has been released. See the [release notes](https://github.com/ponylang/appdirs/releases/tag/0.1.2) for more details.

- Version 1.1.2 of ponylang/crypto has been released. See the [release notes](https://github.com/ponylang/crypto/releases/tag/1.1.2) for more details.

- Version 1.1.2 of ponylang/regex has been released. See the [release notes](https://github.com/ponylang/regex/releases/tag/1.1.2) for more details.

- Version 0.1.6 of ponylang/library-documentation-action has been released. See the [release notes](https://github.com/ponylang/library-documentation-action/releases/tag/0.1.6) for more details.

- Version 0.3.0 of ponylang/readme-version-updater-action has been released. See the [release notes](https://github.com/ponylang/readme-version-updater-action/releases/tag/0.3.0) for more details.

## RFCs

### Final Comment Period

- [Force declaration of FFI functions](https://github.com/ponylang/rfcs/pull/184)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
