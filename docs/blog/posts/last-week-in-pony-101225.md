---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - October 12, 2025"
date: 2025-10-12T17:30:06-04:00
---

We have exciting news this week! Pony 0.60.0 is scheduled for release soon, followed by several additional releases to implement related changes. These updates include significant changes to our container images (shifting to musl-based only), improved multi-architecture support for both AMD64 and ARM64, and the first official support for building Pony on ARM64 Windows machines. We're also renaming our "latest" image tag to the more accurate "nightly" designation. Read on for more details about these upcoming changes.

<!-- more -->

## Expect Lots of Pony Releases

We're going to have a few Pony releases over the next couple of weeks. We have a couple of PRs to merge and then the release train starts with Pony 0.60.0. There will be some follow-up releases to do related changes.

We've made changes to the Pony container images we make available. We're moving to only have musl-based images. The glibc-based images will be removed. If you need glibc, you can build your own image. The glibc-based images were of little use unless you happened to be using whatever the base image was. The musl-based images are more portable.

We're also switching from having an image called "latest" to having one called "nightly". Latest was confusing as it implied "the most recent image", when it was actually "the current nightly image". Nightly is more accurate. Both "latest" and "nightly" will be built for 0.60.0. Immediately after the release, latest will be removed.

Additionally, we're being much more explicit about our musl builds. Prior to this release, we just had a generic "musl" build. That was normally fine, but sometimes it wasn't. All our musl builds are currently based on Alpine Linux. Occasionally, there are breaking changes in Alpine that cause problems when treating musl as a generic target. To address this, we'll have builds for specific Alpine versions. On Amd64, we're starting with Alpine 3.20 and 3.21. On Arm64, we're starting with Alpine 3.21.

Our docker images will be based on the most recent Alpine version that we currently support. For 0.60.0, that will be Alpine 3.21.

Shortly after the 0.60.0 release, we'll be adding support for Alpine 3.22 to ponyc and ponyup. This will allow us to have an Alpine 3.22-based image for Pony 0.60.1.

We're in the process of adding multi-arch support to our ponyc docker images. As of 0.60.0, the nightly images are available for both Amd64 and Arm64. The 0.60.1 release will add multi-arch support for the images with the `release` tag. And finally with 0.60.2, we'll have multi-arch support for images that are given a specific version tag like "0.60.2".

Corral and Ponyup images might become multi-arch in the future. However, it's more likely that we'll drop building images for both applications. Each is included in the ponyc images. If you need them separately, there are statically linked binaries available for both applications in Cloudsmith so the images themselves have limited value.

## Arm64 Windows Support

We're releasing Pony 0.60.0 this week. It's the first release with support for building Pony on Arm64-based Windows machines. Ponyup and corral are already available for Arm64 Windows.

## Items of Note

### Pony Development Sync

The recording of the October 7th Development Sync is available on [Vimeo](https://vimeo.com/1125334905).

### Office Hours

Office Hours this past week started with myself and Jason E. Aten. After a bit, we were joined by Red.

The call was mostly a Q&A session. We talked about Pony, the ecosystem, and some of the challenges of learning a new language. It was an excellent use of Office Hours. If you're interested in learning more about Pony or Pony-related topics, you should join us some week.

## Releases

- [ponylang/ponyup 0.9.0](https://github.com/ponylang/ponyup/releases/tag/0.9.0)
- [ponylang/ponyup 0.9.1](https://github.com/ponylang/ponyup/releases/tag/0.9.1)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
