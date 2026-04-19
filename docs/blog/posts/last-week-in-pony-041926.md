---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - April 19, 2026"
date: 2026-04-19T07:00:06-04:00
---

Two theme songs this week. The topical pick is ["New York Groove"](https://www.youtube.com/watch?v=DXeeY9D9u94), because I spent most of the week back in NYC. Apropos. But the real theme song is ["Dollar Bill Bar"](https://www.youtube.com/watch?v=e3FQpE99zCo) because OMFG, I love that little damn song so much. You go Sierra. You fucking go. Right, umm, where was I. Oh yeah. Pony shit.

Big week. ponyc 0.63.2 is out with a pile of pony-lsp work that makes your editor a lot more useful. ponylang/postgres 0.5.0 is a security-hardening release that closes a SCRAM mutual-authentication bypass, requires SCRAM by default, and routes a stack of protocol failures to your application instead of crashing the driver. contact-red/sensitive shipped its first release and gives you a clean way to keep secrets out of your log files. And three networking libraries picked up timer failure callbacks so you actually find out when your timer subsystem has fallen over. Let's dig in.

<!-- more -->

## ponyc 0.63.2

[ponyc](https://github.com/ponylang/ponyc) 0.63.2 is all about pony-lsp. If you're using pony-lsp in your editor, this release is a big step up.

Rename Symbol now works. Put your cursor on a field, method, behaviour, local variable, parameter, type parameter, class, actor, struct, primitive, trait, or interface, and your editor can rename every occurrence across the whole workspace. `textDocument/prepareRename` is there too, so editors can validate a symbol is renameable before prompting you for a new name. Attempts to rename something defined outside the workspace (stdlib, external packages) get rejected with a proper error, as do invalid Pony identifiers. No more hand-editing every callsite.

Go to Type Definition works. Put your cursor on a local, parameter, or field and your editor jumps to the declaration of the type, not the symbol itself. Explicit annotations and inferred types both work.

Folding ranges got added. pony-lsp now emits a fold range for every top-level type entity, every multi-line member, and every compound expression inside method bodies: `if`, `while`, `for`, `repeat`, `match`, `try`, and `recover`. Your editor can finally collapse Pony code the way it collapses everything else.

Inlay hints got a serious expansion. They now cover capability hints on type arguments inside generic types (including nested generics, union/intersection/tuple members, class fields, and function return types), receiver capabilities (the implicit `box` on `fun`), return-type capabilities when the cap is absent from an explicit return type, and the full inferred return type when a function has no return annotation at all. pony-lsp also sends a refresh request to your editor after each compilation so the hints actually update when you save a file instead of going stale.

Plus `textDocument/declaration` support, which in Pony just routes to go-to-definition since declarations and definitions are always at the same location.

See the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.63.2) for the full list.

## ponylang/postgres 0.5.0

[ponylang/postgres](https://github.com/ponylang/postgres) 0.5.0 is a security and hardening release. Several of the changes are breaking, but all of the breakage is the right kind.

SCRAM-SHA-256 is now required by default. The driver used to accept whatever authentication method the server offered, which meant a malicious or compromised server could downgrade the exchange to MD5, cleartext, or trust. None of those prove the server knows your password. SCRAM does. The driver now refuses anything else unless you explicitly opt in via `AllowAnyAuth` on `ServerConnectInfo`. If you're connecting to a server that doesn't support SCRAM, you'll see `AuthenticationMethodRejected` until you tell the driver that's fine.

The SCRAM exchange itself had a mutual-authentication bypass. A server could skip, duplicate, or malform SCRAM messages and the driver would authenticate the session without verifying the server's signature. That's fixed. Protocol violations during SCRAM now fail the connection with `ServerVerificationFailed` instead of quietly authenticating or silently closing.

Everything that can go wrong during startup now reaches your application through `pg_session_connection_failed`. Authentication failures used to go to a separate callback. Server rejections during startup crashed the process through an unreachable-state panic. Peer-initiated TCP close hung the driver indefinitely. Various parser errors silently shut the session down. All of that now routes through the same error path. `ConnectionFailureReason` picked up new variants: `TooManyConnections`, `InvalidDatabaseName`, `ServerRejected`, `ConnectionClosedByServer`, `ProtocolViolation`, and `AuthenticationMethodRejected`. If you match exhaustively, you'll need new arms.

Protocol hardening across the board. Integer overflow and underflow on server-supplied message lengths get caught at the parse site before the arithmetic wraps. `DataRow` column lengths get validated before they hit a buffered read. A statement timeout that would previously vanish when its timer event subscription failed now gets rearmed with the original duration.

This release requires ponyc 0.63.1 or later. See the [release notes](https://github.com/ponylang/postgres/releases/tag/0.5.0) for the full list, including migration examples for each breaking change.

## contact-red/sensitive

[contact-red/sensitive](https://github.com/contact-red/sensitive) shipped its first release. It's a small library doing a specific, useful thing: tagging sensitive variables so they don't leak into your log files.

The idea is simple. Wrap a value in `Sensitive[T]` and calling `.string()` returns `"[REDACTED]"` instead of the actual contents. To get at the real value, you have to call `.expose()`, which makes reading the data a deliberate act instead of a silent side effect of logging. Red says this pattern (the "oops we logged the password" class of bug) comes up constantly in security audits. Now Pony has a type-level answer.

There's a convenience constructor, `Sensitive[String].from_env(env.vars, "USER")`, that reads a value out of an environment variable straight into a `Sensitive[String]`. That's a common place for secrets to enter a program, so it's a common place to want the tagging.

If you're handling credentials, tokens, or PII of any kind, grab it.

## Timer Failure Callbacks

Last week brought `ASIO_ERROR` to the Pony runtime and wired it through the stdlib so TCP types report event registration failures to the application. This week the networking libraries picked up the equivalent story for their own timers.

[ponylang/lori](https://github.com/ponylang/lori) 0.14.1 adds `_on_idle_timer_failure` and `_on_timer_failure` callbacks. When the idle timer or a user timer's ASIO event subscription fails (think `ENOMEM` from `kevent` or `epoll_ctl` under kernel resource pressure), lori used to cancel the timer silently and leave the connection running without the protection you asked for. Now you get notified. Both callbacks have default no-op implementations, so existing code keeps the old behavior until you override them.

[ponylang/stallion](https://github.com/ponylang/stallion) 0.6.1 does two things. The HTTP server's idle timer now auto-rearms with its original duration when an ASIO subscription failure is detected, so idle-connection reaping resumes on the next ASIO turn with no effort on your part. And a new `on_timer_failure` callback on `HTTPServerLifecycleEventReceiver` reports user timer failures so you can decide what to do about them.

[ponylang/courier](https://github.com/ponylang/courier) 0.2.1 adds the same `on_timer_failure` callback on `HTTPClientLifecycleEventReceiver`.

If your application needs tight control over timer behavior in any of these libraries, you now have it.

## Items of Note

### New Blog Post: Embed You a ponyc for Great Good

I put up a new blog post, ["Embed You a ponyc for Great Good"](https://www.ponylang.io/blog/2026/04/embed-you-a-ponyc-for-great-good/). The pitch: the Pony compiler is a library called libponyc, and there's a flavor of it called libponyc-standalone that bundles libponyc, LLVM, and the supporting libraries into a single static archive. Link against it and you can build your own Pony tooling without reproducing ponyc's link line by hand. If you've ever wanted to embed the compiler into another tool, that's your starting point.

### GC Made Fast Talk

I gave a talk at NYC Systems about Pony's garbage collection architecture. The writeup, slides, and everything else are on [my website](https://www.seantallen.com/talks/gc-made-fast/). If you've ever wondered how Pony manages to do per-actor GC without stopping the world, that's your jam.

### SSL Builder Image Updates

A new LibreSSL 4.2.1 builder image is available. The LibreSSL 4.2.0 image will be removed at the next SSL builder update, so migrate off if you're still on it. Same story on the OpenSSL side: 3.6.2 is now available, and 3.6.0 goes away at the next update. The OpenSSL 3.4.1 builder has been removed and will receive no further updates, so anything still pinned to it needs to switch to a current builder.

### Office Hours

Red and I were there. Red's been using the code-review skill from [ponylang/llm-skills](https://github.com/ponylang/llm-skills) and he's getting better reviews out of it than from Claude's built-in review. That's exactly what I was hoping for when I put the skill together. He's also restarting his ODBC library from scratch and has come up with a clever testing approach: push data through his ODBC driver, read it back with ponylang/postgres, then do the reverse. If both drivers agree, they're both probably right. Red already found a bug in ponylang/postgres that way. It'll be fixed by the time you read this.

### I'm Away Next Week

I'm still traveling and won't be at the April 20 Office Hours or the April 22 Pony Development Sync. Joe is planning on holding the sync. Office Hours will be open as usual. Feel free to show up and chat amongst yourselves. Next week's LWIP may still run late.

## Releases

- [contact-red/sensitive 0.1.1](https://github.com/contact-red/sensitive/releases/tag/0.1.1)
- [ponylang/courier 0.2.1](https://github.com/ponylang/courier/releases/tag/0.2.1)
- [ponylang/lori 0.14.1](https://github.com/ponylang/lori/releases/tag/0.14.1)
- [ponylang/ponyc 0.63.2](https://github.com/ponylang/ponyc/releases/tag/0.63.2)
- [ponylang/ponyup 0.15.3](https://github.com/ponylang/ponyup/releases/tag/0.15.3)
- [ponylang/postgres 0.5.0](https://github.com/ponylang/postgres/releases/tag/0.5.0)
- [ponylang/release-bot-action 0.6.6](https://github.com/ponylang/release-bot-action/releases/tag/0.6.6)
- [ponylang/stallion 0.6.1](https://github.com/ponylang/stallion/releases/tag/0.6.1)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
