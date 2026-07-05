---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - July 5, 2026"
date: 2026-07-05T07:00:00-04:00
---

This week's theme song is Player's ["Baby Come Back"](https://www.youtube.com/watch?v=NmEyGiaqm7k). People ask me sometimes how many people use Pony, whether it's used in production. The honest answer to both is that I have no idea. We've never had much visibility into who's out there. Every so often a hint comes through that someone is shipping Pony for real, and then it goes quiet again.

<!-- more -->

I'm writing this on a holiday weekend. It's the Fourth of July, and this one is the big one, two hundred and fifty years. The World Cup's been on, and so many of the games have been good, even if it seemed like neither Morocco nor the Netherlands wanted to win theirs. It's a good weekend to sit back. The week that led into it wasn't. I put ponyc 0.66.0 out on Monday, with a big change to how Pony does networking on Windows. That meant new versions of lori and everything built on it, so we shipped those too. I landed more fixes on ponyc's main all week, and we're almost done moving ponyc's build over to CMake. Plenty to get to.

## ponyc 0.66.0

The big change in 0.66.0 is how Pony does networking on Windows. I put up the proposal on June 11, wrote up the reasons and the plan here on the blog, and merged it on the 28th. Here's the whole thing, in case you missed those.

Until this release, Pony did socket I/O two ways, depending on the operating system. Everywhere but Windows, it used readiness notifications. The OS tells your program a socket is ready. Your program then calls read or write and hands the kernel the buffer. That call is synchronous: the kernel does the work and returns, and you have your buffer back the moment the call returns. Windows was the exception. It used IOCP, Windows' I/O completion ports, which work the other way, asynchronously. Your program hands the kernel a buffer and the call returns right away, before the read or write is done. The kernel finishes the work later, on its own, writing into your buffer after your call has already returned, and tells you when it's done.

The trouble with that asynchronous write is memory safety. The kernel writes into your buffer after your call has returned, while your own code keeps running. Pony's compiler keeps your program safe by tracking who is allowed to read or write each piece of memory, and when. It can't track a write the kernel makes on its own, after the call, so it can't check that the buffer is safe to touch in the meantime. Not touching it until the kernel signals it's done was left to you. Readiness doesn't have that problem. The kernel only touches your buffer during the synchronous call, so the moment the call returns, the buffer is yours again, and the compiler checks it the same as any other memory.

So in [PR #5556](https://github.com/ponylang/ponyc/pull/5556) I switched Windows to readiness, the same model every other platform already uses. IOCP is gone.

Moving to readiness changed a few other things on Windows, too. One is backpressure. When a program writes to a socket faster than the socket can send, the runtime makes it wait until the socket catches up. On Windows, the runtime used to start that wait from a count of how many writes were still in flight. Now it starts it from whether the socket can actually take more data, the same as on Linux, macOS, and BSD. Another is UDP errors. When a UDP send failed on Windows, you used to get no error at all. Now the runtime reports the failure and closes the socket. The last is muting. When you mute a connection, the runtime stops reading from it. On Windows, the runtime used to deliver a peer's close even while the connection was muted. Now it doesn't deliver that until you unmute, the same as every other platform. Mute a `TCPConnection` and never unmute it, and it never closes. Watch for that if your Windows code relied on the old behavior.

Readiness needs a newer Windows than IOCP did. `ProcessSocketNotifications`, the API for it, only exists on Windows 11 and Windows Server 2022 and later, so those are the minimum now. A binary built with 0.66.0 won't load on anything older, Windows 10 included. Our supported list has been Windows 11 only for a while, so that part stays the same. We used to make a best effort to keep Windows 10 working on top of that. That's over.

0.66.0 has more in it than the Windows work. One fix I'll pull out: if an actor kept taking an object it got from another actor and sending it straight back, the program's memory could climb without limit. I fixed that, and those programs run in bounded memory now. The [release notes](https://github.com/ponylang/ponyc/releases/tag/0.66.0) have the rest.

## Items of Note

### lori and the Libraries Built on It

[lori](https://github.com/ponylang/lori) is the TCP networking library a lot of the Pony ecosystem is built on. [courier](https://github.com/ponylang/courier), [stallion](https://github.com/ponylang/stallion), [postgres](https://github.com/ponylang/postgres), and [mare](https://github.com/ponylang/mare) use it directly. [hobby](https://github.com/ponylang/hobby) is built on stallion, [livery](https://github.com/ponylang/livery) on mare and hobby, [github_rest_api](https://github.com/ponylang/github_rest_api) on courier. Change lori and you have to rebuild all of them. So after I took IOCP out of ponyc and lori, we shipped new versions of everything downstream this week.

[lori 0.16.0](https://github.com/ponylang/lori/releases/tag/0.16.0) is where I took IOCP out of lori, matching the ponyc change, so it has the same Windows changes in it: no more Windows 10, and backpressure that comes from the real socket. Right after, in [lori 0.16.1](https://github.com/ponylang/lori/releases/tag/0.16.1), I fixed a bug in the idle timeout. It could close a connection for sitting idle even while that connection was still sending data. The runtime reset the idle timer when data arrived and when the program called `send`, but not while already-buffered data was still draining out to a slow reader. So during a large, slow send, the connection sat under the idle timeout even though bytes were still leaving the socket, and the timeout closed it mid-transfer. Now the runtime resets the timer whenever data actually moves, in or out. That fix is in every downstream library too, except postgres. postgres 0.7.0 went out just before lori 0.16.1, so it's still on the old lori, and its next release will have it.

[ponyup 0.16.0](https://github.com/ponylang/ponyup/releases/tag/0.16.0) has that same idle-timeout fix in it, so a slow download won't get cut off mid-transfer, plus one of its own. After sending a large request, ponyup could hang forever, waiting on a response that had already arrived, with no error and nothing to show for it. You'd hit it most on large uploads. I fixed both.

### More Fixes on ponyc's main

More fixes landed after the release. On a Linux machine that has glibc but also has the musl loader installed, ponyc was building executables against glibc while stamping musl's dynamic linker into them. They'd compile and then fail to start. Passing an explicit `--triple` didn't help, because ponyc probed the filesystem for a loader and used that instead of the triple. In [PR #5656](https://github.com/ponylang/ponyc/pull/5656) I made ponyc settle the target C library up front: if you pass a `--triple`, it uses that; otherwise it goes by which libc the sysroot actually has.

I fixed a handful of smaller things too. In the `json` package, the code was losing precision when it serialized floating-point values, and it produced invalid JSON for non-finite ones like `NaN` and infinity. `Sig.usr2` was returning whether `SIGUSR2` is available backwards. `Sig.ill`, on a platform without `SIGILL` like Windows, gave a compile error that named `SIGINT` instead of `SIGILL`, and now it names the right one. And Pony delivers zero-byte UDP datagrams now, where it used to drop them.

The rest of the week went to the runtime's stress tests. I run them hard against the runtime, over and over, to shake loose the kind of concurrency bug that only turns up once in a great while. I wrote a couple of weeks ago about making them vary from run to run, so they exercise more of the runtime over time, and I kept at it all week: I added new workloads to the generative harness, tightened the guards, and fixed systematic testing running much slower than it should. None of this shows up in your own program. It's how I catch those rare bugs before you hit them.

### Moving the Build System to CMake

We're deep into moving ponyc's whole build over to CMake. For a long time, building ponyc has meant an odd little split: a Makefile and a `make.ps1` driving a CMake project between them, the three of them with overlapping jobs and a few footguns for anyone who has to touch them. We're turning all of that into one CMake build, and it should be done soon. The [discussion](https://github.com/ponylang/ponyc/discussions/5588) has the details if you want to follow along.

### pony-lsp Now Checks Its Arguments

pony-lsp used to ignore its command line. You could pass it anything and it did the same thing, start up and wait for the editor to talk to it. `pony-lsp --version` did nothing and hung, which is [what got reported](https://github.com/ponylang/ponyc/issues/5646). It works like the rest of the tools we ship now: `--version` and `--help` print and exit, and it rejects arguments it doesn't recognize instead of ignoring them.

If you set up Helix using the config we published, you need to change it. It passed pony-lsp an empty argument, `args = [""]`, which was harmless while pony-lsp ignored everything but now stops the server from starting. Change `args = [""]` to `args = []` in your `languages.toml`. The [docs are already fixed](https://github.com/ponylang/ponylang-website/pull/1388). No other editor config we publish passes an argument, so Neovim, VS Code, and Zed are fine.

### Measuring Data Structures at Runtime

Back when I added C shim compilation to ponyc, where you drop a `.c` file next to your Pony code and ponyc compiles it, I [put out an invitation](https://www.ponylang.io/blog/2026/06/look-ma-i-put-a-compiler-in-the-compiler/#what-its-for) for Red to write up what he'd been doing with it. He did. In [his post](https://contact.red/blog/how_big_is_it_really/), Red measures the size of an arbitrary data structure at runtime. To get there, he goes through Pony's memory allocator, reaches into private runtime data structures, and hooks into the runtime's garbage collection tracing to follow and measure every allocation a structure holds. As Red says, the blog is safe to read. The code is not, because it leans on private functions and internals, and those can change whenever we change the runtime.

### Trimming Supported Platforms

We trimmed the platforms we build and test on. We used to build prebuilt binaries for every supported Alpine version and every supported Ubuntu LTS. Now we build for the two most recent of each. So in ponyc 0.66.0 and ponyup 0.16.0, we dropped Alpine 3.21 and 3.22 and Ubuntu 22.04. On FreeBSD, we stopped testing 14.x, so 15.x is the only version we test now.

### We Updated the llm-skills

If you use the [llm-skills](https://github.com/ponylang/llm-skills) to work on Pony with an LLM, there's a new version out this week. Pull the latest as soon as you can.

### Office Hours

Red, Adrian, and I were on Office Hours this week. It wandered, in the good way: Red's Base64 fix (more on that below), reverting merges, IPFS and content-addressable storage, promises, object literals and capturing variables, and viewpoint adaptation, with a fair amount of this-and-that between them. Jazz hands may have been involved.

A scheduling note. I'll be traveling for work and won't make Office Hours on Monday the 6th. It's still on. Red and Adrian are usually there and are good company, so come by.

### Pony Development Sync

The July 1 [Pony Development Sync](https://vimeo.com/1206299056) went almost entirely to one pull request, then a pass through the ponyc issues.

The pull request was [PR #5597](https://github.com/ponylang/ponyc/pull/5597), Red's fix for `Base64.encode_url`. The configurable `encode` underneath it takes its padding as a `U8`, so it always writes some byte. You can hand it any value, illegal ones included, but you can't tell it to write nothing. To leave padding off, `encode_url` passed `0`, so instead of omitting the padding it wrote NUL bytes where the `=` characters should go, and the output came out wrong. The fix lets `pad` be `None`, so padding can actually be left off. That raised the bigger question of the API itself. Handing a caller the freedom to pad with any byte, illegal values and all, is the wrong thing to make public. So each kind of encoding is going to get its own public method, url and mime and the rest, plus a general one that always pads with `=`, and the byte-level `encode` moves behind a private method.

The issues pass turned up a run of compiler bugs. [Issue #4088](https://github.com/ponylang/ponyc/issues/4088) applies default arguments from the wrong method when you call through a type union. The float-literal lexer, [issue #5329](https://github.com/ponylang/ponyc/issues/5329), doesn't round the way it should. [Issue #5331](https://github.com/ponylang/ponyc/issues/5331) is a misleading error: the compiler prints "unreachable code" and points at your source, when the only unreachable thing is a `None` it synthesized itself. Away from the compiler, [issue #5564](https://github.com/ponylang/ponyc/issues/5564) is a shutdown bug, where a signal handler can dereference an `ASIO` backend that's already been freed.

The last one worth calling out was [issue #4925](https://github.com/ponylang/ponyc/issues/4925), the LLVM 21 readonly optimization that breaks FFI writes through tag pointers. Joe asked whether I was working on it. I am. The fix is [PR #5431](https://github.com/ponylang/ponyc/pull/5431), the spike that splits our single `Pointer` type into `Pointer` and `UnsafePointer`, and it's one piece of the larger work that lets us turn that optimization back on.

## Releases

- [ponylang/ponyc 0.66.0](https://github.com/ponylang/ponyc/releases/tag/0.66.0)
- [ponylang/courier 0.4.0](https://github.com/ponylang/courier/releases/tag/0.4.0)
- [ponylang/github_rest_api 0.7.0](https://github.com/ponylang/github_rest_api/releases/tag/0.7.0)
- [ponylang/hobby 0.9.0](https://github.com/ponylang/hobby/releases/tag/0.9.0)
- [ponylang/livery 0.5.0](https://github.com/ponylang/livery/releases/tag/0.5.0)
- [ponylang/lori 0.16.0](https://github.com/ponylang/lori/releases/tag/0.16.0)
- [ponylang/lori 0.16.1](https://github.com/ponylang/lori/releases/tag/0.16.1)
- [ponylang/mare 0.5.0](https://github.com/ponylang/mare/releases/tag/0.5.0)
- [ponylang/mare 0.5.1](https://github.com/ponylang/mare/releases/tag/0.5.1)
- [ponylang/ponyup 0.16.0](https://github.com/ponylang/ponyup/releases/tag/0.16.0)
- [ponylang/postgres 0.7.0](https://github.com/ponylang/postgres/releases/tag/0.7.0)
- [ponylang/stallion 0.8.0](https://github.com/ponylang/stallion/releases/tag/0.8.0)

## RFCs

### New

The ['Add `noalloc` annotation' RFC](https://github.com/ponylang/rfcs/pull/235) is open for discussion.

### Final Comment Period

The ['Redesign signal handling' RFC](https://github.com/ponylang/rfcs/pull/220) is in its final comment period. If you have thoughts on it, now's the time.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
