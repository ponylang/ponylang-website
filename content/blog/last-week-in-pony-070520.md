+++
draft = false
author = "theobutler"
description = "There is a new set of public Docker images for Pony with SSL system libraries installed. These will be replacing the previous \"x86-64-unknown-linux-builder-with-ssl\" image."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - July 5, 2020"
date = "2020-07-05T18:40:04-04:00"
+++

There is a new set of public Docker images for Pony with SSL system libraries installed. These will be replacing the previous "x86-64-unknown-linux-builder-with-ssl" image.

<!--more-->


## Items of note

- Audio from the [June 30, 2020](https://sync-recordings.ponylang.io/r/2020_06_30.m4a) Pony development sync call is available.

- Are you using any of the docker images we provide the community in the [shared-docker repository](https://github.com/ponylang/shared-docker)? If yes, this announcement is for you. The "x86-64-unknown-linux-builder-with-ssl" image that had latest and release versions has been removed and isn't being updated anymore. It has been replaced by two more specific images. "x86-64-unknown-linux-builder-with-libressl" and "x86-64-unknown-linux-builder-with-openssl_1.1.x". Both of the new images are alpine based like the one they are replacing.

## Releases

- Version 0.5.2 of ponylang-mode has been released. See the [release notes](https://github.com/ponylang/ponylang-mode/releases/tag/0.5.2) for more details.

___

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
