---
date: 2026-06-19T20:00:00-04:00
title: "Look Ma, I put a compiler in the compiler"
authors:
  - seantallen
categories:
  - ponyc
draft: false
---

Calling C from Pony is usually easy. You write the FFI declarations, you call the function, you're done. Sometimes it isn't that easy: you need to call a macro, so there's no symbol to bind to. Or you have to fill in a struct by hand before you can pass it in. Or the calling convention is one Pony's FFI can't express. C has all kinds of little oddities that don't line up with Pony. When you hit one of those oddities, it is time to reach for a shim: a small piece of C between Pony and the library. Building it and shipping it has always been the hard part. Not anymore.

<!-- more -->

Here's how it was: the shim you reached for needed to be built. One approach: you compile the C into a library, with your own toolchain and your own flags, and point Pony at it with `use "lib:..."` and `use "path:..."`. When you control the build, that's irritating but not horrid. It's an extra step in your build, and everyone who works on the project carries it. But the build is yours, so you can make it work and keep it working.

Using someone else's library that needs shims is a different story. You have to incorporate building the shim into your project, and you have two bad options. You can work out how to build it and fold it into your build, or you can run a build script that came with the library. The first ties you to understanding the internal implementation details of the library. The second has you running arbitrary code out of a stranger's repo, which is how many supply chain attacks start.

It was this hard because Pony had no concept of C code, only libraries that conformed to the C ABI, which it linked. And if that was all Pony understood, there was no way to handle shims that wasn't unpleasant in some way.

Here's how it is: now you can keep the C right next to your Pony code, and ponyc compiles it for you and links it into your program. No build script, no `use "lib:..."`, nothing for the people who use your library to run.

## A shim is just a file in the package

Any `.c` file in a package directory, next to the `.pony` files, is a shim. ponyc finds it when loading the package. There's no list to add it to, nothing to wire up. The C is part of the package, the same as the Pony code, so when you pull in a dependency that has a shim, it's already there, and gets built along with the Pony code.

Here's a small program that uses a shim. It's three files. A `main.pony`:

```pony
use "cdefine:CSHIM_ANSWER=42"

use @cshim_answer[I32]()
use @cshim_version[I32]()

actor Main
  new create(env: Env) =>
    env.out.print("answer from the shim: " + @cshim_answer().string())
    env.out.print("version from the header: " + @cshim_version().string())
```

And an `answer.c` beside it:

```c
#include <stdint.h>
#include "version.h"

int32_t cshim_answer(void)
{
  return CSHIM_ANSWER;
}

int32_t cshim_version(void)
{
  return CSHIM_VERSION;
}
```

`answer.c` includes `version.h`, a header with one line, `#define CSHIM_VERSION 7`. Run `ponyc`, then run the program:

```console
$ ./cshim
answer from the shim: 42
version from the header: 7
```

No separate C compiler is needed. Just `ponyc`.

## Telling ponyc how to compile it

Two of those `use` lines are the FFI you write anyway: `use @cshim_answer[I32]()` declares a function so you can call `@cshim_answer()`. The same for `@cshim_version`.

The other one is new. `cdefine:` sets a preprocessor macro — a C compiler's `-D`. There's also `cincludedir:`, which adds an include directory (a C compiler's `-I`), but this shim doesn't need one.

These work differently from the `use` lines you already know. `use "lib:..."` and `use "path:..."` apply to the whole program: a library named in any package is linked into the final binary once, no matter which package named it. Compile flags can't work that way. Two packages can need different headers, or define the same macro to different values, and no single setting fits the whole program. So a `cdefine:` or a `cincludedir:` applies only to the package it's written in.

Flags often change by platform, and a `use` line can take an `if` guard, so you get platform-specific flags for free: `use "cincludedir:/opt/homebrew/include" if macosx` applies only when you build for macOS. `cdefine:` takes a guard too, so a macro can be one value on one platform and another elsewhere.

What you can't do is define the same macro twice in one package. ponyc makes that an error. A macro should have one value. Give `FOO` two and ponyc uses whichever it read last. That's no way to choose a value. When a macro needs to differ by platform, that's what an `if` guard is for, not a second definition.

The guards are on the flags, not the files. Every `.c` in the package is compiled, on every platform. So if a shim only makes sense on one, wrap its body in an `#ifdef` and it compiles to nothing on the rest.

## What it's for

We built this for shims, and shims are all we're setting out to support. People will do more with it. They always do, and good for them. But if doing more needs a feature ponyc doesn't have, that's a request we'll most likely turn down. And of course, Red Davies is already doing things with it well past what I built it for. I'll let him tell that story.

So have at it! Compiling shims is on main now. It ships in the release at the end of the month.
