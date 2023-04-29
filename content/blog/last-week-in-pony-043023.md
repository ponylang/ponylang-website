+++
draft = false
author = "seantallen"
description = "<< content >>"
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony April 23, 2023"
date = "2023-04-30T07:00:06-04:00"
+++

Keeping an open source project up and running has lots of hidden time that goes into it. This past week was one of those. A few things that happened, our Windows CI and builds related to anything that uses LibreSSL started failing consistently. Turns out that the site we were getting LibreSSL from was down. After digging around for a while, Sean figured out that `cdn.openbsd.org` which is what all links on openbsd.org use appears to be far more reliable than the `ftp.openbsd.org` that is used for links on the LibreSSL site. And, they both have the same content. So, we got to update a bunch of libraries and applications that rely on LibreSSL on Windows to fix the failures. You'll see a lot of releases related to that change that happened this week.

We also had a MacOS build incident where the version of python that ships with MacOS Monterey was compiled with an OpenSSL that is no longer supported by `urllib` and our corral and ponyup stopped uploading to Cloudsmith due to the error that `urllib` was throwing. The solution there? Install python via brew in MacOS CI environments to make sure we aren't using a wicked old python. The nice side-effect of that one was we realized that we needed to update to making Ventura our supported MacOS version (several months after we should have).

There's all sorts of stuff that comes up like this that is needed to keep the status quo for a project. So, for all of you who support Pony with your time or [your money](https://opencollective.com/ponyc), thanks. This would all slide into decay were it not for your efforts.

## Items of Note

### Library updates of interest to Windows users

Our two "ssl" related libraries, [ponylang/crypto](https://github.com/ponylang/crypto) and [ponylang/net_ssl](https://github.com/ponylang/net_ssl) both download LibreSSL and build it for Windows users. Previously, they were downloading from `ftp.openbsd.org` which has become unstable lately. We updated both libraries to download from the much more stable `cdn.openbsd.org`.

We suspect all Windows users will want to take advantage of the change as `ftp.openbsd.org` has been completely down in our testing for over 24 hours and was sporadically unavailable prior to that.

The list of libraries that you need to update in order to fully catch up with the changes are:

- [ponylang/crypto](https://github.com/ponylang/crypto)
- [ponylang/github_rest_api](https://github.com/ponylang/github_rest_api)
- [ponylang/http](https://github.com/ponylang/http)
- [ponylang/http_server](https://github.com/ponylang/http_server)
- [ponylang/net_ssl](https://github.com/ponylang/net_ssl)

### Supported MacOS version changed from Monterey to Ventura

We are a little behind the times with this one. We've switch all our CI from using MacOS Monterey to MacOS Ventura. That means that Monterey is "best effort" support going forward, there is no official testing on it.

Additionally, all nightlies of corral, ponyc, and ponyup are built on Ventura and in theory, due to system library linking on MacOS, might not work on earlier versions MacOS.

The next official release packages of corral, ponyc, and ponyup will be built on Ventura and the same caveat applies for using them on earlier versions of MacOS.

### SSL Builder Updates

The ponylang organization SSL builder docker images are being updated this week. Every few months we add new builders to support the latest versions of various OpenSSL and LibreSSL API versions.

#### OpenSSL builder changes

- 3.1.0 builder added
- 3.0.7 deprecated. It will stop receiving updates the next time we add a new 3.x OpenSSL builder.
- 1.1.1t builder added
- 1.1.1n builder deprecated. It will stop receiving updates the next time we add a new 1.x Open SSL builder.
- 1.1.1b builder will no longer receive updates

#### LibreSSL builder changes

- 3.7.2 builder added
- 3.5.3 builder deprecated. It will stop receiving updates the next time we add a new 3.x LibreSSL builder.
- 3.5.2 builder will no longer receive updates

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_04_25.m4a) from the April 25th, 2023 sync is available.

Phew! That was a long one. If you listen to this week's sync recording, strap in. It's 2 hours long. The breakdown is thus...

- About 30 minutes on the [Static arrays of numbers RFC](https://github.com/ponylang/rfcs/pull/209)
- About 20 minutes on the [With block doesn't call dispose on an object if its name is _ ponyc bug](https://github.com/ponylang/ponyc/issues/4345)
- 55 minutes on the [Segmentation fault when capturing Env via lambda](https://github.com/ponylang/ponyc/issues/4343) and [Runtime crash when accessing a field that was captured before it was initialized](https://github.com/ponylang/ponyc/issues/4301) ponyc bugs.

There's an awful lot that went on. We have no idea how much you will be able to follow along at home. Hopefully it's rewarding.

As a bonus, core team member Matthias Wahl who usually can't make it to sync ended up joining shortly after we started. It was great to have Matthias contributing during the call. Hopefully we can continue attending.

If this sort of thing interests you, please feel free to attend a Pony Development Sync. We have it on Zoom specifically because Zoom is the friendliest platform that allows folks without an explicit invitation to join. Every week, [a development sync reminder](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/Sync.20Reminder) with full information about the sync is posted to the [announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) on the Ponylang Zulip. You can stay up-to-date with the sync schedule by subscribing to the [sync calendar](https://calendar.google.com/calendar/ical/59jcru6f50mrpqbm7em4iclnkk%40group.calendar.google.com/public/basic.ics). We do our best to keep the calendar correctly updated.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

We seem to have settled into Office Hours have 3 regular attendees: Adrian Boyko, Red Davies, and Sean T. Allen. This week's Office Hours was just the 3 of them.

The primary point of discussion was generative testing, property-based testing, and Red's usage of it in is LDAP library that he is developing for work. Adrian wasn't familiar with [`pony_check`](https://stdlib.ponylang.io/pony_check--index/), the property-based testing package in the [Pony standard library](https://stdlib.ponylang.io/).

Red took Sean and Adrian through a bit of his usage and Adrian started poking around in the docs to get more familiar with it. Sean also discussed his usage of generative testing as part of his work on [Confidential ACI](https://techcommunity.microsoft.com/t5/apps-on-azure-blog/announcing-public-preview-of-confidential-containers-on-azure/ba-p/3755623) at Microsoft.

Sean's key point was that designing good generative tests is at least has hard as designing "standard unit-tests". And that it is probably harder to do well.

If you aren't familiar with `pony_check` and generative testing, you should stop by Office Hours sometime and discuss with Red and Sean. They are very powerful tools for developing better Pony software. They are both sure that your Pony code would probably benefit from a little `pony_check`.

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Releases

- [ponylang/corral 0.7.0](https://github.com/ponylang/corral/releases/tag/0.7.0)
- [ponylang/crypto 1.2.2](https://github.com/ponylang/crypto/releases/tag/1.2.2)
- [ponylang/github_rest_api 0.1.2](https://github.com/ponylang/github_rest_api/releases/tag/0.1.2)
- [ponylang/http 0.5.4](https://github.com/ponylang/http/releases/tag/0.5.4)
- [ponylang/http_server 0.4.5](https://github.com/ponylang/http_server/releases/tag/0.4.5)
- [ponylang/net_ssl 1.3.1](https://github.com/ponylang/net_ssl/releases/tag/1.3.1)

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

<< content >>

## RFCs

Major changes in Pony go through a community driven process where members of the community can write up "requests for change" that detail what they think should be changed and why. RFCs can range from simple to complex. We welcome your participation.

### New

- [Static arrays of numbers](https://github.com/ponylang/rfcs/pull/209)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
