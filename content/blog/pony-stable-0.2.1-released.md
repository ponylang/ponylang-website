+++
draft = false
author = "seantallen"
categories = [
    "Release",
]
date = "2019-07-23T20:00:00-04:00"
title = "Pony Stable 0.2.1 Released"
+++
Pony Stable 0.2.1 is the latest release of our little dependency manager that could. If you need submodule support when cloning a repository, this release is for you. Otherwise, you can skip it.
<!--more-->
If you had previously installed Stable via the Launchpad PPA, you'll need to change your installation method as we are no longer distributing via Launchpad.
You can install from Bintray by following the Ubuntu instructions in the [pony-stable README](https://github.com/ponylang/pony-stable#debian-and-ubuntu-linux-using-a-deb-package-via-bintray).

Please note, at this time of this release, we are still waiting on the MacOS Homebrew release to be merged. Stable via Homebrew should be available soon, but it's not something we have control over.

### Fixed

- Clone repositories recursively to support submodules ([PR #112](https://github.com/ponylang/pony-stable/pull/112))

### Changed

- Stop building binary packages for Ubuntu Artful
- Stop building binary packages for Ubuntu Trusty
- Stop building binary packages for Debian Jessie
- Stop building binary packages for Ubuntu Cosmic
- Stop building binary packages for Debian Buster
