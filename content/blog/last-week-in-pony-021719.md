+++
draft = false
author = "theobutler"
description = "Last week's Pony news, reported this week."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - February 17, 2019"
date = "2019-02-17T09:19:15-05:00"
+++
_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!--more-->


## Items of note

- Audio for the February 12, 2019 Pony sync is [here](https://sync-recordings.ponylang.io/r/2019_02_12.m4a).

- Interested in helping improve the Pony emacs mode? There's a few ["help wanted" issues open](https://github.com/SeanTAllen/ponylang-mode/issues?q=is%3Aissue+is%3Aopen+label%3A%22help+wanted%22) if you want to dive in.

- LLVM 7.0 support has been [merged to main](https://github.com/ponylang/ponyc/pull/2976). Great work by Joe and Gordon. Everyone should give them a virtual hand.

    Currently, LLVM 3.9.1 is still the recommended LLVM version to use with Pony. LLVM 5 and 6 both had work arounds for bugs and as such were "experimentally supported". However, LLVM 3.9.1 is being deprecated by a lot of distributions. Joe believes he has found the source of the LLVM 5 and 6 issues (which also impact on LLVM 7) and will be testing out a fix soon.


    If that fix appears to work, our plan is as follows:
    * Get some folks to start using LLVM 7.
    * If no one reports any issues with LLVM 7 after some undetermined period of time, make it the recommended default
    * Drop LLVM 3.9.1 support as we only support 3 major LLVM versions at a time.


    If you'd be willing to give LLVM 7 a try, [drop @SeanTAllen a line](mailto:sean@monkeysnatchbanana.com) and he'll let you know when we are ready for testing.

## News and Blog Posts

- If watching someone learn Pony for 4 hours is your thing, we've got the video for you! The core team watched it and learned a lot and in turn made changes to the tutorial: https://www.youtube.com/watch?v=DuZV6pV7aJI

## RFCs

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
