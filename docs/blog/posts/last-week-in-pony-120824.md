---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - December 8, 2024"
date: 2024-12-08T07:00:06-04:00
---

For a small community, we've had a lot going on this past week. Read on to learn about a new Pony runtime feature, a discussion about 32-bit platform support, Advent of Code 2024, changes in supported platforms, a couple small releases from the Pony team, and more.

<!-- more -->

## Items of Note

### Have You Ever Wanted to Pin an Actor to a Pony Scheduler?

This week, we [merged an experimental feature](https://github.com/ponylang/ponyc/pull/4547) implemented by Dipin Hora. The feature allows you to pin an actor to a scheduler thread. This should be particularly useful for usage with older C graphics libraries that require you to run on a specific thread. More broadly, it should allow for Pony programmers to use any libraries that rely on thread-local storage.

Actor pinning is available now in nightly builds and when we do a release at the end of the month, it will be available in the release.

Given the experimental nature of actor pinning, we make no guarantees about its stability or performance. We are looking for feedback on how it works for you. If you try it out, please stop by [the Zulip](https://ponylang.zulipchat.com/) and let us know how actor pinning is working out for you.

### Should We Continue to Support 32-bit Platforms?

We've [started a discussion](https://github.com/ponylang/ponyc/issues/4564) about possibly dropping support for 32-bit platforms. We "aren't in favor of the idea", but we also "aren't against it".

We are a volunteer driven project and 32-bit support has over the last few years often taken up a decent amount of time. We still have open issues so at best we have "ok" support for 32-bit platforms.

If we were a larger community with more active Pony developers, we probably wouldn't be having this conversation. But we are a small community and we have to make choices about where to spend our time.

If you are using Pony for anything serious on a 32-bit platform, please let us know [on the issue](https://github.com/ponylang/ponyc/issues/4564). We want to hear from you.

### Supported Fedora Version Changed

We've switched from supporting Fedora 39 to supporting Fedora 41. All nightly builds for Fedora are now based on Fedora 41. Starting with the next release, we will be building for Fedora 41 rather than Fedora 39.

### Supported Alpine Version Changed

We've switched from supporting Alpine 3.18 to supporting Alpine 3.20. All nightly builds for Alpine are now based on Alpine 3.20. Starting with the next release, we will be building for Alpine 3.20 rather than Alpine 3.18.

In the process of doing this switch, we added support for using Pony with musl libc 1.2.5 which previously didn't work as musl had dropped support for "LFS64" functions like `lseek64`.

### Bson for Pony

It looks like someone has started a package for doing Bson serialization and deserialization in Pony. I saw this on X, so I don't know much about it. If you check it out, please report back.

The code is on GitHub at [2HgO/ponybson](https://github.com/2HgO/ponybson).

### Pony Development Sync

The recording of the December 3, 2024 Pony development sync is available. Check it out on [Vimeo](https://vimeo.com/1035815182).

We discussed a few PRs in the ponyc repo as well as 1 issue.

We also discussed if we should continue to support 32-bit platforms and decided to turn that over to a discussion with ["the community" via an issue we opened in the ponyc repo](https://github.com/ponylang/ponyc/issues/4564).

### Cancelled Pony Development Syncs

We've cancelled 2 upcoming Pony Development Syncs. The December 24th and December 31st syncs are both cancelled for the Holidays. We have 2 more syncs this year, December 10th and December 17th. We'll be back to our regular schedule in the new year.

### Office Hours

Office Hours this past week was myself, Adrian, Red, and Kevin Hovsäter.

Kevin recently started playing around with Pony and is starting by doing this years [Advent of Code](https://adventofcode.com/). We spent a lot of time this week chatting with Kevin. I think all 3 of us regulars were excited to see someone new to Pony and excited to chat with him.

Kevin heard about Pony from the [Developer Voices Podcast I recently did](https://pod.link/developer-voices/episode/89440d0d3be17217212d113cf6a31400). Which means that Adrian is probably responsible for Kevin's interest in Pony. Thanks, Adrian! Adrian spent a lot of time bothering Kris Jenkins to do an episode about Pony and now here we are, talking with Kevin.

I took some rough notes on what we talked about:

- Sweden a bit; "for reasons".
- Kevin discussed his early development experiences some.
- How is F# different than OCaml.
- How many folks work on Pony and other "community related" questions from Kevin.
- RSI
- Nuance Dragon and how great it was for programming.
- LLMs and transcription.
- LLMs in general.
- Finally, we wrapped up with a Pony question from Red about exiting behaviors early.

Clearly, you missed out and you should join us sometime.

### Office Hours December 9, 2024

I won't be in attendance. I'm traveling for work. You should still stop by as Adrian and Red will probably be there.

## Pony Advent of Code Repositories

Folks have been posting [in the Zulip](https://ponylang.zulipchat.com/) about their [Advent of Code 2024](https://adventofcode.com/2024) solutions. Here's a few repositories that I pulled from that:

- [Gordon Tisher](https://github.com/chalcolith/advent_of_code_2024)
- [Kevin Hovsäter](https://codeberg.org/hovsater/advent_of_code/)
- [Matthias Wahl](https://github.com/mfelsche/aoc/)
- [strangejune](https://codeberg.org/strangejune/advent-of-code-pony/)

Are you doing Advent of Code in Pony this year? Let us know and we'll add your repository to the list.

## Releases

- [ponylang/glob 1.0.7](https://github.com/ponylang/glob/releases/tag/1.0.7)
- [ponylang/ponyup 0.8.4](https://github.com/ponylang/ponyup/releases/tag/0.8.4)
- [ponylang/regex 1.1.6](https://github.com/ponylang/regex/releases/tag/1.1.6)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
