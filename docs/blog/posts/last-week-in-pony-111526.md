---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - November 15, 2026"
date: 2026-11-15T07:00:00-04:00
---

This past week, a conversation I had with Gergely Orosz of [Pragmatic Engineer](https://www.pragmaticengineer.com/) was [released](https://www.seantallen.com/interviews/software-correctness-and-programming-languages/). When Gergely and I first started talking over email, one of the things I said was "I'm happy to talk about whatever, 'I have the gift of gab'". Couple things with that... first, I love that phrase. It sounds awesome *and* it has great mouthfeel. Second, it is one of the best lines that John Goodman's Cyclops delivers in ["O Brother, Where Art Thou?"](https://en.wikipedia.org/wiki/O_Brother,_Where_Art_Thou%3F).

<!-- more -->

There's a few things that are notable about "O Brother"... It falls into the 10% of things that Sylvan and I disagree on. I think it is a wonderful movie. Sylvan thinks it is the Coen brothers acting like elitists. And it has an incredible soundtrack.

One of the songs from that incredible soundtrack is "In The Jailhouse Now" which is just a great classic old-timey song. So, this week, in honor of "O Brother" and having the gift of gab and for all the bugs that were smashed in the Pony 0.78.2 release, I give you the great Ernest Tubb's version of [In The Jailhouse Now](https://www.youtube.com/watch?v=321cmIOfRO4).

## ponyc 0.78.2

Pony 0.78.2 was released this week. It's basically a bug fix release. Basically. I mean, there's a bit more in there, but mostly it's about fixing bugs. Some are "edge-casey". Some are "o that isn't good". I advise you upgrade as soon as you are able.

See the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.78.2) for all the gory details.

## Items of Note

### Conversation with Gergely Orosz

As I noted up above in the intro, a [conversation](https://www.seantallen.com/interviews/software-correctness-and-programming-languages/) I had with Gergely was released this week. We talked about a ton of things, many Pony-adjacent, but we only talked about Pony a bit. Still, it might be of interest to Pony-curious folks.

### i386 CI

I added i386 CI to Pony testing. It along with the monthly "by hand" arm32 testing that I have been doing turned up a bunch of esoteric 32-bit errors in the Pony standard library. They all came from having earlier fixed some edge cases with floats and other number types on 64-bit platforms. All the issues found have been fixed and are on main.

Probably doesn't matter to anyone right now as I don't think anyone is taking advantage of the Pony 32-bit support, but hey if you are out there quietly using Pony on a 32-bit platform— you're welcome.

### Coming Soon

[Mutation testing](https://github.com/ponylang/ponyc/pull/6311) is coming to ponyc. The most impactful thing I've done with AI coding agents to get better tests was teaching them to always break a test to make sure it fails, to catch bad tests. Mutation testing automates a similar kind of testing motion. Smoke testing the functionality has already exposed some bad tests that have been fixed.

A bunch more bug fixes are on main as well, and expect even more as I improve test coverage across the ponylang organization ecosystem. NixOS support is also on main but not yet released.

### Pony Development Sync

The November 18 and November 25 Pony Development Syncs are cancelled, the first because I am traveling and the second because it is a holiday week here in the US.

### Office Hours

I won't be at Office Hours this week.

## Releases

- [ponylang/ponyc 0.78.2](https://github.com/ponylang/ponyc/releases/tag/0.78.2)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang-website/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
