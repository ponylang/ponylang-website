---
draft: false
authors:
  - seantallen
  - ryan
description: "Updates on the 'Great CI Move of 2023'."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony August 13, 2023"
date: 2023-08-13T07:00:06-04:00
---

Updates on the "Great CI Move of 2023".

<!-- more -->

## Items of Note

### Pony Development Sync

[Audio](https://vimeo.com/917348806) from the August 8th, 2023 sync is available.

A large chunk of time during the sync call was spent discussing how we plan on responding to our need to [move our CI jobs off CirrusCI](https://www.ponylang.io/blog/2023/08/last-week-in-pony-august-6-2023/#a-great-and-mighty-ci-move-is-coming). Gordon, Joe, and Sean agreed on a general plan. We'll see how that plan holds up when it meets reality.

### The Great CI Move is Underway

We've started moving our CI jobs from [CirrusCI to GitHub actions](https://www.ponylang.io/blog/2023/08/last-week-in-pony-august-6-2023/#a-great-and-mighty-ci-move-is-coming). We've run into a few issues. At the moment, all our Linux jobs are moved but MacOS and Windows are "being difficult".

We plan on using x86 MacOS CI to verify that we don't break anything until such time as GitHub Actions have Arm MacOS support. Arm MacOS support has been delayed several times and is currently scheduled for Q4.

Our [MacOS x86 fallback](https://github.com/ponylang/ponyc/pull/4390) has run into issues on both Monterey and Ventura. We have a segfault on Ventura that might be impossible to solve given that no one has access to an x86 Ventura MacOS machine. The Monterey issues appear easier to solve and our stop gap until Arm runners are available for MacOS might be x86 on Monterey testing.

Our move of Windows CI ran into a hiccup because, GitHub doesn't support using Windows Containers so we have to get an actual Windows configuration set up rather than simply "run this container on GitHub" that was most of our Linux work. We've run into some odd issues with [Windows PR](https://github.com/ponylang/ponyc/pull/4383) that Gordon is looking into while Sean is going to open an additional PR that tries a slightly different approach.

There's a PR open to [drop FreeBSD as a supported platform](https://github.com/ponylang/ponyc/pull/4382) that should be merged this coming week.

If you'd like to assist with a variety of outstanding CI move tasks, we'd love to have your help. Please stop by the [#ci stream on the Ponylang Zulip](https://ponylang.zulipchat.com/#narrow/stream/190359-ci) to volunteer.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

Office Hours was spent with Dipin, Joe, and Sean discussing and debugging [issue #4369](https://github.com/ponylang/ponyc/issues/4369). The issue is a confounding one that "doesn't really make sense". We either made great progress or none, time will tell. At the moment, the bug is still in a state where there could be wildly differing interpretations of what "the root cause" might be. Aka, lots more investigation is still needed and we are pursuing a number of divergent possibilities.

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week we are looking at [Pony's Open Collective page](https://opencollective.com/ponyc). As with any sizable open source project, Pony has expenses to cover such as hosting for resources like the Pony Playground, Zoom for Pony Sync calls and open office hours, or hardware to test/support more platforms. These expenses and others can all be seen on the Pony Open Collective page. Let's take a brief tour of this resource.

When you first visit the Pony Open Collective page you will see a few tabs of interest, in order: Contribute, Budget, Connect, and About. Contribute will direct you to the various monthly contribution tiers -- at this time $5, $25, and $100/month -- as well as an option for one-time donation. Budget will direct you to a preview of the latest expenses and transactions alongside the current balance and estimated yearly budget. If you want to view all expenses or transactions, one way to do this is to hover over Budget and click either [Transactions](https://opencollective.com/ponyc/transactions) or [Expenses](https://opencollective.com/ponyc/expenses). Both of these pages allow you to filter or search for specific instances or types. On the Expenses page, there is also a short list of commonly applied tags: web services, software, hardware, and communications, clicking any of these will narrow expenses to only those with a particular tag. Back on the main page, Connect and About will both give you information about Pony, news, the team behind the project.

We want to thank all those who contribute to Pony's continued success either with their time or money. It would not be possible for this project to continue without your generous support!

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
