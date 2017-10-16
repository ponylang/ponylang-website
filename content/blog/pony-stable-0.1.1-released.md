+++
draft = false
author = "seantallen"
categories = [
    "Release",
]
date = "2017-10-16T11:00:43-04:00"
title = "Pony Stable 0.1.1 Released"
+++
Pony-stable 0.1.1 is a recommended update for anyone who uses our prepackaged binaries. Previously, when using pony-stable 0.1.0 with a prepackaged version of ponyc, you might get a core dump for an "illegal instruction". Pony-stable 0.1.1 resolves this issue. Upgrading pony-stable to 0.1.1 as soon as possible is recommended.

<!--more-->

### Fixed

- Fix possible illegal instruction core dump when using prebuilt ponyc binaries ([PR #45](https://github.com/ponylang/pony-stable/pull/45))

### Added

- Add `version` command line option ([PR #44](https://github.com/ponylang/pony-stable/pull/44))
