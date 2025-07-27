---
draft: false
authors:
  - seantallen
  - red
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - July 27, 2025"
date: 2025-07-27T07:00:06-04:00
---

Welcome to Last Week in Pony! It was a [Guns n' Roses](https://www.youtube.com/watch?v=Rbm6GXllBiw&list=RDRbm6GXllBiw&start_radio=1) morning here at Pony HQ as we were putting together this week's Last Week in Pony for you. This week we have an update on the 0.60.0 release progress, with a major milestone achieved in Ponyup's arm64 Windows support. We also have notes from our latest Office Hours session, which included discussions on electronics, distributed Pony applications, and high-throughput event processing.

<!-- more -->

## 0.60.0 Release Update

We merged Ponyup support for arm64 Windows this past week. That was a major hurdle to get over before we could release 0.60.0. There are still a number of items to finish up before and after the release, but we're getting closer.

You can follow along on the [release issue](https://github.com/ponylang/ponyc/issues/4690).

## Items of Note

### Office Hours

The people in the initial portion of this week's Office Hours were myself, Niclas, and Red. Right before the end of the hour I could stay, Lucus joined us. However, he didn't get his audio working until after I left. So what follows about the Lucus portion of Office Hours comes from quick notes that Red sent me.

The pre-Lucus portion included very little Pony talk and a lot of electronics discussion. Niclas showed off manufacturing equipment he has at home. It's pretty impressive.

Red left the following notes for the Lucus portion:

> Notes: I'll do a full write-up in a bit:
>
> Lucus asked about distributed Pony, Apache Kafka, and his use-case that could involve hundreds of thousands of events per second.
>
> I talked about my integration with Carbon Black and pony where I processed >hundreds of thousands of events per second with pony not even breaking a sweat.
>
> We gestured towards Wallaroo as a product that did this commercially.
>
> A string of ponies.
>
> A string of small towns as we head further north in Sweden.
>
> What (if any) is the link between Verona and Pony, and what did/should each of them learn from each other.

Clearly, as you can tell, Red never got around to doing a full write-up. If you want to hear more about the Lucus portion of Office Hours, you'll have to ask him.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
