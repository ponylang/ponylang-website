---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - December 22, 2024"
date: 2024-12-22T07:00:06-04:00
---

<< content >>

<!-- more -->

## Items of Note

### A Conversation About Pony (and more)

A couple weeks ago, Sylvan and I did an interview/conversation with Mike Shah about Pony and other things computer. It was released on Friday. Both Sylvan and I had a great time and loved talking with Mike. We hope you enjoy it as well. Hopefully, we can chat with Mike again sometime.

[Pony Programming Language with Sylvan Clebsch and Sean Allen -- Conversation #7](https://www.youtube.com/watch?v=_jhPREUmHJ4)

### No Development Syncs the Next 2 Weeks

We are taking a break for the Holidays. See you in 2025!

### Pony Development Sync

The recording of the December 17, 2024 Pony development sync is available. Check it out on [Vimeo](https://vimeo.com/1040416322).

### Office Hours the Next 2 Weeks

We have Office Hours scheduled the next 2 weeks. I'm not sure if I will be in attendance. I will be playing it by ear each Monday based on what I have going on in my life while taking some time off from work.

### Office Hours

I wasn't at Office Hours this past week but Joe was. He provided the following summary:

- We discussed Pony's underlying pool allocator, and how it works. Specifically, we discussed size classes, thread-local free lists, and the clever trick it uses of reusing the soon-to-be-deallocated buffer to store the linked list pointer without allocating a new data structure.
- We looked at Red's solution for calling a C API via FFI that expects a pointer to an array of a C unions using a Pony tuple of mixed members. Joe also proposed a different approach with different pros and cons - in this specific case where the C union members can all boil down to different numeric types, and the union has a 64 bit size/alignment, Joe suggested that Red could also consider converting each element to a U64 and send an Array[U64] buffer pointer to the FFI function.
- We discussed other programming languages, and talked about the use cases for specialized languages that make more assumptions vs "general-purpose" languages that make fewer assumptions.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
