+++
draft = false
author = "seantallen"
description = ""
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - November 13, 2022"
date = "2022-11-20T07:00:06-04:00"
+++

<!--more-->

## Items of Note

### Library Documentation Action Changes

In July of 2022, GitHub announced a beta of [Custom GitHub Actions Workflows](https://github.blog/changelog/2022-07-27-github-pages-custom-github-actions-workflows-beta/). The gist of the announcement is that GitHub pages can now be built directly from GitHub actions rather than via an opaque process that uses a "magic branch" in a repository.

Our [library documentation action](https://github.com/ponylang/library-documentation-action) was built to work with the "magic branch" workflow, but we very much wanted to support the new GitHub actions workflow. There was no way to update the library documentation action to support both workflows without introducing breaking changes that required updates for existing library documentation action users. So, we've introduced a "new library documentation action" called [library documentation action v2](https://github.com/ponylang/library-documentation-action-v2).

Going forward, we plan to deprecate the original library documentation action and eventually only support v2. Sometime after the start of 2023, we will make the original action read-only and stop building new versions of the action that work with the latest ponyc versions.

If you have any questions or concerns, please stop by [the Zulip](https://ponylang.zulipchat.com/) and let's chat.

### Improved Ponylang Libraries Documentation Sites

All the various Ponylang organization libraries have had their documentation rebuilt using the mkdocs-material-insiders theme. As we detailed [last week](https://www.ponylang.io/blog/2022/11/last-week-in-pony---november-13-2022/#stdlib-ponylang-io-improved), the theme greatly improves the search experience. Two weeks ago we rolled out the changes for the [standard library documentation site](https://stdlib.ponylang.org); this past week, we rolled it out across all our library sites.

Note, in order to see the improvements, you might have to clear cached content for the documentation site.

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2022_11_15.m4a) from the November 15th, 2022 sync is available.

We addressed a number of RFCS, issues, and PRs during the 1 hour of the sync call. A good amount of time went to Sean and Joe live triaging of [ponyc issue #4240](https://github.com/ponylang/ponyc/issues/4240) which is now ready for work.

For the most part, it was a fairly straightforward sync call modulo the live triaging which only happens ever so often.

If you are interested in attending a Pony Development Sync, please do! We have it on Zoom specifically because Zoom is the friendliest platform that allows folks without an explicit invitation to join. Every week, [a development sync reminder](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/Sync.20Reminder) with full information about the sync is posted to the [announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) on the Ponylang Zulip. You can stay up-to-date with the sync schedule by subscribing to the [sync calendar](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics). We do our best to keep the calendar correctly updated.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Lately, the meetings have been based around the work on getting a Postgres driver working and the corresponding work on Lori. Other office hours topics have been "open support time" where more experienced community member help others diagnose bugs or otherwise, get unstuck with the Pony projects they are working. And sometimes, it is just a gab fest. And sometimes, no one shows up!

<< content here >>

All-in-all, it was a rousing office hours. Perhaps we will see you at the next one! Interested in giving attending a go? There's a [topic for that](https://ponylang.zulipchat.com/#narrow/stream/189934-general/topic/Office.20hours) in the Zulip.

## Releases

- Ponyc 0.52.1. See [the release notes](https://github.com/ponylang/ponyc/releases/tag/0.52.1) for more details.

## Highlighted Issues

Pony is a volunteer driven project. Nothing gets down without someone volunteering their time and helping to push things forward. Yes, there are folks who dedicate more time than others and a core team that dedicates time specifically for guiding Pony's development. Everyone's time is limited, so each week, we highlight a couple of issues that we hope will inspire someone to volunteer their time to help fix.

In addition to our highlighted issues, you can find more that we are looking for assistance on by visiting just about any [repository in the ponylang org](https://github.com/ponylang/) and looking for issues labeled with "help wanted"

If you are interested in working on either issue or any other issue from a Ponylang repository, you can get in touch on the issue in question or, even better, join us on the [Ponylang Zulip](https://ponylang.zulipchat.com/) to strike up a conversation.

This week's issues as selected by Ryan A. Hagenson are:

### fu

<< content here >>

### bar

<< content here >>

## RFCs

Major changes in Pony go through a community driven process where members of the community can write up "requests for change" that detail what they think should be changed and why. RFCs can range from simple to complex. We welcome your participation.

Two RFCs saw activity this week. The "term erase codes" RFC was voted on and accepted. A [PR](https://github.com/ponylang/ponyc/pull/4246) has already been opened that implements the RFC. The "empty ranges" RFC was moved from "final comment period" to "ready for vote". There's been a great deal of discussion on "empty ranges". It was decided to not expand the scope of the RFC and instead to vote on the RFC as written. Please see the RFC PR for additional details.

### Ready for Vote

RFCs that are are still accepting comments but we plan to vote on their acceptance at the next sync meeting.

- [Introduce Empty Ranges](https://github.com/ponylang/rfcs/pull/201)

### Accepted RFCs

RFCs that have been accepted and can be now be implemented.

- [Inclusion of all erase codes in the Term package](https://github.com/ponylang/rfcs/pull/203)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
