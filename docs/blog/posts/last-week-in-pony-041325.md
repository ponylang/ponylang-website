---
draft: false
authors:
  - seantallen
  - red
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - April 13, 2025"
date: 2025-04-13T07:00:06-04:00
---

This past week in Pony included updates to SSL builders with two new additions and two deprecations. The April 8th development sync was brief, covering only beginner help questions. Office Hours featured wide-ranging discussions from Florida wildlife to the Actor Model, RDMA, and state replication in distributed systems. The team explored how Actor Model concurrency creates programs well-suited for state replication, with insights from financial industry applications.

<!-- more -->

## Items of Note

### New SSL Builders

We did our regular "every 6 months" rotation of the Pony + SSL docker images that we provide. Two new builders were added:

- LibreSSL 4.0.0
- OpenSSL 3.4.1

And two were deprecated:

- LibreSSL 3.9.1
- OpenSSL 3.3.0

SSL builders are updated nightly with the latest `ponyc`. We also maintain "release images" for the SSL builders that are generated each time there is a new `ponyc` release. Deprecated images stop getting updates so, if you are using either of the deprecated images, update to a new one.

You can see all the currently maintained SSL builders in the [ponylang/shared-docker](https://github.com/ponylang/shared-docker) repository.

### Pony Development Sync

The [recording](https://vimeo.com/1074823934) of the April 8th, 2025 sync is available. It was a quick meeting with no issues or pull requests to go over. We only reviewed unanswered questions in the [beginner help Zulip stream](https://ponylang.zulipchat.com/#narrow/channel/189985-beginner-help).

### Office Hours

Office Hours this past week was with Adrian, Alex, and myself. We talked about computers and Pony but took a while to get there.

We spent time talking about alligators and Florida experiences with gators. That led to a conversation about dangerous animals including cougars and feral hogs.

From there, we ended up talking about the Superbowl of Hardcore. I don't know if it still happens but I hope so. I had a great time attending when I was younger. Alex was fortunate enough to have a father who took him.

Then we finally got to computers. Alex brought up the Actor Model and distributed runtimes. When Adrian and I are both in these conversations, we usually talk about [RDMA](https://en.wikipedia.org/wiki/Remote_direct_memory_access).

While I appreciate BEAM's approach to distributing an actor model runtime, I care more about performance than the creators of Erlang did. Distribution within a rack where you could use RDMA interests me more. During our "fast distributed Pony runtime" tangent, Adrian brought up [CXL](https://en.wikipedia.org/wiki/Compute_Express_Link), which I don't remember knowing about.

As such conversations go, we moved to consistency versus availability, then to state replication. I discussed our approach with [Wallaroo](https://github.com/seantallen/wallaroo) and our trade-offs. Our decisions then were driven by the Finance market. I talked about disaster recovery strategies common in big banks.

The Wallaroo discussion led to our final topic: how the Actor Model's approach to concurrency creates programs friendly to state replication.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
