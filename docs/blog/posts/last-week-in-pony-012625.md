---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - January 26, 2025"
date: 2025-01-26T07:00:06-04:00
---

A nasty bug in the Pony type system was closed this week. If you can, you should start using a nightly release as soon as possible.

<!-- more -->

## Items of Note

### Soundness Hole Closed

A couple years ago, we switched the underlying model for the Pony type system to [one developed by George Steed](https://www.ponylang.io/media/papers/a_prinicipled_design_of_capabilities_in_pony.pdf). Unfortunately, when that was done, a rather large [soundness hole was introduced](https://github.com/ponylang/ponyc/issues/4579). That hole was only recently discovered.

The following code that should have been rejected by the compiler was being accepted:

```pony
class Bad
  let _s: String iso

  new iso create(s: String iso) =>
    _s = consume s

  fun ref take(): String iso^ =>
    match _s
    | let s': String iso => consume s'
    end
```

The code should not compile because `let s': String iso` is aliasing _s an `iso` field. Consuming an aliased `iso` shouldn't return an `iso^`.

The take-away is that "very bad things could happen" and the data race freedom guarantees of the Pony compiler were being violated.

We've closed the soundness hole. We recommend all Pony users update as soon as possible. The fix is in the most recent nightly releases of ponyc and will be in the next release that will be cut in less than a week.

We've added a number of new tests to ensure that this hole doesn't get opened again.

### Important ponylang/http update

We've released version 0.6.2 of [ponylang/http](https://github.com/ponylang/http). Without the update it contains, it won't compile if you try to use a recent version of ponyc. The fix we did for the soundness bug with `match` and `iso` caused a small section of code to no longer compile.

### Pony Development Sync

The [recording](https://vimeo.com/1049160657) of the January 21, 2025 Pony Development Sync is available.

I don't remember what was covered or discussed, so, no synopsis this week. You'll just have to listen for yourself.

### Office Hours

It was a holiday in the US on Monday, Red and I met up for a couple minutes. We chatted about a couple of things and then called it a day. We'll be back at it next week.

## Releases

- [ponylang/corral 0.8.2](https://github.com/ponylang/corral/releases/tag/0.8.2)
- [ponylang/github_rest_api 0.2.0](https://github.com/ponylang/github_rest_api/releases/tag/0.2.0)
- [ponylang/http 0.6.2](https://github.com/ponylang/http/releases/tag/0.6.2)
- [ponylang/json 0.2.0](https://github.com/ponylang/json/releases/tag/0.2.0)
- [ponylang/release-notes-bot-action 0.3.9](https://github.com/ponylang/release-notes-bot-action/releases/tag/0.3.9)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
