---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - October 26, 2025"
date: 2025-10-26T08:00:00-04:00
---

We completed our container infrastructure migration with the release of Pony 0.60.3. Support for MacOS on Intel and Fedora 41 is ending soon.

<!-- more -->

## Ponyc 0.60.3 Released

We released Pony 0.60.3. This was the final release in a quick series to complete our migration to multi-architecture container images. You can read the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.60.3) for more details.

## MacOS for Intel Support is Ending

We're ending support for MacOS on Intel (x86_64) architecture. The Pony compiler will no longer be built or tested on that platform.

GitHub Actions will no longer provide MacOS Intel runners for our CI builds, and we will no longer produce MacOS Intel binaries for download.

We won't remove existing support for MacOS Intel in the Pony compiler itself. If you're using Pony on MacOS Intel, you can continue to do so by building from source.

## Fedora 41 Builds Are Ending

We're stopping Fedora 41 builds for Pony. Fedora 41 reaches end of life in November. If you're interested in adding Fedora 42 support, stop by the [Zulip](https://ponylang.zulipchat.com/) and we can point you in the right direction. Adding support for a new platform involves some work in the `ponylang/ponyc` and `ponylang/ponyup` repositories. It's doable if you're up for it.

## Library Documentation Action V2 Tag Change

We previously used the tag `latest` for versions of `ponylang/library-documentation-action-v2` that featured the most recent nightly build of Pony. We've changed this to `nightly` as part of our container image updates work. The new name better reflects the tag's purpose.

## PCRE Builder Image

We've stopped maintaining the `shared-docker-ci-x86-64-unknown-linux-builder-with-pcre` image. It's been replaced by the `shared-docker-ci-standard-builder-with-pcre` image that has `nightly` and `release` tags and is built for both amd64 and arm64.

## Items of Note

### Office Hours

Red and I met on Monday for Office Hours. We discussed the recent releases, including the one I kicked off at the start of the meeting. I debugged a small issue with a recent change in our ponyc release workflow.

We also discussed the design of Red's user-facing ODBC API and the trade-offs that had to be made due to the ODBC "standard".

## Releases

- [ponylang/ponyc 0.60.3](https://github.com/ponylang/ponyc/releases/tag/0.60.3)
- [ponylang/ponyup 0.10.0](https://github.com/ponylang/ponyup/releases/tag/0.10.0)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
