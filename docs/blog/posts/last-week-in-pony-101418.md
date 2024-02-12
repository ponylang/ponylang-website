---
draft: false
authors:
  - jdhorwitz
description: "Last week's Pony news, reported this week."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - October 14, 2018"
date: 2018-10-14T18:25:00-04:00
---
_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!-- more -->

## Items of note

- Pony is now a member project of [Open Collective](https://opencollective.com). Interested in helping us pay for hosting and other bills? We'd certainly love you for it. [Become a contributor today](https://opencollective.com/ponyc).

We've been quite pleased with the response. Thank you everyone. @jemc and @SeanTAllen have already started work on putting your donations to use in the form of a Pony library and documentation repository that will live at `main.actor` (nothing there yet). Thank you to all our contributors so far. And thank you to everyone who sees this and signs up to help Pony. Y'all rock.

## News and Blog Posts

- Pony 0.25.0 has been released. 0.25.0 contains a couple of high priority bug fixes. Upgrading as soon as possible is recommended.

- The most notable inclusion in this release is partial integer math. What's that? Well, there has been a bit of hubbub about integer division in Pony being total and that division by zero results in a zero. This offends a lot of people's sensibilities. We've always intended to address this via the inclusion of partial integer math operators. What are these? They look like `/?` instead of `/` for division. `*?` instead of `*` for multiplication. And so on and so forth.

 What is partial math? Well, there are a few key points.

    1. for division by zero, you get an error.
    2. you also get an error if your integer value overflow or underflow the max or min value for you datatype.
    3. because of these checks, they are slower than their corresponding total versions like `+`, `-`.

You can learn more about the new arithmetic operators in [the tutorial](https://tutorial.ponylang.io/expressions/arithmetic.html). And in the meantime, learn about everything that is in this release by checking out [the release notes](https://www.ponylang.io/blog/2018/10/0.25.0-released/).

- Are you interested in what is coming next with Pony? One of the big changes is how we work with LLVM. Since LLVM 3.9.1, there have been bugs in LLVM that make us continue to recommend 3.9.1 for use with Pony.  Let's hear more from core member Sean T. Allen about this exciting change!

> [Wink Saville](https://github.com/winksaville) has been hard at work making it so we can have our own patched version of LLVM that we can build Pony with that addresses these issues. It will also allow us to advance Pony on our schedule rather than LLVM's. It's a big win. Wink has been hard at work on this for a long time and deserves a huge round of applause for all his work. It's not the most thankful work and has no immediate feedback rewards as it has taken a long time to work out all the issues but, it should be merged soon.
>
> This is going to be a big moment for us and Wink did all the heavy lifting to get us there. I personally think everyone in the Pony community should reach out to Wink and personally thank him. He deserves all of our thanks.
>
> The PR to be merged is [here](https://github.com/ponylang/ponyc/pull/2748). There's also a couple PRs prior to that were fits and starts before Wink and all the Pony committers could agree on the right approach. So again, from everyone on the Pony core team. Thank you. Thank you very much. You are awesome.
>
> Getting this merged is very timely as `ponyc` is the last homebrew formula using LLVM 3.9.1 and they will be removing that LLVM formula when the next LLVM release comes out. That would mean, no more easy `brew install ponyc` for Mac users. Definitely something we want to avoid.

## RFCs

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
