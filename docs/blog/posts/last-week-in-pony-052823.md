---
draft: false
author: "seantallen"
description: "ponyc 0.55.0 has been released."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony May 28, 2023"
date: 2023-05-28T07:00:06-04:00
---

Hey hey hey! It's [Sunday morning](https://www.youtube.com/watch?v=8_xd5jG3JTA) again, so you know what that means, it's time to read about some of what happened last week as it relates to Pony...

<!-- more -->

## Items of Note

### ponyc 0.55.0 has been released

Version 0.55.0 of the Pony compiler was released on Saturday. There's a bug fix for `with` blocks that is also a breaking change as well as a couple changes to supported platforms.

We no longer support Ubuntu 18.04. 18.04 is no longer receiving updates from Canonical and as such starting with 0.55.0, we no longer build `ponyc` releases for it. You can still build from source for it if you want.

Additionally, our supported MacOS platform is now Ventura. All testing is being done on Ventura and all `ponyc` releases are done for Ventura. You can continue to build for Monterey from source.

See the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.55.0) for full details.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

This past week's Office Hours attendees were Sean T. Allen, Adrian Boyko, and Dipin Hora.

Topics of conversation were wide ranging and only somewhat related to Pony. We discussed Sean leaving Microsoft and his currently interviewing at other companies and the fun that is technical interviews.

From there, Sean explained what [mutation testing](https://en.wikipedia.org/wiki/Mutation_testing) is and how it relates to [code coverage](https://en.wikipedia.org/wiki/Code_coverage). Adrian nicely summarized mutation testing as "quality assurance for your quality assurance". Sean asked Adrian and Dipin to think about how they might imagine utilizing mutation testing with Pony as Sean is thinking of "putting mutation testing into the compiler" i.e. allowing for mutation testing of Pony code without needing tools beyond `ponyc`.

After the mutation testing discussion, Adrian asked Sean for his opinions on [D-Bus](https://en.wikipedia.org/wiki/D-Bus) which lead to Sean saying "he didn't have many". We ended up discussing [Bonobo](https://en.wikipedia.org/wiki/Bonobo_(GNOME)) (the [GNOME](https://en.wikipedia.org/wiki/GNOME) predecessor) and [CORBA](https://en.wikipedia.org/wiki/Common_Object_Request_Broker_Architecture) which after a detour through some conversation about [Cap n' Proto](https://capnproto.org/) and other serialization formats lead to a discussion about [Hypermedia](https://en.wikipedia.org/wiki/Hypermedia) and the differences between [RPC](https://en.wikipedia.org/wiki/Remote_procedure_call) and [REST](https://en.wikipedia.org/wiki/Representational_state_transfer).

Sean passed along a couple Hypermedia related links. The first, a link to an [excellent book](https://www.oreilly.com/library/view/building-hypermedia-apis/9781449309497/) by Mike Amundsen that despite using "dated" technologies, does a wonderful job of describing why Hypermedia controls are a great data interchange format. The second link was to [one of Steve Vinoski's excellent talks comparing RPC and Hypermedia](https://www.infoq.com/presentations/vinoski-rpc-convenient-but-flawed/).

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Releases

- [ponylang/ponyc 0.55.0](https://github.com/ponylang/ponyc/releases/tag/0.55.0)

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week we return to the Tutorial in order to discuss one way we can get a concrete type out of an abstract type: the [as operator](https://tutorial.ponylang.io/pattern-matching/as.html).

In Pony, every object has a concrete type, but sometimes it is more appropriate to discuss abstract types. In order to check an abstract type for some concrete type we use the [as operator](https://tutorial.ponylang.io/pattern-matching/as.html). This operator has a few different uses: 1) get a concrete type out of a union of disjoint types (see the `Animal` example), 2) check that a type has additional functionality (see the `Person` example), 3) specify a type in an array literal (see the `Main.foo` example). All of these uses will error if invalid. The first two will `error` at runtime, while the third will fail to type check and therefore compile.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
