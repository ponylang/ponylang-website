---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - January 12, 2025"
date: 2025-01-12T07:00:06-04:00
---

Theo Butler's simple HTTP framework Jennet, got some updates this week thanks to Red Davies.

<!-- more -->

## Items of Note

### Actor Pinning Update

A [bug](https://github.com/ponylang/ponyc/issues/4582) was discovered in the version of actor pinning that was released in Pony 0.58.8. The bug has been fixed and will go out in the next Pony release. If you are interested in working with actor pinning, you should start using nightly builds of Pony until the next release is available.

### Jennet Update

Red Davies wrote in to say:

> Pony has a simple HTTP framework [Jennet](https://github.com/Theodus/jennet) which extends the functionality of Pony's [http_server](https://github.com/ponylang/http_server) to add lightweight request matching, routing, and parameter parsing.  Examples of this type of type of router (or multiplexer) model in other languages include Elixir's [phoenix framework](https://www.phoenixframework.org/), or Go's [httprouter](https://github.com/julienschmidt/httprouter).
>
> This week we bumped all the dependencies to the latest versions, including linking to OpenSSL 3.0.x.
>
> There is one breaking change that was introduced by a breaking change in the upstream [http_server](https://github.com/ponylang/http_server) library in ponylang/http_server#74. The Content-Length header is no longer an optional header unless chunking.
>
> Please see the [updated examples](https://github.com/Theodus/jennet/blob/main/examples/params/main.pony) for more context.

### Pony Development Sync

The [recording](https://vimeo.com/1045102238) of the January 7, 2025 Pony Development Sync is available.

This sync was a bit different from our usual fare in that it included some "live debugging" of [ponylang/ponyc issue #4579](https://github.com/ponylang/ponyc/issues/4579).

If live debugging is your thing, you should definitely check it out.

### Office Hours

We had a great time at Office Hours this past week. We missed you. Adrian, Red, and I had an excellent conversation.

We discussed Red's experience with Gtk and the new actor pinning functionality. He reports that it has been going great for him. He showed off some of the code he has been working on for making it easier for folks to use Gtk with Pony.

I noticed something in his code that led to a discussion of [nominal typing](https://tutorial.ponylang.io/types/traits-and-interfaces.html?h=interface#nominal-subtyping) vs [structural typing](https://tutorial.ponylang.io/types/traits-and-interfaces.html?h=interface#structural-subtyping) and how they relate to traits and interfaces in Pony. And we covered why you would decide to use a trait instead of an interface and vice-versa. We covered a lot of material that is [in the tutorial](https://tutorial.ponylang.io/types/traits-and-interfaces.html). As a result of our conversation, Red ended up switching all the interfaces in his nascent framework to traits.

We also ended up discussing [the mixin pattern](https://patterns.ponylang.io/code-sharing/mixin). I noticed Red using it in his framework and asked him about it and discovered he wasn't aware that the pattern he was using was written up in [Pony Patterns](https://patterns.ponylang.io/). We ended up going over the pattern some more in case there were any details in the pattern that might be useful to him in the future.

Finally, we discussed that Red was going to need to generate PDF documentation for his framework for use at work. We went over Pony's builtin documentation generation. And discussed the [ponylang/library-documentation-action-v2](https://github.com/ponylang/library-documentation-action-v2/) and the changes it makes to generated documentation.

Office Hours really is a great opportunity to learn about Pony and computer science concepts in general. You should join us. I'm pretty sure you'll learn something new.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
