+++
draft = false
author = "seantallen"
description = "<< content >>"
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony April 23, 2023"
date = "2023-04-23T07:00:06-04:00"
+++

<< content >>

<!-- more -->

## Items of Note

### Pony Development Sync

There's no audio for the Pony development sync from this past week. The agenda was empty when it was generated 30 minutes before the meeting. However, an issue [#4343](https://github.com/ponylang/ponyc/issues/4343) came in just before the start of the meeting, so Sean triaged/debugged the issue for the hour of the sync call occasionally sharing information with and answering questions from the other attendees: Adrian, Alan, and Red.

A recording could have been made but for the most part it wouldn't have made for thrilling watching. Most of the time was Sean mumbling to himself and sometimes making statements about what he was seeing.

If this sort of thing interests you, please feel free to attend a Pony Development Sync. We have it on Zoom specifically because Zoom is the friendliest platform that allows folks without an explicit invitation to join. Every week, [a development sync reminder](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/Sync.20Reminder) with full information about the sync is posted to the [announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) on the Ponylang Zulip. You can stay up-to-date with the sync schedule by subscribing to the [sync calendar](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics). We do our best to keep the calendar correctly updated.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

Office Hours this past week was Sean, Alan, and Red. The time was divided between Sean looking at [ponyc issue #4345](https://github.com/ponylang/ponyc/issues/4345) while Alan and Red looked on and Sean explaining parts about how the pony compiler works to Red and Alan.

Particular attention was paid to the "treecheck" feature for the AST and the [treecheck rule definitions](https://github.com/ponylang/ponyc/blob/main/src/libponyc/ast/treecheckdef.h).

A number of related topics were covered as Red learned more about the compiler including the concept that "the AST" is not a mutable thing, but rather a "living data structure" that is updated and changed by [various compiler passes](https://github.com/ponylang/ponyc/blob/main/src/libponyc/pass/pass.h).

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Releases

- [ponylang/release-notes-bot-action 0.3.7](https://github.com/ponylang/release-notes-bot-action/releases/tag/0.3.7)
- [redvers/pony-email](https://github.com/redvers/pony-email/releases/tag/0.0.11)
- [redvers/pony-smtp](https://github.com/redvers/pony-smtp/releases/tag/0.0.3)

The new packages pony-email and pony-smtp allow you to generate EMails and send them via an SMTP relay server. The former constructs multipart MIME EMails in mailbox format so they can be dispatched by the latter. They are very much alpha quality and the author would very much appreciate feedback on the API. The Author is using it in production, but you probably shouldn't (yet).

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

<< content >>

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!