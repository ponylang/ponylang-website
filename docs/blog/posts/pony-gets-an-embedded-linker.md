---
date: 2026-03-25T15:00:00-04:00
title: "Pony Gets an Embedded Linker"
authors:
  - seantallen
categories:
  - ponyc
draft: false
---

As of [`ponylang/ponyc`](https://github.com/ponylang/ponyc) 0.61.1, the compiler carries its own linker. When you compile a Pony program on Linux, macOS, or Windows, ponyc no longer shells out to an external tool to produce your binary. It calls [LLD](https://lld.llvm.org/) directly, in-process, using the same LLVM infrastructure it already uses for code generation. Cross-compilation to Linux targets works the same way. The compiler is more self-contained than it's ever been, and cross-compilation just got a lot simpler.

<!-- more -->

## What a linker does and why ponyc had to care

Most people don't think about linkers. You shouldn't have to. The compiler turns your source code into machine code, and then something has to take those chunks of machine code and stitch them together with the operating system's runtime libraries into an actual executable. That something is the linker. It resolves symbols, wires in the C runtime (which most people don't even know exists), and produces the file you can actually run. It's plumbing. It should just work.

ponyc has always needed a linker. It uses LLVM to generate object files, but LLVM's code generation stops at the object file. Turning that into an executable is a separate step, and until now, ponyc handled it by shelling out to whatever linker happened to be available on the system.

On Linux, that meant invoking a C compiler driver like GCC or Clang, which would find the C runtime objects, the system libraries, and the dynamic linker, then call its own linker under the hood. On macOS, ponyc invoked `ld` directly. On Windows, it found and invoked MSVC's `link.exe` through registry lookups and `vswhere.exe`. Three platforms, three completely different code paths, each with its own assumptions about what's installed and where things live.

This worked. But it had consequences. Your ponyc binary depended on having the right external tools installed. Error messages came back through shell escaping, garbled when paths had spaces or special characters. And cross-compilation was particularly painful: if you wanted to produce a RISC-V Linux binary from an x86 machine, you needed to install a full RISC-V GCC cross-compiler toolchain, even though ponyc only needed it for linking. You already had LLVM generating the right machine code. You just needed something to stitch it together. But the linker was bundled inside GCC, so you installed the whole thing.

## How we got here

We've wanted to embed LLD into ponyc for almost as long as ponyc has existed. LLD is LLVM's linker. It supports ELF (Linux), Mach-O (macOS), COFF (Windows), and WASM, all behind a C++ API. Since ponyc already vendors LLVM for code generation, adding LLD to the build was a natural fit. But it didn't work early on, and the idea sat.

A few years ago, Sebastian Blessing got a prototype working. It was a shim, not production-ready, but it proved that the early hurdles that had prevented Sylvan from embedding LLD in the early days of Pony no longer existed. It mostly sat after that. We also had the benefit of Joe Eli McIlvain's experience embedding LLD in [Savi](https://github.com/savi-lang/savi), which gave us a head start on understanding the problems we'd encounter. There would be ponyc-specific issues, but we had some idea of how it was all going to go.

