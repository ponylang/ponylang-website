---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - January 26, 2025"
date: 2025-01-26T07:00:06-04:00
---

A fix for a nasty bug in the implementation the Pony type system was released as part of Pony 0.58.10. We recommend everyone update as soon as possible.

<!-- more -->

## Items of Note

### Pony 0.58.10 Released

As we [detailed last week](https://www.ponylang.io/blog/2025/01/last-week-in-pony---january-26-2025/#soundness-hole-closed), a soundness hole was fixed in the Pony compiler recently. Pony 0.58.10 which was released on Saturday February 1st, 2025, contains the fix. We recommend everyone update as soon as possible.

There's other important fixes in the release as well, but in the end, soundness holes will get all the headlines. Go, update now!

### Pony Development Sync

There was no agenda of note for this week's sync so we chatted for a bit and then went about our days without making a recording.

### Office Hours

We had a great time at Office Hours this week. Red, Adrian, Alex Webber, and I had a great conversation that covered a range of topics.

Among the things that were discussed:

- [ponylang/http_server PR #81](https://github.com/ponylang/http_server/pull/81)
- How to test an actor based version of Conway's Game of Life.
- Alex's work towards his degree
- [Smalltalk](https://en.wikipedia.org/wiki/Smalltalk)
- Unbounded queues
- The [ponylang/http_server](https://github.com/ponylang/http_server/) APIs and things that Red and I would like to see changed.

And we spent a ton of time talking about [systematic testing in Pony](https://github.com/ponylang/ponyc/blob/main/BUILD.md#systematic-testing) and how it came to be. I discussed it coming over from [Verona](https://www.microsoft.com/en-us/research/project/project-verona/) where [Pantazis Deligiannis](https://opensource.microsoft.com/blog/author/pantazis-deligiannis/) had added it. While we were talking, I was texting with Sylvan and he sent me links to other work that Pantazis has done including [Coyote](https://microsoft.github.io/coyote/) and P#. Which lead to a decent amount of conversation about the [P programming language](https://en.wikipedia.org/wiki/P_(programming_language)).

We really do have a great time at these things. You should join us. If you come with Pony problems, we can help! If you come with fun conversation, we can chat! If you come with both, we can do both!

## Releases

- [ponylang/ponyc 0.58.10](https://github.com/ponylang/ponyc/releases/tag/0.58.10)
- [ponylang/release-bot-action 0.6.4](https://github.com/ponylang/release-bot-action/releases/tag/0.6.4)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
