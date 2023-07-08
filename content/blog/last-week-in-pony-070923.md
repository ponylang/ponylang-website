+++
draft = false
author = "seantallen"
description = "A short holiday week."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony July 2, 2023"
date = "2023-07-09T07:00:06-04:00"
+++

Not a ton of activity this week in part because it was a long holiday weekend here in the US.

## Items of Note

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

<< content >>

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week we are looking into the [Gotchas](https://tutorial.ponylang.io/gotchas/) section of the Pony Tutorial to cover [Scheduling](https://tutorial.ponylang.io/gotchas/scheduling.html)!

It is not uncommon for a new Pony user to end up creating a long-running behavior which then hogs a scheduler thread. This is because the scheduler will not yield control until a behavior is done. If you have multiple such patterns in your program, you can end up in a situation where the entire program is now made up of thread hogs. The solution is to break this behavior into smaller pieces, perhaps by using the [Timer]([scheduler](https://stdlib.ponylang.io/time-Timer/)) class as the Tutorial suggests, or by re-engineering the program to following something like the [yield](https://github.com/ponylang/ponyc/tree/44b777d37690dba225a286accff2f34952335d99/examples/yield) example.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
