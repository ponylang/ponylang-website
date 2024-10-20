---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - October 20, 2024"
date: 2024-10-20T07:00:06-04:00
---

Ponyc 0.58.8 has been released. We advise upgrading as soon as possible.

<!-- more -->

## Items of Note

### Ponyc 0.58.8 Released

Ponyc 0.58.8 has been released. We advise upgrading as soon as possible. This release contains two fixes for very unlikely, but possible, runtime segmentation faults.

### New SSL Builders Added

We've added new SSL builders that can be used for building SSL dependent Pony applications. `release` and `latest` versions are available for each. The `release` version contains the most recent ponyc release. The `latest` version is contains the most recent ponyc nightly version.

- [LibreSSL 3.9.2](https://github.com/ponylang/shared-docker/tree/main/x86-64-unknown-linux-builder-with-libressl-3.9.2)
- [OpenSSL 3.3.2](https://github.com/ponylang/shared-docker/tree/main/x86-64-unknown-linux-builder-with-openssl_3.3.2)

### SSL Builders Deprecated

We've deprecated 3 SSL builders. Effectively immediately, they will no longer be updated.

- LibreSSL 3.7.3
- OpenSSL 3.1.3
- OpenSSL 3.2.0

### Pony Development Sync

The recording of the October 15th development sync is [available on Vimeo](https://vimeo.com/1021424153).

### Office Hours

There was no Office Hours this week. I hung out for a while and when no one else joined, I left early.

## Releases

- [ponylang/ponyc 0.58.6](https://github.com/ponylang/ponyc/releases/tag/0.58.6)
- [ponylang/changelog-bot-action 0.3.6](https://github.com/ponylang/changelog-bot-action/releases/tag/0.3.6)
- [ponylang/release-bot-action 0.3.8](https://github.com/ponylang/release-notes-bot-action/releases/tag/0.3.8)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
