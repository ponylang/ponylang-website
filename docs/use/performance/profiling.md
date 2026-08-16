# Profiling Pony Programs

Pony compiles to native binaries. You profile Pony programs with the same tools you'd use for C or C++ — `perf` on Linux, Instruments on macOS, Callgrind anywhere Valgrind runs. No special runtime build is needed for `perf` or Instruments. Callgrind requires a custom `ponyc` build (see [below](#callgrind)). No Pony-specific profiler.

## Compile with `--debug`

Compile with `ponyc --debug` before profiling. If your project uses corral, pass the flag through: `corral run -- ponyc --debug`.

- **Disables optimization.** Without `--debug`, LLVM inlines user functions aggressively. A default build's profile shows only runtime internals — `ponyint_cpu_tick`, `run_thread`, `read_msg` — because your code was inlined into them. With `--debug`, your functions appear by name with accurate sample counts.
- **Adds DWARF debug info.** The profiler can map samples to source file and line number, not just function name.

There is no middle ground. `ponyc` has no separate optimization-level flag — `--debug` gives you no optimization plus DWARF, and the default gives you full optimization with no DWARF.

The trade-off: `--debug` profiles show where time goes in unoptimized code. Hot spots in unoptimized code are usually hot in optimized code too, but relative proportions can shift. The optimizer may eliminate overhead that looks significant in the unoptimized profile.

### A note on `--strip`

The `--strip` flag removes DWARF debug sections from a `--debug` build but leaves the symbol table intact — function names still appear in profiles. Only source-line mapping is lost. On a default (non-debug) build, there are no DWARF sections to remove, so `--strip` has no effect.

## What you'll see in a profile

### Pony name mangling

Pony compiles each method to a C-level symbol named `TypeName_refcap_methodname_types`. Some examples from a real profile:

- `Main_ref__compute_WW` — the `_compute` method on `Main ref`
- `Main_tag_create_ioo` — the `create` constructor on `Main tag`
- `collections_Range_U64_val_ref_has_next_b` — the `has_next` method on `Range[U64]`

The type name appears at the start and the method name appears after the reference capability — you can read both at a glance without decoding the rest.

### Scheduler threads, not actors

The Pony runtime runs N scheduler threads (OS threads). Each thread picks up actors from a queue and runs their behaviors. A profiler samples OS threads, so samples land on scheduler threads — but each sample's call stack shows which actor behavior was running at that moment. You can still see which of your functions are hot.

There is also an ASIO thread for async I/O. If you see time in ASIO functions, your program is I/O-bound and a CPU profiler won't show the bottleneck. I/O profiling is outside the scope of this guide.

### Runtime functions

You'll see these functions from the Pony runtime in your profiles:

| Function | What it does |
|---|---|
| `ponyint_actor_run` | The scheduler running an actor's behavior. Your code appears in the call stack under this function. |
| `pony_sendv` | Sending a message to an actor. Time here means message-passing overhead. |
| `pony_create` | Creating a new actor. |
| `ponyint_gc_mark`, `ponyint_gc_sweep` | Garbage collection mark and sweep phases. Time here means GC pressure. |
| `ponyint_sched_*` | Scheduler internals — work stealing, thread coordination. |

How to read the results:

- Most time in your own functions under `ponyint_actor_run` — normal. Optimize your code directly.
- A lot of time in `ponyint_gc_mark` or `ponyint_gc_sweep` — GC pressure. See the [garbage collector](pony-performance-cheat-sheet.md#garbage-collector) section of the performance cheat sheet.
- A lot of time in `pony_sendv` or `pony_create` — too many actors or too many messages. See the [design](pony-performance-cheat-sheet.md#design-for-performance) and [allocations](pony-performance-cheat-sheet.md#avoid-allocations) sections of the cheat sheet.

## Linux: perf

`perf` is the standard sampling profiler on Linux.

Record a profile with call graphs, then view the results:

```bash
perf record -g ./my-program
perf report
```

The `-g` flag records call graphs so you see the full call stack, not just the leaf function that was running when each sample was taken.

`perf record` needs either root or an appropriate `perf_event_paranoid` setting. You may need:

```bash
sudo sysctl kernel.perf_event_paranoid=1
```

### Flame graphs

Flame graphs make hot call paths easy to spot. Two ways to generate them:

**With Brendan Gregg's [FlameGraph](https://github.com/brendangregg/FlameGraph) scripts:**

```bash
perf script | stackcollapse-perf.pl | flamegraph.pl > flamegraph.svg
```

**With `perf`'s built-in support (recent kernels):**

```bash
perf script report flamegraph
```

This produces an HTML flame graph without external scripts.

## macOS: Instruments

Instruments ships with Xcode. The Time Profiler instrument is the one you want.

You can open Instruments and attach to a running process, or launch the program from Instruments. From the command line:

```bash
xctrace record --template 'Time Profiler' --launch ./my-program
```

Open the resulting `.trace` file in Instruments for analysis. With `--debug`, you get source-level detail in the call trees.

## Callgrind

Callgrind is part of [Valgrind](https://valgrind.org/). Unlike `perf` and Instruments, which sample, Callgrind instruments every function call. This makes it precise but slow — programs run 10-50x slower.

Using Callgrind requires a `ponyc` built with Valgrind annotations so that Valgrind can track allocations through Pony's memory allocator. This means building ponyc from source. See the [Valgrind section](../compiler/custom-ponyc-builds.md#valgrind) of the custom ponyc builds page for instructions.

Record a profile:

```bash
valgrind --tool=callgrind ./my-program
```

View the results as text:

```bash
callgrind_annotate callgrind.out.<pid>
```

Or open the output in KCachegrind (Linux) or QCachegrind (macOS) for a visual call graph.

## See also

- [Tracing Pony Programs](../debugging/tracing.md) — runtime event tracing (actor scheduling, GC, message sends) via a custom `ponyc` build. Different from CPU profiling: tracing records what the runtime did and when, while profiling shows where CPU time went.
- [DTrace / SystemTap](../compiler/custom-ponyc-builds.md#dtrace-systemtap) — USDT probes in the Pony runtime for live tracing on Linux (SystemTap) and FreeBSD (DTrace).
