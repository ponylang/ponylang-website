---
authors:
  - seantallen
categories:
- Last Week in Pony
date: 2017-06-03T10:07:42-04:00
description: Last week's Pony news, reported this week.
draft: false
title: Last Week in Pony - June 4, 2017
---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!-- more -->

## Items of note

- Audio from the [May 31st Pony Development Sync](https://vimeo.com/915142584) is available for your listening pleasure. Unlike the previous week where we mostly stuck to one subject, we were back to our more usual freewheeling style. If variety is your bag, you'll enjoy this sync call.

## News and Blog Posts

- Patiency Shyu was introduced to Pony during a recent summer school experience and wrote up some of her initial impressions "What I Learned at Summer School". Sadly the link has been broken over time and we updated this to let you know that the post is gone.

## RFCs

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!

### New RFCs

- I introduced a new RFC titled ["Send arbitrary messages to notify classes"](https://github.com/ponylang/rfcs/pull/91) that attempts to address a current shortcoming in several standard library classes. It's not a great long term solution but provides a nice, non-breaking stopgap. From the summary: "Update existing standard library classes that have "notify" classes that allow for programmer specialization, for example, `TCPConnnection` with its `TCPConnectionNotify` class, to allow to arbitrary messages and data to be sent to the notify class."
