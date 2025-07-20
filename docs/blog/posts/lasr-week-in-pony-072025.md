---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - July 20, 2025"
date: 2025-07-20T07:00:06-04:00
---

Welcome to the July 20, 2025 edition of Last Week in Pony! This week we're ending support for MacOS on Intel processors and introducing the new ponylang/ssl library. It replaces the deprecated crypto and net_ssl libraries. We also have several new releases, including ponylang/ssl 1.0.0.

<!-- more -->

## MacOS for Intel Support is Coming to an End

[GitHub announced](https://github.blog/changelog/2025-07-11-upcoming-changes-to-macos-hosted-runners-macos-latest-migration-and-xcode-support-policy-updates/#macos-13-is-closing-down) they're ending support for MacOS on Intel processors in November.

We'll remove Intel MacOS support from our CI sometime before then. Changes we make will no longer be tested on Intel MacOS. We won't be providing pre-built versions of ponyc, corral, and ponyup for Intel MacOS anymore.

If you're using Pony on Intel MacOS, you'll need to build everything from source.

[We haven't decided](https://ponylang.zulipchat.com/#narrow/channel/190359-ci/topic/macOS.20for.20intel.20support) exactly when we'll remove support, but it'll be sometime before November 2025.

## Items of Note

### New OpenSSL/LibreSSL Support Library

We had two libraries before: [ponylang/crypto](https://github.com/ponylang/crypto) and [ponylang/net_ssl](https://github.com/ponylang/net_ssl). Both were API wrappers around OpenSSL and LibreSSL. We've merged them into a single library called [ponylang/ssl](https://github.com/ponylang/ssl).

We've deprecated ponylang/crypto and ponylang/net_ssl. They're now read-only repositories. Use ponylang/ssl instead.

The transition is straightforward:

- Update your corral.json to point at the new dependency
- Update your use statements from `use crypto` and `use net_ssl` to `use ssl/crypto` and `use ssl/net`

### Pony Development Sync

The [recording](https://vimeo.com/1102058085) of the July 15th, 2025 sync is available.

### Office Hours

This week's Office Hours had myself and Niclas. We talked a lot about Sweden and Swedish things. Eventually we ended with him showing me what he's [been working on](https://github.com/niclash/pink2web). It's pretty cool. You should grab me and have him give you a demo.

## Releases

- [ponylang/github_rest_api 0.2.1](https://github.com/ponylang/github_rest_api/releases/tag/0.2.1)
- [ponylang/http 0.6.4](https://github.com/ponylang/http/releases/tag/0.6.4)
- [ponylang/http_server 0.6.3](https://github.com/ponylang/http_server/releases/tag/0.6.3)
- [ponylang/lori 0.6.2](https://github.com/ponylang/lori/releases/tag/0.6.2)
- [ponylang/postgres 0.2.2](https://github.com/ponylang/postgres/releases/tag/0.2.2)
- [ponylang/ssl 1.0.0](https://github.com/ponylang/ssl/releases/tag/1.0.0)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
