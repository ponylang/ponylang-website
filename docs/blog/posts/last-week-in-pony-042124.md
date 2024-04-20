---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - April 21, 2024"
date: 2024-04-21T07:00:06-04:00
---

<< content >>

<!-- more -->

## Items of Note

### New SSL Builders

We've added new SSL builders that can be used for building SSL dependent Pony applications. `release` and `latest` versions are available for each. The `release` version contains the most recent ponyc release. The `latest` version is contains the most recent ponyc nightly version.

- [LibreSSL 3.9.1](https://github.com/ponylang/shared-docker/tree/main/x86-64-unknown-linux-builder-with-libressl-3.9.1)
- [OpenSSL 3.3.0](https://github.com/ponylang/shared-docker/tree/main/x86-64-unknown-linux-builder-with-openssl_3.3.0)

### SSL Builders Deprecated

We've deprecated 3 SSL builders. Effectively immediately, they will no longer be updated.

- LibreSSL 3.7.2
- OpenSSL 1.1.1t
- OpenSSL 3.1.0

### Pony Development Sync

The [recording](https://vimeo.com/935667506) of the April 16, 2024 sync is available.

There will be no development sync on April 23, 2024. The next sync currently scheduled is April 30, 2024.

### Office Hours

As far as I know, there was no office hours this week. I had a migraine and didn't attend.

## Releases

- [ponylang/crypto 1.2.3](https://github.com/ponylang/crypto/releases/tag/1.2.3)
- [ponylang/github_rest_api 0.1.5](https://github.com/ponylang/github_rest_api/releases/tag/0.1.5)
- [ponylang/http 0.6.1](https://github.com/ponylang/http/releases/tag/0.6.1)
- [ponylang/http_server 0.6.2](https://github.com/ponylang/http_server/releases/tag/0.6.2)
- [ponylang/net_ssl 1.3.3](https://github.com/ponylang/net_ssl/releases/tag/1.3.3)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
