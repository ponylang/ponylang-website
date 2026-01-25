---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - January 25, 2026"
date: 2026-01-25T11:30:00-04:00
---

There's a Pony release coming next weekend—get ready—there's lots of good stuff in it.

<!-- more -->

## Pony Language Server

We've moved the Pony Language Server out of its own repo and into the ponyc repo. All nightly builds now include ponyc and pony-lsp. The release coming next weekend will have both as well.

## Ponyup

We've released a new version of `ponyup`. You'll need it to correctly install the new ponyc packages that contain both `ponyc` and `pony-lsp`. If you use an older version to install the new ponyc packages, only `ponyc` will be available in your path. `pony-lsp` will have been installed, but it won't get added to your `$PATH`.

So hey, go update now.

## Items of Note

### Office Hours

I won't be at Office Hours tomorrow. I'm starting a new job and will be in the office for the week so, being "in office at work" means I can't attend "Office Hours" remotely. I'll see you the week after. If you want to show up, do. It is quite possible others will as well and then you can chat all about Pony and other fun things.

### Pony Development Sync

The recording of the January 20th Development Sync is available on [Vimeo](https://vimeo.com/1156643069).

## Releases

- [ponylang/ponyup 0.11.0](https://github.com/ponylang/ponyup/releases/tag/0.11.0)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There’s a GitHub issue for that. Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
