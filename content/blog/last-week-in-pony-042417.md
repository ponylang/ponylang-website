---
author: seantallen
categories:
- Last Week in Pony
date: 2017-04-23T00:00:01-04:00
description: Last week's Pony news, reported this week.
draft: false
title: Last Week in Pony - April 23, 2017
---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), our [users' mailing list](https://pony.groups.io/g/user) or join us [on IRC](https://webchat.freenode.net/?channels=%23ponylang). 

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!--more-->

## Pony 0.13.1 released

0.13.1 is a high priority release that everyone is encouraged to update as soon as possible. PR #1842 fixed a garbage collection bug that resulted in GC running too often and in turn could have a large impact on performance for some applications. Full details can be found in the [release notes](https://www.ponylang.io/blog/2017/04/0.13.1-released/).

## Items of note

- [Pony-stable](https://github.com/ponylang/pony-stable), the little dependency manager that could, is now an official Ponylang project. There's been a lot of noise about creating a [Pony package manager](https://github.com/ponylang/ponyc/issues/247) but so far, nothing has popped up. One reason is that for folks working every day in Pony, stable has been sufficient. We're sure that might change but in the meantime, [stable is the choice we are moving forward with](https://pony.groups.io/g/dev/topic/package_manager/4654150?p=,,,20,0,0,0::recentpostdate%2Fsticky,,,20,2,0,4654150).
- Dipin Hora opened a [PR](https://github.com/ponylang/ponyc/pull/1844) that starts us down the path towards supporting musl based operating systems. Once the change is merged, you should be able to compile and run Pony on Alpine Linux.
- Audio from the April 19th Pony Development Sync meeting is available for [your listening pleasure](https://pony.groups.io/g/dev/files/Pony%20Sync/April%2019,%202017). Includes a discussion of the heavy burden of trying to maintain install packages for various operating systems and possible things we can do to ease the load.

## RFCs

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!

### In progress

- Benoit Vey has opened a [PR](https://github.com/ponylang/ponyc/pull/1858) to implement [RFC #34 - "Bare FFI Lambdas"](https://github.com/ponylang/rfcs/blob/master/text/0034-bare-ffi-lambdas.md). Once merged, you'll be able to use bare lambdas for use in FFI interoperation with C libraries that use function pointers as callbacks.
- Jaroslaw Palka has opened a [PR](https://github.com/ponylang/ponyc/pull/1853) to implement [RFC #25](https://github.com/ponylang/rfcs/blob/master/text/0023-network-dont-provide-default-implementation-for-failures.md) - " Require programmer to implement network failure handling". When merged, it will result in a breaking change that will cause some network applications to be updated if they aren't implementing their own error handling.
- Benoit Vey has been working on implementing [RFC #26: Subtype checking](https://github.com/ponylang/rfcs/blob/master/text/0026-subtype-checking.md). We're quite excited to see this land on master. Last week, we [merged the first half of that work](https://github.com/ponylang/ponyc/pull/1855).  Pony now support `iftype` conditionals. Specialized generic functions and documentation are in the pipeline.
