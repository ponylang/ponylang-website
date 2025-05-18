---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - May 18, 2025"
date: 2025-05-18T07:00:06-04:00
---

LLVM 18 support is here. Ditto for Linux Arm support and Alpine prebuilt binaries for ponyc. [It's an exciting time](https://www.youtube.com/watch?v=Y1D3a5eDJIs).

<!-- more -->

## Items of Note

### LLVM 18

We merged the LLVM 18 support pull request this past week.

### Windows for Arm support

Gordon's Arm-based Windows laptop has arrived. We are working on getting the prebuilt binaries for Windows Arm64 ready.

Gordon reports that everything is working on his machine but we are still getting failures in CI.

### Linux for Arm64 support

We are now creating prebuilt binaries for Alpine 3.21 and Ubuntu 24.04 on Arm64. Nightly versions are available. The next release will include these prebuilt binaries.

ponyup and corral support for these platforms will be added around the time of the next release.

### Pony Development Sync

The [recording](https://vimeo.com/1084088097) of the May 13th, 2025 sync is available.

### Office Hours

Office Hours this past week was myself, Red, and Adrian.

We discussed what compiler intrinsics are and how to track down their implementation.

Red and I discussed the change in LLVM 19 that scared him off from trying to add LLVM 19 support to Pony. I tracked down a [migration guide](https://llvm.org/docs/RemoveDIsDebugInfo.html) for Red and hopefully after reviewing it, he will find the change less daunting.

We reviewed the 2 LLVM 18 related patches that Joe and I wrote. I walked Red through the changes, explaining how and why they worked. The goal was to get Red to write a [solid commit message](https://github.com/ponylang/ponyc/commit/f1f2d63ec59a49eb342ab987c5bce4440be1e7ec) for the changes.

To help Red debug and fix similar issues in the future, I walked him through our debugging process. I explained how past experience led us to do more work than needed. The problem was straightforward, but it was in an area that has often been complicated, so Joe and I didn't consider the simple cause at first.

As we finished writing Red's commit message, I shared with him the "[really simple way to squash an entire branch](https://wiki.seantallen.com/notes/squash-git-branch/)". I explained what git's "force with lease" option is and why he should always use it instead of "just force". If you aren't familiar with "force with lease", I recommend reading [this StackOverflow question](https://stackoverflow.com/questions/52823692/git-push-force-with-lease-vs-force). It's a great way to avoid losing work.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