Last fall, I picked it back up. I got the initial pieces moving, then handed it off to Red Davies, who ran with it. Between November and December 2025, he proved the approach could work end-to-end for Linux, building out the file search logic and musl support along the way ([#4768](https://github.com/ponylang/ponyc/pull/4768), [#4770](https://github.com/ponylang/ponyc/pull/4770), [#4774](https://github.com/ponylang/ponyc/pull/4774)). In the process, we learned just how fiddly linking actually is when you're doing it yourself instead of letting a compiler driver handle it.

The fiddly details add up fast. Every executable on Linux needs a handful of small object files called CRT (C runtime) objects. These are the glue between the operating system and your program. They set up the stack, call `main`, and handle cleanup when your program exits. You never write them, but you can't link without them.

The problem is that these files come from two different places. Some come from your C library (glibc or musl). Others come from your compiler runtime (GCC or LLVM's compiler-rt). They live in different directories, and those directories vary by distribution, architecture, and which version of GCC happens to be installed. The dynamic linker path (which tells the OS how to load shared libraries at runtime) changes depending on the architecture and whether you're using glibc or musl. GCC's library directories are laid out differently on Debian than on Fedora than on Alpine. It's the kind of work where you think you're done, and then you try it on a different distro and discover three new edge cases.

That exploration fed into a [detailed design document](https://github.com/ponylang/ponyc/discussions/4941) covering every platform, every edge case, and a phased plan to roll out embedded LLD across all targets.

## A good job for an LLM

Here's the thing about linking: once you understand the patterns for one platform, the others are variations on the same theme. Figure out where the CRT objects live. Figure out where the system libraries are. Figure out the dynamic linker path. Build the argument list. Call LLD. The details change per platform, but the structure doesn't.

It's also part of why the work sat for so long. This is incredibly tedious, boring work. It's not the kind of thing you can easily motivate yourself to do in your spare time. You're not solving an interesting problem. You're cataloging where Debian puts `crtbeginS.o` versus where Fedora puts it versus where Alpine puts it, and then doing the same thing for three more architectures. Important, yes. Fun, no.

That makes it a great task for an LLM. The patterns are clear once a human has worked them out, the work is tedious and repetitive, and getting it right requires attention to a lot of small details that a human will eventually fumble through fatigue. We'd done the research. We knew what the right linker invocation looked like for each platform. None of us wanted to be the one typing out eight variations of GCC library path search logic across three architectures and two C libraries. Claude executed the final implementation across five phases in three days:

- [Phase 1](https://github.com/ponylang/ponyc/pull/4945): Build infrastructure and compiler-rt CRT objects
- [Phase 2](https://github.com/ponylang/ponyc/pull/4964): Cross-compilation to Linux targets
- [Phase 3](https://github.com/ponylang/ponyc/pull/4971): Native Linux builds
- [Phase 4](https://github.com/ponylang/ponyc/pull/4993): Native macOS builds
- [Phase 5](https://github.com/ponylang/ponyc/pull/4996): Native Windows builds

Each phase built on the last. Cross-compilation came before native Linux builds on purpose: it's lower traffic and a safer place to shake out bugs before touching the code path everyone uses. macOS was simpler than Linux (no CRT objects to hunt for). Windows was nearly a 1:1 translation of the existing `link.exe` arguments.

## The choices that mattered

A few decisions shaped how the whole thing turned out.

The biggest one was shipping our own CRT objects instead of depending on GCC's. Remember those small startup files the linker needs? Some of them come from GCC's compiler runtime. That's fine when GCC is already installed, but for cross-compilation it meant you needed a target-specific GCC installed just to get a couple of `.o` files. LLVM has its own version of these files called compiler-rt. We now build compiler-rt as part of the ponyc build and ship those CRT objects alongside the compiler. One fewer dependency. For cross-compilation, this is the difference between "install a cross-GCC toolchain" and "just point us at a directory with the target's libraries."

That handles half the CRT objects. The other half come from the C library (glibc or musl) on the target system, and those we can't ship. They belong to the target, not to the compiler. So the linker still needs to find them on disk, along with system libraries and the dynamic linker (the small program the OS uses to load shared libraries when your binary starts). Red's initial implementation searched for all of this by walking directories recursively and matching filenames with regex. It worked, but it was slow and fragile. The final approach is simpler: we know what the files are called and we know the handful of places they can live, so we just check each candidate path directly. First hit wins. No walking, no pattern matching, no surprises.

All of this comes together in a new ponyc option: `--sysroot`. A sysroot is just a directory that looks like a target system's filesystem: it has the target's C library, headers, and system libraries in the expected layout. Cross-compilation used to require `--linker=<cross-gcc>` and `--link-ldcmd=<backend>`, which told ponyc to shell out to a cross-compiler for linking. Now you just need `--triple` (which tells ponyc what platform you're building for) and `--sysroot` (which tells it where to find that platform's libraries). The embedded linker handles the rest. If you don't specify `--sysroot`, ponyc checks common locations automatically. The old `--linker` flag still exists as an escape hatch for exotic setups, but the common case is simpler.

## What this means for you

If you compile Pony on Linux, macOS, or Windows, your ponyc binary no longer depends on a system linker. It links your programs itself. One fewer thing to install, one fewer thing that can go wrong.

If you cross-compile, the linking side got easier. You no longer need a cross-linker installed, and the flags are simpler: `--triple` and `--sysroot` instead of `--linker` and `--link-ldcmd`. Cross-compilation still isn't easy overall, but one barrier is gone. More on what's left below.

Error messages are better too. When ponyc shelled out to external linkers, error output went through the shell and came back with whatever quoting and escaping the shell applied. Now LLD's diagnostics come straight to your terminal.

## What's left

There's more to do. BSD variants (FreeBSD, DragonFly BSD, OpenBSD) still use the system linker. Those platforms ship with LLD natively, so this isn't urgent, but migrating them to the embedded linker will make the codebase simpler by removing the legacy linking code paths.

We've made cross-compilation simpler, but we know it's still a pain. You don't need a cross-linker anymore, but you still need to build the Pony runtime for your target architecture yourself. That means cloning the ponyc repo, running `make cross-libponyrt` with a cross-compiler, and managing the output. It works, but it's not something we'd call easy. The [next step](https://github.com/ponylang/ponyc/discussions/4980) is bundling pre-built cross-compiled runtimes directly in the ponyc release tarballs. Install ponyc, get cross-compilation support out of the box. No separate builds, no extra steps.

Cross-compilation to macOS or Windows targets from a different platform is further out. The architecture supports it since ponyc already has the Mach-O and COFF LLD drivers built in. What's missing is the sysroot side: you'd need a macOS SDK or Windows SDK available on the build host. That's solvable, and when it happens, the same `--triple` and `--sysroot` pattern will work.

## Looking forward

Embedding the linker is part of a broader push to make ponyc more self-contained. A compiler that carries its own linker, its own CRT objects, and its own runtime is a compiler that's easier to install, easier to cross-compile with, and easier to maintain. Less surface area for things to break, fewer dependencies to chase across distributions.

For years, ponyc asked the host system to do its linking. Now it does the job itself. That's the kind of change that makes everything else we want to do easier.
