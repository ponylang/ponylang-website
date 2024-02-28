---
draft: false
authors:
  - seantallen
  - ryan
description: "Update your Pony installation as soon as possible."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - October 15, 2023"
date: 2023-10-15T07:00:06-04:00
---

Update your Pony installation as soon as possible.

<!-- more -->

## Items of Note

### Pony 0.57.0

Pony 0.57.0 was released this past week. It fixes a flaw in the implementation of the type system. Versions prior to 0.57.0 allow for unsafe data handling with `recover` blocks. We advise updating as soon as possible.

### Pony Development Sync

[Audio](https://vimeo.com/917350362) from the October 10th, 2023 sync is available.

## Releases

- [ponylang/ponyc 0.57.0](https://github.com/ponylang/ponyc/releases/tag/0.57.0)

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

It is always a sweet week in Pony when there is a compiler release so this week let us look at something equally as sweet: [sugar](https://tutorial.ponylang.io/expressions/sugar)!

On the Tutorial page for syntactic sugar, we cover `create`, `apply`, `create-apply`, and `update` sugar. The first three are interrelated and as such can be confused for one another with relative ease. Given we have a type `Foo`, the create sugar is when this type is bare at the value level, `var foo = Foo` becomes `var foo = Foo.create()`. The apply sugar is when we already have an instance of this type (i.e., `var foo = Foo`) and we then call the object directly, `foo()` becomes `foo.apply()`. We can combine these together for create-apply, `var foo = Foo()` becomes `var foo = Foo.create().apply()` -- this can only be used when `Foo.create()` takes no arguments as any arguments given here are passed to `apply`. Lastly, we have update sugar where an expression such as `foo(37) = x` becomes `foo.update(37 where value = x)` -- by defining an update method that takes an argument named `value` this sugar can be used on a type you define.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
