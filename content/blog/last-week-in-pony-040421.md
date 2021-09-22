+++
draft = false
author = "theobutler"
description = "Ponyc 0.39.1 has been released! The Roaring Pony group has made progress, including an addition to the standard library math package. Sean T. Allen is looking for assistance with the ponydoc project."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - April 4, 2021"
date = "2021-04-04T20:30:35-04:00"
+++

Ponyc 0.39.1 has been released! The Roaring Pony group has made progress, including an addition to the standard library math package. Sean T. Allen is looking for assistance with the ponydoc project.

<!--more-->

## Items of note

- Audio from the [March 30, 2021](https://sync-recordings.ponylang.io/r/2021_03_30.m4a) Pony development sync call is available.

- The [Roaring Pony](https://github.com/salty-blue-mango/roaring-pony) group has been hard at work expanding upon their work -- all while ensuring expansive testing as new functionality is added. The group plans to meet for another Zoom call this Tuesday 10PM CET, the meeting link will be posted over on [Zulip in the project topic](https://ponylang.zulipchat.com/#narrow/stream/190363-projects/topic/RoaringBitmap). All are welcome to join the call. The group plans to discuss project next steps and review any open PRs/issues during the call.

- @rhagenson writes that sometimes a dead end in one Pony project is a useful contribution elsewhere. While working on [Roaring Pony](https://github.com/salty-blue-mango/roaring-pony) Ryan Hagenson found himself at the end of a useful idea there so transformed some of his work into a useful addition to the `math` package in the form of [`IsPrime`](https://github.com/ponylang/ponyc/pull/3738). By working with @jemc, [over on Zulip](https://ponylang.zulipchat.com/#narrow/stream/189985-beginner-help/topic/Static.20memory.20allocation.3F), Ryan was able to define a statically allocated primes array to further speed up this added `math` functionality.

- @SeanTAllen writes that he is looking for assistance with the [ponydoc](https://github.com/ponylang/ponydoc) project. If you are interested in assisting, please drop him a line over on the [ponylang Zulip](https://ponylang.zulipchat.com/). There's already some [initial conversation and braindump](https://ponylang.zulipchat.com/#narrow/stream/190363-projects/topic/ponydoc) information in the Zulip.

## Releases

- Version 0.39.1 of ponylang/ponyc has been released.
See the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.39.1) for more details.

- Version 0.3.0 of ponylang/http has been released.
See the [release notes](https://github.com/ponylang/http/releases/tag/0.3.0) for more details.

- Version 1.1.3 of ponylang/net_ssl has been released.
See the [release notes](https://github.com/ponylang/net_ssl/releases/tag/1.1.3) for more details.

- Version 1.1.4 of ponylang/net_ssl has been released.
See the [release notes](https://github.com/ponylang/net_ssl/releases/tag/1.1.4) for more details.

- Version 0.6.0 of ponylang/ponycheck has been released.
See the [release notes](https://github.com/ponylang/ponycheck/releases/tag/0.6.0) for more details.

- Version 0.6.0 of ponylang/valbytes has been released.
See the [release notes](https://github.com/ponylang/valbytes/releases/tag/0.6.0) for more details.

## RFCs

### Approved RFCs

- The ["Add mandatory FFI declarations" RFC](https://github.com/ponylang/rfcs/pull/184) has been accepted.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
