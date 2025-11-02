---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - November 2, 2025"
date: 2025-11-02T08:00:00-04:00
---

MacOS on Intel support has been given a reprieve. This and other Hank Williams inspired news in this week's edition of Last Week in Pony.

<!-- more -->

## Pony 0.60.4 Released

We released Pony 0.60.4. This release adds Alpine 3.22 support and ends support for Fedora 41. You can read the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.60.4) to learn more.

## MacOS for Intel Support is NOT Ending

Last week, we [announced](https://www.ponylang.io/blog/2025/10/last-week-in-pony---october-26-2025/#macos-for-intel-support-is-ending) we were ending support for MacOS on Intel (x86_64) architecture. Then I stumbled upon an issue on GitHub where the GitHub Actions team announced a new MacOS 15-based runner that they will support until August 2027, so... we're keeping MacOS Intel support until then.

## A Builder Image Meets Its End

We stopped maintaining the `shared-docker-ci-x86-64-unknown-linux-builder` image. It's been replaced by the `shared-docker-ci-standard-builder` image that has `nightly` and `release` tags and is built for both amd64 and arm64.

## Items of Note

### Pony Development Sync

The recording of the October 28 Pony Development Sync is now available on [Vimeo](https://vimeo.com/1132897765).

### Office Hours

This past week at Office Hours, we had Red, myself, and Alex Webber, who returned after being away for a while.

We discussed the "read_again" pattern for giving up the scheduler in a Pony actor but then picking up the work again later. I covered exactly how it works under the hood and how it interacts with the actor's message queue and how actors are scheduled.

We had a quick discussion of object capabilities and how you pass around tokens and how the tokens are implemented and their hierarchy-like nature. We also discussed how you can pass around `FilePath` rather than a token and use the `FilePath` to allow access to only a segment of the file system.

We then discussed AI slop books. Alex pointed us to a number of AI slop books about Pony on Amazon. That's when Red and I learned that at some point, someone created a [Wikipedia page](https://en.wikipedia.org/wiki/Pony_(programming_language)) for Pony and so far, editors haven't deleted it. If you know me well enough, this is where you should insert me grumbling about Wikipedia notability guidelines. And insert me laughing at the fact that AI slop books on Amazon might be helping keep the Wikipedia page alive since at least one of the books is referenced from the Wikipedia page.

## Releases

- [ponylang/ponyc 0.60.4](https://github.com/ponylang/ponyc/releases/tag/0.60.4)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
