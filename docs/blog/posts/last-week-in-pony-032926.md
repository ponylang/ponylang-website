---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - March 29, 2026"
date: 2026-03-29T07:00:06-04:00
---

ponyc 0.62.1 is out and you need to update. There's a type system soundness hole in there, a Windows crash that we didn't fully nail last time, and a bunch more. Beyond ponyc, ponylang/hobby threw out its old handler model and rebuilt it around actors the way Pony wants you to build things. Big week. Let's crank up an oldie but a goodie, ["Son of a Pig Farmer"](https://krylls.bandcamp.com/track/son-of-a-pig-farmer) by Krylls, and get into it.

<!-- more -->

## ponyc 0.62.1

[ponyc](https://github.com/ponylang/ponyc) 0.62.1 is a bug fix release. Update as soon as possible.

The headline fix is a type system soundness hole. The compiler was letting you duplicate `iso` references in certain patterns involving arrow types. Code like this compiled but shouldn't have:

```pony
class Container[A]
  var inner: A
  fun get(): this->A =>
    let tmp = inner  // aliases to this->A!
    consume tmp      // consume doesn't undo the alias
```

The fix is to return the field directly instead of going through a local. If you had code using `val->A!` in similar patterns, change it to `val->A`. The persistent list in `collections/persistent` had four signatures that relied on this bug, and those are fixed.

Windows got a lot of attention this release. The big one is a use-after-free crash in the IOCP (I/O Completion Ports) layer. When a socket is closed, completion callbacks can still fire after the owning actor has freed the associated event, leaving the callback with a dangling pointer. The 0.62.0 release tried to fix this by checking for specific error codes, but that wasn't sufficient since Windows can deliver completions with other error codes too. The new fix is more fundamental: each event gets a shared liveness token with an atomic dead flag. When the event is destroyed, the flag gets set. Callbacks check it before touching anything. Beyond that, Windows path handling was broken in both `pony-lint` and `pony-lsp`, and both now have Windows CI to prevent regressions.

The compiler was also silently accepting some type parameter constraints that should have been rejected. If you had a constraint where the capabilities couldn't all be satisfied at once, the compiler would let it through instead of reporting an error.

See the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.62.1) for the full list.

## ponylang/hobby 0.4.0

