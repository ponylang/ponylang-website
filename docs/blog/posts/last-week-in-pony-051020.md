---
draft: false
authors:
  - theobutler
description: "It's been a big week in Pony world for new ponylang projects and releases. ponyc 0.34.1 has been released for users on glibc-based Linux platforms. We've also opened a new GitHub repo for collecting information relevant to Pony contributors."

categories:
  - "Last Week in Pony"
title: "Last Week in Pony - May 10, 2020"
date: 2020-05-10T11:03:33-04:00
---

It's been a big week in Pony world for new ponylang projects and releases. ponyc 0.34.1 has been released for users on glibc-based Linux platforms. We've also opened a new GitHub repo for collecting information relevant to Pony contributors at [https://github.com/ponylang/contributors](https://github.com/ponylang/contributors).

<!-- more -->

## Items of note

- Pony 0.34.1 has been released. You only need to update if you are using 0.34.0 on a glibc based Linux. Full details are in the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.34.1).

- Audio from the May 5, 2020 Pony sync is available [here](https://vimeo.com/916245830).

- We've started a GitHub repository to collect information relevant to people who want to contribute to Pony. It's rather barren at the moment, but more information will be added over time. Please feel free to contribute. [https://github.com/ponylang/contributors](https://github.com/ponylang/contributors)

- We are beginning the switch package management on ponylang projects from pony-stable to [corral](https://github.com/ponylang/corral). Corral provides additional features, such as transitive dependencies and semver version constraints. Once all ponylang projects transition to using Corral, we will begin deprecating pony-stable.

- We have added a new Linux distro, Ubuntu 18.04, to the list of platforms we build releases for. We've added support for it as our generic glibc builds are now built on Ubuntu 20.04 and don't work on Ubuntu 18.04. The 18.04 builds were added at the request of core team member Sean T. Allen. If there's a Linux glibc distribution that you'd like us to do releases for, drop us a line. We'll be adding others as the community requests.

- A peg parser that @sylvanc wrote in Pony a few years ago and that we have been using as part of the [changelog-tool](https://github.com/ponylang/changelog-tool) has become [an official ponylang project](https://github.com/ponylang/peg). The repo is pretty empty other than the code but over the next couple weeks we'll be adding documentation, CI, and all of the goodness that Pony organization libraries have.

- We have a new package in the ponylang org: [http_server](https://github.com/ponylang/http_server), hosting the new official ponylang http server. It has been extracted from the former official library [https://github.com/ponylang/http](https://github.com/ponylang/http) and has been rewritten for improved performance. Very simplistic benchmarks showed good enough results to publish this. More work will be done and every kind of help is much appreciated.

- Version 0.2.0 of http_server has been released. See the [release notes](https://github.com/ponylang/http_server/releases/tag/0.2.0) for more details.

- We have a new package in the ponylang org: [valbytes](https://github.com/ponylang/valbytes). It provides an abstraction layer to work with multiple concatenated byte-arrays (`Array[U8]`) as if it was one, as you would receive them from a TCP connection package by package. It tries to avoid data-copying when extracting values from it. We are going to use it as the foundation of the new official ponylang http_server. Stay tuned!

- Version 0.5.0 of valbytes has been released. See the [release notes](https://github.com/ponylang/valbytes/releases/tag/0.5.0) for more details.

- Version 0.3.2 of corral has been released. See the [release notes](https://github.com/ponylang/corral/releases/tag/0.3.2) for more details.

- Version 0.0.12 of ponylang-mode has been released. See the [release notes](https://github.com/ponylang/ponylang-mode/releases/tag/0.0.12) for more details.

- Version 0.1.0 of reactive_streams has been released. See the [release notes](https://github.com/ponylang/reactive_streams/releases/tag/0.1.0) for more details.

## RFCs

### Ready For Vote

- ["Change type of Env.root to AmbientAuth" RFC](https://github.com/ponylang/rfcs/pull/159) will be voted on May 12th.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
