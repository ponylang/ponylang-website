---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - April 12, 2026"
date: 2026-04-12T07:00:06-04:00
---

I'm going to be traveling a lot during the next couple weeks, so our theme song this week is Willie Nelson's ["On the Road Again"](https://www.youtube.com/watch?v=dBN86y30Ufc). A true classic. And for a true story: once upon a time I was a young child and met another kid while we were both sitting on Willie's lap at his 4th of July picnic. Years later, I met him again at a bar in NYC when he came up from Texas to hang out with a good friend who was one of my best friends. Small world, right? Willie Nelson, bringing together awesome people since the time of the dinosaurs.

All that aside, we have some great stuff as usual happening in Pony land. ponyc 0.63.1 is out and has safety-related fixes you need. ponylang/postgres 0.3.0 is a monster of a release. A pile of networking libraries went out that you'll want to grab. And there's a whole pitch to make about LLMs and Pony. Let's dig in, because it all just fucking rocks. Get on board this train while there is still time. That's what I'm saying. Get the fuck on board. Oh, and Cloudsmith has throttled us until the end of the day today UTC so, sorry, you can't download any prebuilt binaries until that has lifted.

<!-- more -->

## ponyc 0.63.1

[ponyc](https://github.com/ponylang/ponyc) 0.63.1 has several safety-related fixes. Update as soon as possible. Aka Monday UTC.

The biggest is a soundness hole in match capture bindings. A match `let` capture with a viewpoint-adapted or generic type could bypass capability checks and hand you a second `iso` reference to the same object. A direct `let x: Foo iso` was correctly rejected, but `let x: this->B iso` and `let x: this->T` where `T` could be `iso` slipped through, because viewpoint adaptation through `box` erases the ephemeral marker the existing check relied on. The compiler now checks whether a capture type has a capability that would change under aliasing and rejects the capture when the match expression isn't ephemeral. Code that was accepted before and now fails was unsound and could segfault at runtime. The fix, when you hit it, is to `match consume x` so the discriminee is ephemeral.

A related fix: matching a tuple element against a union or interface type when the tuple was accessed through `Any val` caused a segfault at runtime. No more.

Two more compiler fixes worth naming. Interfaces with multiple type parameters where one parameter appeared as a type argument to the same interface would fail to type check. The compiler replaced type variables one at a time during reification, so replacing `S` could inadvertently transform another parameter's constraint before that parameter was processed. All type variables are now replaced in a single pass. And `this->` in a lambda type parameter was desugared so that `this` referred to the anonymous interface's own receiver instead of the enclosing class's receiver, which meant wrong vtable dispatch, incorrect results, or segfaults when the lambda was forwarded. That's fixed.

On the runtime side, the OS could fail to register an I/O event or arm a timer and the failure would be silently ignored. Actors waited for notifications that would never fire: connections that never complete, listeners that stop accepting, timers that stop firing, all with no indication of what went wrong. The runtime now detects registration failures and delivers an `ASIO_ERROR` notification to the affected actor. Stdlib consumers like `TCPConnection`, `TCPListener`, and `Timers` handle it automatically. If you implement `AsioEventNotify` yourself, check `AsioEvent.errored(flags)` and tear down. Linux, macOS, and BSD all get this.

pony-lsp got a batch of work. New support for `textDocument/documentHighlight`, `textDocument/inlayHint`, and `textDocument/references`. Go-to-definition now works on type alias names and on type arguments inside generic type aliases. A hang on shutdown is fixed, as is a startup hang on Windows caused by text-mode stdout translating `\n` to `\r\n` and mangling the LSP header separator. The off-by-one in `goto_definition`'s range end is corrected.

pony-lint picked up hierarchical `.pony-lint.json` configuration, so a subdirectory config overrides the project root config for the subtree it covers. There's also a new `style/docstring-leading-blank` rule that flags a blank line between the opening `"""` and the first line of content.

See the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.63.1) for the full list.

## ponylang/postgres 0.3.0

[ponylang/postgres](https://github.com/ponylang/postgres) 0.3.0 is the release the driver's been building toward. Parameterized queries via the extended query protocol, named prepared statements, SSL/TLS, query cancellation, a redesigned `Session` constructor built around `ServerConnectInfo` and `DatabaseConnectInfo`, receivers that get the session handed to them so they can chain operations without stashing a reference, equality for `Field`, `Row`, and `Rows`, a Terminate message on close so the server stops holding resources for you, and a handful of bug fixes cleaning up edge cases in error delivery and result typing. Oh, and `SesssionNeverOpened` no longer has three s's in the middle.

That's a lot of stuff and it all matters. I wrote [a whole blog post](https://www.ponylang.io/blog/2026/04/ponys-postgres-driver-grows-up/) about why this release is a big deal and what you can do with it now that you couldn't before. Go read it.

## Update Your Networking Libraries

Two waves of networking library releases hit this week, both worth taking.

Early in the week, a backpressure stall fix landed in [ponylang/lori](https://github.com/ponylang/lori) 0.13.1 and cascaded out. Connections could stop processing incoming data after completing a large write that triggered backpressure, hanging until someone closed the socket. Pick up lori 0.13.1, stallion 0.5.5, courier 0.1.5, hobby 0.6.1, mare 0.2.4, livery 0.1.4, github_rest_api 0.3.2, postgres 0.3.1, and ponyup 0.15.2. github_rest_api also fixed a race where closing a connection during setup could crash the program, which was unlikely but possible, particularly on arm64.

The second wave is tied to the `ASIO_ERROR` infrastructure in ponyc 0.63.1. lori 0.14.0 handles the new notifications across listeners, connections, and timers, and adds a `ConnectionFailedTimerError` case to `ConnectionFailureReason` for when a connect timer's subscription fails. The rest of the networking ecosystem followed to require ponyc 0.63.1 and pick up the same detection: stallion 0.6.0, hobby 0.7.0, mare 0.3.0, courier 0.2.0, livery 0.2.0, github_rest_api 0.4.0, and postgres 0.4.0. These releases require ponyc 0.63.1 and will not build against earlier compiler versions. If you're not ready to update ponyc, stay on the older library releases. If you match exhaustively on `ConnectionFailureReason`, you'll need a case for the new variant.

If you use any of these libraries, update everything together. The ponyc and library releases were designed to go out as a set.

## Claude You Some Pony For Great Good

Look ma, we got LLM skills to help you write Pony. [ponylang/llm-skills](https://github.com/ponylang/llm-skills) is a repo of Claude Code skills covering design, code review, test design, debugging, and the Pony language reference, and it's ready for you to use. For the impatient: clone the repo and run the install script. For the patient: I wrote [a blog post about it](https://www.ponylang.io/blog/2026/04/claude-you-some-pony-for-great-good/) that walks through what's in there, why it exists, and how to get the most out of it. Go read the post, then go get the skills.

## Pony and LLMs Virtual Users' Group?

There's been a lot of interest lately in how Pony and LLMs fit together, between the llm-skills work, the recent blog posts, and conversations on Zulip. I'm wondering if there's enough appetite for a virtual users' group specifically about it. If that sounds good to you, [stop by Zulip and say so](https://ponylang.zulipchat.com/#narrow/channel/189934-general/topic/LLMs.20and.20Pony.20VUG.3F/with/579341477). If I hear "yes please" enough, I'll put something together.

## Items of Note

### Cloudsmith Migration

I've started working on a plan to migrate from Cloudsmith to GitHub for hosting releases. Cloudsmith throttles the organization when too many downloads happen. GitHub throttles individuals. That's a much better model for us. The transition will be as seamless as I can make it, and I plan to move all the releases currently hosted on Cloudsmith over to GitHub. You'll be able to get rate limited by GitHub if you try to download too much in too short a window, but that's much better than the whole organization getting turned off. Expect more details over the next two or three weeks as I roll the transition out.

### VS Code Extension Renamed

[ponylang/vscode-extension](https://github.com/ponylang/vscode-extension) 0.4.0 is a rename. The extension is now published as `ponylang-vscode-extension` on the marketplace, because `pony` and `ponylang` were already taken. If you have the old version installed, go grab the re-published one.

### Fedora 42 Support Ending

We're dropping Fedora 42 support at the end of the month. Fedora 42 is about to hit end of life. There's no plan to add support for a more recent Fedora version right now. If you'd like that to happen, let us know on Zulip.

### I'm Traveling the Next Two Weeks

I'll be away for work the next two weeks and won't be at the Pony Development Sync on either week. I also won't be at Office Hours on April 20th, but anyone and everyone is welcome to show up and chat amongst themselves. I'm not required, though clearly I'm the most fun. If you're going to [Bug Bash](https://antithesis.com/bugbash/conference2026/) or [NYC Systems](https://nycsystems.xyz/2026/april.html) this coming Thursday, say hi. Next week's LWIP will likely come out late. It'll happen, just not on time.

### Office Hours

Red and I were there this week. Red showed off what you can do with [contact-red/equestuia](https://github.com/contact-red/equestuia), his pure-Pony immediate-mode TUI framework that just shipped its first release. We went through [ponyc PR 5134](https://github.com/ponylang/ponyc/pull/5134), which became part of the 0.63.1 tuple-via-Any segfault fix. Red's ODBC driver got a harsh review from [pony-code-review](https://github.com/ponylang/llm-skills/tree/main/pony-code-review), which is exactly what you want from a code reviewer. The new hobby API came up, as did pony-doc and the ergonomics of setting up llm-skills. The best line of the session belongs to Red, who figured out a brilliant prompt to aim at a codebase: "Are there any patterns in this repo that you believe should be in the language's standard library?" And because why not, we also ended up reading about [BeOS's Interface Kit](https://www.haiku-os.org/legacy-docs/bebook/TheInterfaceKit_Overview_Introduction.html).

### Pony Development Sync

The [recording](https://vimeo.com/1181342783) of the April 8, 2026 Pony Development Sync is available.

Joe and I went through a stack of compiler PRs. [PR 5145](https://github.com/ponylang/ponyc/pull/5145) on type alias expansion during name resolution, where I walked through the approach of preserving alias identity through the compiler pipeline. [PR 5134](https://github.com/ponylang/ponyc/pull/5134) for the segfault in tuple matching against unions or interfaces via `Any`. [PR 3664](https://github.com/ponylang/ponyc/pull/3664), which closed out a long-standing interface type parameter issue originally reported in 2017. [PR 4975](https://github.com/ponylang/ponyc/pull/4975) on the match capture soundness hole, and [PR 5127](https://github.com/ponylang/ponyc/pull/5127) on the lambda `this->` codegen fix. Most of the above made it into 0.63.1.

## Releases

- [contact-red/equestuia 0.1.2](https://github.com/contact-red/equestuia/releases/tag/0.1.2)
- [ponylang/courier 0.1.5](https://github.com/ponylang/courier/releases/tag/0.1.5)
- [ponylang/courier 0.2.0](https://github.com/ponylang/courier/releases/tag/0.2.0)
- [ponylang/github_rest_api 0.3.2](https://github.com/ponylang/github_rest_api/releases/tag/0.3.2)
- [ponylang/github_rest_api 0.4.0](https://github.com/ponylang/github_rest_api/releases/tag/0.4.0)
- [ponylang/hobby 0.6.1](https://github.com/ponylang/hobby/releases/tag/0.6.1)
- [ponylang/hobby 0.7.0](https://github.com/ponylang/hobby/releases/tag/0.7.0)
- [ponylang/livery 0.1.4](https://github.com/ponylang/livery/releases/tag/0.1.4)
- [ponylang/livery 0.2.0](https://github.com/ponylang/livery/releases/tag/0.2.0)
- [ponylang/lori 0.13.1](https://github.com/ponylang/lori/releases/tag/0.13.1)
- [ponylang/lori 0.14.0](https://github.com/ponylang/lori/releases/tag/0.14.0)
- [ponylang/mare 0.2.4](https://github.com/ponylang/mare/releases/tag/0.2.4)
- [ponylang/mare 0.3.0](https://github.com/ponylang/mare/releases/tag/0.3.0)
- [ponylang/ponyc 0.63.1](https://github.com/ponylang/ponyc/releases/tag/0.63.1)
- [ponylang/ponyup 0.15.2](https://github.com/ponylang/ponyup/releases/tag/0.15.2)
- [ponylang/postgres 0.3.0](https://github.com/ponylang/postgres/releases/tag/0.3.0)
- [ponylang/postgres 0.3.1](https://github.com/ponylang/postgres/releases/tag/0.3.1)
- [ponylang/postgres 0.4.0](https://github.com/ponylang/postgres/releases/tag/0.4.0)
- [ponylang/semver 0.2.5](https://github.com/ponylang/semver/releases/tag/0.2.5)
- [ponylang/stallion 0.5.5](https://github.com/ponylang/stallion/releases/tag/0.5.5)
- [ponylang/stallion 0.6.0](https://github.com/ponylang/stallion/releases/tag/0.6.0)
- [ponylang/vscode-extension 0.4.0](https://github.com/ponylang/vscode-extension/releases/tag/0.4.0)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
