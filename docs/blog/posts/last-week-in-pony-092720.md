---
draft: false
authors:
  - theobutler
description: "Ponyc 0.38.1 has been released. Support for prebuilt \"generic glibc Linux\" ponyc binaries is being dropped in favor of prebuilt images for specific Linux distributions. We are also pleased to announce Jason Carr, AKA @jasoncarr0, is now a Pony committer!"
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - September 27, 2020"
date: 2020-09-27T10:55:23-04:00
---

Ponyc 0.38.1 has been released. Support for prebuilt "generic glibc Linux" ponyc binaries is being dropped in favor of prebuilt images for specific Linux distributions. We are also pleased to announce Jason Carr, AKA @jasoncarr0, is now a Pony committer!
<!-- more -->

## Items of note

- Audio for the September 22, 2020 Pony developers' sync is available:
[https://vimeo.com/916250721](https://vimeo.com/916250721)

- We are dropping support for prebuilt "glibc" ponyc builds for Linux.

    ---
    This doesn't mean you can't run ponyc on Linux using glibc. It means that if we detect that you are using glibc when you install via Ponyup we won't be installing the generic version. "Generic" is misleading here as it really means a version of ponyc with some unknown version of glibc. At the moment, that version is whatever glibc Ubuntu 20.04 uses.

    This is a horrible experience where we ask people to install and then if they get a glibc version mismatch error, ask them to install a version specific to their distro.

    We will be doing the following:

    - Updating ponyup to drop support for "generic glibc".

    If ponyup finds that you are running on a glibc distro it will prompt you to select from our list of supported glibc distros. If your distro isn't currently supported via prebuilts, you can either build ponyc from source or request that your distro be supported.

    We will support building for any version of a Linux distro so long as it is a long term release that is still supported. Note, that we might ask for your assistance in crafting the Dockerfile that will be used as the build environment for said distro and version. For those who are curious, you can see our [existing builder environments](https://github.com/ponylang/ponyc/tree/main/.ci-dockerfiles) in the ponyc repo.

    ---

- Jason Carr, AKA @jasoncarr0, is now a Pony committer. Welcome to the team Jason. We look forward to more awesomeness in the future.

## Releases

- Version 0.38.0 of ponylang/ponyc has been released.
See the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.38.0) for more details.

- Version 0.38.1 of ponylang/ponyc has been released.
See the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.38.1) for more details.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
