---
draft: false
authors:
  - seantallen
description: "Last week's Pony news, reported this week."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - April 29, 2018"
date: 2018-04-29T09:30:19-04:00
---
_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!-- more -->

## We need you

We could use help moving Pony forward. Interested in helping? Here's a few ideas:

- Grab a [beginner friendly issue](https://github.com/ponylang/ponyc/issues?q=is%3Aopen+is%3Aissue+label%3A%22complexity%3A+beginner+friendly%22) and dive in to working on the Pony compiler and runtime.
- Help move ["stable"](https://github.com/ponylang/pony-stable), our little dependency manager that could, forward. We have a [number of issues](https://github.com/ponylang/pony-stable/issues) open and would love to add more folks as committers on that project.
- [Help out with the website](https://github.com/ponylang/ponylang.github.io/issues).
- Help grow the content on [Pony Patterns](https://github.com/ponylang/pony-patterns/) website.
- Help push the [library-starter-project](https://github.com/ponylang/library-project-starter/issues) forward.

And there's a ton more as well. Stop by the [developer mailing list](https://pony.groups.io/g/dev/), we'll help you figure out a way that you can contribute.

## Items of Note

- [Detecting end of incoming actor messages](https://www.reddit.com/r/ponylang/comments/8eelbs/detecting_end_of_incoming_actor_messages/) discussion on [/r/ponylang](https://www.reddit.com/r/ponylang/). Got anything to add? Join in. Also, this question has come up before. We'd love to see someone write up a [Pony Pattern](https://patterns.ponylang.io/) for addressing this scenario.

- Work is underway to vendor LLVM into Pony. As you might know, the only version of LLVM listed as support by the Pony team is LLVM 3.9.1. LLVM 5 and 6 are experimental only. Why? LLVM 5 and 6 have bugs that we need to get fixed. All-in-all, our current LLVM support story isn't working out well. During the [April 18th Pony developer sync call](https://vimeo.com/videos/915361053/), we decided that we needed to support a single version of LLVM that we could patch and periodically upstream. This would make Pony's LLVM usage a lot more like the model used by Rust. Interested in helping with the effort? Wink has been working on the effort for a while. Stop by his [pull request](https://github.com/ponylang/ponyc/pull/2663) and see how you might assist.

## Pony Development Sync

The Pony developers met on their weekly sync call on Wednesday, April 25, 2018. Check out the [recorded audio](https://vimeo.com/videos/915361302).

The next one is scheduled for Wednesday, May 2, 2018, at 03:30 PM (GMT-04:00) America/New York via zoom. We'd love to have you there.

## RFCs

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!

### Approved RFCs

- [Subtyping Exclusion](https://github.com/ponylang/rfcs/blob/main/text/0054-subtyping-exclusion.md)
