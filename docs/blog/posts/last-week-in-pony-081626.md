---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - August 16, 2026"
date: 2026-08-16T07:00:00-04:00
---

Here's how it was. Years ago, I auditioned to be the guitar player in the Heroine Sheiks. Aside from having quite possibly the best name in the history of all bands, they also had an incredible drummer who I really wanted to play with. It took a bit of chutzpah to audition because the guitar player being replaced was a NYC legend. Norman Westberg played some seriously weird and twisted and totally awesome guitar parts for the Swans and later the Heroine Sheiks.

As anyone who knows me can attest, I have chutzpah and was all over that audition. I didn't get the job. According to John, I was the runner up and "made a hell of an impression." Turns out I didn't mind not getting the gig because John left a few months later. I continued to listen to the Heroine Sheiks for years. Great band. So this week, while you're learning a bit about what's going on with Pony, enjoy some Heroine Sheiks goodness with Norman on guitar: [Mas Suicide](https://www.youtube.com/watch?v=QMPx8vQtG2M). And maybe think about how I'm just a chutzpah machine, ready to step in for Norman and years later, stepping in for Sylvan. And now, on with the show!

<!-- more -->

## The process monitor rewrite

`ProcessMonitor` used end-of-file on a child's stdout and stderr pipes as the signal that the child had exited. That's wrong. A grandchild that inherited those pipes keeps them open after the child is gone, so the exit could be reported late, or not at all, and the program would hang.

The ['Redesign the process monitor' RFC](https://github.com/ponylang/rfcs/pull/237) was accepted this week, and the [implementation](https://github.com/ponylang/ponyc/pull/5770) is already merged to main. Pipe-based detection is replaced with native OS events, and a kill-after-reap race and a file-descriptor leak on a failed start are fixed too.

It's a breaking change. Starting a process now returns a result:

```pony
match StartProcess(sp_auth, bp_auth, consume notifier, path, args, vars)
| let pm: ProcessMonitor => // a live child is running
| let err: ProcessError  => // never started; err has the reason
end
```

Failures previously reported asynchronously through `ProcessNotify.failed` now come back synchronously from `StartProcess`, and no monitor is created for them.

## Items of Note

### Pony's arena allocator

I published a blog post on [Pony's arena allocator](ponys-arena-allocator.md) this week. If you've been following the progress in these posts, this is the full write-up. The allocator is merged to main and will be the default in the next release.

### What's coming in the next ponyc release

No ponyc release this week, but a lot has landed since 0.68.0. Besides the arena allocator and the process monitor rewrite, here's what else is on main:

- A streaming JSON parser in the `json` package. Feed it bytes as they arrive, it emits tokens as they complete, no tree built.
- `Readline` preserves in-progress input when browsing history with arrow keys. Previously, whatever you'd typed was lost.
- File reads from redirected stdin on Windows are about nine times faster.
- A bug in `ANSITerm`'s escape-sequence timeout that corrupted later input is fixed.
- The `pony-lint` linter's peak memory on a 37-package repo dropped from ~18 GB to ~330 MB.
- A potential use-after-free on Windows during socket teardown is fixed.

I'm letting the stress tests run on the nightlies before cutting the release. Expect a release around the end of the month.

### ponylang/courier 0.6.0

[ponylang/courier](https://github.com/ponylang/courier) [0.6.0](https://github.com/ponylang/courier/releases/tag/0.6.0) is out. The headliner is opt-in redirect following: wrap an `HTTPClientConnection` in a `RedirectFollower` and redirects are handled internally. courier now uses [ponylang/uri](https://github.com/ponylang/uri) for URL handling, which removes courier's own URL types. That and a couple of other changes are breaking; see the [release notes](https://github.com/ponylang/courier/releases/tag/0.6.0) for the migration.

## Releases

- [ponylang/courier 0.6.0](https://github.com/ponylang/courier/releases/tag/0.6.0)
- [ponylang/changelog-bot-action 0.3.11](https://github.com/ponylang/changelog-bot-action/releases/tag/0.3.11)
- [ponylang/changelog-bot-action 0.3.12](https://github.com/ponylang/changelog-bot-action/releases/tag/0.3.12)
- [ponylang/release-notes-bot-action 0.3.14](https://github.com/ponylang/release-notes-bot-action/releases/tag/0.3.14)
- [ponylang/release-notes-bot-action 0.3.15](https://github.com/ponylang/release-notes-bot-action/releases/tag/0.3.15)

## RFCs

### Accepted

The ['Redesign the process monitor' RFC](https://github.com/ponylang/rfcs/pull/237) was accepted.

### Implemented

The ['Redesign the process monitor' RFC](https://github.com/ponylang/rfcs/pull/237) was [implemented](https://github.com/ponylang/ponyc/pull/5770) and merged to main.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
