+++
draft = false
author = "seantallen"
description = "Last week's Pony news, reported this week."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - July 9, 2017"
date = "2017-07-09T07:00:00+02:00"
+++
_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

<!--more-->

## 0.15.0 has been released

Tons of bug fixes, lots of new features, a couple breaking changes. It's advised you update as soon as possible. Check out the [release notes](https://www.ponylang.io/blog/2017/07/0.15.0-released/) for full details.

## Items of note

- InfoQ did a podcast interview with Sylvan Clebsch, the designer of Pony. Check out [Pony Language Designer Sylvan Clebsch on Pony’s Design, Garbage Collection, and Formal Verification](https://www.infoq.com/podcasts/sylvan-clebsch-pony-formal-verification).

- There's a big mean old breaking change on the horizon. It will break every Pony codebase out there. So heads up that it is coming. It will be a little painful but in the long run, its going to be a good thing. You can follow along [with the issue](https://github.com/ponylang/ponyc/issues/1771#issuecomment-313859191) and check out the [RFC: Explicit partial calls](https://github.com/ponylang/rfcs/blob/main/text/0039-explicit-partial-calls.md).

- Slides from Sean T. Allen's Polyconf talk [Why Pony?](https://speakerdeck.com/seantallen/why-pony) are now available.

## RFCs

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!

### New RFCs

- [#write gencap](https://github.com/ponylang/rfcs/blob/feature/gencap-write/text/0000-gencap-write.md): Add #write, a new gencap for use in type parameter constraints, implying the capability set: {`iso`, `trn`, `ref`}.
