+++
draft = false
author = "seantallen"
description = "A week of cancelled meetings and compile-time expression conversation."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony May 7, 2023"
date = "2023-05-07T07:00:06-04:00"
+++

For reasons of migraine and work, there was no Pony Development Sync meeting this week nor did we hold the Office Hours meeting. But, we did discuss compile-time expressions a bit and probably will a lot more in the future.

## Items of Note

### Ubuntu 18.04 is no longer supported

Ubuntu 18.04 reached it's end of life in April. In keeping with our support policy, we have stopped using doing `ponyc` CI against it and no longer do nightly or release builds for Ubuntu 18.04 and distributions built off of it.

### `ponylang/release` shared docker image is deprecated

Ages ago, we had a shared docker image called `ponylang/release`. We stopped using in the ponylang organization quite some time ago. This week we remove the Dockerfile and associated source for creating the image. No new updates will be provided. The last existing image will continue to exist in the ponylang DockerHub.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week we are going to look at one of our Frequently Asked Question with regard to a bit of syntactic sugar: [What does `Foo()` do if my `Foo` class has both `create()` and `apply()` methods? Does it call both?](https://www.ponylang.io/faq/#Foo()-create-apply)

Since Pony classes have syntactic sugar for both `create()` and `apply()` it can be confusing as to what a single `Foo()` will do. It will call both so is equivalent to `Foo.create().apply()`. However, it does not work exactly as one might expect. `Foo()` is broken into `Foo` which calls `Foo.create()` and `()` which calls `.apply()` on the newly created `Foo`. Note that both of these method have zero arguments in the example. If either has arguments then there will be an error for `not enough arguments` pointing to the relevant stage.

## RFCs

Major changes in Pony go through a community driven process where members of the community can write up "requests for change" that detail what they think should be changed and why. RFCs can range from simple to complex. We welcome your participation.

In addition to there being a little activity on the [Static arrays of numbers RFC](https://github.com/ponylang/rfcs/pull/209), there was also discussion in the a [Zulip stream](https://ponylang.zulipchat.com/#narrow/stream/189959-RFCs/topic/static.20arrays.20of.20numbers) related to it as well.

Most of the conversation related to the "Static arrays of numbers" RFC is about Matthias wanting to add a `Vector` type to Pony which is related to "static arrays of numbers" as any "static array" is actually a `Vector`. This in turn lead to some conversation about `ponyta` which features amongst other things, a vector type and compile time expressions.

To learn more about `ponyta`, check out [Luke Cheeseman's presentation](https://vimeo.com/175746403) on it at the Pony VUG from many years ago.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
