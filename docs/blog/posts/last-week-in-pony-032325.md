---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - March 23, 2025"
date: 2025-03-23T07:00:06-04:00
---

<!-- more -->

## Items of Note

### Pony Development Sync

The [recording](https://vimeo.com/1067405139) of the March 18th, 2025 sync is available.

### Office Hours

We had a great time at Office Hours this week. It was myself, Red, Adrian, and Alex.

Adrian brought up concerns with iterators and object allocations. We went into a discussion of the pros and cons of using direct access to collection elements via while loops. We ended up as such conversations often do with me discussing my dislike of iterators, problems with most iterators, and how I prefer the Smalltalk approach.

From there, "for reasons," we ended up on a discussion of chili peppers, hot stuff, and Mirin. How on earth did we end up on Mirin? Well, I love to pair it with chilis and Red just loves it in general.

If you ever join an Office Hours call, there's a decent chance that Red will be in his room where behind him is a mass of old keyboards; mostly various IBM models. If you like discussing old IBM keyboards, then the next few minutes of conversation between Red and Alex were for you.

Once again, we ended up discussing a couple things about [ponylang/lori](https://github.com/ponylang/lori) and some changes that will be coming once I have time to pick up the work again. I was moving ahead at a good clip with it but then got sick and now have a lot of spare time going to "spring cleanup and prep around the homestead." I'll be back at it before too long, though.

Part of the lori discussion was how in an earlier version I did something that was garbage collector unfriendly. It slowed down the reaping of actors and led to explosive memory growth during stress testing as actors to handle new connections were being created faster than the old ones could be reaped.

Alex presented some Pony code he is writing (concurrent Game Of Life) and asked for feedback on how to handle a problem. He noted that in Java, he would solve the problem using a barrier of some sort. I told him how I address such problems in languages like Pony (and in a distributed setting across any language). Hopefully Alex has had a chance over the course of the week to implement and he'll be back tomorrow to report on how well things are going.

From there we got into an esoteric topic that Adrian brought up in relation to the aforementioned Alex conversation. Adrian noted that if you could use the Pony runtime's quiescence detection for triggering state changes rather than program shutdown, that would be powerful. I noted that my solution for Alex effectively does this, but not at the runtime level. I also agreed that Adrian's idea could make for a very elegant runtime if one was to write one custom to the problem (and similar) that Alex is working on.

Red and I ended up having a conversation about how I use "AI." In particular, how I have never been very good at "programming a search engine" to get the results that I want, but I am very good at "programming Kagi Assistant and Perplexity." I talked with Red about what I find good about them and why, for me, they provide a much better search engine experience and can save me hours a week versus using a standard "Google-style" search engine.

We then veered off into LLMs not being able to "write Pony" at all and how I have been playing around with the idea of developing a data set to make that not the case.

Finally, we ended the day with my telling the story of when I was running a machine-learning team several years ago and how we introduced a massive bug into the model implementation through a ridiculous "oops" moment.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
