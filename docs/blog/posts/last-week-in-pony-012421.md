---
draft: false
authors:
  - theobutler
description: "The Pony community is preparing to support Apple Silicon. Version 0.3.0 of ponylang/flycheck-pony has been released."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - January 24, 2021"
date: 2021-01-24T11:18:38-05:00
---

The Pony community is preparing to support Apple Silicon. Version 0.3.0 of ponylang/flycheck-pony has been released.
<!-- more -->

## Releases

- Version 0.3.0 of ponylang/flycheck-pony has been released. See the [release notes](https://github.com/ponylang/flycheck-pony/releases/tag/0.3.0) for more details.

---

## M1 support

As some of you are aware, Pony currently doesn't have any support for running on Apple Silicon. We have no current CI resources via GitHub or CirrusCI that allow us to provide prebuilt packages for the new ARM based macs. Worse still, the build system currently errors out in places when trying to build from source.

A couple of intrepid Pony users tried to step into the breach to fix the build issues, but they were just starting using Pony and trying to figure out the oddities of arm processor support for `-mnative`, figuring out other issues, and learning cmake is a bit much to try out when you just want to dip your toes into trying a programming language.

We recognize Apple Silicon support is important and will be even more so in the future as Apple drops support for x86 based processors.

Yesterday, two members of the Pony community ordered Mac Minis. With those machines in hand, Joe and Borja will be able to spend what might be a non-trivial amount of time getting us up and running on Apple Silicon and then will have the hardware to be our M1 support team going forward if any macOS or Apple Silicon issues arise.

To pay for the machines, we are spending money from [our collective](https://opencollective.com/ponyc).  Money for the collective comes from donations from members of the community and those who are otherwise interested in putting money towards helping Pony succeed. We don't bring in a ton of money, but over the course of time, it has built up to about $8,000. We've been careful to keep our expense low so that we would have money to use when "we really needed it".

Recently, the core team got together and decided that putting about $1500 towards Apple Silicon was something that "really needed to happen. We'd like to thank each person who has or is still donating money to help support Pony. We couldn't have done this without you. If you are reading this and would like to become a donor, please visit our [open collective page](https://opencollective.com/ponyc). We'd love to get a small monthly stipend from you or a nice one-time donation. The more folks who donate, the more often we'll be able to spend to help support Pony and the larger community.

If you are interested in seeing how collective monies are spent, everything is open and in the clear, you can view all approved expenses [on the open collective website](https://opencollective.com/ponyc/expenses).

Thanks again to all our donors and thanks to Joe and Borja for stepping up to be "the M1 support team". We'll see you "on the M1 side" of things in a while.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
