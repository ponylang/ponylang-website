+++
draft = false
author = "theobutler"
description = "The supported version of FreeBSD is moving from 12.1 to 12.2. The Apple M1 support team has an initial report. The documentation site website, main.actor, is being shut down. The default branch renaming is underway. Interested in contributing to Corral or other Pony tools?"
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - February 14, 2021"
date = "2021-02-14T21:47:46-05:00"
+++

The supported version of FreeBSD is moving from 12.1 to 12.2. The Apple M1 support team has an initial report. The documentation site website, main.actor, is being shut down. The default branch renaming is underway. Interested in contributing to Corral or other Pony tools?

<!--more-->


## Items of note

- ponyc, corral, and ponyup are all switching the supported version of FreeBSD from 12.1 to 12.2. Everything should continue to work fine on 12.1, but all testing will be done with 12.2 and all release binaries will target 12.2.

- Sean T. Allen writes in to report that he is going to be doing a lot of work on Corral and some other Pony ecosystem tools and he's looking for assistance. If you'd be interested in learning Pony and perhaps some design alongside of Sean, stop by the Zulip "#contribute to pony" stream and let him know on [this topic](https://ponylang.zulipchat.com/#narrow/stream/192795-contribute-to.20Pony/topic/Corral).


## Releases

- Version 0.1.1 of ponylang/appdirs has been released.
See the [release notes](https://github.com/ponylang/appdirs/releases/tag/0.1.1) for more details.

- Version 1.1.1 of ponylang/crypto has been released.
See the [release notes](https://github.com/ponylang/crypto/releases/tag/1.1.1) for more details.

- Version 1.0.2 of ponylang/glob has been released.
See the [release notes](https://github.com/ponylang/glob/releases/tag/1.0.2) for more details.

- Version 0.2.7 of ponylang/http has been released.
See the [release notes](https://github.com/ponylang/http/releases/tag/0.2.7) for more details.

- Version 0.2.3 of ponylang/http_server has been released.
See the [release notes](https://github.com/ponylang/http_server/releases/tag/0.2.3) for more details.

- Version 0.1.5 of ponylang/library-documentation-action has been released.
See the [release notes](https://github.com/ponylang/library-documentation-action/releases/tag/0.1.5) for more details.

- Version 0.2.8 of ponylang/mkdocs-theme has been released.
See pypi for more details: [Package mkdocs-ponylang](https://pypi.org/project/mkdocs-ponylang/)

- Version 0.1.1 of ponylang/peg has been released.
See the [release notes](https://github.com/ponylang/peg/releases/tag/0.1.1) for more details.

- Version 0.1.1 of ponylang/reactive_streams has been released.
See the [release notes](https://github.com/ponylang/reactive_streams/releases/tag/0.1.1) for more details.

- Version 0.2.1 of ponylang/semver has been released.
See the [release notes](https://github.com/ponylang/semver/releases/tag/0.2.1) for more details.

- Version 0.5.1 of ponylang/valbytes has been released.
See the [release notes](https://github.com/ponylang/valbytes/releases/tag/0.5.1) for more details.

___

The "M1 team" has returned with an initial report.

To run on the M1 we are going to need to change Pony's FFI system. At the moment, all FFI calls that have no associated `use` declaration are generated using vararg calling conventions whether they use varargs or not. This is a nice feature for Pony programmers as they don't have to care when calling a C function whether it takes varargs.

Unfortunately, on the M1, you can not call a non-varargs function using varargs calling conventions. We're preparing an RFC to make `use` declarations required for FFI calls so that varargs can be consistently distinguished from non-varargs functions by the signature in the associated `use` declaration.

You can follow along with more of the M1 adventure in the [M1 stream on our Zulip](https://ponylang.zulipchat.com/#narrow/stream/275038-M1).

There's more information specific to the varargs calling convention change in a [topic in the RFC stream](https://ponylang.zulipchat.com/#narrow/stream/189959-RFCs/topic/Distinguish.20FFI.20varargs).

___

Our "one documentation site to rule them all" website main.actor is being shut down. It might come back in another form, but its current form didn't work out.

Watch Last Week in Pony for more information as we move forward.

In the meantime, you can note that most of the ponylang organization libraries now link to their API documentation from their READMEs and the documentation cross-links between different sites as needed to traverse the various types in the API.

The tooling use to create the documentation is available for any Pony library projects to use, including yours. Except a write up of some form in the future once we have it all fully fleshed out.

___

The great "main as default branch" migration is underway. So far we've switched the following repositories to having `main` as the default branch:

- action-readme-version-updater
- appdirs
- changelog-bot-action
- changelog-tool
- contributors
- corral
- corral-test-repo
- crypto
- flycheck-pony
- glob
- http
- http_server
- library-documentation-action
- library-scaffolding-generator
- net_ssl
- mkdocs-theme
- peg
- ponyc
- ponylang-mode
- ponylang-website
- ponyup
- pony-ctags
- pony-patterns
- pony-playground
- pony-snippets
- pony-sync-helper
- pony-tutorial
- reactive_streams
- regex
- release-bot-action
- release-notes-bot-action
- release-notes-reminder-bot-action
- rfcs
- semver
- shared-docker
- stdlib.ponylang.io
- valbytes

___

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
