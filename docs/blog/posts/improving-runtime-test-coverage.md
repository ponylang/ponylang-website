---
date: 2026-06-26T21:00:00-04:00
title: "Improving Runtime Test Coverage"
authors:
  - seantallen
categories:
  - runtime
draft: false
---

Pony's runtime has a set of stress tests. They run in CI, each one a program that exercises the runtime over and over for an extended period of time: one passes messages between actors without a break, another opens and closes network connections again and again, sending data back and forth. The idea is that the more you push on a part of the runtime you think is bug-prone, and the longer you keep at it, the more likely you are to shake out a bug that only turns up once in a while. For the runtime, bug-prone means "susceptible to concurrency issues". And we hammer away at those areas as much as we can. Or try to anyway. That was the idea.

<!-- more -->

That idea has been a bit iffy lately. It has been a long time since a stress test run found a problem. At this point, when I get a notification that one has failed, I assume it is an environment issue in GitHub like "couldn't pull the test container". There are two ways I can look at that. One, the runtime is rock solid. Two, our tests could be improved. In reality it's probably a little column A, a little column B.

The runtime has seen a lot of hardening over the years, but at the same time, the stress tests we've been running the last few years are lacking. They are stale. They haven't changed since they were created and worse yet, they are static. They run the same way every time. They only exercise certain runtime options, and the ones they do touch run exactly the same every day. If any of those code paths were broken, the stress tests should catch it, but there's a whole state space they simply never explore. This is the story of what happened when I started to make our stress tests more dynamic.

Two things had to change. The first was to stop running the same fixed setup every time. There is still one program, but every run varies a couple of things. One is the workload: how many actors there are, how they connect, how much they send to each other. The other is the runtime underneath, set through its own options, like how many scheduler threads it runs on and how the garbage collector is tuned. The new setup is incorporating ideas from [swarm testing](https://www.youtube.com/watch?v=wzfC7Q-xNik): one fixed setup only ever exercises one path through the runtime; randomizing both, run after run, eventually covers a huge range, and turns up bugs a handful of hand-picked setups never would. We are a lot more likely now to encounter weird emergent behavior than we were before.

Varying the setup was the first change. It should help flush out bugs. But flushing out bugs isn't everything. Reproducing them easily is important as well. I've spent way too much time tracking down weird bugs that come up in CI where at best I have an assertion failure and a backtrace to work from. I get to the conclusion and fix the issue but it can take a long time. When a run breaks the runtime, I want to replay that exact failure, as many times as it takes to understand it. A bug that shows up once and never the same way again is still fixable, but I'd rather not spend my time chasing one down.

The Pony runtime has a mode that can help: systematic testing. Normally the runtime runs actors in parallel across a set of scheduler threads, and the order they interleave depends on those threads and the hardware under them. Running a program 2 times in a row won't run in the exact same way. The output might be the same, but how the runtime "got us there" won't be. Systematic testing makes running a Pony program a lot more deterministic. When it is on, we run the scheduler threads one at a time instead of in parallel so we can control the order that actors are run in. A program that does nothing non-deterministic of its own then runs the same way every time.

The new stress test is deterministic. Its randomness all comes from a seed, and it reads no clock or other outside state like calling out to OS functions that could change ordering. This means nothing in it varies from one run to the next. When we run it under systematic testing with a fixed seed, we get the exact same run. When something fails in CI, we can replay it from its seed for as long as it takes to understand wtf happened.

That's the idea, anyway. Humans, we are fallible, so the stress test has a sanity check in it. It records a fingerprint of each run, a summary of the order things happened in, and compares them. Every run actually runs twice with the same parameters and we compare the fingerprints to make sure they are the same. If they aren't then we know that we either messed up the determinism of the program or the runtime isn't deterministic with the options we gave it.

I fired up the stress test locally, ran it and the fingerprint test failed. My first thought was "wtf": a deterministic test cannot produce that difference, so it had to be the runtime, in how it ran the program. But how?

It turns out two bugs were breaking the replay. The first was time. The scheduler read the system clock in a few places, and the system clock is different on every run, so those reads made the same seed run differently. Replacing them with a counter that advances with the run fixed it. The second had nothing to do with the program at all. Reading the system clock is a classic way that programs break determinism. But the 2nd, it surprised me. It's one of those things that is obvious in hindsight, but you are unlikely to come up with without debugging.

The cause was ASLR. Every run, the operating system loads a program at fresh, random memory addresses, so an attacker can't predict where anything is. It makes no difference to what the program computes, but it does put every actor at a different address on every run.

In several places, the runtime orders actors by that address. It holds a set of actor pointers and works through them in the order the addresses fall. One of those orders is the order the scheduler runs actors in. Under systematic testing that order should come from the seed and nothing else, but the runtime took that order partly from the addresses, which the seed does not control. ASLR changes the addresses every run, so the same seed ran the actors in a different order each time, and the rest of the run followed.

The first place I found the problem was in the backpressure system, where the runtime mutes actors that are overwhelming a slower one. It holds pointers to them and reschedules them in address order. The same thing turned up in two more places: the reference counting between actors, and the cycle detector. Each one ordered actors by pointer, so ASLR scrambled the order in each. The fix is the same wherever it applies: order the actors by the sequence they were created in, which ASLR can't move, instead of by their address.

So how did these bugs "creep in"? Systematic testing was introduced four years ago, and apparently no one tried to use it until now. It was passing its basic tests, but... irony of ironies: they were incredibly static and didn't exercise much of the state space.

I'm kind of amused that I started with the idea to find bugs with this new test running daily in CI. But it found bugs before I ever even got it to CI. I guess it has already earned its keep.
