---
draft: false
authors:
  - seantallen
description: "You probably won't remember this 3rd of December."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - December 3, 2023"
date: 2023-12-03T07:00:06-04:00
---

You probably won't remember this 3rd of December.

<!-- more -->

## Items of Note

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_11_28.m4a) from the November 28th, 2023 sync is available.

We had a short agenda that we ran through pretty quickly. It was almost entirely pull requests opened by Sean that closed "good first issues" posted to the [contribute to pony Zulip stream](https://ponylang.zulipchat.com/#narrow/stream/192795-contribute-to-Pony).

### Office Hours Cancellations

Office Hours won't be held on Christmas and New Year's Day. We will have a two week gap in Office Hours meetings. We will be holding other meetings on our normal schedule.

To stay up-to-date with the Office Hours changes, [subscribe to the calendar](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics).

### Office Hours

We have an open Zoom meeting every week for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try. The meeting is open to anyone. Stay up-to-date with the schedule by [subscribing to the Office Hours calender](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics). Hopefully, we'll see you at an Office Hours soon.

Attendees were Adrian, Dipin, and Sean. Our only Pony related discussion was around an error that Gordon Tisher encountered and [brought up on Zulip](https://ponylang.zulipchat.com/#narrow/stream/189985-beginner-help/topic/partial.20application.20help).

Interested in background? Check out the [initial conversation](https://ponylang.zulipchat.com/#narrow/stream/234733-off-topic/topic/Algorithm.20Request.3A.20uniform.20and.20100.25.20coverage.20prng) from the Ponylang Zulip.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

Pony is a highly concurrent, actor-based language. This high concurrency can have an effect where many actors are generated to share a workload (i.e., "fan out") which all then report results to a single actor (i.e., "fan in"). When this is well-balanced life is good and all is well, but when unbalanced it can lead to massive slow down. One possible reason for such a slow down is the "thundering herd" problem which necessitates a well-implemented backpressure system. In general, a backpressure system allows for those parts of a system that are causing strain to be temporarily stopped so the rest of the system can reduce that strain. The Pony backpressure system allows us to mitigate problems such as the "thundering herd" by re-balancing resource usage (i.e., which actors are scheduled on finite cores).

This week we invite you to watch the Virtual User Group video [An informal tour of the Pony backpressure system](https://vimeo.com/707155973). In this video, Sean explains how the Pony backpressure system works. After watching the video, take a look at some of the examples that use the backpressure system such as [fan-in](https://github.com/ponylang/ponyc/tree/main/examples/fan-in), [overload](https://github.com/ponylang/ponyc/tree/main/examples/overload), and [under_pressure](https://github.com/ponylang/ponyc/tree/main/examples/under_pressure).

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