[ponylang/hobby](https://github.com/ponylang/hobby) is a web framework for Pony, built on top of [ponylang/stallion](https://github.com/ponylang/stallion). Version 0.4.0 is a massive API change that redesigns how request handlers work, and the result is a much better framework.

The old handler model was synchronous. Your handler ran inside the connection actor, did its work, and returned a response. That's fine when all you need to do is build a response from what's already in memory. But the moment you need to talk to a database, call another service, or do anything that requires waiting for an answer from another actor, you're stuck. Pony is built around actors communicating asynchronously, and hobby's old handler model fought that instead of embracing it.

The new model gives each request its own actor. Your handler is an actor that receives the request context, does whatever async work it needs to do, and responds when it's ready. Simple routes that don't need async can still respond inline with a lambda, but the important thing is that async handlers are now the natural path instead of a workaround:

```pony
actor GetUserHandler
  embed _handler: hobby.RequestHandler

  new create(ctx: hobby.HandlerContext iso, db: Database tag) =>
    _handler = hobby.RequestHandler(consume ctx)
    db.query(this)

  be result(data: String) =>
    _handler.respond(stallion.StatusOK, data)
```

Your handler is an actor. It talks to the database, gets a callback, and responds. This is just how Pony works, and now hobby works with it instead of against it.

Middleware got a redesign too. Response headers are now buffered until after all middleware runs, so after-middleware can actually modify headers before they hit the wire. That was impossible before. hobby 0.4.1 followed with signed cookie support, which builds on the buffered response work.

See the [design discussion](https://github.com/ponylang/hobby/discussions/41) for the full rationale.

## ponylang/ponyup 0.15.0

[ponylang/ponyup](https://github.com/ponylang/ponyup) is the tool you use to install and manage Pony toolchain versions. The 0.15.0 release cleans up the CLI in ways that have been bugging me for a while.

The `--platform` flag is gone. You used to have to pass it to `find`, `remove`, `update`, and `select`, which was tedious and error-prone. Platform is now determined from a `.platform` file in ponyup's data directory. Run `ponyup default` to set it once and forget about it.

The other change is how you specify versions. Channel and version used to be jammed together with a dash, like `release-0.33.1`. That always felt wrong. Now they're separate arguments:

```sh
# Before
ponyup update ponyc release-0.33.1

# After
ponyup update ponyc release 0.33.1
```

Omit the version to get the latest, same as before.

## Items of Note

### Pony Gets a Template Engine

A [blog post](https://www.ponylang.io/blog/2026/03/pony-gets-a-template-engine/) about [ponylang/templates](https://github.com/ponylang/templates) went up this week. If you've ever had to think about XSS in template output, the contextual auto-escaping story alone is worth the read.

### Pony Gets an Embedded Linker

A [blog post](https://www.ponylang.io/blog/2026/03/pony-gets-an-embedded-linker/) covering the embedded LLD linker work that landed in ponyc 0.61.1. If you've ever wondered why Pony shelled out to the system linker and what it took to stop, it's a good read.

### VS Code Extension 0.3.0

[ponylang/vscode-extension](https://github.com/ponylang/vscode-extension) 0.3.0 is out. The big change: it requires `pony-lsp` 0.61.0 or above, which auto-locates the standard library, so the `pony.ponyStdLibPath` setting is gone. You also get the Pony icon in the sidebar, and you can now point the extension at a custom LSP executable and `ponypath` if you need non-default locations.

### Update Your Networking Libraries

A round of bug fixes landed across the networking ecosystem this week. Update [ponylang/lori](https://github.com/ponylang/lori) to 0.13.0, [ponylang/stallion](https://github.com/ponylang/stallion) to 0.5.3, [ponylang/mare](https://github.com/ponylang/mare) to 0.2.3, [ponylang/courier](https://github.com/ponylang/courier) to 0.1.4, [ponylang/livery](https://github.com/ponylang/livery) to 0.1.3, and [ponylang/github_rest_api](https://github.com/ponylang/github_rest_api) to 0.3.1. Don't wait on these.

### Pony Development Sync

The [recording](https://vimeo.com/1177124742) of the March 25, 2026 Pony Development Sync is available.

We reviewed the `--shuffle` RFC, which is now accepted, and worked through subtype checker fixes for arrow types and match capture bindings. The `serialise` package removal came up too. We also discussed updates to Pony Patterns and potential improvements to Windows and POSIX IO functions.

### Office Hours

I had fixes for three type soundness bugs in ponyc, and Sylvan stopped by to go over them with Red and me. He signed off on two. The third, he had another idea for, so I'll be approaching that one differently.

## Releases

- [ponylang/changelog-bot-action 0.3.8](https://github.com/ponylang/changelog-bot-action/releases/tag/0.3.8)
- [ponylang/courier 0.1.2](https://github.com/ponylang/courier/releases/tag/0.1.2)
- [ponylang/courier 0.1.3](https://github.com/ponylang/courier/releases/tag/0.1.3)
- [ponylang/courier 0.1.4](https://github.com/ponylang/courier/releases/tag/0.1.4)
- [ponylang/github_rest_api 0.3.1](https://github.com/ponylang/github_rest_api/releases/tag/0.3.1)
- [ponylang/hobby 0.4.0](https://github.com/ponylang/hobby/releases/tag/0.4.0)
- [ponylang/hobby 0.4.1](https://github.com/ponylang/hobby/releases/tag/0.4.1)
- [ponylang/livery 0.1.1](https://github.com/ponylang/livery/releases/tag/0.1.1)
- [ponylang/livery 0.1.2](https://github.com/ponylang/livery/releases/tag/0.1.2)
- [ponylang/livery 0.1.3](https://github.com/ponylang/livery/releases/tag/0.1.3)
- [ponylang/lori 0.12.0](https://github.com/ponylang/lori/releases/tag/0.12.0)
- [ponylang/lori 0.13.0](https://github.com/ponylang/lori/releases/tag/0.13.0)
- [ponylang/mare 0.2.2](https://github.com/ponylang/mare/releases/tag/0.2.2)
- [ponylang/mare 0.2.3](https://github.com/ponylang/mare/releases/tag/0.2.3)
- [ponylang/ponyc 0.62.1](https://github.com/ponylang/ponyc/releases/tag/0.62.1)
- [ponylang/ponyup 0.13.0](https://github.com/ponylang/ponyup/releases/tag/0.13.0)
- [ponylang/ponyup 0.13.1](https://github.com/ponylang/ponyup/releases/tag/0.13.1)
- [ponylang/ponyup 0.14.0](https://github.com/ponylang/ponyup/releases/tag/0.14.0)
- [ponylang/ponyup 0.15.0](https://github.com/ponylang/ponyup/releases/tag/0.15.0)
- [ponylang/release-notes-bot-action 0.3.11](https://github.com/ponylang/release-notes-bot-action/releases/tag/0.3.11)
- [ponylang/stallion 0.5.2](https://github.com/ponylang/stallion/releases/tag/0.5.2)
- [ponylang/stallion 0.5.3](https://github.com/ponylang/stallion/releases/tag/0.5.3)
- [ponylang/vscode-extension 0.3.0](https://github.com/ponylang/vscode-extension/releases/tag/0.3.0)

## RFCs

### Accepted

- [Add --shuffle option to PonyTest](https://github.com/ponylang/rfcs/pull/224)

### New

- [Remove serialise package from stdlib](https://github.com/ponylang/rfcs/pull/225)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
