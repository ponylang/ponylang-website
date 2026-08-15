---
date: 2026-08-14T07:00:00-04:00
title: "Pony's Arena Allocator"
authors:
  - seantallen
categories:
  - Runtime
draft: false
---

Here's how it was. We'd been running stress tests on the TCP system in ponyc every day for a really long time. Those tests hadn't failed in forever. There's two ways you can look at "no tests are failing." Either your system is rock solid or your tests aren't covering enough of the codebase. I'd long felt that the lack of stress test failures was the result of "tests aren't good enough."

A few months back, I did something about that. I took the TCP stress tests that did the same thing on every run and added some "swarm testing goodness" — randomizing what they were doing and how they were being run, from run to run. A lot more code was getting exercised, and out popped a bunch of bugs.

This post is about one of those "bugs."

<!-- more -->

Under certain usage patterns, memory grew without bound. A little investigation showed that it wasn't a bug in the TCP code itself. The test was triggering an interesting collection of edge cases in the Pony runtime's allocator.

There were three reasons the old allocator could hold on to memory in a way that could lead to the degenerate case I was seeing with the failing stress test instance.

1. In Pony, a message is allocated by its sender and freed by its receiver. About half of all frees land on a different thread than the one that did the allocation. A large block freed on the wrong thread stayed reserved, never reclaimed. A workload that passed blocks between threads reserved fresh address space for every block it allocated and freed, without bound. At ten thousand blocks, it was still climbing, about 4.3 MiB of address space per block.

2. Once memory was carved into 32-byte slots, it held 32-byte objects forever. The allocator never returned it for a different size.

3. Two adjacent free blocks were never merged. The old allocator kept a sorted free list, and mixed-size workloads slowed to a crawl walking it. 0.49 seconds to allocate at 4,000 blocks. 39.6 seconds at 16,000. 64,000 blocks did not finish in nine minutes.

All three came from the same place: the old allocator used a global pool with per-size-class free lists shared by every thread. No thread tracked which memory it allocated.

The fix for all three: make each thread track the memory it allocates — what's in use, what's free, when a region is empty. That tracking is what the old allocator lacked. With it, the allocator can merge freed memory, return empty regions to the OS, and reuse memory across threads.

## The New Allocator

