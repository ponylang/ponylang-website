---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - February 8, 2026"
date: 2026-02-08T07:30:00-04:00
---

Busy week on the release front. Ponyc 0.60.6 squashes several compiler bugs that were crashing instead of giving you error messages, Alpine support got bumped to 3.23, and [seantallen-org/msgpack](https://github.com/seantallen-org/msgpack) landed a big update with streaming support and compact encoding.

<!-- more -->

## Pony 0.60.6

Pony 0.60.6 is out with four compiler bug fixes. Several of these turned crashes or segfaults into proper error messages, so you should upgrade.

Fixes include: a crash when ephemeral types were used in parameters with default arguments, incorrect array element type inference for union types, a segfault when a lambda captured an uninitialized field, and a crash when assigning ephemeral capability types. All four now produce helpful error messages instead of crashing.

The release also adds Alpine 3.23 support and updates the Docker image base from Alpine 3.21 to Alpine 3.23.

Check the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.60.6) for the full details.

## Ponyup 0.11.1

Ponyup 0.11.1 adds Alpine 3.23 as a supported platform. If you're running Alpine 3.23 on arm64 or amd64, ponyup will now recognize it and let you install ponyc and related packages.

## seantallen-org/msgpack 0.3.0

A big release for [seantallen-org/msgpack](https://github.com/seantallen-org/msgpack). Three changes worth knowing about.

First, there's a new `MessagePackStreamingDecoder` for use with streaming data sources. Unlike the existing decoder, it won't corrupt your reader on partial reads. It peeks before consuming and returns `NotEnoughData` when more bytes are needed.

Second, the encoder and decoder now have compact methods that automatically select the smallest wire format for a given value. You can still use the format-specific methods when you want explicit control.

Third, a breaking change: the nanoseconds component of decoded timestamps is now `U32` instead of `I64`. This affects `MessagePackDecoder.timestamp()` and `MessagePackTimestamp.nsec`. The encoder already accepted `U32`, so encoding code is unaffected.

See the [release notes](https://github.com/seantallen-org/msgpack/releases/tag/0.3.0) for usage examples.

## Items of Note

### Pony Development Sync

The recording of the February 4th Development Sync is available on [Vimeo](https://vimeo.com/1161993849).

## Releases

- [ponylang/ponyc 0.60.6](https://github.com/ponylang/ponyc/releases/tag/0.60.6)
- [ponylang/ponyup 0.11.1](https://github.com/ponylang/ponyup/releases/tag/0.11.1)
- [seantallen-org/msgpack 0.3.0](https://github.com/seantallen-org/msgpack/releases/tag/0.3.0)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
