---
draft: false
authors:
  - seantallen
description: "All the news that blew in on the wayward wind this week."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - November 20, 2022"
date: 2022-11-20T07:00:06-04:00
---

There's a lot going on in Ponyland. Ok, not as much as say, the world of cryptocurrencies. (Man, they are **really** cooking with gas!) But hey, there's still a lot going on, especially given the size of the community. Here's your update on all the various things from this last week.

We strongly suggest that you settle in because there's a lot to catch up on from this past week, so, how about you put on [Patsy Cline's Showcase](https://www.youtube.com/watch?v=9loTXznGJy4&list=PLVnkoLiLMTm4o55C42Y7Axl4oQjIU7cyf) and get reading!

<!-- more -->

## Items of Note

### A Most Excellent Causal Messaging Conversation

In response to Sean's "quick and dirty" [write-up of the November 11th office hours](https://www.ponylang.io/blog/2022/11/last-week-in-pony---november-13-2022/#office-hours), Adrian Boyko started a conversation in Zulip about [causal messaging](https://ponylang.zulipchat.com/#narrow/stream/189934-general/topic/Causal.20Messaging/near/309479310).

The conversation ended up going very deep into runtime implementation and general theory around causal messaging. A key takeaway was that defining our terms very clearly is an important part of correctly conveying what Pony's causal messaging does and does not guarantee.

We believe that it's a very important conversation and one that many programmers can learn a lot from. We strongly suggest you check it out. In another topic, Derrick Turk [highlighted how the conversation had helped him](https://ponylang.zulipchat.com/#narrow/stream/189934-general/topic/Segfault.20during.20program.20end.28.3F.29/near/310966763) understand a logic bug in a program of his.

### Library Documentation Action Changes

In July of 2022, GitHub announced a beta of [Custom GitHub Actions Workflows](https://github.blog/changelog/2022-07-27-github-pages-custom-github-actions-workflows-beta/). The gist of the announcement is that GitHub pages can now be built directly from GitHub Actions rather than via an opaque process that uses a "magic branch" in a repository.

Our [library documentation action](https://github.com/ponylang/library-documentation-action) was built to work with the "magic branch" workflow, but we very much wanted to support the new GitHub Actions workflow. There was no way to update the library documentation action to support both workflows without introducing breaking changes that required updates for existing library documentation action users. So, we've introduced a "new library documentation action" called [library documentation action v2](https://github.com/ponylang/library-documentation-action-v2).

Going forward, we plan to deprecate the original library documentation action and eventually only support v2. Sometime after the start of 2023, we will make the original action read-only and stop building new versions of the action that work with the latest `ponyc` version.

If you have any questions or concerns, please stop by [the Zulip](https://ponylang.zulipchat.com/) and let's chat.

### Improved Ponylang Libraries Documentation Sites

All the various Ponylang organization libraries have had their documentation rebuilt using the mkdocs-material-insiders theme. As we detailed [last week](https://www.ponylang.io/blog/2022/11/last-week-in-pony---november-13-2022/#stdlib-ponylang-io-improved), the theme greatly improves the search experience. Two weeks ago we rolled out the changes for the [standard library documentation site](https://stdlib.ponylang.org); this past week, we rolled it out across all our library sites.

Note, in order to see the improvements, you might have to clear cached content for the documentation site.

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2022_11_15.m4a) from the November 15th, 2022 sync is available.

We addressed a number of RFCS, issues, and PRs during the one hour of the sync call. A good amount of time went to Sean and Joe live triaging [ponyc issue #4240](https://github.com/ponylang/ponyc/issues/4240), which is now ready for work.

For the most part, it was a fairly straightforward sync call modulo the live triaging which only happens every so often.

If you are interested in attending a Pony Development Sync, please do! We have it on Zoom specifically because Zoom is the friendliest platform that allows folks without an explicit invitation to join. Every week, [a development sync reminder](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/Sync.20Reminder) with full information about the sync is posted to the [announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) on the Ponylang Zulip. You can stay up-to-date with the sync schedule by subscribing to the [sync calendar](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics). We do our best to keep the calendar correctly updated.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Lately, the meetings have been based around the work on getting a Postgres driver working and the corresponding work on Lori. Other office hours topics have been "open support time" where more experienced community member help others diagnose bugs or otherwise, get unstuck with the Pony projects they are working. And sometimes, it is just a gab fest. And sometimes, no one shows up!

This week's office hours as a great one. Sean T. Allen, Red Davies, and Adrian Boyko covered a massive amount of ground.

At the time that office hours started, Sean was working on [ponyc issue #4193](https://github.com/ponylang/ponyc/issues/4193). Issue #4193 is a two part issue. The first part is the segfault. The segfault is fixed by [ponyc PR #4251](https://github.com/ponylang/ponyc/pull/4251). The second part of #4193 is the reported "early termination". Roughly what was going on is that Derrick was expected one of two outputs when the program ran, but it was often "terminating early" by which Derrick meant that the program ended without printing either of his expected results.

Upon joining, Red Davies started taking a look along with Sean. Red quickly suggested a very common "let's see what's going on technique" with "misbehaving" Pony programs: run it with one thread and see if it is different than running with more than one. Why is this a common technique? Because, there's a deterministic order for many Pony programs when they are run with a single thread. AND almost as importantly, because of the implementation of the runtime's scheduling, that order will match most people's mental models of what a program will do if they are "applying sequential thinking" to the program. That is, they are thinking about the program's execution order in a sequential, serial order that one would see from a language like Python that is built around a single thread model.

As [noted on #4193](https://github.com/ponylang/ponyc/issues/4193#issuecomment-1320474536), it was discovered that running with only a single thread always resulted in the expected results, but running with more than one, resulted in it occasionally working as expected and usually resulted in "early termination". After spending a few more minutes looking at the issue, we put it aside and moved on to discussing [PR #4251](https://github.com/ponylang/ponyc/pull/4251) and the various "cycle detector race conditions" that it fixes. Later in the evening, Sean returned to #4193 and figured out the logical flaw in the program. If you are interested in learning more about that, you can check out [the explanatory comment](https://github.com/ponylang/ponyc/issues/4193#issuecomment-1320793266).

The last hour and forty-five minutes of office hours involved a discussion of various topics related to [#4251](https://github.com/ponylang/ponyc/pull/4251). Sean walked Red and Adrian through each of the race conditions that were fixed, starting with the existing pre-fix code and help them identify each of the race conditions, discussed the history of how the race condition came about, and walked through each of the fixes that are in #4251. I (Sean) think that Adrian and Red learned a ton in the process, but I don't want to speak for them. I can, however, say that we covered a ton of information and it was probably a bit of a mind melting experience.

A decent portion of the time was spent on discussing the rather simplistic but fairly easy to understand earliest versions of the cycle detector, why it was created, and why it had performance bottlenecks. We walked through changes to the cycle detector over time and how those changes (and related changes) improved performance of Pony programs but in the process made the cycle detector and its interactions with individual actors even harder to understand. We brought everything back around to [#4251](https://github.com/ponylang/ponyc/pull/4251) by discussing how the current race conditions that it fixes were introduced because of the considerably increased complexity from early versions of the cycle detector. Sean noted that he thought the increased complexity was worth it for the performance gains but that it was now "relatively easy" for even highly knowledgeable people such as himself, Sylvan Clebsch, and Dipin Hora to have all written/reviewed the changes that introduced the race conditions (in [Pony 0.38.0](https://github.com/ponylang/ponyc/releases/tag/0.38.0)).

We also ended up talking about [ponyc issue #1118](https://github.com/ponylang/ponyc/issues/1118) and the forthcoming fix that Sean has been working on in consultation with Joe McIlvain. We covered the [ORCA protocol](https://www.ponylang.io/media/papers/OGC.pdf) at a high-level and Sean took Red through its basics. If you are interested in getting a high-level overview of ORCA without joining an office hours, we recommend you check out Andrew Turley's Pony VUG #6 presentation [The Art of Forgetting - Garbage Collection in Pony](https://vimeo.com/181099993).

All-in-all, it was one of the best office hours in recent memory. Perhaps we will see you at the next one! Interested in giving attending a go? There's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

### Office Hours Calendar

We've added a [calendar for office hours](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to make it easier for everyone to keep track of the schedule.

## Releases

- Ponyc 0.52.1. See [the release notes](https://github.com/ponylang/ponyc/releases/tag/0.52.1) for more details.

## Highlighted Issues

Pony is a volunteer driven project. Nothing gets down without someone volunteering their time and helping to push things forward. Yes, there are folks who dedicate more time than others and a core team that dedicates time specifically for guiding Pony's development. Everyone's time is limited, so each week, we highlight a couple of issues that we hope will inspire someone to volunteer their time to help fix.

In addition to our highlighted issues, you can find more that we are looking for assistance on by visiting just about any [repository in the ponylang org](https://github.com/ponylang/) and looking for issues labeled with "help wanted"

If you are interested in working on either issue or any other issue from a Ponylang repository, you can get in touch on the issue in question or, even better, join us on the [Ponylang Zulip](https://ponylang.zulipchat.com/) to strike up a conversation.

This week's issues as selected by Ryan A. Hagenson are:

### Partial constructor application ponyc segfault

Our first highlighted issue was part of this week's Pony Development Sync! Someone taking this issue will be continuing what Joe has posted in the issue to "add a special case path for constructors in the part of the compiler that sugars the partial application into a lambda."

[Ponyc issue #4240](https://github.com/ponylang/ponyc/issues/4240)

### Generics and numbers

Generics in Pony are not as ergonomic as we would like; adding a pattern to Pony Patterns showing the way to define a generic function over number types would be immensely helpful. It would be so helpful that we intend to link directly to this Pony Patterns entry from the Ponylang website FAQ page upon completion. Someone taking this issue will be continuing from an example that was posted in Zulip and addressing one of the hurdles of learning Pony for newcomers.

[Pony patterns issue #46](https://github.com/ponylang/pony-patterns/issues/46)

## RFCs

Major changes in Pony go through a community driven process where members of the community can write up "requests for change" that detail what they think should be changed and why. RFCs can range from simple to complex. We welcome your participation.

Two RFCs saw activity this week. The "term erase codes" RFC was voted on, accepted, and implemented. The "empty ranges" RFC was moved from "final comment period" to "ready for vote". There's been a great deal of discussion on "empty ranges". It was decided to not expand the scope of the RFC and instead to vote on the RFC as written. Please see the respective RFC PR for additional details.

### Ready for Vote

RFCs that are are still accepting comments but we plan to vote on their acceptance at the next sync meeting.

- [Introduce Empty Ranges](https://github.com/ponylang/rfcs/pull/201)

### Accepted RFCs

RFCs that have been accepted and can be now be implemented.

- [Inclusion of all erase codes in the Term package](https://github.com/ponylang/rfcs/pull/203)

### Implemented RFCs

RFCs with an implementation now on the main development trunk.

- [Inclusion of all erase codes in the Term package](https://github.com/ponylang/ponyc/pull/4246)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
