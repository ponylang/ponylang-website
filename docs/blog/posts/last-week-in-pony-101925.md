---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - October 19, 2025"
date: 2025-10-19T14:30:06-04:00
---

We had 3 Pony releases this week and a ton of changes to our container infrastructure as we continue migrating to multi-architecture images and clearer tagging. We've also added new standard builder images for Linux that should cover most use cases. Read on for the details.

<!-- more -->

## Ponyc 0.60.0 Released

We've released Pony 0.60.0. It's the first release in a while with breaking changes. You probably won't be affected by these changes, but you should read through the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.60.0) to see if anything impacts you.

We also released Pony 0.60.1 and 0.60.2 this week. These releases are part of the migration of our container infrastructure that we [detailed last week](https://www.ponylang.io/blog/2025/10/last-week-in-pony---october-12-2025/#expect-lots-of-pony-releases).

Expect another release this coming week to finish up the migration.

## Corral and Ponyup Docker Images

We've stopped building separate docker images for corral and ponyup. Both applications are included in the ponyc images as statically linked binaries. If you need to use either application separately, you can download the statically linked binaries from Cloudsmith.

## New Standard Linux Builder Images

We provide container images that can be used for various Pony related tasks. We call these images "builders". We're making our builders multi-architecture. As part of that process, we've added new Linux builders for both Amd64 and Arm64.

We have a new basic builder called "standard-builder". It is multi-arch and is based on Alpine Linux 3.21. It replaces the "x86-64-unknown-linux-builder". There are two tags available with the new builder: `nightly` and `release`.

Where you previously had:

`ghcr.io/ponylang/shared-docker-ci-x86-64-unknown-linux-builder:latest`

You now want:

`ghcr.io/ponylang/shared-docker-ci-standard-builder:nightly`

And where you previously had:

`ghcr.io/ponylang/shared-docker-ci-x86-64-unknown-linux-builder:release`

You now want:

`ghcr.io/ponylang/shared-docker-ci-standard-builder:release`.

The images are rebuilt every day to ensure they have the latest packages.

## LibreSSL 4.2.0 Builder

We've added a new builder image that includes LibreSSL 4.2.0. The image is called "shared-docker-ci-standard-builder-with-libressl-4.2.0" and is available for both Amd64 and Arm64.

There are two tags available for the new builder: `nightly` and `release`.

## OpenSSL 3.6.0 Builder

We've added a new builder image that includes OpenSSL 3.6.0. The image is called "shared-docker-ci-standard-builder-with-openssl-3.6.0" and is available for both Amd64 and Arm64.

There are two tags available for the new builder: `nightly` and `release`.

## Alpine-Arm64 Images

We previously had an image called `ponyc:alpine-arm64`. It was a musl-based image that was built nightly for arm64. It has been replaced by our multiplatform `ponyc:nightly` image.

Additionally, we had an image that we used for building Ponyup on arm64 called `shared-docker-ci-arm64-unknown-linux-builder-with-libressl-4.0.0`. We've stopped creating that image. It has been replaced by `shared-docker-ci-standard-builder-with-libressl-4.0.2`. If you happened to be using `shared-docker-ci-arm64-unknown-linux-builder-with-libressl-4.0.0`, you should also switch to `shared-docker-ci-standard-builder-with-libressl-4.0.2`.

## We're Migrating Off of "Latest" Tags

For many of our images, we're migrating off of using the "latest" tag. The "latest" tag was confusing as it implied "the most recent image", when it was actually the nightly image for many of our images. We're switching to "nightly". Nightly is more accurate.

As part of this, the `shared-docker-ci-release-a-library` image now uses `nightly` instead of `latest`. If you were using the `latest` tag, you'll need to switch to `nightly` to continue getting updates.

Expect to see more of this migration in the coming weeks.

## LibreSSL 4.0.0 Image Has Been Dropped

We've dropped the `shared-docker-ci-x86-64-unknown-linux-builder-with-libressl-4.0.0` image. You should now use the `shared-docker-ci-standard-builder-with-libressl-4.0.2` image that has `nightly` and `release` tags.

## OpenSSL 3.3.2 Image Has Been Dropped

The `shared-docker-ci-x86-64-unknown-linux-builder-with-openssl_3.3.2` image has been dropped. You should now use the `shared-docker-ci-standard-builder-with-openssl-3.6.0` image that has `nightly` and `release` tags.

## OpenSSL 3.4.1 Image Is Deprecated

The `shared-docker-ci-x86-64-unknown-linux-builder-with-openssl_3.4.1` image is deprecated and will be removed in a few months with the next round of SSL builder changes. You should switch to the new `shared-docker-ci-standard-builder-with-openssl-3.6.0` image that has `nightly` and `release` tags.

## Items of Note

### Pony Development Sync

The recording of the October 14th Development Sync is available on [Vimeo](https://vimeo.com/1128207895).

## Releases

- [ponylang/ponyc 0.60.0](https://github.com/ponylang/ponyc/releases/tag/0.60.0)
- [ponylang/ponyc 0.60.1](https://github.com/ponylang/ponyc/releases/tag/0.60.1)
- [ponylang/ponyc 0.60.2](https://github.com/ponylang/ponyc/releases/tag/0.60.2)
- [redvers/pony-odbc 0.3.1](https://github.com/redvers/pony-odbc/releases/tag/0.3.1)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
