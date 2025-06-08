---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - June 8, 2025"
date: 2025-06-08T07:00:06-04:00
---

There has been lots of activity this week from core team members. Most of it in service of getting the Pony 0.60.0 release out the door.

<!-- more -->

## Items of Note

### Pony 0.60.0 Release

We are working towards the Pony 0.60.0 release. I had hoped to have it out this past week but that didn't happen. You can follow along with our checklist of pre and post release tasks on the [release issue](https://github.com/ponylang/ponyc/issues/4690).

### Libgpiod Bindings

Niclas Hedhman [announced in Zulip](https://ponylang.zulipchat.com/#narrow/channel/189934-general/topic/FYI.20-.20Pony.20for.20Embedded.20use/near/522341336) that he has started work on bindings for libgpiod.

These bindings would be of interest to Raspberry Pi and other embedded Pony users who want to interact with GPIO pins.

### Cross-compiling Pony Directions

With a tiny bit of help from me, Niclas got himself able to cross-compile Pony for Raspberry Pi. He later announced in Zulip that he had tried to document that effort. You can give his directions a go by [checking them out on GitHub](https://github.com/niclash/pony-pi/blob/main/README.md).

### Pony Development Sync

The [recording](https://vimeo.com/1090233782) of the June 3rd, 2025 sync is available.

Lots of talk about Docker and how to build cross-platform container images for Pony.

### Office Hours

Office Hours this past week started with just Adrian and myself. We talked more about the data structure that Adrian has been working on that I call "leasable buffer" and Adrian calls "Vector v2".

From that we spun off into discussions of Pony's [ORCA protocol](https://www.ponylang.io/media/papers/orca_gc_and_type_system_co-design_for_actor_languages.pdf) and some more general Pony garbage collection topics.

Red joined partway through and talked about the [ODBC](https://en.wikipedia.org/wiki/Open_Database_Connectivity) library he is working on.

And at some point Niclas joined and he and Adrian ended up talking about [Software Defined Radio](https://en.wikipedia.org/wiki/Software-defined_radio) and related topics.

## Releases

- [ponylang/changelog-tool 0.5.1](https://github.com/ponylang/changelog-tool/releases/tag/0.5.1)
- [ponylang/changelog-tool 0.5.2](https://github.com/ponylang/changelog-tool/releases/tag/0.5.2)
- [ponylang/crypto 1.2.4](https://github.com/ponylang/crypto/releases/tag/1.2.4)
- [ponylang/http 0.6.3](https://github.com/ponylang/http/releases/tag/0.6.3)
- [ponylang/net_ssl 1.3.4](https://github.com/ponylang/net_ssl/releases/tag/1.3.4)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
