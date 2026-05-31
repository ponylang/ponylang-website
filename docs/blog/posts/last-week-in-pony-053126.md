---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - May 31, 2026"
date: 2026-05-31T07:00:06-04:00
---

This week's theme song is 16 Horsepower's ["Black Soul Choir"](https://www.youtube.com/watch?v=f-vpAn15-vE), all banjo and brimstone, because we shipped a release with some brimstone in it. ponyc 0.64.0 is out. Three breaking changes, two long-standing compiler bugs put to bed, and the recursive type alias work all landed in one drop. The whole networking stack moved over with it. Red also shipped the first release of a timezone library.

<!-- more -->

## ponyc 0.64.0

[ponyc 0.64.0](https://github.com/ponylang/ponyc/releases/tag/0.64.0) is a big one, so let's start with the part that will make you read the migration notes.

`error` no longer unwinds the stack. Partial functions now return an error flag alongside their result, and `try` and `?` check that flag directly. If you write pure Pony, you'll never notice. `error`, `try`, and `?` behave exactly as they always have. Where you will notice is the boundary with C. The `pony_error()` runtime function is gone, which means partial FFI is gone with it. C code that used to signal a Pony error now reports failure through its return value, and the Pony side checks that value and raises `error` itself. I wrote up the why and the how in [Pony's Errors Stop Unwinding the Stack](https://www.ponylang.io/blog/2026/05/ponys-errors-stop-unwinding-the-stack/) if you want the full story.

That's one of three breaking changes. The second is the `serialise` package, which is no longer in the standard library. It was a security footgun. Safe only with fully trusted data, and the capability tokens gating it did nothing to make deserializing untrusted input safe. Rather than rework it, we removed it, as ratified in RFC 83. If you leaned on it, you'll need a serialization scheme suited to your own threat model. The third is the socket runtime functions, `pony_os_writev` and friends, which now return a three-state result type instead of being partial functions with `0` doubling as a would-block signal. That one came out of RFC 228.

Those three are the reason the whole library ecosystem moved this week, which I'll get to below.

There's more than breakage. The finite recursive type alias work, the eleven-years-in-the-making feature I went on about at length last week, is now in a shipped release. So is the fix for two recursive generic type shapes that used to hang or crash the compiler. One was a generic interface drifting toward ever-larger type arguments, the other a type parameter whose constraint referenced itself. Both now either compile or give you a clean type error instead of spinning forever. I wrote that one up too, in [Round and Round](https://www.ponylang.io/blog/2026/05/round-and-round/).

The language server got a pile of work. Orien has been cranking on it, and it shows. New call hierarchy support means editors that speak the protocol can show you who calls a method and what a method calls, with the exact call sites. On top of that, a long list of hover fixes: no more popups on declaration or capability keywords, lambda types rendered as readable Pony instead of a compiler-internal ID, docstrings on class fields, and parameter hovers that show valid syntax instead of a `param` keyword that doesn't exist in the language. Document outlines stopped dropping members after a lambda field initializer, and spurious inlay hints inside lambda annotations are gone.

Underneath all that, we moved to LLVM 22.1.6, and FreeBSD, DragonFly, and OpenBSD now link with the embedded LLD linker instead of shelling out to an external compiler driver. That's the same dependency-shedding work that's been rolling across platforms for a while now, three more of them off the list.

There's a longer tail of compiler crash and assertion fixes in the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.64.0). Read them before you upgrade. The three breaking changes mean this isn't a free bump.

## contact-red/tz

Red put out the first release of [contact-red/tz](https://github.com/contact-red/tz), a timezone library for Pony, and timezones are exactly the kind of thing you don't want to write yourself. The design leads with a strong opinion: a timezone is not an offset, and a regional timezone doesn't always map to a canonical one, so there's no plain `DateTime` class. There's `ZonedDateTime`, which carries a POSIX UTC instant alongside its zone, and that one decision pays off everywhere. You can cast an instant between zones and get the same moment re-resolved into the new zone's local fields. Comparisons across zones stay DST-safe, because every value compares on its underlying UTC instant and the local DST quirks of either side never enter into it.

On top of that sit `Date` and `Time` for date and time math, parsers and formatters for the RFC 2822, RFC 3339, and ISO 8601 formats you actually run into, and a set of calendaring iterators for "every weekday at this time in this zone" or "the last weekday of every month." If you want historical pre-1970 timezone data, you compile with `-D HISTORICAL_TZ`. It's an early release, so expect it to grow, but there's already a lot here.

## Items of Note

### The Networking Stack Moves to 0.64.0

The FFI and socket runtime changes in 0.64.0 ripple straight through anything that touches the network, so the whole stack moved over together. [ponylang/lori](https://github.com/ponylang/lori) updated first, and from there the rest followed: [ponylang/mare](https://github.com/ponylang/mare), [ponylang/courier](https://github.com/ponylang/courier), [ponylang/postgres](https://github.com/ponylang/postgres), [ponylang/stallion](https://github.com/ponylang/stallion), [ponylang/hobby](https://github.com/ponylang/hobby), [ponylang/livery](https://github.com/ponylang/livery), and [ponylang/github_rest_api](https://github.com/ponylang/github_rest_api) all now require ponyc 0.64.0 or later. If you're upgrading the compiler, plan on upgrading these in step with it.

### hobby 0.8.0 Reaps Idle Connections Again

[ponylang/hobby](https://github.com/ponylang/hobby), the web framework, shipped a real fix alongside its compiler bump. hobby runs an idle timer that reaps connections that have gone quiet. Under sustained kernel resource pressure, the timer's ASIO event subscription could fail, and when it did, the timer was silently cancelled. Idle connections stopped getting reaped, and stale connections piled up. The timer now re-arms itself after a subscription failure, using the duration you configured, and keeps retrying until one sticks. Idle-timeout protection comes back on the next ASIO turn instead of staying off.

### Pony Development Sync

The [recording](https://vimeo.com/1196107576) of the May 27 Pony Development Sync is up.

### ponylang/http and ponylang/http_server Are Officially Deprecated

The deprecation I mentioned last week is now final. [ponylang/http](https://github.com/ponylang/http) and [ponylang/http_server](https://github.com/ponylang/http_server) are officially deprecated and will receive no more updates. [courier](https://github.com/ponylang/courier) is the client and [stallion](https://github.com/ponylang/stallion) is the server going forward.

## Releases

- [ponylang/ponyc 0.64.0](https://github.com/ponylang/ponyc/releases/tag/0.64.0)
- [contact-red/tz 0.1.2](https://github.com/contact-red/tz/releases/tag/0.1.2)
- [ponylang/lori 0.15.0](https://github.com/ponylang/lori/releases/tag/0.15.0)
- [ponylang/mare 0.4.0](https://github.com/ponylang/mare/releases/tag/0.4.0)
- [ponylang/courier 0.3.0](https://github.com/ponylang/courier/releases/tag/0.3.0)
- [ponylang/postgres 0.6.0](https://github.com/ponylang/postgres/releases/tag/0.6.0)
- [ponylang/stallion 0.7.0](https://github.com/ponylang/stallion/releases/tag/0.7.0)
- [ponylang/hobby 0.8.0](https://github.com/ponylang/hobby/releases/tag/0.8.0)
- [ponylang/livery 0.3.0](https://github.com/ponylang/livery/releases/tag/0.3.0)
- [ponylang/github_rest_api 0.5.0](https://github.com/ponylang/github_rest_api/releases/tag/0.5.0)
- [ponylang/regex 1.1.7](https://github.com/ponylang/regex/releases/tag/1.1.7)
- [ponylang/release-notes-bot-action 0.3.12](https://github.com/ponylang/release-notes-bot-action/releases/tag/0.3.12)
- [ponylang/changelog-bot-action 0.3.9](https://github.com/ponylang/changelog-bot-action/releases/tag/0.3.9)
- [ponylang/release-notes-reminder-bot-action 0.1.2](https://github.com/ponylang/release-notes-reminder-bot-action/releases/tag/0.1.2)

## RFCs

### Accepted

- [Json.print() api in stdlib json package](https://github.com/ponylang/rfcs/pull/223)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