I built a new allocator, inspired by [snmalloc](https://github.com/microsoft/snmalloc)'s region-based design. Memory is organized in two tiers: large regions requested from the OS, split into smaller arenas. Each arena belongs to one thread. That thread is responsible for all the bookkeeping in its arenas — tracking what's allocated, what's free, and when memory can go back to the OS. Cross-thread frees are batched and routed to the owning thread rather than handled globally.

### Regions and arenas

The allocator requests memory from the OS in large aligned chunks called regions — 256 MiB on 64-bit machines, 64 MiB on 32-bit. Regions are shared by every thread and never unmapped. By not unmapping regions, a thread walking the region list has a memory safety guarantee that the rest of the design depends on.

Threads take arenas from regions. An arena is 8 MiB on 64-bit, 2 MiB on 32-bit, and each is bound to a thread. The owning thread is responsible for maintaining the arena's bookkeeping. When an arena empties, its physical pages go back to the OS, but its address space stays parked in the region for reuse.

Freeing memory starts with finding which arena it belongs to. An arena's starting address is aligned to its own size. On 64-bit, every arena starts on an 8 MiB boundary. Mask the low bits of any pointer and you get the arena's base address. One instruction. No memory read. Nice and fast. We like nice and fast over here in Ponyland.

### Units, slabs, and the bitmap

An arena is divided into 16 KiB units. A slab is one or more contiguous units serving one size class. There are 16 size classes, from 32 bytes up to 1 MiB, each a power of two. For small classes, multiple objects fit into a single unit — a 32-byte class fits 512 objects per unit. Large classes span multiple units.

Free or used is one bit per unit in a bitmap. An 8 MiB arena has 512 units, which fits in 8 bitmap words on a 64-bit machine.

Two free units next to each other in memory are two zero bits next to each other in the bitmap. They're already one contiguous span; there's nothing to merge. Finding N free units is scanning for N consecutive zeros. No merge code. No sorted free list. No O(n) walk. The old allocator's block boundary — where two adjacent free blocks never merged — can't happen here because the representation doesn't allow it. Adjacency in memory is adjacency in the bitmap, and adjacency in the bitmap is a span. Always was.

Ascending first-fit in one direction leaves long runs in the other. Without that split, single-unit allocations would fragment the large spans that multi-unit slabs need.

Arena bookkeeping — the bitmap, per-unit records — lives at the arena's start. Nothing sits in front of an allocated object.

### Cross-thread frees

In Pony, a message is allocated by the thread running the sender and freed by the thread running the receiver. Those are usually different threads. Cross-thread frees aren't an edge case — they happen constantly, and the allocator has to be fast at them.

The direct approach is one atomic operation per foreign free: push the freed object onto the owning thread's inbox. However, testing showed that under contention performance collapsed. The direct approach doesn't work.

Instead, the freeing thread collects freed objects and sends them to the owner in batches. One atomic for 32 frees instead of 32 atomics for 32 frees. The performance difference between the batched and unbatched is huge. The owning thread processes the freed memory and can reuse it.

### The thread cache

Batching cross-thread frees is faster than one atomic per free, but sending the batch back to the owner still costs something. Better to avoid sending it at all when you can. Each thread keeps a small cache of recently freed blocks, one per size class. When a thread frees a block that belongs to another thread, it goes into the local cache. If the thread later needs a block of that size, it reuses the cached one directly — no cross-thread coordination, no batch to send. The block only gets routed back to its owner when the cache overflows, the thread goes idle, or the thread exits.

Each size class gets a cache depth: the byte budget (256 KiB) divided by the class size or the profile's floor count, whichever is larger, capped at 512 blocks. Large classes need the floor — without it, the byte budget divides down to zero or one entry, and every churn cycle pays a full slab reserve and release.

The idle return flushes the entire cache, so the floor costs resident memory only while a thread actively churns. Once a thread parks, its cache is empty.

### Memory return

When a thread has been idle long enough, it starts giving memory back to the OS. The old allocator never did this. A thread that goes briefly idle and gets work again keeps its memory. But a thread that stays idle gives back everything it holds. Cache, dirty pages, all of it. A parked thread holds nothing.

The mechanism is a timed tick. An idle thread checks in every 10 milliseconds, doubling the interval each quiet visit up to a 500-millisecond cap. Once it reaches the cap, all held memory goes back to the OS.

While a thread is active, small freed slabs stay resident and get returned in batches rather than one at a time. Larger freed slabs get returned immediately.

I started this post talking about the old allocator hanging on to memory in problematic ways, so what does it look like now? Here are some numbers from testing: 105 MiB of size-class memory, thread goes idle, resident memory falls to 6.5 MiB. The old allocator held all of it, 104 MiB. At a 1 GiB working set, the arena peaks at 1,025 MiB and settles to 27 MiB after idle. The old allocator: 1,019 MiB, start to finish.

### The tuning knob

Not every program has the same needs. I spent several days testing different tunable parameters that let you trade memory usage for performance. They're exposed in a new flag, `--ponymemoryprofile`, a scale from 1 to 10. The default is 3. At 1, the allocator returns memory to the OS as aggressively as possible — lowest footprint. At 10, it holds on to memory longer to avoid the cost of returning and re-acquiring it — highest throughput.

Every setting returns everything when a thread goes idle. The tradeoff only matters while a thread is actively working.

## What's next

The arena allocator is merged to main and is the default on every platform Pony supports. There's one tradeoff worth knowing: the old allocator was faster in workloads where the working set exceeds the thread cache, because it never gave memory back. That's the price of reclaiming.

I'm letting the stress tests run for several days to see if they shake out any bugs. Expect a release by the end of the month.
