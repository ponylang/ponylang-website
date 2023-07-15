+++
draft = false
author = "seantallen"
description = "A quiet week."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony July 16, 2023"
date = "2023-07-16T07:00:06-04:00"
+++

## Items of Note

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

<< content >>

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week, we draw your addition to the Virtual Users Group (VUG). All the VUG videos are recorded and available on the [Ponylang Vimeo](https://vimeo.com/ponylang) page. Let us look at the [first VUG](https://vimeo.com/163871856), wherein Sylvan discusses Pony generics.

Pony generics are more difficult because of the need to track reference capabilities. Some of the concepts that we must address are:

- receiver capabilities (i.e., `this` representing the receiver)
- viewpoint adaptation (i.e. `this->T` of how `this` views some generic `T`)
- collections of reference capabilities (e.g., `#read` which represents all the readable reference capabilities)
- alias types (i.e., `T!` which is an alias of some generic `T`)
- ephemeral types (i.e., `T^` which is some generic `T` without an alias)

Sylvan discusses these concepts by using the `Array` class as a working example. This is a highly recommended video for those learning to write Pony generics!

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
