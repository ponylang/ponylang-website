+++
draft = false
author = "theobutler"
description = "Our community Zulip has over 500 members! Ryan A. Hagenson introduces pony-bio, a bioinformatics library for the Pony ecosystem."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - February 2, 2020"
date = "2020-02-02T12:13:58-05:00"
+++

Our community Zulip has over 500 members! Ryan A. Hagenson introduces pony-bio, a bioinformatics library for the Pony ecosystem.

<!--more-->


## Items of note

- Audio from the January 28, 2020 Pony sync is available [here](https://sync-recordings.ponylang.io/r/2020_01_28.m4a). Most of the conversation is related to Joe's work on looking into integrating a Pony-like language with Verona runtime.

- The Zulip got its 500th member this week. What an awesome milestone. Baby steps to programming language domination. [Baby steps](https://www.youtube.com/watch?v=ncFCdCjBqcE).

___
## @rhagenson's introduction to pony-bio

There is growing interest in using Pony for Bioinformatics!

As the admin of [pony-bio](https://github.com/pony-bio/pony-bio), I shared my intent on its design with the community, namely:

pony-bio should be tightly integrated to achieve the most benefit -- this is counter to a previous Bioinformatics library I designed ([sembio/go](http://github.com/sembio/go)), which has intentional loose coupling.

I am looking toward [Rust-Bio](http://github.com/rust-bio/) (of which I am also a contributor) as a model Bioinformatics library for organizational concerns and future integration should a pure-Pony solution not be fast enough.

My personal philosophy is that a Bioinformatics library should make the routine and obvious just that: routine and obvious. Additional complexity has a cost, most problematically on the programmer knowing their code is correct as expected -- correctness is paramount in Bioinformatics. Therefore, I am using the Rosalind problem set ([rosalind.info](http://rosalind.info)) as a reference for the operations that should never be made complicated.

A special :tada: thank you :tada: to @adri326, who cleaned up my mess of an initial pony-bio draft.

I invite anyone to contribute to pony-bio and help shape the future of Bioinformatics in Pony! :smiley: Anyone wishing to get involved can reach out to me on [Zulip](https://ponylang.zulipchat.com).
___

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
