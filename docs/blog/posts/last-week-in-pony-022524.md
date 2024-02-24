---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - February 25, 2024"
date: 2024-02-25T07:00:06-04:00
---

Pony 0.58.2 has been released. We strongly advise updating as soon as possible.

<!-- more -->

## Items of Note

### Pony 0.58.2 has been released

Pony 0.58.2 was released this past Saturday. It features a number of improvements. We recommend updating as soon as possible.

There's a critical bug fix that remove an unlikley but possible memory corruption that can occur when using `Array.copy_to`. Everyone should definitely update to get that fix.

For all the MacOS users out there, we once again are doing releases built for Apple Silicon based machines. The first went out with 0.58.2. We are very happy that GitHub has made Apple Silicon runners available for Open Source projects and that we can again provide builds for Apple Silicon based machines.

We've added Fedora 39 as a supported platform.

And for all your domain modellers out there, we've added a new package to the standard library for doing [constrained types](https://stdlib.ponylang.io/constrained_types--index/). The documentation has some relatively in-depth how-to use examples. It's a great addition to the standard library. If you have questions on how to use, stop by the [Zulip](https://ponylang.zulipchat.com) and ask.

### Pony Virtual Users' Group Recordings

We're organizing the Pony Virtual Users' Group recordings into a channel on Vimeo. You can locate the channel at [vimeo.com/channels/ponyvug](https://vimeo.com/channels/ponyvug).

### Development Sync Recordings are on the move

We're moving our Development Sync recordings from NearlyFreeSpeech to Vimeo. We will work on moving our several years of recordings over to Vimeo in the coming weeks.

We've created a [channel on Vimeo](https://vimeo.com/channels/ponydevelopmentsync) where all future Development Sync recordings will be posted.

### Pony Development Sync

The [recording](https://sync-recordings.ponylang.io/r/2024_02_20.mp4) of the February 20th, 2024 sync is available.

We had a short, two issue agenda:

- We triaged an issue that had a new case added to it.
- We discussed an addition to the [ponylang/http_server](https://github.com/ponylang/http_server/pull/75) repository.

From there we discussed the fact that we now pay more for hosting our Development Sync recordings on NearlyFreeSpeech than we would if we hosted on Vimeo. We agreed to move our recordings from NearlyFreeSpeech to Vimeo.

### Office Hours

We had an excellent Office Hours this week. Adrian and I (Sean) spent over and hour discussing a customization to the Pony standard library that Adrian did as part of his software defined radio project.

I would summarize the class as a "leasable byte buffer". It's a fixed buffer that segments of can be leased out to other parts of the system. The leased segments can be made either "read-only" or "read-write". It's a great example of how Pony's capabilities can be used to build a high performance, safe system.

Adrian's primary goal was to massively curtail the number of allocations done by his software defined radio. It reminded me of the sort of optimization that one would see in order to make Hadoop run somewhat efficiently. We covered a lot of ground and explored numerous aspects of what the design would need to fit a use case like Adrian's. The meeting end with an agreement that I would sketch out the idea and we'd discuss it in the future.

The final goal would be to get an RFC together for eventual inclusion in the Pony standard library. The classes in question would have to be part of the `builtin` package of the Pony standard library as they need to do "pointer magic".

For those who are unfamiliar, Pony does "unsafe pointer magic" but it's all encapsulated in classes in the standard library's `builtin` package. There's a number of unsafe pointer operations that are available only to classes in `builtin`. Code outside of `builtin` can then leverage that unsafe code in a safe fashion. This limits the amount of unsafe code in the system and makes it easier to reason about the safety of the system. So far, no one has come forward with a detailed explanation for a data structure they need to do that can't be built on top of the existing `builtin` classes (primarily `Array`).Adrian's use case requires a new addition to `builtin` and some additional unsafe pointer operation code.

## Releases

- [ponylang/http_server 0.5.0](https://github.com/ponylang/http_server/releases/tag/0.5.0)
- [ponylang/ponyc 0.58.2](https://github.com/ponylang/ponyc/releases/tag/0.58.2)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
