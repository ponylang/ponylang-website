---
draft: false
author: "seantallen"
description: "Beware of OpenSSL 3.2 (for now)."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - January 14, 2024"
date: 2024-01-14T07:00:06-04:00
---

## Items of Note

### OpenSSL 3.2 related bug

We've had a report that some code written with the [HTTP library](https://github.com/ponylang/http) that uses OpenSSL 3.2 via the [NetSSL library](https://github.com/ponylang/net_ssl) "has a bug". The bug presents as a program hang when compiled in release mode and as a segmentation fault when compiled in debug mode.

You can follow along with the issue [on the ponylang/NetSSL issue](https://github.com/ponylang/net_ssl/issues/105).

### New OpenSSL builder added

We've added a new OpenSSL builder and made it publicly available. We'll be using it to test the OpenSSL 3.2 bug. You can use it for whatever you want, it's
available as `ghcr.io/shared-docker-ci-x86-64-unknown-linux-builder-with-openssl_3.2.0`.

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2024_01_09.m4a) from the January 9th, 2023 sync is available.

We had a short agenda. We ran through it. Pretty standard for a Pony Development Sync.

### Office Hours

We have an open Zoom meeting every week for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try. The meeting is open to anyone. Stay up-to-date with the schedule by [subscribing to the Office Hours calender](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics). Hopefully, we'll see you at an Office Hours soon.

We had a really good Office Hours this week. It was a great way to return after a couple weeks off for the holidays. Attendees were Adrian Boyko, Sean Allen, and Greg Wilson.

Greg is the author of ["Software Design by Example"](https://third-bit.com/sdxpy/). The description from his website is as follows:

> The best way to learn design in any field is to study examples, and the most approachable examples are ones that readers are already familiar with. These lessons therefore build small versions of tools that programmers use every day to show how experienced software designers think. Along the way, they introduce some fundamental ideas in computer science that many self-taught programmers haven’t encountered. We hope these lessons will help you design better software yourself, and that if you know how programming tools work, you’ll be more likely to use them and better able to use them well.

Greg is looking to do a version of Software Design by Example about concurrent programming and distributed systems. He stopped by to chat about if Pony would be a good language to use for teaching.

The three of us discussed things we like in different languages that help with learning. We got a decent understanding of how we all think about the subjects of "complexity" and "simplicity" in terms of pedagogy.

The last 20 minutes, we discussed why Pony would be a good language for Greg to use and what might be difficult. A lot of the difficult is in the "getting tools installed" phase. Pony currently lacks prebuilt binaries for Apple Silicon based MacOS. It also only has prebuilt binaries for a couple Ubuntu versions and a version of Alpine.

Greg is going to spend a couple weeks playing around with Pony to get a better feel for if it is a good fit and if he thinks so, he'll join us again at another Office Hours to discuss how we as a community could help his efforts with things like more prebuilt binaries of the compiler.

If you see Greg pop up in the Zulip asking beginner questions, please do jump in and give him a hand if no one else is around.

Adrian and Sean both think that Pony has many features that make it a great teaching language and we'd love to see Greg pick up Pony for his latest work.

## Releases

- [ponylang/peg 0.1.6](https://github.com/ponylang/peg/releases/tag/0.1.6)

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

Pony uses a system of reference capabilities to ensure its safe concurrency. These reference capabilities (often shortened to "refcaps") are: `iso`, `trn`, `ref`, `val`, `box`, and `tag`. There is a whole Pony Tutorial chapter on [Reference Capabilities](https://tutorial.ponylang.io/reference-capabilities/). While these refcaps can often be understood individually with a little bit of practice, it can be helpful to refer to the [Capability Matrix](https://tutorial.ponylang.io/reference-capabilities/capability-matrix). You should take note of how the matrix is about denial, not allowance. Even if we would normally talk about what a refcap **can** do, you will get a deeper understanding by switching your thinking to what a refcap **cannot** do. For example, both an `iso` and a `ref` can be read from and written to, however because an `iso` cannot be aliased (locally or globally) it is safe to share between actors.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
