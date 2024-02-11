---
draft: false
authors:
  - seantallen
  - ryan
description: "We are approaching the end of the great DockerHub Migration."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - November 26, 2023"
date: 2023-11-26T07:00:06-04:00
---

We are approaching the end of the great DockerHub Migration.

<!-- more -->

## Items of Note

### Ponyc 0.58.0 has been released

We released Ponyc version 0.58.0 on Black Friday. It is technically a break change release as we disallowed the usage of `return` at the end of `with` blocks. Previously this was allowed and did create programs that would run but it also created invalid LLVM IR which might for some programs result in bugs.

Additionally, we made validating LLVM IR a standard compilation step for Pony programs so we catch issues like this sooner. If any of your programs complain about invalid IR, please [open an issue](https://github.com/ponylang/ponyc/issues/new) and add the `--noverify` flag when compiling.

### DockerHub Deprecation is Here

Sometime in the next two weeks, we will stop pushing all our container images to DockerHub. We will only be pushing to GitHub Container Registry. If you are using images that are updated regularly like `ponylang/ponyc:latest` or `ponylang/ponyc:release`, you'll need to start pulling them from the GitHub Container Registry.

For example where you previously referenced `ponylang/ponyc:latest` you will now need to reference `ghcr.io/ponylang/ponyc:latest`.

Existing images that are in DockerHub will remain there, but no new images or updates to existing images will happen.

### The Great DockerHub Migration

We've migrated all `ponylang/ponyc` Linux release images that were ever created from DockerHub to GitHub Container Registry. You can now pull any image going back to 0.13.0 from GitHub Container Registry.

We haven't and don't intend to migrate the Windows images.

### Office Hours

We have an open Zoom meeting every week for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try. The meeting is open to anyone. Stay up-to-date with the schedule by [subscribing to the Office Hours calender](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics). Hopefully, we'll see you at an Office Hours soon.

Office Hours today was Sean and Dipin helping Red track down a bug in his [pseudorandom permutation](https://en.wikipedia.org/wiki/Pseudorandom_permutation) code that he is building for a work project.

Turns out the bug was that the algorithm that Red was using requires the size of collection to be combined with a number that is [coprime](https://en.wikipedia.org/wiki/Coprime_integers) with the size and Red's weren't.

Interested in background? Check out the [initial conversation](https://ponylang.zulipchat.com/#narrow/stream/234733-off-topic/topic/Algorithm.20Request.3A.20uniform.20and.20100.25.20coverage.20prng) from the Ponylang Zulip.

## Releases

- [ponylang/ponyc 0.58.0](https://github.com/ponylang/ponyc/releases/tag/0.58.0)

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

When sharing minimal examples of Pony code, it can be useful to share the environment as well. Thankfully, Pony provides the [Pony Playground](https://playground.ponylang.io/) for just this purpose. After entering your minimal example into the Playground, you can shared a link to the example by clicking the Share button at the top. This is a great way to share a code snippet when asking a question in the Ponylang Zulip or requesting assistance with debugging a confusing compilation message.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
