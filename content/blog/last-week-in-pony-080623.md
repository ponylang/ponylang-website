+++
draft = false
author = "seantallen"
description = "Upgrade your ponyc as soon as possible."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony August 6, 2023"
date = "2023-08-06T07:00:06-04:00"
+++

## Items of Note

### A Great and Mighty CI Move is Coming

There's going to be a lot of "CI" related upheaval coming soon. Almost all our CI related to `ponyc` (where all the heavy lifting is) is being done on CirrusCI. However, they are [ending their unlimited free CI](https://cirrus-ci.org/blog/2023/07/17/limiting-free-usage-of-cirrus-ci/).

We went over the monthly limit in less than 4 days so, this is definitely not good for us as a project. Realistically, we probably have to move to GitHub Actions which is going to cause a decent amount of pain.

For example, there's no FreeBSD runners with GitHub Actions. There's no MacOS Arm runners with GitHub Actions. There's no Arm runners in general with GitHub Actions. Those are all things that we currently use with CirrusCI. We could try keeping those jobs at Cirrus but, then we are in the situation where we can suddenly have things we depend on stop because we are out of free time. We could try to keep some of those things running by paying for time with credits but that would probably get expensive quickly and while we have a decent amount of money in the collective, we have it because we intentionally keep expenses low. Further, because of how CirrusCI works, people could "attack us" by opening lots of jobs on CirrusCI from the ponyc repo and burn through our money.

We could also try doing self-hosted runners for either GitHub Actions or CirrusCI but that gets us into the systems administration game that no one wants to be in as a volunteer project.

It is quite likely that we:

- Drop FreeBSD as a supported platform
- Drop MacOS on Arm as a supported platform
- Do all our Linux arm testing using QEMU
- Considerably reduce the amount of nightly stress testing we do

Whatever we end up doing, this is going to be a lot of work for me (Sean) over the next 4 weeks before I start my new job. Wheeee!

So now that the pain part of this notice is done, we as a team want to express our tremendous amount of gratitude to CirrusCI as a company. They have provided us so much in the way of free minutes and responsive technical support over the years. They have been simply amazing. If you are looking for an amazing CI solution for your company that can afford to pay, please give them a look. They have been incredible. I'd be happy to discuss with you in the [Pony Zulip](https://https://ponylang.zulipchat.com/) to see if they fit your company's needs.

Thank you Fedor and company, you have been simply amazing.

A lot of you might be too young to remember what it was like before CI was easily available to Open Source projects. Let me tell you (old man hat on!), maintaining cross-platform software in the 90s was awful. You had to beg to get time from one of a tiny number of organizations that might have a bit of spare time in their build cluster and odds were, you weren't getting any. It was so easy to bork someone's carefully built build cluster. In general, they didn't want anyone else going near it.

With the birth of companies like CirrusCI and TravisCI and all the others who have provided tons of free minutes to Open Source projects over the years, that completely changed. There's no way the Pony project would have been able to get the velocity we've had as a small volunteer project without all the support that the various CI services we've used provided. It's been a god-send.

So, putting aside my old man hat; if you'd like to contribute to Pony is some way, now is a good chance, I could use assistance with the transition we make (final shape to be decided). If you are interested in helping, please stop by the [#ci stream on the Pony Zulip](https://ponylang.zulipchat.com/#narrow/stream/190359-ci) and drop me a note.

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_08_01.m4a) from the August 1st, 2023 sync is available.

Sync this week came in at about 30 minutes, almost all of which was some initial discussion of [ponylang/ponyc issue #4369](https://github.com/ponylang/ponyc/issues/4369). We ended with "Sean and Joe will debug together on Friday".
That Friday debugging session which ran over into Office Hours was productive and resulted in this weekend's ponyc release.

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

Office Hours was a "two-parter" this week. An hour before Office Hours started, Joe and Sean got together and started debugging [ponylang/ponyc #4369](https://github.com/ponylang/ponyc/issues/4369). They hadn't finished when it was time for Office Hours so for the first 30 minutes, they continued debugging. Eventually arriving at a place where it appeared to be a similar bug as [#3874](https://github.com/ponylang/ponyc/issues/3874).

The second half of the meeting was spent on some "getting LLVM 16 working" debugging. Nicolai Stawinoga is trying to get ponyc running with LLVM head and ran into some problems where there's a crash during the "verification" compiler step that is turned on when ponyc tests are run. No resolution was found during that time, but Red Davies got to see the answer to his question "how would you go about debugging something like that?"

It was a very deep, intense, and Pony-focused Office Hours. You would have had fun. Shame you weren't there, but we [have some theme music for you](https://www.youtube.com/watch?v=d01VdBg65Dg) to make up for it.

See ya next week!

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

<< content >>

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
