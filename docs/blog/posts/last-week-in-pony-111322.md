---
draft: false
authors:
  - seantallen
description: "Windows! Documentation generation! Love and Happiness!"
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - November 13, 2022"
date: 2022-11-13T07:00:06-04:00
---

The story of the last week in Pony? Well, I guess you could say it was a story of documentation generation and a story of Windows and a story of DNS. There's a new Pony compiler version running free on the streets and some [Al Green music](https://www.youtube.com/watch?v=rqqAnjY2Rmo) in the sheets.

<!-- more -->

## Items of Note

### stdlib.ponylang.io Improved

The [standard library documentation site](https://stdlib.ponylang.io) has been updated to use the `mkdocs-material` theme. In particular, the same [insiders build](https://squidfunk.github.io/mkdocs-material/insiders/) that we use for the [Pony Tutorial](https://tutorial.ponylang.io/) and [Pony Patterns](https://patterns.ponylang.io/) websites.

You should find the search experience to be greatly improved on the standard library documentation site as the insiders build contains [numerous search improvements](https://squidfunk.github.io/mkdocs-material/blog/2021/09/13/search-better-faster-smaller/).

### We've "broken" Documentation Generation

The Ponyc 0.52.0 release "broke" documentation generation. Everything continues to work fine, but, where you previously needed to have the mkdocs `mkdocs-ponylang` theme, you'll now need to have the `mkdocs-material` theme.

See the [0.52.0 release notes](https://github.com/ponylang/ponyc/releases/tag/0.52.0) for more details as to why the change was made. We wanted to make sure that no one missed that the change was made. Please note, that the [library-documentation-action](https://github.com/ponylang/library-documentation-action) has been updated accordingly, so if you are using it, there's nothing you'll have to do.

### Windows Stress Tests Added

Every night, we run a stress test of the Pony runtime on various "officially supported platforms". The stress test is designed to heavily exercise the runtime and expose bugs. In the past, the stress tests have exposed an incorrect usage of atomics on aarch64 that was subsequently fixed.

This week, we added stress tests that run on X86-64 Windows. This is the first time we've run stress tests on Windows. Given that Windows has (as far as we are aware) never been used extensively as a production platform, we wouldn't be surprised if the stress tests start exposing issues to be addressed.

Keep an eye on future Last Week in Pony issues to see if anything is discovered.

### Help Adding Additional Stress Tests Is Sought

We are looking to add additional stress tests. Our existing stress test is to run the [message-ubench](https://github.com/ponylang/ponyc/tree/main/examples/message-ubench) for an extended period of time. Ubench has been instrumental over the years in helping us find a variety of runtime issues, but it has its limits. We are looking to add additional stress tests and we are asking for assistance in the writing of those tests. If you are interested in helping, please contact Sean T. Allen on Zulip.

There was some initial conversation in the ["gc stress test"](https://ponylang.zulipchat.com/#narrow/stream/190359-ci/topic/GC.20stress.20test) topic on Zulip that can you give an idea of what sort of things we are looking to do.

### Windows Documentation Building Fixed

You know a good way to know a feature isn't being used "in the community"? When a core team member discovers the feature has been broken for "a long time".

And so it was this past week that Matthias discovered that the "docgen" compiler feature was broken on Windows. Documentation generation on Windows has since been fixed, but could still be broken in the future.

We need to add testing as part of our CI process that documentation generation is "working correctly", where "working correctly" means "creates some output". If you are interested in getting started with helping with Pony, this would a good way to get your feet wet with the build and CI systems. Talk to Sean T. Allen in Zulip if you'd like to assist.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Lately, the meetings have been based around the work on getting a Postgres driver working and the corresponding work on Lori. Other office hours topics have been "open support time" where more experienced community member help others diagnose bugs or otherwise, get unstuck with the Pony projects they are working. And sometimes, it is just a gab fest. And sometimes, no one shows up!

This week, many folks showed up. Regular attendee Adrian Boyko was in attendance along with Red Davies, Ryan Hagenson, and Sean T. Allen.

The call started with a followup discussion to Adrian's Zulip question [Can I call a trait's default function implementation from my class's?](https://ponylang.zulipchat.com/#narrow/stream/189985-beginner-help/topic/Can.20I.20call.20a.20trait's.20default.20function.20imp.20.20from.20my.20class's.3F). Sean went through a couple different approaches to the issue with Adrian that were in line with what he was already thinking about. They covered the [Pony Mixin Pattern](https://patterns.ponylang.io/code-sharing/mixin.html) and discussed the differences between traits and mixins as seen in the paper [Traits: Composable Units of Behaviour](https://www.researchgate.net/publication/221496370_Traits_Composable_Units_of_Behaviour).

The second half of the call covered what is and isn't covered by casual messaging. At one point Adrian remarked "that's pretty limited", which was true. Casual messaging guarantees only hold between two points in space. That is we can make guarantees about the order that messages from actor A will arrive at actor B but not about the order that messages with arrive from A and B at a third actor C.

Sean then covered how you can still leverage casual messaging to do powerful things by giving a simplified example of the message watermarking system that was built in [Wallaroo](https://github.com/seantallen/wallaroo).

Somewhere along the line, a discussion also arose of messaging guarantees in Erlang and how select receive makes most guarantees meaningless given that programmers can easily violate them.

All-in-all, it was a rousing office hours. Perhaps we will see you at the next one! Interested in giving attending a go? There's a [topic for that](https://ponylang.zulipchat.com/#narrow/stream/189934-general/topic/Office.20hours) in the Zulip.

### Pony Development Sync

There was no Pony Development Sync this week. Joe was the only person in attendance and called it off. We'd love to see more folks interested in learning more about the development of Pony. Please, join us! See below for information on how to attend.

If you are interested in attending a Pony Development Sync, please do! We have it on Zoom specifically because Zoom is the friendliest platform that allows folks without an explicit invitation to join. Every week, [a development sync reminder](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/Sync.20Reminder) with full information about the sync is posted to the [announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) on the Ponylang Zulip. You can stay up-to-date with the sync schedule by subscribing to the [sync calendar](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics). We do our best to keep the calendar correctly updated.

## Releases

- Ponyc 0.52.0. See [the release notes](https://github.com/ponylang/ponyc/releases/tag/0.52.0) for more details.

## Highlighted Issues

Pony is a volunteer driven project. Nothing gets down without someone volunteering their time and helping to push things forward. Yes, there are folks who dedicate more time than others and a core team that dedicates time specifically for guiding Pony's development. Everyone's time is limited, so each week, we highlight a couple of issues that we hope will inspire someone to volunteer their time to help fix.

In addition to our highlighted issues, you can find more that we are looking for assistance on by visiting just about any [repository in the ponylang org](https://github.com/ponylang/) and looking for issues labeled with "help wanted"

If you are interested in working on either issue or any other issue from a Ponylang repository, you can get in touch on the issue in question or, even better, join us on the [Ponylang Zulip](https://ponylang.zulipchat.com/) to strike up a conversation.

This week's issues as selected by Ryan A. Hagenson are:

### Create test suite for testing Pony programs in their process environment

As part of the Pony automated testing, it would be useful to how Pony interacts with its environment at this could have found some issues sooner. Building a test suite for this environmental interaction is a great place for someone to jump into contributing to Pony!

[Ponyc issue #3128](https://github.com/ponylang/ponyc/issues/3128)

### Clarify a couple intro points

There is no better issue to jump in on than one that is literally: we need someone new to learn Pony and tell us how the first page of the Tutorial can be improved! Pony exists within a subset of ideas that make the first page of the Tutorial a bit tricky to get right. Not only would we want someone new to learn Pony for this issue, but we would need them to consider the broader learning community. What might the typical "new Pony learner" know or not know so where the landing page as it is today leads them to draw incorrect conclusions about Pony itself?

[Pony tutorial issue #348](https://github.com/ponylang/pony-tutorial/issues/348)

## RFCs

Major changes in Pony go through a community driven process where members of the community can write up "requests for change" that detail what they think should be changed and why. RFCs can range from simple to complex. We welcome your participation.

### Final Comment Period

RFCs that are in a final comment period before they are either accepted or rejected.

- [Inclusion of all erase codes in the Term package](https://github.com/ponylang/rfcs/pull/203)
- [Introduce Empty Ranges](https://github.com/ponylang/rfcs/pull/201)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
