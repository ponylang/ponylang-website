+++
draft = false
author = "seantallen"
description = "We promise there are no April's Fools jokes in this issue."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony April 2, 2023"
date = "2023-04-02T07:00:06-04:00"
+++

There wasn't a ton of "above ground" activity in Pony this week, although Sean and Joe have been working on fixing a couple of compiler bugs. While you wait for a Last Week in Pony that includes news of those bugs being fixed and the ponyc release that includes them, we offer you this smaller Last Week in Pony and suggest you get reading right after you put on some [Aretha](https://www.youtube.com/watch?v=V4cknWqVnVg).

<!-- more -->

## Items of Note

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

Office hours this week covered a few topics but most of the time was Sean, Adrian, Red, and Nicolai working to address two questions that remained unanswered in the [beginner help Zulip stream](https://ponylang.zulipchat.com/#narrow/stream/189985-beginner-help).

Given that we generally don't have a super detailed accounting of Office Hours (unless Adrian Boyko has the time to do an awesome write-up), you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

And if it doesn't sound interesting, you can join and steer the conversation in directions you find interesting, so really, there's no excuse to not attend!

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week we are highlighting the [Pony Tutorial](https://tutorial.ponylang.io/); specifically we are going to look at Pony's nominal versus structural typing!

Pony has two ways of subtyping: [traits and interfaces](https://tutorial.ponylang.io/types/traits-and-interfaces.html), the former is _nominal_ typing, while the latter is _structural_ typing. But what does this mean? Nominal typing via a trait declares the relationship between the concrete class/type and the subtype trait at the definition site -- we **name** the subtype as part of the definition, hence _nominal_ typing. Meanwhile, structural typing via an interface declares what shape a concrete class must take in order to be treated like the subtype in specific instances. The trade off here is that of default methods versus an open world typing. A trait, by being nominal, is declared and therefore picks up on any default methods that are part of the trait (there is a [useful pattern](https://patterns.ponylang.io/code-sharing/mixin.html) that uses default private methods). An interface, by being structural, allows defining only the relevant portions of a type so any number of concrete classes/types can be made compliant.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
