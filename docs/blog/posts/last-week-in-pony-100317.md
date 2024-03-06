---
draft: false
authors:
  - mwahl
description: "Last week's Pony news, reported this week."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - October 03, 2017"
date: 2017-10-03T20:00:00+02:00
---
_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!-- more -->

## Pony 0.19.2 Released

On sunday Pony 0.19.2 has been released. It is a bug fix release which contains a fix for a high priority bug that leads to segfaults in serialization. Upgrading is highly recommended. Have a look at the [release blog post](https://github.com/ponylang/ponyc/releases/tag/0.19.2)

## Wallaroo

The folks over at WallarooLabs have open sourced their *"ultrafast and elastic data processing engine"* Wallaroo. As many of you might have heard, Wallaroo is written in Pony. It's an excellent chance to explore a real world Pony codebase.

The GitHub repo is here: [https://github.com/wallaroolabs/wallaroo](https://github.com/wallaroolabs/wallaroo)

## Items of note

- Stewart Gebbie announced a StatsD client for Pony on the [mailing list](https://pony.groups.io/g/user/message/1388).

  > This library provides the basic mechanisms for producing StatsD telemetry from Pony programme.

  Go check it out on [GitHub](https://github.com/sgebbie/pony-statsd).

- The Pony Kafka client [pony-kafka](https://github.com/wallaroolabs/pony-kafka) from WallarooLabs has been updated to be compatible with the latest ponyc.

- Another week, another pony development sync call. The call from *September 27th 2017* has been recorded for your listening pleasure. Get the audio [here](https://vimeo.com/915152014). It features a Sean being Sean again and a light-headed promise to start a *Guided Tour of the Standard Library* in the tutorial.

## RFCs

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
