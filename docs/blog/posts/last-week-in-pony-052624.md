---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - May 19, 2024"
date: 2024-05-26T07:00:06-04:00
---

<< content >>

<!-- more -->

## Items of Note

### Pony Development Sync

The [recording](https://vimeo.com/949571597) of the May 21, 2024 sync is available.

I wasn't able to attend. Adrian and Joe passed along the following information about a conversation that happened after the agenda that wasn't recorded:

Adrian:

> It's probably worth describing our not-recorded discussion for the sake of Last Week in Pony: Joe, Red, and Adrian talked for some time about additional and/or modified capabilities. We discussed:
>
>- A lin cap which is more restrictive than iso and would enable linear types.
>- The idea of eliminating tag which would make iso as restrictive as lin and eliminate the need for the latter.
>- Additional "borrow" capabilities which would make usage of iso simpler in certain very common scenarios.

Joe:

> I would rephrase "eliminating tag" as "eliminating tag aliases of iso as capable of and used for memory retention" (which happens to also be a requirement for if we want to eventually move Pony to the Verona runtime)

### Office Hours

Dan Plyukhin stopped by to discuss his work on distributed actor garbage collection and cycle detection. You can find information about Dan's work at [https://dplyukhin.github.io/](https://dplyukhin.github.io/).

You should check it out. It's pretty cool.

I won't be at Office Hours next week. I'm taking a nice 3-day weekend.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
