---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - March 31, 2024"
date: 2024-03-31
---

Pony 0.58.3 has been released. The only change is fix for a bug in documentation generation. Update at your leisure.

<!-- more -->

## Items of Note

### Pony 0.58.3 on Apple Silicon

The Pony 0.58.3 doesn't have a release for Apple Silicon. The was a problem during the release and given the relative unimportance of the release, it was decided to not hold up the release for the Apple Silicon build. We'll get that fixed for the next release.

### Pony Development Sync

[Audio](https://vimeo.com/927791445) from the March 26th, 2024 sync is available.

We had a few issues and PRs to cover. A lot of conversation was related to organization of information in the tutorial.

Sebastian Hädrich followed up on the sync discussions by opening a mess of PRs. Go Sebastian. That was awesome.

### Office Hours

Office Hours attendees were myself, Red, Adrian, and Niclas. Niclas had no working microphone.

Red pointed out during the call that there was a documentation in the [JSON repo](https://github.com/ponylang/json) that was incorrectly generated. During the call I tracked down the issue and [opened a PR](https://github.com/ponylang/ponyc/pull/4502) to fix it.

## Releases

- [ponylang/ponyc 0.58.3](https://github.com/ponylang/ponyc/releases/tag/0.58.3)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
