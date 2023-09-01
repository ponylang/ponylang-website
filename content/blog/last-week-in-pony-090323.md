+++
draft = false
author = "seantallen"
description = "<< content >>"
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony September 3, 2023"
date = "2023-09-03T07:00:06-04:00"
+++

## Items of Note

### CirrusCI Migration Update

All done! Everything has been moved off of CirrusCI or ["decommissioned"](https://www.youtube.com/watch?v=yVDP5M0eTcM).

### DockerHub to GitHub Container Registry Migration

As we [mentioned last week](https://www.ponylang.io/blog/2023/08/last-week-in-pony-august-27-2023/#we-re-migrating-container-images-from-dockerhub-to-github-container-registry), we are migrating from DockerHub to GitHub Container Registry. On December 1st, we'll stop updating images in DockerHub. This past week we updated the following images:

- `ponylang/changelog-bot-action`

We've updated to post future releases while we migrate to both registries. It's unlikely we'll see another release before during the migration period so we uploaded tag 0.3.5 to GitHub Container Registry.

- `ponylang/changelog-tool`

We've updated to post future releases while we migrate to both registries. It's unlikely we'll see another release before during the migration period so we uploaded tag 0.5.0 to GitHub Container Registry.

- `ponylang/corral`
- `ponylang/library-documentation-action`
- `ponylang/library-documentation-action-v2`
- `ponylang/ponyc`

We've merged the PR to start uploading builds, both nightly and release, to GitHub Container Registry. By the time you read this, nightly images will be going in. On the next release, release images will be available via GitHub Container Registry as well.

- `ponylang/ponyup`
- `ponylang/release-bot-action`
- `ponylang/release-notes-bot-action`

We've updated to post future releases while we migrate to both registries. It's unlikely we'll see another release before during the migration period so we uploaded tag 0.3.7 to GitHub Container Registry.

- `ponylang/release-notes-reminder-bot-action`

We've updated to post future releases while we migrate to both registries. It's unlikely we'll see another release before during the migration period so we uploaded tag 0.1.1 to GitHub Container Registry.

That's everything that needs to move. Next up, on or after December 1st, we'll turn off pushing images to DockerHub. Please be sure to transition by then.

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_08_229.m4a) from the August 29th, 2023 sync is available.

We covered a bunch of PR and issues. Most were related to our CirrusCI migration that we finished and our DockerHub migration that is just getting underway.

We spent a good amount time going over the latest from [issue #4369](https://github.com/ponylang/ponyc/issues/4369).

A lot of disparate ground was covered, so have a listen!

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

We had another long Office Hours this week. About an hour and forty-five minutes total. We initially discussed with Red whether OpenSSL is adding full QUIC support as in, it implements the full protocol. Turns out they are and the 3.2 release will have QUIC client support in it and we assume, a later release will have server support.

From there we spent a good amount of time with Victor Morrow looking for his memory corruption bug in the QUIC library he is working on. It appears that by the end, we had the problem "narrowed down" to a single `memcpy` call. But, time will tell if we were correct. Along the way, we discovered a [compilation issue](https://github.com/ponylang/ponyc/issues/4412) with some code that was merged into ponyc last month.

Adrian Boyko was also in attendence and was incredibly helpful when he translated a Victor question that Sean was struggling with into "is malloc thread-safe"? Adrian is great at translating into Sean. Bless him.

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Releases

- [ponylang/corral 0.8.0](https://github.com/ponylang/corral/releases/tag/0.8.0)
- [ponylang/ponyc 0.56.0](https://github.com/ponylang/ponyc/releases/tag/0.56.0)
- [ponylang/ponyup 0.8.0](https://github.com/ponylang/ponyup/releases/tag/0.8.0)
- [ponylang/release-bot-action 0.6.2](https://github.com/ponylang/release-bot-action/releases/tag/0.6.2)
- [ponylang/release-bot-action 0.6.3](https://github.com/ponylang/release-bot-action/releases/tag/0.6.3)

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

<< content >>

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
