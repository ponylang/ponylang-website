---
draft: false
authors:
  - seantallen
  - red
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - July 6, 2025"
date: 2025-07-06T07:00:06-04:00
---

We're back after a short break! I was traveling last week, so there was no Last Week in Pony post. This week, we have a few updates and some discussion from the last Office Hours.

<!-- more -->

## Items of Note

### Change in Core Team Membership

After several years of dedicated service, Gordon Tisher has stepped down from the Pony Core Team. We are grateful for all the work Gordon has done to help Pony grow and improve. Thank you, Gordon!

Gordon didn't feel that he had the time to continue contributing at the level he wanted, and we understand that. We hope to see him back in the future when he has more time.

### Pony Development Sync

The [recording](https://vimeo.com/1096041952) of the June 24th, 2025 sync is available, as is the [July 1 recording](https://vimeo.com/1097974053).

### Office Hours

I was traveling during the last Office Hours, so the write-up comes from Red.

Office Hours this week was attended by Niclas, Adrian, and Red. We covered a number of topics:

1. Pony Radio - We got our first look at the source code behind Pony Radio. What I found most interesting was how Adrian had chosen to solve his actor creation, initialization, and data flow configuration. Pony Radio is designed to be completely configurable like its [gnu-radio](https://www.gnuradio.org/) peer.
2. Constructor Tags & Initialization Patterns: This discussion happened before the explanation in the [Pony Developer Sync](https://vimeo.com/1097974053). The conversation evolved into a discussion around common patterns we see where classes or actors have to perform asynchronous actions as part of their initialization. Or they need to communicate the error condition as to why they failed to initialize. We discussed various patterns we use, as well as patterns in use in the standard library.
3. We talked briefly about Pony use in embedded devices, which embedded platforms we knew were in use, and which embedded platforms we'd be interested to see an implementation for in the future. [ESP32](https://www.espressif.com/en/products/socs/esp32), [P2](https://www.parallax.com/propeller-2/), and the [RP2040](https://datasheets.raspberrypi.com/rp2040/rp2040-datasheet.pdf) were discussed, as well as how one would implement the Pony runtime on bare metal platforms.

A fun time was had by all.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
