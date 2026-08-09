---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - August 9, 2026"
date: 2026-08-09T07:00:00-04:00
---

Two theme songs this week. Roger Miller's ["Where Have All The Average People Gone"](https://www.youtube.com/watch?v=p3jiXa06-R0) and Charley Crockett's ["Where Have All the Honest People Gone"](https://www.youtube.com/watch?v=mfSMZEbf20w). Mostly the same song, and I deeply relate to both. It was a big week. A cascade of bug fixes in [ponylang/ssl](https://github.com/ponylang/ssl) rippled through the whole ecosystem, and sixteen releases went out the door.

<!-- more -->

## ponylang/ssl — upgrade now

[ponylang/ssl](https://github.com/ponylang/ssl) went through three releases this week: [3.0.1](https://github.com/ponylang/ssl/releases/tag/3.0.1), [4.0.0](https://github.com/ponylang/ssl/releases/tag/4.0.0), and [4.1.0](https://github.com/ponylang/ssl/releases/tag/4.1.0). Upgrade to 4.0.0 or later as soon as possible.

It started innocently enough. I was adding missing SSL functionality to [ponylang/lori](https://github.com/ponylang/lori), the TCP networking library a lot of the Pony ecosystem is built on, which surfaced a couple of problems in ssl. Fixing those surfaced a couple more. Fixing those surfaced more. At some point I was staring at the screen going "Jesus. This is a lot of bugs. Fuck."

3.0.1 has eleven bug fixes on its own. In 4.0.0 I redesigned the API: `state()` polling after every operation is gone, replaced with return values from `receive()`, `read()`, and `send()`, and there's a new `SSL.close()` for orderly TLS shutdown. It's a breaking change, but the migration is mechanical — the [release notes](https://github.com/ponylang/ssl/releases/tag/4.0.0) have examples. I added DTLS (datagram TLS) in 4.1.0, which I need for getting UDP and secure UDP into lori. There's no extra work in going to 4.1.0 instead of 4.0.0.

If you use any of the downstream libraries — lori, stallion, hobby, courier, mare, postgres, livery, github_rest_api, or ponyup — update them as soon as possible. They've all been updated to ssl 4.0.0 already, so upgrading to the latest version gets you the fixes.

## Items of Note

### ponylang/stallion 0.9.0

[ponylang/stallion](https://github.com/ponylang/stallion) [0.9.0](https://github.com/ponylang/stallion/releases/tag/0.9.0) is out, along with [ponylang/hobby](https://github.com/ponylang/hobby) [0.10.0](https://github.com/ponylang/hobby/releases/tag/0.10.0) and [ponylang/livery](https://github.com/ponylang/livery) [0.7.0](https://github.com/ponylang/livery/releases/tag/0.7.0). stallion is Pony's HTTP server; hobby and livery are built on top of it. The core functionality was working, but there were a number of significant bugs. Upgrade all three as soon as possible. Here's what was wrong:

- Closing a connection from a request callback could hang the program
- A connection could wedge permanently under sustained write backpressure
- Requests kept arriving on HTTPS connections after backpressure kicked in
- Streaming chunk callbacks fired once per write-queue drain, not once per chunk
- Chunk callbacks didn't fire at all when the connection closed
- A write could hang the whole program under load
- `yield_read()` didn't do what its name implies — it's gone, replaced by `read_buffer_size` on `ServerConfig`
- `Responder` reports `ConnectionClosed` now — previously, writes to a dead connection returned success

### ponylang/lori 0.18.0

[ponylang/lori](https://github.com/ponylang/lori) [0.18.0](https://github.com/ponylang/lori/releases/tag/0.18.0) is out with the ssl fixes and a few of its own. There's a breaking change to send callbacks, so check the [release notes](https://github.com/ponylang/lori/releases/tag/0.18.0) for the migration. [0.18.1](https://github.com/ponylang/lori/releases/tag/0.18.1) followed later that day for TLS `close_notify` on graceful close.

The goal is for lori to become the standard library's networking library. I need the API to be solid and the implementation pretty darn bug free before that happens, so I keep pushing on it.

### The new allocator

If you've been reading along, you know I've been working on a new memory allocator for the Pony runtime — the current one can't reclaim freed memory across sizes or threads, so usage climbs in some workloads. It's almost done. I'm hoping it lands this week. If things go really well, it lands after I've written this but before this post goes live.

### Pony in Nix

Red has finished the work to get ponyc 0.67.0 into Nix, just in time for the 0.68.0 release. He expects the refactored package to be easier to maintain. Nix isn't a directly supported platform by the Pony team, due to how Nix manipulates libraries and linkers.

### ponylang/llm-skills

[ponylang/llm-skills](https://github.com/ponylang/llm-skills), the skills we publish for working on Pony with an LLM, has been updated. If you use them, update.

### Office Hours

I'm traveling for work and missed Office Hours on August 3rd. If it happened, I don't know about it.

### Pony Development Sync

The syncs on August 5th and August 12th are both canceled.

## Releases

- [ponylang/ssl 3.0.1](https://github.com/ponylang/ssl/releases/tag/3.0.1)
- [ponylang/ssl 4.0.0](https://github.com/ponylang/ssl/releases/tag/4.0.0)
- [ponylang/ssl 4.1.0](https://github.com/ponylang/ssl/releases/tag/4.1.0)
- [ponylang/lori 0.18.0](https://github.com/ponylang/lori/releases/tag/0.18.0)
- [ponylang/lori 0.18.1](https://github.com/ponylang/lori/releases/tag/0.18.1)
- [ponylang/stallion 0.9.0](https://github.com/ponylang/stallion/releases/tag/0.9.0)
- [ponylang/hobby 0.10.0](https://github.com/ponylang/hobby/releases/tag/0.10.0)
- [ponylang/livery 0.7.0](https://github.com/ponylang/livery/releases/tag/0.7.0)
- [ponylang/courier 0.5.0](https://github.com/ponylang/courier/releases/tag/0.5.0)
- [ponylang/mare 0.6.1](https://github.com/ponylang/mare/releases/tag/0.6.1)
- [ponylang/mare 0.6.2](https://github.com/ponylang/mare/releases/tag/0.6.2)
- [ponylang/postgres 0.8.1](https://github.com/ponylang/postgres/releases/tag/0.8.1)
- [ponylang/postgres 0.8.2](https://github.com/ponylang/postgres/releases/tag/0.8.2)
- [ponylang/github_rest_api 0.8.0](https://github.com/ponylang/github_rest_api/releases/tag/0.8.0)
- [ponylang/ponyup 0.16.2](https://github.com/ponylang/ponyup/releases/tag/0.16.2)
- [contact-red/sensitive 0.2.0](https://github.com/contact-red/sensitive/releases/tag/0.2.0)

## RFCs

### Final Comment Period

The ['Redesign the process monitor' RFC](https://github.com/ponylang/rfcs/pull/237) is in final comment period.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
