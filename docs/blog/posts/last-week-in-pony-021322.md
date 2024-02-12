---
draft: false
authors:
  - seantallen
description: ""
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - February 13, 2022"
date: 2022-02-13T14:16:45-05:00
---

This week's "Last Week in Pony" is brought to you with even more love than usual. It was a another boisterous week in Pony; as such we strongly suggest reading this issue while listening to [Wizard of Finance](https://www.youtube.com/watch?v=HeCm5GF5PME). Ponyup for Windows saw its first release and Pony 0.48.0 was released including fixing a rare but nasty [runtime crash](https://github.com/ponylang/ponyc/pull/3993).

It was also a busy week with RFCS. 3 RFCs were moved to "final comment period" and [another](https://github.com/ponylang/rfcs/pull/193) has had continued discussion.

<!-- more -->

## Items of note

- [ponyup](https://github.com/ponylang/ponyup) is now available for Windows. This is a huge moment in making it easier to install Pony on Windows. You can now download ponyup and use it to install both [ponyc](https://github.com/ponylang/ponyc) and [corral](https://github.com/ponylang/corral).
- Sean T. Allen held his third weekly "office hours" meeting. It was another good week of discussing many things Pony. Got Pony related questions or conversation? Join Sean every Friday at 15:00 Eastern US on [Zoom](https://us02web.zoom.us/j/77752669310?pwd=bSSyWWTduqMRfdvEpEBo9DICCDjxWA.1).
- Audio from the [February 8th](https://sync-recordings.ponylang.io/r/2022_02_08.m4a) Pony development sync is available.

## Issue of the Week

Each week, we will highlight on "good first issue" from the Pony ecosystem that we're trying to motivate someone to spend a bit of time on closing. If we close the issue of the week every week, by the next week, it will really add up and help Pony move forward quicker. So hey, how about you make this week your week?

This week's issue is ["Explain numeric widths, unsigned/signed integers, and overflow/underflow"](https://github.com/ponylang/pony-tutorial/issues/486) from the [tutorial](https://github.com/ponylang/pony-tutorial) repository.

Required background includes a decent understanding of signed and unsigned numerics and widths in languages like C. You should also be able to emphasize with users who come from languages without concepts like numeric widths and wraparound when exceeding the width for a given type. Is that you? We hope so. Let's get this one closed before the 20th or at least, a PR opened.

## Releases

- [Pony 0.48.0](https://github.com/ponylang/ponyc/releases/tag/0.48.0)
- [ponylang/library-documentation-action 0.4.0](https://github.com/ponylang/library-documentation-action/releases/tag/0.4.0)
- [ponylang/fork_join 0.1.0](https://github.com/ponylang/fork_join/releases/tag/0.1.0)
- [ponylang/regex 1.1.4](https://github.com/ponylang/regex/releases/tag/1.1.4)
- [ponylang/crypto 1.1.4](https://github.com/ponylang/crypto/releases/tag/1.1.4)
- [ponylang/http 0.5.1](https://github.com/ponylang/http/releases/tag/0.5.1)
- [ponylang/corral 0.5.5](https://github.com/ponylang/corral/releases/tag/0.5.5)
- [ponylang/net_ssl 1.2.0](https://github.com/ponylang/net_ssl/releases/tag/1.2.0)
- [ponylang/ponyup 0.6.6](https://github.com/ponylang/ponyup/releases/tag/0.6.6)

## RFCs

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!

### Final comment period

- [Change the standard library pattern for object capabilities](https://github.com/ponylang/rfcs/pull/196)
- [Add ponycheck to the standard library](https://github.com/ponylang/rfcs/pull/197)
- [Remove logger package from standard library](https://github.com/ponylang/rfcs/pull/198)

### Implemented

- [Expose runtime scheduler info](https://github.com/ponylang/rfcs/pull/194)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
