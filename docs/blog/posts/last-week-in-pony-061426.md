---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - June 14, 2026"
date: 2026-06-14T07:00:06-04:00
---

This week's theme song is The Rubberbandits' ["Horse Outside"](https://www.youtube.com/watch?v=ljPFZrRD3J8), and it's completely brilliant. It's a man at a wedding telling everyone to keep their cars. Fuck your Honda Civic, he's got a horse outside. Pony spent the week in that exact mood. Fuck your external linker, it's gone. Fuck your second build system, ponyc compiles your C shims itself now. That last one came together so fast it just felt good. Pony is the fucking horse outside.

<!-- more -->

No release went out this week, but main didn't sit still, and neither did the rest of the ecosystem. I set out to split Pony's one pointer type in two and ran into a wall. For a bit it looked like a frustrating dead end. It wasn't. Working out why the split wouldn't hold led me somewhere I wasn't looking: how much better Windows networking gets once we ditch IOCP. Away from all that, I hardened the HTTP handling in stallion and hobby. Good week. Oh, and let's not forget my favorite thing I "landed."

## Compiling C Shims with an Embedded clang

A lot of the time, calling a C library from Pony needs no C at all. You write the FFI declarations, call straight into the library, and you're done. But not always. Sometimes the function you need is really a macro. Sometimes the library wants a struct built up just so before you can hand it over. Sometimes it just doesn't map cleanly onto Pony's FFI. In those spots a little C smooths it out. A shim: a handful of functions that sit between Pony and the library and make the Pony side pleasant.

Writing one today is more annoying than the shim itself. You compile the C yourself, with your own compiler and your own flags, into a library, then point Pony at the result with `use "lib:..."`. Pony never touches the C. It only links the object that fell out the other end. So every project that reaches for a shim grows a second build step that lives outside Pony, and every contributor who checks the project out has to know about it.

I put up [an early spike](https://github.com/ponylang/ponyc/pull/5469) at making that glue just compile. You drop a `.c` next to your `.pony` files, and when ponyc builds the package, it builds the C too, in process, with an embedded clang, and links the object in. No second build system, no `use "lib:..."`. Two new `use` schemes, `cdefine:` and `cinclude:`, configure the compile per package, and they take the same platform guards that platform-specific linking already does. ponyc already vendors all of LLVM in its submodule, clang included, so turning clang on is mostly a matter of building a piece of the monorepo we'd been leaving switched off. It isn't free. Shipping clang inside ponyc makes the compiler binary noticeably bigger, and I'm still shaking it out on macOS and Windows CI before it's ready to ship. The code has already moved past the [design doc](https://github.com/ponylang/ponyc/discussions/5390), but it's still worth a read to understand the design space for the feature: the alternatives I weighed, the choices I made, and the open questions like caching the compiled objects and how clang's errors should surface through Pony's own diagnostics.

## Replacing the Windows IOCP I/O Model

On Linux and the BSDs, the Pony runtime does socket I/O with readiness notifications. The kernel tells you a socket is ready, and you do the read or write yourself, synchronously, with your own buffer. Windows works the other way. It uses completion-based overlapped I/O, IOCP, where you hand the kernel a buffer, the call returns before the work is done, and Windows tells you later, on one of its own threads, that the operation has finished with your buffer. Two different models for the same job, split down the middle of the platform list.

This week I put up [a proposal](https://github.com/ponylang/ponyc/discussions/5465) to end that split and put readiness everywhere, Windows included. The lead reason is memory safety. Under completions, the kernel writes into a Pony buffer after the call that started the operation has already returned, and no reference capability can describe that. Not corrupting an in-flight buffer is, today, the user's burden, enforced by nothing but care. Readiness moves that burden onto the runtime: a read writes only during the call, so capabilities can describe everything that happens to socket memory, on every platform. The other reasons line up behind that one. One I/O model for anyone writing event-driven code against the runtime. Real backpressure on Windows, taken from the kernel's own writability signal instead of the current "16 writes in flight" guess the source itself calls arbitrary. And a Windows-only twin of nearly every read and write path in the net package, plus a whole subsystem that exists only to survive completions firing on foreign threads, all of it deleted.

The cost is a hard floor. The clean way to get readiness on Windows is a documented Winsock API that arrived with Windows 11 and Windows Server 2022, so taking it makes those the minimum. Pony's supported-platforms list is already Windows 11 only and CI runs Server 2025, so nothing changes for supported targets, but it does mean dropping the best-effort Windows 10 support entirely. I'm taking this to the rest of the Pony team and it'll likely become an RFC. Sylvan's called it an excellent idea. I don't need his sign-off, but he's one of my main sounding boards, so I always want it.

## Items of Note

### The External Linker Is Gone

For a good while now, ponyc has been moving its linking in process. Instead of shelling out to an external linker or compiler driver, it calls an embedded copy of LLVM's LLD directly. Platform by platform, that's been rolling out for the last couple months. This week I finished it off. [PR #5452](https://github.com/ponylang/ponyc/pull/5452) removes the `--linker` and `--link-ldcmd` flags and the old `system()`-based external linker path they reached. Embedded LLD is now the linker for every supported native and cross configuration, full stop. I moved the last holdouts over with it too: FreeBSD and macOS sanitizer builds and FreeBSD `use=dtrace` builds all run on embedded LLD now.

Losing the flags means there's no longer a way to pass arbitrary linker flags directly. `use "lib:..."` with `use "path:..."` covers the common case of pulling in a library, and whether to offer a replacement for the rest is still an open question. ponyc now depends on less of your system to turn Pony code into a binary.

### Pointer and UnsafePointer

Today Pony has one `Pointer` type, and it does two jobs. It points at memory Pony allocates and manages, and it points at foreign memory that came across the C-FFI boundary. The reference capabilities on it have been doing double duty to cover both, and that overloading costs us. It gets in the way of LLVM optimizations, and the capabilities on an FFI pointer turn out to be a Pony-side fiction the compiler trusts and can't enforce. [PR #5431](https://github.com/ponylang/ponyc/pull/5431) is a spike Joe McIlvain and I put up splitting the one type in two: `Pointer` for the memory Pony owns, `UnsafePointer` for the foreign memory crossing the boundary. The generated code is identical. The difference lives in the type system and in where each one is allowed.

The first phase, doing the split and updating ponyc and [ponylang/ssl](https://github.com/ponylang/ssl) to see what it looks like, went fine. The second phase is the hard one: making the capabilities on these pointers reflect how they're actually used, so a pointer you can write through stops claiming it can't. That's run into a wall, because C allows anything, and it may not be possible to give a foreign pointer an honest capability when the C on the other side honors nothing. I'm going to keep exploring that, and nothing is changing immediately. That wall is also what led me to the IOCP work above. Same trouble, different shape: a reference capability can't honestly describe memory Pony doesn't control, whether that's a pointer handed back from C or a buffer the kernel fills in after the call returns.

Safer FFI is something I want to help with whether or not the split lands. There's [a PR for an FFI-audit skill](https://github.com/ponylang/llm-skills/pull/49) that comes with it if it does, one that walks an FFI codebase for calls where C mutates Pony data through a reference capability that forbids it, the exact violation the compiler trusts the declaration about and won't catch. If the split falls through, that PR goes with it. The goal doesn't: I still want to give Pony programmers linting and LLM-skill help for practicing safer FFI.

### A Run of Compiler Fixes on main

No release went out, so all of this is sitting on main waiting for the next one, and I got through a lot of it. I cleared a run of crashes: a reachability crash on intersection types that contain a union member ([#5460](https://github.com/ponylang/ponyc/pull/5460)), a runtime crash in optimized builds for types with 128-bit fields ([#5464](https://github.com/ponylang/ponyc/pull/5464)), and a Windows process crash when a UDP socket fails to listen ([#5483](https://github.com/ponylang/ponyc/pull/5483)). I tightened the type checker where it had been too loose, so it now rejects tuple types hidden inside an intersection in a type constraint ([#5439](https://github.com/ponylang/ponyc/pull/5439)), and fixed the net package's multicast socket-option plumbing ([#5481](https://github.com/ponylang/ponyc/pull/5481)) with broadened UDP broadcast and multicast test coverage behind it. None of it is headline work on its own. Together it's the steady forward motion between releases.

### Alpine 3.24 Is a Supported Platform

I added [Alpine 3.24 as a supported platform](https://github.com/ponylang/ponyc/pull/5466) for ponyc, with prebuilt binaries available through [ponyup](https://github.com/ponylang/ponyup). We'll keep building releases for it until 2028, when its upstream security support runs out.

### stallion and hobby Harden Their HTTP

[stallion](https://github.com/ponylang/stallion) and [hobby](https://github.com/ponylang/hobby) both shipped twice this week. They carry Pony's HTTP support now that [ponylang/http](https://github.com/ponylang/http) and [ponylang/http_server](https://github.com/ponylang/http_server) are deprecated, and since each handles HTTP on its own, the same two problems lived in both. I fixed them.

The first is a security pass. Both HTTP parsers used to accept a range of malformed requests, including recognized request-smuggling vectors: a request carrying both a `Content-Length` and a `Transfer-Encoding`, a bare CR or LF where the protocol requires a CRLF, a `Host` that disagrees with the authority named in the request-target, and more. When your server sits behind or in front of another HTTP processor, a proxy, a load balancer, a CDN, that disagrees about where one request ends and the next begins, those are how an attacker slips a hidden request past one of them. Both parsers now reject them and close the connection. The hardening goes wider than smuggling too. `Transfer-Encoding` is read as the comma-separated list of codings it actually is rather than matched with a loose substring check, a `Connection: close` token is honored wherever it appears instead of only when it's alone on the line, multi-line comma-separated headers get combined the way the spec says, and `Host` values are validated as real hosts. A method that's well-formed but unimplemented now gets a `501` instead of a `400`.

The second is a streaming fix. A large streaming response to a slow client, a chunked Server-Sent Events stream or a big static file, could be silently truncated, the client left with a partial body and no closing chunk. It happened when the network applied backpressure, eased it, then re-applied it while the server was still flushing buffered chunks: the chunks not yet sent were dropped instead of held back. Both now keep buffered chunks queued until they can actually go out, and a response held back by backpressure finishes once the connection drains.

### Office Hours

Office Hours on June 8, with Adrian and me this time. We opened catching up, then the conversation wandered the way it does: GPUs, Vulkan and OpenGL, MQTT, and a crazy reference-capability naming scheme from Adrian.

### Pony Development Sync

Most of the June 10 Pony Development Sync ([recording](https://vimeo.com/1200285225)) was a pass through the review queue, with one larger design conversation up front: the `Pointer`/`UnsafePointer` split from above. The team agreed on a couple of rules for `UnsafePointer`. It shouldn't be returned from a public interface, and it should be null-checked whenever you receive one. The implementation already handles that null safety through the existing box methods, so that part mostly codifies what we already do.

From there it was the queue, all three mine. [PR #5420](https://github.com/ponylang/ponyc/pull/5420) fixes the intermittent crashes we'd been hitting when compiling on multiple threads at once. The next two sit on opposite sides of the same corner of the language. [PR #5423](https://github.com/ponylang/ponyc/pull/5423) starts rejecting self-referential `iftype` constraints inside lambdas and object literals, which had been compiling silently when they never should have. [PR #5443](https://github.com/ponylang/ponyc/pull/5443), from the same root cause, fixes the other direction: a valid `iftype` condition in a lambda or object literal could be wrongly rejected, and a local binding in its `then` branch could crash the compiler. Last on the agenda was [rfcs issue 232](https://github.com/ponylang/rfcs/issues/232), on allowing optimization options when using ponyc. We didn't get to it. That one gets its own time in a future sync.

## Releases

- [ponylang/stallion 0.7.1](https://github.com/ponylang/stallion/releases/tag/0.7.1)
- [ponylang/stallion 0.7.2](https://github.com/ponylang/stallion/releases/tag/0.7.2)
- [ponylang/hobby 0.8.1](https://github.com/ponylang/hobby/releases/tag/0.8.1)
- [ponylang/hobby 0.8.2](https://github.com/ponylang/hobby/releases/tag/0.8.2)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
