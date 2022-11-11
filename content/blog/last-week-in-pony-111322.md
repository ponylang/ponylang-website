+++
draft = false
author = "seantallen"
description = "Windows! Documentation generation! Love and Happiness!"
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - November 13, 2022"
date = "2022-11-13T07:00:06-04:00"
+++

The story of the last week in Pony? Well, I guess you could say it was a story of documentation generation and a story of Windows and a story of DNS. There's a new Pony compiler version running free on the streets and some [Al Green music](https://www.youtube.com/watch?v=rqqAnjY2Rmo) in the sheets.

<!--more-->

## Items of Note

### We've "broken" Documentation Generation

The Ponyc 0.52.0 release "broke" documentation generation. Everything continues to work fine, but, where you previously needed to have the mkdocs `mkdocs-ponylang` theme, you'll now need to have the `mkdocs-material` theme.

See the [0.52.0 release notes](https://github.com/ponylang/ponyc/releases/tag/0.52.0) for more details as to why the change was made. We wanted to make sure that no one missed that the change was made. Please note, that the [library-documentation-action](https://github.com/ponylang/library-documentation-action) has been updated accordingly, so if you are using it, there's nothing you'll have to do.

### "Old" Standard Library Site Is No More

So, as some of you might know. Years ago, we used the domain "ponylang.org". That domain was registered in the personal account of someone no longer affiliated with the project and, we lost access to it. The domain was sadly, never transferred to the folks who are still maintaining Pony. Quite some time ago, we switched to using "ponylang.io" and all our official links use that domain. However, there are still some "ponylang.org" links floating around out there.

As of the Ponyc 0.52.0, we have switched where we host our standard library documentation site stdlib.ponylang.io. With this switch, if you were accessing the site via ponylang.org, that will stop working. At first, it will merely be stale and a while after that, it will have no content at all.

In case you are wondering, years ago, we stopped doing anything "Pony important" in individual accounts and have a shared 1Password account for the core team. Thanks 1Password for the free team account!

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

Interested in giving attending a go? There's a [topic for that](https://ponylang.zulipchat.com/#narrow/stream/189934-general/topic/Office.20hours) in the Zulip.

### Pony Development Sync

There was no Pony Development Sync this week. Joe was the only person in attendance and called it off. We'd love to see more folks interested in learning more about the development of Pony. Please, join us! See below for information on how to attend.

If you are interested in attending a Pony Development Sync, please do! We have it on Zoom specifically because Zoom is the friendliest platform that allows folks without an explicit invitation to join. Every week, [a development sync reminder](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/Sync.20Reminder) with full information about the sync is posted to the [announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) on the Ponylang Zulip. You can stay up-to-date with the sync schedule by subscribing to the [sync calendar](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics). We do our best to keep the calendar correctly updated.

## Releases

- Ponyc 0.52.0. See [the release notes](https://github.com/ponylang/ponyc/releases/tag/0.52.0) for more details.

## Highlighted Issues

Pony is a volunteer driven project. Nothing gets down without someone volunteering their time and helping to push things forward. Yes, there are folks who dedicate more time than others and a core team that dedicates time specifically for guiding Pony's development. Everyone's time is limited, so each week, we highlight a couple of issues that we hope will inspire someone to volunteer their time to help fix.

In addition to our highlighted issues, you can find more that we are looking for assistance on by visiting just about any [repository in the ponylang org](https://github.com/ponylang/) and looking for issues labeled with "help wanted"
This week's issues as selected by Ryan A. Hagenson are:

### foo

description

### bar

description

If you are interested in working on either issue or any other issue from a Ponylang repository, you can get in touch on the issue in question or even better, join us on the [Ponylang Zulip](https://ponylang.zulipchat.com/) strike up a conversation.

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
