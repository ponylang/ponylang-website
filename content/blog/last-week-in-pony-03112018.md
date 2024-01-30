+++
draft = false
author = "seantallen"
description = "Last week's Pony news, reported this week."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - March 11, 2018"
date = "2018-03-11T10:09:41-04:00"
+++
_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!--more-->

## Items of note

* Audio from the [March 7 Pony Development Sync](https://sync-recordings.ponylang.io/r/2018_03_07.m4a).
* I've been doing some testing on how to improve read performance for `TCPConnection`. In particular, related to how `expect` is implemented. If you are interested, there's a repository available with some basic test code: [https://github.com/wallaroolabs/pony-network-tests](https://github.com/wallaroolabs/pony-network-tests).

## Last Week's Playground

We have one "Last Week's Playground" submission from [MightyAlex200](https://github.com/MightyAlex200).

Alex notes:

> My submission is quite simple, but I hadn't ever seen anything like this in any other language and I thought it was cool that Pony can do this.
>
> This snippet demonstrates adding a method to primitives via trait subtyping that overloads the "not" operator to return a specific primitive.
>
> This allows types to be easily declared as "opposites" of each other

[Trait Subtyping](https://playground.ponylang.io/?gist=13c4ad2c9752cd90d5ecc0860469f4d7)

## RFCs

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!

### Implemented RFCS

[New Ponybench API](https://github.com/ponylang/ponyc/pull/2578)

### Approved RFCs

[Compile time expressions](https://github.com/ponylang/rfcs/blob/main/text/0053-compile-time-expression.md)
