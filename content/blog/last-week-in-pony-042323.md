+++
draft = false
author = "seantallen"
description = "Two new Pony libraries join the world."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony April 23, 2023"
date = "2023-04-23T07:00:06-04:00"
+++

Hey there kiddos! Sunday is here again. It's Last Week in Pony time. This week's news is headlined by [3 releases](#releases), so hey, put on that [Hank Thompson music](https://www.youtube.com/watch?v=HSh2XoqeZes) and dig in for a read.

Just remember, 3 times 7 is 21.

## Items of Note

### Email and SMTP packages from Red

Red writes about two libraries he released last week:

I've release two packages [redvers/pony-email](https://github.com/redvers/pony-email) and [redvers/pony-smtp](https://github.com/redvers/pony-smtp) that allow you to generate emails and send them via an SMTP relay server. The former constructs multipart MIME emails in mailbox format so they can be dispatched by the latter. They are very much alpha quality and I would very much appreciate feedback on the API. I'm using it in production, but you probably shouldn't (yet).

### Pony Development Sync

There's no audio for the Pony development sync from this past week. The agenda was empty when it was generated 30 minutes before the meeting. However, an issue [#4343](https://github.com/ponylang/ponyc/issues/4343) came in just before the start of the meeting, so Sean triaged/debugged the issue for the hour of the sync call occasionally sharing information with and answering questions from the other attendees: Adrian, Alan, and Red.

A recording could have been made but for the most part it wouldn't have made for thrilling watching. Most of the time was Sean mumbling to himself and sometimes making statements about what he was seeing.

If this sort of thing interests you, please feel free to attend a Pony Development Sync. We have it on Zoom specifically because Zoom is the friendliest platform that allows folks without an explicit invitation to join. Every week, [a development sync reminder](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/Sync.20Reminder) with full information about the sync is posted to the [announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) on the Ponylang Zulip. You can stay up-to-date with the sync schedule by subscribing to the [sync calendar](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics). We do our best to keep the calendar correctly updated.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

Office Hours this past week was Sean, Alan, and Red. The time was divided between Sean looking at [ponyc issue #4345](https://github.com/ponylang/ponyc/issues/4345) while Alan and Red looked on and Sean explaining parts about how the pony compiler works to Red and Alan.

Particular attention was paid to the "treecheck" feature for the AST and the [treecheck rule definitions](https://github.com/ponylang/ponyc/blob/main/src/libponyc/ast/treecheckdef.h).

A number of related topics were covered as Red learned more about the compiler including the concept that "the AST" is not an immutable thing, but rather a "living data structure" that is updated and changed by [various compiler passes](https://github.com/ponylang/ponyc/blob/main/src/libponyc/pass/pass.h).

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Releases

- [ponylang/release-notes-bot-action 0.3.7](https://github.com/ponylang/release-notes-bot-action/releases/tag/0.3.7)
- [redvers/pony-email 0.0.11](https://github.com/redvers/pony-email/releases/tag/0.0.11)
- [redvers/pony-smtp 0.0.3](https://github.com/redvers/pony-smtp/releases/tag/0.0.3)

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

Howdy! This week we are looking at an often overlooked, but especially helpful resource. One that you could realistically print out and keep handy as you learn/use Pony: [the cheatsheet](https://www.ponylang.io/media/cheatsheet/pony-cheat-sheet.pdf)!

The cheatsheet one-pager offers a view of the landscape of Pony. Today, draw your attention to a specific part of the cheatsheet, the section titled "REF CAP USAGE" just right of center. Here you will see two entries `class refcap MyClass` and `new refcap create()`. But what do these entries mean? Let's replace the placeholder _refcap_ in the former and say it is a `ref`, making the statement `class ref MyClass`. In this situation, anytime `MyClass` is used as a type it is an implicit `MyClass ref`. Defining a refcap on a type, changes the default refcap at the type level. When a type is defined without a default refcap, it still has a default: classes default to `ref`, primitives default to `val`, and actors default to `tag`. Meanwhile, the latter of these two entries, `new refcap create()`, changes the default return capability from the constructor. Therefore defining `new iso create()` on a `MyClass` leads to `MyClass.create()` creating a `MyClass iso` instance. Defining a refcap on a constructor, changes the default refcap at the instance level.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
