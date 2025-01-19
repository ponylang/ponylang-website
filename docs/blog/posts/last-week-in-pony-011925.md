---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - January 19, 2025"
date: 2025-01-19T07:00:06-04:00
---

A new week, a new article about Pony and a new RFC accepted. All this and more in this week's Last Week in Pony.

<!-- more -->

## Items of Note

### Preventing data races with Pony

A couple weeks back, LWN.net published an article titled ["Preventing data races with Pony"](https://lwn.net/Articles/1001224/). The article is a good introduction to Pony and its capabilities. If you are a current Pony user or a regular reader of Last Week in Pony, you probably won't get much from it, but hey, it's news.

### Pony Development Sync

The [recording](https://vimeo.com/1046916736) of the January 14, 2025 Pony Development Sync is available.

### Office Hours

Office Hours this past week was me helping Red with what changes would be needed to allow the [Pony http_server](https://github.com/ponylang/http_server) to send back a chunked response when a full request is received. At the moment, the way the server's handler interface is implemented, once a request is received, you have 1 and only 1 chance to respond. Red found that this was sub-optimal when you want to read a huge file into memory to send to the client.

If you chunked the response, you could end up using a lot less memory in return for a slightly longer response time. The change identified is relatively small and should be easy to implement. Red is going to take a stab at it and we'll see how it goes.

## RFCs

### Accepted

- [RFC 80: "String Find USize"](https://github.com/ponylang/rfcs/blob/main/text/0080-usize-indexing.md)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
