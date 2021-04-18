+++
draft = false
author = "theobutler"
description = "The supported version of FreeBSD has switched to 13.0 for ponyc and corral. The Roaring pony folks met again."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - April 18, 2021"
date = "2021-04-18T19:07:00-04:00"
+++

The supported version of FreeBSD has switched to 13.0 for ponyc and corral. The Roaring pony folks met again.

<!--more-->


## Items of note

- We've switched our supported version of FreeBSD for ponyc to 13.0. Starting on April 15, 2021, all prebuilt nightly versions of ponyc will be built on/for FreeBSD 13.0. All future release versions will also be for FreeBSD 13.0. We will continue to do "best effort" to not break ponyc on previous versions of FreeBSD, but will only be testing on FreeBSD 13.0 going forward.

- We've switched our supported version of FreeBSD for corral to 13.0. Starting on April 15, 2021, all prebuilt nightly versions of corral will be built on/for FreeBSD 13.0. All future release versions will also be for FreeBSD 13.0. We will continue to do "best effort" to not break corral on previous versions of FreeBSD, but will only be testing on FreeBSD 13.0 going forward.

- @mfelche writes:
The Roaring pony folks did meet again and recorded their session: https://sync-recordings.ponylang.io/roaring-bitmap/2021_04_13.mp4. This time we did some small code cleanup, detected a non-temrinating ponycheck generator and we have been looking at ponybench, the benchmarking library from the pony stdlib.

___

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
