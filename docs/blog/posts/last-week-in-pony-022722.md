---
draft: false
author: "theobutler"
description: "We have a ton of releases this week due to the 3 accepted and implemented RFCs. These include breaking changes to the standard library. We've also changed how \"releases\" are done for the library-documentation-action."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - February 27, 2022"
date: 2022-02-27T12:38:52-03:00
---

We have a ton of releases this week due to the 3 accepted and implemented RFCs. These include breaking changes to the standard library. We've also changed how "releases" are done for the library-documentation-action.

<!--more-->

## Items of note

- Audio from the February 22, 2022 Pony development sync is available: [https://sync-recordings.ponylang.io/r/2022_02_22.m4a](https://sync-recordings.ponylang.io/r/2022_02_22.m4a).
  Highlights include a good discussion around revisiting the ["explicit self member access" RFC](https://github.com/ponylang/rfcs/pull/173)

## Issue of the Week

- This week's issue is [Add avoid boxing via Parameterization pattern](https://github.com/ponylang/pony-patterns/issues/15) on the pony-patterns repo. This calls for the description of a performance pattern where function parameterization is used to avoid boxing/unboxing primitives. This is going to bite people coming from dynamic languages if they use Any for actor methods. This can also impact on people using union types a lot.

---

Message from @**Sean T Allen**:

We've changed how "releases" are done for the [library-documentation-action](https://github.com/ponylang/library-documentation-action/). Previously, we did numbered releases like you would see from ponyc, corral, and other ponylang organization projects. Doing numbered releases came with a serious drawback.

We had to do a new version of the action each time a new ponyc with breaking changes was released and then every user of the action had to update to the latest version before they released updated documentation for their library to match the new ponyc version. This sucked. It was a lot of extra work. It was especially painful knowing that we were working towards removing the need for the library-documentation-action entirely.

The library-documentation-action has always been a temporary solution with Sean T. Allen works towards bringing better documentation generation fully "into the compiler". Given that, we feel that the action is "feature complete" and that we won't be making any more changes to it. All releases going forward are expected to be updates to get a new ponyc version. Given that, we have changed how releases are done.

The library-documentation-action now a docker image with two tags in DockerHub for your use. The `release` tag is updated each time a new ponyc version comes out and has the most recent ponyc release. The `latest` tag is updated each time there's a new ponyc nightly release and has the most recent nightly ponyc.

See the [library-documentation-action example workflows](https://github.com/ponylang/library-documentation-action#example-workflow) for the small change you'll need to make in your action usage to stay up-to-date.

## Releases

- Version 1.0.0 of ponylang/logger has been released.
  See the [release notes](https://github.com/ponylang/logger/releases/tag/1.0.0) for more details.

- Version 0.49.0 of ponylang/ponyc has been released.
  See the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.49.0) for more details.

- Version 0.5.0 of ponylang/library-documentation-action has been released.
  See the [release notes](https://github.com/ponylang/library-documentation-action/releases/tag/0.5.0) for more details.

- Version 0.2.4 of ponylang/semver has been released.
  See the [release notes](https://github.com/ponylang/semver/releases/tag/0.2.4) for more details.

- Version 0.2.1 of ponylang/reactive_streams has been released.
  See the [release notes](https://github.com/ponylang/reactive_streams/releases/tag/0.2.1) for more details.

- Version 1.0.1 of ponylang/logger has been released.
  See the [release notes](https://github.com/ponylang/logger/releases/tag/1.0.1) for more details.

- Version 0.1.5 of ponylang/appdirs has been released.
  See the [release notes](https://github.com/ponylang/appdirs/releases/tag/0.1.5) for more details.

- Version 0.1.4 of ponylang/peg has been released.
  See the [release notes](https://github.com/ponylang/peg/releases/tag/0.1.4) for more details.

- Version 0.6.2 of ponylang/valbytes has been released.
  See the [release notes](https://github.com/ponylang/valbytes/releases/tag/0.6.2) for more details.

- Version 1.1.5 of ponylang/crypto has been released.
  See the [release notes](https://github.com/ponylang/crypto/releases/tag/1.1.5) for more details.

- Version 0.5.7 of ponylang/corral has been released.
  See the [release notes](https://github.com/ponylang/corral/releases/tag/0.5.7) for more details.

- Version 1.1.5 of ponylang/regex has been released.
  See the [release notes](https://github.com/ponylang/regex/releases/tag/1.1.5) for more details.

- Version 0.1.1 of ponylang/fork_join has been released.
  See the [release notes](https://github.com/ponylang/fork_join/releases/tag/0.1.1) for more details.

- Version 1.2.1 of ponylang/net_ssl has been released.
  See the [release notes](https://github.com/ponylang/net_ssl/releases/tag/1.2.1) for more details.

- Version 0.5.2 of ponylang/http has been released.
  See the [release notes](https://github.com/ponylang/http/releases/tag/0.5.2) for more details.

- Version 1.0.6 of ponylang/glob has been released.
  See the [release notes](https://github.com/ponylang/glob/releases/tag/1.0.6) for more details.

- Version 0.2.3 of ponylang/templates has been released.
  See the [release notes](https://github.com/ponylang/templates/releases/tag/0.2.3) for more details.

- Version 0.4.1 of ponylang/http_server has been released.
  See the [release notes](https://github.com/ponylang/http_server/releases/tag/0.4.1) for more details.

- Version 0.2.1 of seantallen-org/lori has been released.
  See the [release notes](https://github.com/seantallen-org/lori/releases/tag/0.2.1) for more details.

- Version 0.2.5 of seantallen-org/msgpack has been released.
  See the [release notes](https://github.com/seantallen-org/msgpack/releases/tag/0.2.5) for more details.

## RFCs

### Approved (& Implemented) RFCs

- [Change standard library object capabilities pattern](https://github.com/ponylang/rfcs/blob/main/text/0072-change-stdlib-object-capabilities-pattern.md)

- [Add PonyCheck to the standard library](https://github.com/ponylang/rfcs/blob/main/text/0073-add-ponycheck-to-stdlib.md)

- [Remove logger package from standard library](https://github.com/ponylang/rfcs/blob/main/text/0074-remove-stdlib-logger.md)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
