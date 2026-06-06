---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - June 7, 2026"
date: 2026-06-07T07:00:06-04:00
---

This week's theme song is Willie Nelson's ["Uncloudy Day"](https://www.youtube.com/watch?v=pAWltTBhaF0). Last week shipped with some brimstone in it, and this week the skies cleared. No releases went out, but main kept filling up, and the headline is that RFC 86 is implemented. The stdlib `json` package now has a way to turn any `JsonValue` back into a string.

<!-- more -->

## RFC 86 Implemented: A JsonPrinter for the stdlib

The `json` package gave you a `JsonParser` for reading JSON into a `JsonValue`. Going the other way was the awkward part. [PR #5397](https://github.com/ponylang/ponyc/pull/5397) implements [RFC 86](https://github.com/ponylang/rfcs/blob/main/text/0086-json-encode-jsonvalue.md) and fixes that. There's now a `JsonPrinter` primitive, and it serializes any `JsonValue` you hand it — objects, arrays, and scalars alike — into a JSON string.

That "any value" part is the whole point. The old way out was `string()` on `JsonObject` and `JsonArray`, inherited from `Stringable`. It worked for objects and arrays, but the moment a bare scalar or a `None` reached `.string()`, you got something that wasn't valid JSON. `None` came back as `None`. Strings came back unescaped. `JsonPrinter.print` serializes the lot correctly, whatever the shape.

Making `JsonPrinter` the right answer meant taking the wrong one away. `JsonObject` and `JsonArray` no longer implement `Stringable`, and their serialization methods are renamed: `string()` becomes `print()` and `pretty_string()` becomes `pretty_print()`. The objects and arrays keep those as convenience methods, so the common case stays a one-liner. This is a breaking change for `json` package users, and it isn't in a release yet. It's on main, headed for the next ponyc at the end of the month.

## Items of Note

### Library Updates Are Coming With the JSON Change

When the next ponyc ships, the JSON breaking change ships with it, and a handful of libraries that lean on the stdlib `json` package will need releases to match. [ponylang/github_rest_api](https://github.com/ponylang/github_rest_api), [ponylang/livery](https://github.com/ponylang/livery), and [ponylang/ponyup](https://github.com/ponylang/ponyup) all use the package directly and will get updated. If you build on any of these, plan to bump them when you move to the next compiler. None of it has shipped yet.

### The Next ponyc Is Taking Shape

Beyond the JSON work, a run of compiler robustness fixes landed on main this week, all of it headed for the next release. A batch of crashes got fixed: control expressions that jump away in a value position ([PR #5406](https://github.com/ponylang/ponyc/pull/5406)), partial application of a method with a literal default argument ([PR #5412](https://github.com/ponylang/ponyc/pull/5412)), and `while` and `repeat` loops that jump away ([PR #5418](https://github.com/ponylang/ponyc/pull/5418)). Two recursive-type shapes that used to spin the compiler now get a clean error instead: infinitely recursive generic types ([PR #5411](https://github.com/ponylang/ponyc/pull/5411)) and self-referential type parameter constraints ([PR #5403](https://github.com/ponylang/ponyc/pull/5403)).

There's some plumbing too. Partial and non-partial methods now get [separate vtable slots](https://github.com/ponylang/ponyc/pull/5396), and the unused serialization subsystem [came out](https://github.com/ponylang/ponyc/pull/5417). That last one came up at the development sync, so more on it below.

### Office Hours

Office Hours on June 1, with Red, Adrian, and me. It wandered the way it does. We talked keyboards and Unicode, and had a laugh at what Claude said were the gaps keeping the Pony ecosystem from "mass adoption" when someone asked it. Red brought his http11 test suite, his GTK work, and his use of the "pony compiler." The rest ranged across macros, Pony in Pony, clang in ponyc, the bad idea that was corral's script commands, and package hierarchy. We closed on [RFC 229](https://github.com/ponylang/rfcs/pull/229), Red's type-layout intrinsics proposal.

### Pony Development Sync

The [recording](https://vimeo.com/1198184025) of the June 3 Pony Development Sync is up. Most of the meeting was pull request review, with one thread worth calling out. The team talked through removing the signature code from the serialization subsystem, and I confirmed it would make the stringtab thread-safety work ([#5273](https://github.com/ponylang/ponyc/issues/5273)) cleaner to implement. That's the same cleanup that landed on main this week.

On the PRs: the macOS universal binary work was closed, since Intel macOS support has ended and there's nothing left to bundle. The separate vtable slots for partial and non-partial methods were approved and merged. A round of compiler crash fixes went through, along with error message improvements for type-parameter constraints and capability errors, where Joe McIlvain pushed for wording that's clearer and more pedantically correct. The ponyup pre-built binaries documentation PR was closed for carrying outdated information. Triage closed an old issue asking for GCC support on Windows. The original motivation has faded now that free build tools are available.

## RFCs

### Implemented

- [Json.print() api in stdlib json package](https://github.com/ponylang/rfcs/pull/223)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
