---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - August 17, 2025"
date: 2025-08-17T07:00:06-04:00
---

After a week off, we're back with a double issue of Last Week in Pony! This week, we have updates on the latest Pony development sync and Red's talk.

<!-- more -->

## Items of Note

### Red's Talk at the Carolina Code Conference

Red shared news about his talk at the [Carolina Code Conference](https://blog.carolina.codes/):

> I gave my pony talk ["Fast, Concurrent, Secure, Correct Actors - and a Pony"](https://blog.carolina.codes/i/162773221/intermediate-fast-concurrent-secure-correct-actors-and-a-pony) at [Carolina Codes Polyglot and Infosec Conference](https://carolina.codes/).
>
> Conversations were had, stickers were handed out, lots of in-person discussions followed.
>
> It was a great time.
>
> ![Red onstage](assets/red-carolina-codes-august-2025.png)

Personally, I think those "Rules of Engagement" are fucking awesome. Especially the "There will be generalizations".

### Pony Development Sync

The [recording](https://vimeo.com/1107522980) of the August 5th, 2025 sync is available as is the [recording](https://vimeo.com/1110692141) of the August 12th, 2025 sync.

### Office Hours

There was only one Office Hours during the past two weeks. Red and I discussed what he'd talk about at the [Carolina Code Conference](https://blog.carolina.codes/). We discussed Red's idea to create a `UTF8String` type in Pony that wraps the standard library's [`String` type](https://stdlib.ponylang.io/builtin-String/). After much discussion so I could understand the use case, I told Red two things:

- He should be wrapping [`Array`](https://stdlib.ponylang.io/builtin-Array/), not [`String`](https://stdlib.ponylang.io/builtin-String/).
- He should be biting off a smaller chunk of work and not try to make his initial version fit all the use cases he can think of. Rather, he should focus on the most common use case and then iterate from there as needed.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
