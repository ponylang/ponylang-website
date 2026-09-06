---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - September 6, 2026"
date: 2026-09-06T07:00:00-04:00
---

Welcome back kids. Or I guess, welcome back me? Anyway, we didn't have an issue last week because I jetted off to Fort Worth for a grand old time in the stockyards. Good times were had. Good times indeed. Because we missed a week, we are doubling up on theme songs. We are doing two versions of "Make Way for a Better Man Than You" — [Charley Crockett](https://www.youtube.com/watch?v=7TLLfNMpoH4) and [Willie Nelson](https://www.youtube.com/watch?v=p0wFj1gvdoE).

It's an apropos pairing because Willie has been a huge part of my life (ask me about sitting on his lap as a kid) and if you have been paying close attention, you know I'm a huge Charley Crockett fan — in fact, the trip to Fort Worth was built around seeing him play at Billy Bob's. His show was amazing, including his tribute to Dolly Parton. She will be missed. O how she will be missed. So let's play this week's episode out with her version of [Jolene](https://www.youtube.com/watch?v=Ixrje2rXLMA).

And now, on with the show.

Just a reminder. We do really [appreciate your donations](https://opencollective.com/ponyc). I'm asking everyone to pony up a monthly amount — even $10 would be huge. We are looking to add some new infrastructure and our monthly intake is pretty darn low, so... toss us a bone or eeerrr, whatever the appropriate equine idiom is.

And now, for real this time, on with the show!

<!-- more -->

## ponyc 0.70.0 and 0.70.1

ponyc 0.70.0 is a beast. It's a huge mess of bug fixes. I think there's about thirty. I dunno. It's a lot. I'm not going to count. You can if you want to. But wait! There more... it ain't just bug fixes! There's multiple breaking changes as well. And just to really spice things up, several new features on top of that. I'm going to hit the highlights, but you should [read the full release notes](https://github.com/ponylang/ponyc/releases/tag/0.70.0) because there's a lot more in there.

There are three breaking changes you should know about. First, the compiler now applies the named type's default capability to type parameter constraints. If you relied on the implicit `#any`, you now need explicit capabilities. The most common case is intersection constraints where one member had an explicit cap and the other didn't. If you had `fun test_sort[A: (Comparable[A] val & Stringable)](x: A)`, you now need `Stringable val`. Second, we renamed the PonyCheck generator parameters from `min`/`max` to `from`/`to`. The old names were a silent footgun when `min > max` — unsigned subtraction wrapped and you got wrong output with no warning. If you use named arguments for those parameters, update them. Positional callers are fine. Third, applying a capability to a whole tuple type alias (`FooPair val`) is now a compile error. You need to specify capabilities on each element inside the alias.

Now the fun stuff. Generic type argument inference landed. You can omit type arguments when the compiler can infer them: `Sorter.sort(U8(3), U8(1))` instead of `Sorter.sort[U8](U8(3), U8(1))`. Works for constructors too: `Pair("hello", U8(42))` instead of `Pair[String, U8]("hello", U8(42))`. When only one concrete type implements an interface, the compiler now turns indirect method calls into direct calls. LLVM can then inline across the boundary. This matters most for closures and iterators through generic combinators.

And then there's `\c_api\`, which lets you expose Pony types to C. RFC 18 was accepted ten years ago. A lot has changed with Pony since then, including the addition of annotations and c-shims, so I took a different tack and carried the RFC's spirit forward rather than implementing it as originally written. Annotate a type with `\c_api\` and the compiler generates C-ABI wrapper functions and a `.h` header file.

[0.70.1](https://github.com/ponylang/ponyc/releases/tag/0.70.1) followed the next day with fixes for a few regressions from the type inference work — lambda parameters, consumed `iso`/`trn` arguments, and capability subtype checking. You also get PonyCheck generators for all the persistent collection types.

## Items of Note

### What's Coming

I'm cranking away on more stuff than you can shake a stick at. Here's a peek at four of them.

I'm reworking the package system. I just did a ton of releases this period and most of them happened because a test dependency changed upstream. It's long been a problem that you can't fully test your Pony library without making it so changes in your test dependencies force changes in downstream libraries. That's one of the things I'm solving. There are also some supply chain security issues that aren't serious in most cases but are real, and I want them addressed.

I'm rounding out PonyCheck. Statistics and classification are coming so you can see what your generators actually cover. F32/F64 generators. Stateful and model-based testing. Actors are state machines. Without state-machine testing, PonyCheck can't reach the most valuable territory.

I'm moving [ponylang/lori](https://github.com/ponylang/lori) into the standard library to replace the existing `net/` packages.

I'm exploring bringing back case methods. The old case methods, removed years ago by RFC 51, were fragile sugar over match statements. The new version would dispatch at compile time based on type constraints. You get return type specialization. Today `Array[A].clone()` always returns `ref^` even when `A` is shareable and could return `iso^`. With case methods, the caller would see `iso^` directly, no match, no cast. There's an [RFC request](https://github.com/ponylang/rfcs/issues/240) up.

And a bonus one..

Sylvan and I have been discussing type system soundness. There are a couple of soundness problems we're working on fixing in a principled way.

All of this is to say, expect lots of breaking changes. Especially if the type system changes end up happening. Hoo-doggie, that would be a mess of changes at a biblical level.

### ponylang/lori 0.20.0

[ponylang/lori](https://github.com/ponylang/lori) [0.20.0](https://github.com/ponylang/lori/releases/tag/0.20.0) has UDP alongside TCP. `UDPSocket` uses the same class-in-actor pattern as `TCPConnection`.

### ponylang/msgpack

[ponylang/msgpack](https://github.com/ponylang/msgpack) was transferred from `seantallen-org` to the `ponylang` organization. It was the last library I maintained personally outside the org.

### Docker CI Builder Tag Change

The legacy x86-64-only Docker CI builder images for LibreSSL 3.9.2 and OpenSSL 1.1.1w are now tagged `nightly` instead of `latest`. The newer multi-arch builders were already tagged `nightly`. If your CI workflow pulls one of these images with the `latest` tag, you'll need to switch to `nightly`.

### ponylang/llm-skills Updates

I updated [ponylang/llm-skills](https://github.com/ponylang/llm-skills). If you use them, grab the latest.

### Office Hours

We have two Office Hours to cover. The first was on August 24th.

That one was awesome because Alex Webber made an appearance. He hasn't been around much lately so it was extra good to catch up with him. Beyond that we (Alex, Adrian, Red, and myself) covered a ton of ground. I only know about the first hour. I had to drop but it just kept going for another.

According to the notes, Red gave him a recap of the Carolina Codes talk. We got into security — the model for the new dependency fetcher and `.gitattributes` filter attacks and how you can use them to take over a machine. Red had a lot going on: how he broke ponyc and how to avoid repeating it, ponyradio architecture, running Pony programs on servers with 72 really slow cores, and his meminfo package and how it still works after the allocator swap. We also talked about [ponylang/ponyc PR #5792](https://github.com/ponylang/ponyc/pull/5792), sequence and dataflow diagrams for async message sends, how many new contributors have come to the project since llm-skills, the mechanics of opening PRs against Pony projects, `__builtin_popcount` and friends, and magical ringbuffers and how you'd implement one in Pony.

On the 31st it was Adrian, Red, and me. We talked about whether writing a compiler specifically for a Pony LSP would be worth it, query-based compilers, term-rewriting compilers, and general compiler stuff.

Hey Alex, show up more often. Hey other people, show up at all. We love when new folks join the mix. So I guess this week I am saying... give money, come to Office Hours. Weird message, but *shrug*... yup.

### Pony Development Sync

The August 26th sync has a [recording](https://vimeo.com/1221580069) but I forgot to turn on the transcript, so there's no summary.

The September 2nd sync was short and not recorded. A couple of PRs merged. Red and I discussed a couple things synchronously that we'd been discussing privately.

### Schedule Changes

No Office Hours on September 7 (US holiday), September 14 (I'm traveling for work), or September 28 (traveling for work again). No Pony Development Sync on September 16 or September 28 (same reason).

## Releases

- [ponylang/ponyc 0.70.0](https://github.com/ponylang/ponyc/releases/tag/0.70.0)
- [ponylang/ponyc 0.70.1](https://github.com/ponylang/ponyc/releases/tag/0.70.1)
- [ponylang/peg 0.1.8](https://github.com/ponylang/peg/releases/tag/0.1.8)
- [ponylang/ssl 5.0.0](https://github.com/ponylang/ssl/releases/tag/5.0.0)
- [ponylang/uri 0.4.0](https://github.com/ponylang/uri/releases/tag/0.4.0)
- [ponylang/crdt 0.2.0](https://github.com/ponylang/crdt/releases/tag/0.2.0)
- [ponylang/msgpack 0.4.0](https://github.com/ponylang/msgpack/releases/tag/0.4.0)
- [ponylang/valbytes 0.7.0](https://github.com/ponylang/valbytes/releases/tag/0.7.0)
- [ponylang/lori 0.20.0](https://github.com/ponylang/lori/releases/tag/0.20.0)
- [ponylang/courier 0.8.0](https://github.com/ponylang/courier/releases/tag/0.8.0)
- [ponylang/github_rest_api 0.10.0](https://github.com/ponylang/github_rest_api/releases/tag/0.10.0)
- [ponylang/stallion 0.11.0](https://github.com/ponylang/stallion/releases/tag/0.11.0)
- [ponylang/hobby 0.12.0](https://github.com/ponylang/hobby/releases/tag/0.12.0)
- [ponylang/mare 0.8.0](https://github.com/ponylang/mare/releases/tag/0.8.0)
- [ponylang/templates 0.4.0](https://github.com/ponylang/templates/releases/tag/0.4.0)
- [ponylang/livery 0.9.0](https://github.com/ponylang/livery/releases/tag/0.9.0)
- [ponylang/postgres 0.10.0](https://github.com/ponylang/postgres/releases/tag/0.10.0)

## RFCs

### Withdrawn

[RFC #43 (gencap-write)](https://github.com/ponylang/rfcs/pull/238) was withdrawn.

### Implemented

[RFC #18 (export)](https://github.com/ponylang/rfcs/blob/main/text/0018-export.md) was [implemented](https://github.com/ponylang/ponyc/pull/5898).

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang-website/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
