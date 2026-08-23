---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - August 23, 2026"
date: 2026-08-23T07:00:00-04:00
---

Here's how it is. Back in 2017, we put in a style guide for Pony and without thinking about it, we accidentally encoded a serious footgun into it. Ooops. Shit. It wasn't noticed until this week when I was working on using `pony-lint` on the standard library. The style guide's operator continuation convention (binary operators at start of continuation lines) interacted badly with the parser. Pony has no `;` or anything of the sort to end an expression, so to make something like returning a negative number work, the parser treats any `-` at the beginning of a line as negation, not subtraction. That silently broke `Timer.abs` for nine years. The convention is reversed and the linter now catches it.

So, what's the issue? Pony's syntax is a little clever. The style guide said put binary operators at the start of continuation lines. And oops, ya, that put you right into "incorrect."

Odds are, this isn't an issue for you. In all the ponylang organization code, I found exactly one instance of this as a problem. But it is still a footgun that was lurking. The style guide has been changed. No longer will it be:

```pony
a
+ b
```

for operator continuation. It will now be:

```pony
a +
b
```

because that avoids the footgun. If you are using `pony-lint`, know that you will get a bunch of new errors because the rule was flipped around. And hey, it's just another data point in my campaign for "explicit is better than implicit" and my righteous campaign to make everyone realize that "clever" should be an insult.

And in the meantime, while you are reading about the mass of releases that happened this week, listen to the fairly apropos [Effity Eff](https://www.youtube.com/watch?v=9K2uaKaJuy8). Read quick though, it's a damn short song.

<!-- more -->

## ponyc 0.69.0

I'm breaking from the usual format here because there's too much in this release to pick one thing and highlight it.

There are four breaking changes. To close a nasty `ProcessMonitor` bug correctly, we had to cut off Linux kernels prior to 5.3. `ProcessMonitor` itself was rewritten, so if your code uses it, you'll need to update it. The standard library was made Style Guide compliant, which introduced breaking changes into the JSON package, and, just for fun, we introduced a couple of other JSON breaking changes to improve memory usage and performance. And there's a breaking change to `InputNotify` as part of making input handling better and more readline-like.

The new allocator is the centerpiece. For almost every use case I tested, it results in better throughput and memory usage than the old allocator. One use case had much better memory but worse throughput. Nothing about user programs needs to change. There's a new `--ponymemoryprofile` runtime option that takes a value from 1 (smallest footprint) to 10 (most throughput) so you can trade memory for throughput. The default is 3.

There are a pile of fixes in this release, but my favorite is the cmake versioning bug. Since we switched to cmake a couple months back, the build system wasn't updating the version correctly. The version from the first configure never changed. Each install was an additive overwrite, so both old and new files ended up on disk. I found the bug because I renamed some files while linting the stdlib, then an install produced compile errors from both old and new names existing. Almost no one is likely to hit this bug, but it will be hell to track down for anyone who might have hit it.

Expect more big releases like this for a while. I have [a lot planned](https://www.youtube.com/watch?v=REqic8eN6BE).

## Items of Note

### ponyc 0.69.1

Almost immediately after 0.69.0 was released, I started updating [ponylang/lori](https://github.com/ponylang/lori) to the newest version and found a bug in Pony's trait name resolution. When a generic type has a default type argument naming a type in its own package, using that generic from a consumer that imports the package with an alias fails with "can't find definition of." Fixed, shipped. Two releases in one week. One big. One about as small as a release can get.

### ponylang/lori 0.19.0

Working on [ponylang/lori](https://github.com/ponylang/lori) [0.19.0](https://github.com/ponylang/lori/releases/tag/0.19.0) is how I found the 0.69.1 compiler bug, but the real story is mockable backends. `TCPConnection` and `TCPListener` are now generic over `TCPBackend`. `TCPBackend` is a public trait, so a test fake that implements it can drive the connection state machine without real sockets. The default is `RuntimeBackend`, so existing code compiles unchanged.

The testing you can do with this is single-actor. The ASIO backend (Pony's async I/O event system) is still live, which limits mocking to one actor's view of the world, not cross-actor interactions. I am exploring how to do mockable ASIO backends that provide real value. Nothing might come of that. Pure awesomeness might come from it.

As of lori 0.19.0, lori and all the libraries that depend on it now require ponyc 0.69.1 or later to compile.

### contact-red/yaml 0.1.0

Red released a YAML reader for Pony. The repo is [contact-red/yaml](https://github.com/contact-red/yaml).

Scalars have no type until you ask for one. `1.20` is the text `1.20`, `NO` is the text `NO`, `0755` is the text `0755`. You assign meaning when you ask for a type, so a country code does not become `false` and a version string does not become a float.

There are three entry points: `YamlLoad` parses source and binds onto your types (you get your value, or every problem found while producing it), `YamlParser.parse` walks a node tree, and `YamlCursor` gives you an event stream without building a tree. Red has run 402 official yaml-test-suite cases against it. This is 0.x software, so expect the API to shift.

### No Last Week in Pony on August 30th

I'm traveling next weekend. I'll be back with a double issue on September 6th.

### Office Hours

Office Hours was August 17th. Just me and Red. We talked about the Carolina Codes conference and Red's experience there, Red building a matrix server in Pony, a `String` bug, xml > json > yaml (according to me; Red only conceded xml > json), a GitHub outage, matrix servers and IRC and the ephemerality of messages and history, the new allocator and Red's thing that reads the internals of the old allocator, and what [ponylang/pyrois](https://github.com/ponylang/pyrois) will become.

### Pony Development Sync

A light sync this week, August 19th. Just me and Adrian. Most of the time went to [ponylang/pony-tutorial 469](https://github.com/ponylang/pony-tutorial/issues/469): the tutorial's actors section never shows you how to instantiate one. Adrian posted proposed text in the [Zulip tutorial channel](https://ponylang.zulipchat.com/#narrow/channel/190368-tutorial/topic/Proposed.20text.20for.20Issue.20469). Adrian starts with classes (which the reader already knows), shows that you create an actor the same way you create an object, then adds an example of calling a behavior. I reviewed the additions and thought they were a good fit. Adrian will open a PR.

[Recording](https://vimeo.com/1219652455).

## Releases

- [ponylang/ponyc 0.69.0](https://github.com/ponylang/ponyc/releases/tag/0.69.0)
- [ponylang/ponyc 0.69.1](https://github.com/ponylang/ponyc/releases/tag/0.69.1)
- [ponylang/lori 0.19.0](https://github.com/ponylang/lori/releases/tag/0.19.0)
- [ponylang/courier 0.7.0](https://github.com/ponylang/courier/releases/tag/0.7.0)
- [ponylang/mare 0.7.0](https://github.com/ponylang/mare/releases/tag/0.7.0)
- [ponylang/stallion 0.10.0](https://github.com/ponylang/stallion/releases/tag/0.10.0)
- [ponylang/postgres 0.9.0](https://github.com/ponylang/postgres/releases/tag/0.9.0)
- [ponylang/hobby 0.11.0](https://github.com/ponylang/hobby/releases/tag/0.11.0)
- [ponylang/livery 0.8.0](https://github.com/ponylang/livery/releases/tag/0.8.0)
- [ponylang/changelog-tool 0.5.3](https://github.com/ponylang/changelog-tool/releases/tag/0.5.3)
- [ponylang/github_rest_api 0.9.0](https://github.com/ponylang/github_rest_api/releases/tag/0.9.0)
- [contact-red/yaml 0.1.0](https://github.com/contact-red/yaml/releases/tag/0.1.0)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang-website/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
