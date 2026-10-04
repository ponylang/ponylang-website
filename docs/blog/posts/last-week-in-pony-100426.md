---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - October 4, 2026"
date: 2026-10-04T07:00:00-04:00
---

I'm not going to pretend like this music that I have decided to include in this week's intro is in any way related to this last week in Pony except that I happened to listen to We Care a Lot and then was just like "OMFG, Chuck Mosley era Faith No More had a couple absolutely bangers and more people need to hear them". So hey, something something Pony stuff (you'll learn more below anyway), but be sure to listen to [We Care A Lot](https://www.youtube.com/watch?v=LQhX8PbNUWI) and [Anne's Song](https://www.youtube.com/watch?v=w7dD-JJJytM) while you do you some Pony this week. Deal?!? Good. ON WITH THE SHOW!

<!-- more -->

## Two Theme Songs, Two Pony Releases

Cos who doesn't like symmetry, right? Or maybe you are thinking "what the flip Sean, why two releases so close together?" or maybe you are thinking "thank god I don't have to decide when to do Pony releases, I got Sean to decide for me." Whatever brought you here, I got some information for you.

I've been breaking a lot of stuff to make stuff better and part of that is keeping CI green. But breaking changes require other parts of the ecosystem to change and when those changes cascade deep enough, the only way to keep CI green is to do a Pony release, so I can update a library that depends on it, so I can release that library, so I can update the next library that depends on *that* one. Phew. What a chain, anyway, that happened twice this week. I don't want to leave broken things lying around and hiding potentially new bugs, so you got two releases.

So what were the breaking changes that brought all this on?

A big one was that I wanted to improve our property based testing story. I've been adding features at a regular clip for a while now. I got to one where it was a little janky. And that jank sprung from the fact that our property based testing framework `pony_check` was an appendage to our testing framework rather than part of it. So, I said to myself: "myself, this just ain't right-- Pony only has a few users and if we don't make things better where they can be, all we will ever have is a few users." So, I broke all the PonyCheck tests by getting rid of it and moving all the functionality into PonyTest where it just fits so much better. Check out the release notes for 0.73.0 and have a look at the new property based testing API-- it is just much better.

The other big breaking change that resulted in a release was merging the crypto library into the standard library and shutting down the `ponylang/ssl` library. So ya, that's a couple of the breaking changes. Let's talk about one more change that made it into the releases before I tell you to bugger off and read the release notes.

There's more performance improvement than you can shake a stick at, especially if you are on a platform that we can build with clang like MacOS and Linux. We now build all Pony modules as LLVM bitcode and the Pony runtime as LLVM bitcode. This unlocks a whole mess of additional program optimizations. And, no breaking changes to get it. I don't just break, I also make more awesomer.

There's plenty more goodness as well so check out the release notes.

- [0.73.0](https://github.com/ponylang/ponyc/releases/tag/0.73.0)
- [0.74.0](https://github.com/ponylang/ponyc/releases/tag/0.74.0)

## Items of Note

### LLM Skills Updated

The [llm-skills](https://github.com/ponylang/llm-skills) have been updated. If you use them, please update.

## Releases

- [contact-red/equestuia 0.1.4](https://github.com/contact-red/equestuia/releases/tag/0.1.4)
- [ponylang/crdt 0.3.0](https://github.com/ponylang/crdt/releases/tag/0.3.0)
- [ponylang/fork_join 0.2.0](https://github.com/ponylang/fork_join/releases/tag/0.2.0)
- [ponylang/fork_join 0.3.0](https://github.com/ponylang/fork_join/releases/tag/0.3.0)
- [ponylang/github_rest_api 0.14.0](https://github.com/ponylang/github_rest_api/releases/tag/0.14.0)
- [ponylang/hobby 0.17.0](https://github.com/ponylang/hobby/releases/tag/0.17.0)
- [ponylang/hobby 0.18.0](https://github.com/ponylang/hobby/releases/tag/0.18.0)
- [ponylang/livery 0.13.0](https://github.com/ponylang/livery/releases/tag/0.13.0)
- [ponylang/livery 0.14.0](https://github.com/ponylang/livery/releases/tag/0.14.0)
- [ponylang/mare 0.11.0](https://github.com/ponylang/mare/releases/tag/0.11.0)
- [ponylang/mare 0.12.0](https://github.com/ponylang/mare/releases/tag/0.12.0)
- [ponylang/msgpack 0.5.0](https://github.com/ponylang/msgpack/releases/tag/0.5.0)
- [ponylang/msgpack 0.6.0](https://github.com/ponylang/msgpack/releases/tag/0.6.0)
- [ponylang/multipart_mime 0.3.0](https://github.com/ponylang/multipart_mime/releases/tag/0.3.0)
- [ponylang/ponyc 0.73.0](https://github.com/ponylang/ponyc/releases/tag/0.73.0)
- [ponylang/ponyc 0.74.0](https://github.com/ponylang/ponyc/releases/tag/0.74.0)
- [ponylang/postgres 0.13.0](https://github.com/ponylang/postgres/releases/tag/0.13.0)
- [ponylang/postgres 0.14.0](https://github.com/ponylang/postgres/releases/tag/0.14.0)
- [ponylang/stallion 0.15.0](https://github.com/ponylang/stallion/releases/tag/0.15.0)
- [ponylang/templates 0.6.0](https://github.com/ponylang/templates/releases/tag/0.6.0)
- [ponylang/valbytes 0.8.0](https://github.com/ponylang/valbytes/releases/tag/0.8.0)
- [ponylang/web_link 0.2.0](https://github.com/ponylang/web_link/releases/tag/0.2.0)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang-website/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
