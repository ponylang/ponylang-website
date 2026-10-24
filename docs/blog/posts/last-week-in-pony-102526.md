---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - October 25, 2026"
date: 2026-10-25T07:00:00-04:00
---

I often write these semi-long intros for Last Week in Pony. I'm not going to do that this week. I'm just going to say that [Daisy Chain 4 Satan](https://www.youtube.com/watch?v=uN0yI-ambNY) is a great song. And it will put you in a proper mood for Pony learning. So have at it kiddos and let's get this underway...

<!-- more -->

## ponyc 0.77.1

I released Pony 0.77.1 this past week. It's basically a bug fix version. As some of you might know, I started working at [Antithesis](https://antithesis.com) this past January. It's a great job for me because I love to talk about software correctness and I love to work on making it easier. I generally describe myself as someone who likes to create software that gets correct results quickly. I don't keep posting those Ricky Bobby videos and photos for no reason. Anyway, we have this prototype for a new tool internally at Antithesis and I turned it loose on the Pony standard library and I've been fixing the bugs it found. Most are in the "minor" to "that ain't great" category but there is one that was legitimately "that ain't at all good" aka "memory safety is at risk". You should upgrade as soon as you can and in the meantime, check out the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.77.1) to learn more about the mass of fixes.

p.s. Expect more to come soon. I've already merged a number of additional fixes to main, but I didn't want to hold back the memory safety fix so I made sure to get it out quite soon after it was merged.

## Items of Note

### pony-doc Info Backend

There's a new `--backend info` option for pony-doc. It generates a single `.info` file you can read in Emacs, standalone `info`, or `pinfo`. If you've never touched the backend flag, nothing changes for you; `mkdocs` is still the default.

### Next Week

There won't be a Last Week in Pony next week. You'll get a double issue the next week. I will be traveling for personal reasons next weekend. That also means that I won't be at Office Hours on November 2nd.

## Releases

- [ponylang/ponyc 0.77.1](https://github.com/ponylang/ponyc/releases/tag/0.77.1)
- [ponylang/postgres 0.15.1](https://github.com/ponylang/postgres/releases/tag/0.15.1)

## RFCs

### Final Comment Period

- [Add `noalloc` annotation](https://github.com/ponylang/rfcs/pull/235)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang-website/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
