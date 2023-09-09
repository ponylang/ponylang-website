+++
draft = false
author = "seantallen"
description = ""
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - September 10, 2023"
date = "2023-09-10T07:00:06-04:00"
+++

## Items of Note

### Office Hours is Going to be Moving

Sean just started a new job and he has a fairly regular, recurring meeting that conflicts with Office Hours. This past week, we moved Office Hours back by one hour. We haven't settled on a final "new time" for Office Hours. You are welcome to contribute to the discussion of what days/times are best for you [in the Zulip](https://ponylang.zulipchat.com/#narrow/stream/189934-general/topic/Office.20hours.20-.20need.20to.20change.20the.20time).

### Going beyond JavaScript and Actor-Based Programming

Victor Morrow shared an interview with Douglas Crockford (of "JavaScript: The Good Parts" fame) in the Zulip this week.

Victor summarized the interview as:

> (Crockford) talking about the need for replacement of JavaScript with an actor based programming solution. He did not seem to be aware of Pony in the talk but suggesting that there should be a language with the properties of Pony

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_09_05.m4a) from the September 5th, 2023 sync is available.

The primary topic of this week's sync was the Windows TCP test flakiness that Sean spent several days tracking down. Knowing that he was going to be starting a new job on the 5th and wouldn't have time to address any hard Pony issues for a while, he dug in and figured out the source of our Windows TCP test flakiness that was only showing up in GitHub Actions. Curious? Good. Now, go listen to the recording.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

Sadly there was no Office Hours this week. There was going to be, but then Sean lost power and... no Office Hours.

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week we are going to look at one of the Pony Patterns: [Testing Output Only Actors](https://patterns.ponylang.io/testing/output-only-actors)!

Many actors will produce output that is meant to leave the system, but how do we test these actors? In Pony we can use a combination of factors built right into the language to ensure proper testing. The factors of importance here are: 1. [Pony promises](https://stdlib.ponylang.io/promises--index/), 2. Stub objects, and 3. [causal messaging](https://www.ponylang.io/faq/#causal-messaging).

The moving parts for this pattern are difficult to summarize any clearer than the Patterns entry itself so I will leave you with the brief advice that if you have an actor that implements the `OutStream` interface then it is worth looking at this pattern! And if you don't yet have such an actor, look anyway!

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
