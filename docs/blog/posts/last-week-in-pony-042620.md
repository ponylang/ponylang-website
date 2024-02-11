---
draft: false
author: "theobutler"
description: "Nightly builds of ponyc for FreeBSD 12.1 are available. pony-semver has moved into the ponylang organization. The past sync meeting discussed syntax changes for the call site of behaviours."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - April 26, 2020"
date: 2020-04-26T11:00:11-04:00
---

Nightly builds of ponyc for FreeBSD 12.1 are available. pony-semver has moved into the ponylang organization. The past sync meeting discussed syntax changes for the call site of behaviours.
<!-- more -->

## Items of note

- Audio from the April 21, 2020 Pony sync is available [here](https://sync-recordings.ponylang.io/r/2020_04_21.m4a). There were a few topics of discussion. The primary topic was changing the syntax at the call site for behaviours from `.` to `~`.

- Nightly builds of ponyc are now available for download for FreeBSD 12.1. FreeBSD 12.1 nightlies are available from [Cloudsmith](https://cloudsmith.io/~ponylang/repos/nightlies/packages/?q=name%3A%27%5Eponyc-x86-64-unknown-freebsd12.1.tar.gz%24%27).

- [pony-semver](https://github.com/ponylang/pony-semver), a project started by [@btab](https://github.com/btab/), has become an official Ponylang organization project. pony-semver is a semantic versioning library for Pony. It is being used in the [corral dependency manager](https://github.com/ponylang/corral) project.

- Hydraconf is all online this July and they are looking for a Pony talk. Interested? Submit your talk today at: [https://speakers.hydraconf.com/](https://speakers.hydraconf.com/). The deadline to submit is May 1st, 2020.

## RFCs

### New RFCs

- [Move Hashable to builtin package and make it easier to make objects Hashable](https://github.com/ponylang/rfcs/pull/157)

- [Add IP address classes to net package](https://github.com/ponylang/rfcs/pull/158)

- [Change type of Env.root to AmbientAuth](https://github.com/ponylang/rfcs/pull/159)

- [Add RFC for adding the maybe library to stdlib](https://github.com/ponylang/rfcs/pull/161)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
