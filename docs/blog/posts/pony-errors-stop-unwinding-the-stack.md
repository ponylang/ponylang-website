---
date: 2026-05-26T14:30:00-04:00
title: "Pony's Errors Stop Unwinding the Stack"
authors:
  - seantallen
categories:
  - ponyc
draft: false
---

Here's how it is: for a few years, off and on, I went looking for a bug.

My aarch64 testing machine, a sturdy little Raspberry Pi, was the site of so very many segfaults. The same tests would fail run after run, and I could boil the crash down to a handful of lines of `try` and `error`. It came out of the machinery Pony uses to unwind the stack when `error` fires. So I'd pull that code up and compare it to the spec. It looked right. I'd run out of leads and put it down. Months later I'd pick it up and start over.

I never found it.

I kept coming back to it. I'd talk it through with Sylvan, and we'd end up in the same place. I'd talk it through with Joe, and we'd end up there too. The bug probably isn't ours. It's probably down in the guts of LLVM, somewhere we don't own. Probably.

So I stopped chasing the bug and looked at where it lived: the stack unwinding. Pony doesn't have to unwind the stack to raise an error. Take the unwinding away, and the bug has nowhere left to be. Soon, that's how it'll work — there's a [pull request](https://github.com/ponylang/ponyc/pull/5002) open against the compiler that takes stack unwinding out of Pony's errors, and [that bug](https://github.com/ponylang/ponyc/issues/3874) is part of why I wrote it. But only a part.

<!-- more -->

## Unwinding the stack

Let's start with what Pony's `error` is. A Pony function that can fail is called a partial function, and you mark it with a `?`. You call it inside a `try`. If it raises `error`, control leaves the spot where you called it and jumps to the `try`'s `else`.

```pony
try
  let n = parse_number(text)?
  use(n)
else
  // parse_number raised error
  handle_bad_input()
end
```

How that jump happens is what's about to change. Here's how it works today.

Every call to a partial function compiles to an LLVM [`invoke`](https://llvm.org/docs/LangRef.html#invoke-instruction) instruction instead of an ordinary `call`. When `error` fires, the runtime unwinds the stack: libunwind on POSIX, the [structured exception handling](https://learn.microsoft.com/en-us/cpp/cpp/structured-exception-handling-c-cpp) machinery on Windows. It walks back up the call frames one at a time, checking each against a [personality function](https://llvm.org/docs/ExceptionHandling.html) and a side table, the [LSDA](https://itanium-cxx-abi.github.io/cxx-abi/abi-eh.html), to find the frame that handles the error. When the walk reaches your `try`, it hands control to the [landing pad](https://llvm.org/docs/LangRef.html#landingpad-instruction), and the landing pad runs your `else`. This is the same stack unwinding that C++ exceptions use, and it's platform-specific.

If you don't know what all of that is, that's fine. Writing Pony, you never see it — you write `try` and `else`, an error goes to the `else`, and you carry on. It all happens underneath, in the code the compiler generates.

The code the compiler generates is what this post is about. In that code, an error doesn't come back like a normal function call. It jumps out through the runtime and the platform and lands somewhere else, on a path that isn't easy to follow.

## The bug I can't locate

Which brings me back to the bug. The crash comes out of how Pony handles `error`: the unwinding code and the personality function. I've compared them to the spec, line by line, multiple times. They look right every time. Sylvan's read them too, and he agrees it all looks correct.

Everything I've checked suggests "it isn't us". The LLVM IR we generate on aarch64 is the same as on x86, where nothing crashes. We aren't doing anything special for 64-bit Arm. And when the program is optimized, or linked a different way through LLVM's own tools, the crash disappears. Every piece I own looks correct, and the program still crashes.

The platforms fit too. We've seen the crash on 64-bit Arm under Linux, and it has been reported on 32-bit Arm. We've never seen it on Apple Silicon. Apple Silicon is 64-bit Arm too, and it runs far more code, for far more people, than Linux on aarch64 does. We suspect the Linux aarch64 code is more likely to have "never been here" bugs, the ones without enough traffic to force them out.

What's left is LLVM's aarch64 code generation. I haven't been able to prove the bug lives there — proving it would mean weeks inside LLVM, and I've never had that kind of time. So the bug stays. Now that I've done the work to remove stack unwinding, I can test whether the segfaults are gone. But that only shows the symptom is gone, not that I found the root cause and fixed it.

## Returning a flag

The idea to remove stack unwinding is older than the bug: stop unwinding the stack, and carry a flag back instead. For years, off and on, Joe and I had talked about it — and, separately, Sylvan and I had too. The reason was a hunch about the [branch predictor](https://en.wikipedia.org/wiki/Branch_predictor): a flag could be at least as fast as unwinding, maybe faster. It was a performance idea.

The bug turned it into more than that. Unwinding wasn't just maybe-slower than it had to be; it had a bug in it I'd never found. And still it sat. Joe wrote the idea up in 2023 as [issue #4443](https://github.com/ponylang/ponyc/issues/4443). I didn't build it until recently.

Here's what the new code does. Partial functions return two things: a result, and an error flag that indicates success or failure. The caller reads the flag. If it's set, the caller does what `error` always did: it runs the `try`'s `else`, or, if there's no `try` here, it passes the failure up to its own caller. If the flag isn't set, the caller takes the result and carries on.

Put that next to how it works today on main: a partial call is an `invoke`, and on an error, control jumps away from the function. With the change, a partial call is an ordinary `call` that hands back a flag, and the failure path is a branch sitting right there in the generated code. The `invoke` is gone, and so are the landing pad, the personality function, the side tables, and the whole platform-specific apparatus underneath. The path from a failed call to its handler is a branch I can follow with my finger.

The Pony you write doesn't change at all. The `try`, the `else`, the `?` on the call — all the same. The same source compiles, and it behaves the way it always has. What changes is underneath.

## The branch predictor

If a flag sounds "basically free" performance-wise, it isn't. Every call to a partial function ends with a check: read the flag, branch on it. You pay for that check even when nothing fails, which is almost every time. Do enough of them in a tight loop and you might wonder whether you've made the common case of no error slower in order to make the rare case of error cleaner.

Sylvan and I didn't think it would. The hunch had two parts.

On the path where nothing fails, the branch goes the same way every single time. No error, no error, no error. That is the easy case for a branch predictor, and the check all but disappears. On the path where something does fail, the flag should be much faster, because the thing it replaces is expensive when it fires. Unwinding the stack costs real time, and that has been true of stack unwinding for a long time, in every language that does it. It's not a Pony-specific claim.

I ran a smoke test on the no-error path. The tool was `message-ubench`, one of the examples that ships with the compiler. It hammers the actor message dispatch loop, the hot path that every Pony program runs on, and that loop hits a partial array access on every message it forwards. The access always succeeds, so the test pays the new check on every pass without ever taking the error branch. I built it both ways, with the old unwinding compiler and the new one, and ran them head to head.

The old way moved about 20.7 million messages a second. The new way moved about 21.8 million. Call it 5.35% faster. That's the success path. The smoke test's partial call always succeeds, so it never measures the error path, the half I just told you has the most to gain. I believe it does, going by precedent. But I didn't measure it. And a performance claim you haven't measured isn't worth much, however good the reasoning. No stopwatch. Ya never know.

And the numbers I do have are soft too. I ran the "benchmark" on my laptop, under WSL2, with no CPU pinning and none of the isolation a real benchmark needs. I take [benchmarking](../../contribute/developer-resources/performance-testing-setup.md) seriously, and this wasn't a benchmark. It's a smoke test, enough to say the common path didn't regress. And that was good enough for us to move forward with removing stack unwinding.

## The bug, again

This is a big change, and it has consequences for some existing code. I'm not going to walk through them here. The [pull request](https://github.com/ponylang/ponyc/pull/5002) has the details.

I'm never going to find that aarch64 bug. I want to be clear about that: I am just sidestepping it. It would be easy to read the change as a fix, and it isn't one. This pull request didn't find the bug. I still don't know what it is. But the new error handling has no landing pad, no unwinder, none of the machinery the bug is tangled up in. So whatever it is, the new path has no place for it.

The old mechanism mostly works. But when it doesn't, it's a nightmare to deal with. The new error handling is plain control flow: calls, and a branch on a flag, the same on every target. I can read it start to finish, from the call to the handler, without leaving the function.

That is the part I keep coming back to. It turned out to be a little faster too. But I'd have made the trade so long as it didn't hurt performance a measurable amount.
