# Custom ponyc Builds for Debugging

ponyc supports several build-time options that instrument the compiler and runtime for debugging. These require building ponyc from source with specific flags. All options described here use the Unix/Makefile build system.

## Build Workflow

Every option follows the same pattern:

1. Clone ponyc and build its dependencies (one-time):

    ```bash
    git clone https://github.com/ponylang/ponyc.git
    cd ponyc
    make libs
    ```

2. Configure with the desired option:

    ```bash
    make configure use=<option>
    ```

3. Build:

    ```bash
    make build
    ```

The resulting `ponyc` binary is in `build/release/`. Use it in place of your system `ponyc` to compile programs with the instrumentation enabled.

To combine multiple options, separate them with commas:

```bash
make configure use=address_sanitizer,undefined_behavior_sanitizer
```

Not all combinations are valid — see the individual sections below for compatibility notes.

For full source build instructions (including platform-specific prerequisites), see [Building ponyc from Source](../../contribute/compiler/building-ponyc-from-source.md).

## Valgrind

Annotates the Pony runtime so [Valgrind](https://valgrind.org/) tools like Memcheck and Helgrind can understand Pony's custom memory allocator.

Valgrind development headers must be installed before building. On Debian/Ubuntu:

```bash
apt-get install valgrind
```

Build ponyc with Valgrind support:

```bash
make configure use=valgrind
make build
```

Compile your program with the instrumented ponyc, then run it under Valgrind:

```bash
valgrind ./my-program
```

!!! warning "Not available on OpenBSD"
    Valgrind has no OpenBSD port, so its development headers aren't available and `use=valgrind` can't be built there. `gmake configure use=valgrind` is rejected on OpenBSD with an error.

## Address Sanitizer

[AddressSanitizer](https://clang.llvm.org/docs/AddressSanitizer.html) (ASan) detects memory errors at runtime: buffer overflows, use-after-free, double-free, and stack buffer overflows.

```bash
make configure use=address_sanitizer
make build
```

Compile your program with the instrumented ponyc and run it normally. ASan reports errors to stderr as they occur.

Cannot be combined with `thread_sanitizer`.

!!! warning "Not available on OpenBSD or DragonFly BSD"
    OpenBSD's base toolchain ships no AddressSanitizer runtime, and DragonFly BSD's `gcc13` toolchain doesn't build one either, so `use=address_sanitizer` can't be built on either. `gmake configure use=address_sanitizer` is rejected on OpenBSD with an error.

## Thread Sanitizer

[ThreadSanitizer](https://clang.llvm.org/docs/ThreadSanitizer.html) (TSan) detects data races at runtime.

```bash
make configure use=thread_sanitizer
make build
```

Compile your program with the instrumented ponyc and run it normally. TSan reports data races to stderr.

Cannot be combined with `address_sanitizer`.

!!! warning "Not available on OpenBSD or DragonFly BSD"
    OpenBSD's base toolchain ships no ThreadSanitizer runtime, and DragonFly BSD's `gcc13` toolchain doesn't build one either, so `use=thread_sanitizer` can't be built on either. `gmake configure use=thread_sanitizer` is rejected on OpenBSD with an error.

## Undefined Behavior Sanitizer

[UndefinedBehaviorSanitizer](https://clang.llvm.org/docs/UndefinedBehaviorSanitizer.html) (UBSan) detects undefined behavior at runtime: signed integer overflow, null pointer dereference, misaligned memory access, and other categories.

```bash
make configure use=undefined_behavior_sanitizer
make build
```

Compile your program with the instrumented ponyc and run it normally. UBSan reports violations to stderr.

Can be combined with `address_sanitizer` or `thread_sanitizer`.

!!! warning "Not available on OpenBSD or DragonFly BSD"
    OpenBSD ships only the minimal UndefinedBehaviorSanitizer runtime, not the standalone runtime ponyc links against; DragonFly BSD's `gcc13` toolchain doesn't build the UBSan runtime at all. Either way, `use=undefined_behavior_sanitizer` can't be built there. `gmake configure use=undefined_behavior_sanitizer` is rejected on OpenBSD with an error.

## DTrace / SystemTap

The Pony runtime includes [USDT](https://illumos.org/books/dtrace/chp-usdt.html) (Userland Statically Defined Tracing) probes. They're consumed by SystemTap on Linux and by DTrace on FreeBSD. No other platform is supported: macOS removed DTrace, and neither DragonFly BSD nor OpenBSD ships a DTrace-compatible probe-generation tool (OpenBSD's `btrace` is a separate tracer with no USDT support).

Building requires a `dtrace`-compatible tool on your `PATH`:

```bash
make configure use=dtrace
make build
```

The probes are defined under the `pony` provider and cover:

- **Actor lifecycle** — creation, scheduling, descheduling
- **Message passing** — actor-to-actor and thread message send/receive/push/pop
- **Backpressure** — overload, mute/unmute, pressure state changes
- **Garbage collection** — GC start/end, send/receive phases, threshold changes
- **Memory** — heap allocation
- **Runtime lifecycle** — init, start, end
- **Work stealing** — steal success/failure
- **Thread state** — suspend, resume, nanosleep

For the full list of probes with parameter types and descriptions, see [`src/common/dtrace_probes.d`](https://github.com/ponylang/ponyc/blob/main/src/common/dtrace_probes.d) in the ponyc source.

!!! warning "Static linking on FreeBSD"
    Statically linked programs (`ponyc --static`) build and run but do not expose their probes to DTrace. FreeBSD registers USDT probes through the runtime linker, which a static binary doesn't use; trace a dynamically linked build instead.

!!! warning "Runtime bitcode is incompatible with DTrace"
    A ponyc built with `use=dtrace` cannot compile programs with `--runtimebc`, and rejects the combination with an error. Probe generation operates on native object files, not LLVM bitcode, so the bitcode runtime carries no probes — a `--runtimebc` binary would have none. Use the default static runtime to trace your program.

## Runtime Statistics

Runtime statistics tracking instruments the Pony runtime to report memory usage per actor and per scheduler thread. This is useful for understanding where memory is going in a running program.

Two options are available:

- `runtimestats` — enables basic runtime statistics
- `runtimestats_messages` — adds per-message tracking on top of `runtimestats`

For most debugging scenarios, enable both:

```bash
make configure use=runtimestats,runtimestats_messages
make build
```

For details on the available tracking functions and how to call them from Pony code, see [Tracking Memory Usage at Runtime](../debugging/track-memory-usage.md).

## Runtime Tracing

Runtime tracing records events from the Pony scheduler, actor lifecycle, and message passing. Events can be written to a trace file in the background, or stored in in-memory circular buffers that dump to stderr on abnormal termination (SIGILL, SIGSEGV, SIGBUS). Trace files use Chromium JSON format and can be viewed with [Perfetto](https://perfetto.dev/).

```bash
make configure use=runtime_tracing
make build
```

For details on tracing options and usage, see [Tracing Pony Programs](../debugging/tracing.md).

## Systematic Testing

Systematic testing replaces the Pony scheduler with a deterministic, single-threaded scheduler that explores different actor interleaving orders. This is useful for reproducing concurrency bugs that are otherwise non-deterministic.

Systematic testing requires two options together:

```bash
make configure use=scheduler_scaling_pthreads,systematic_testing
make build
```

The `scheduler_scaling_pthreads` option is required because systematic testing needs pthread-based scheduler scaling rather than the default implementation.

### Seed-Based Replay

When a systematic testing build runs, it uses a random seed to determine the interleaving order. If a run triggers a bug, the runtime prints the seed and a rerun command to stderr. You can replay the exact same interleaving:

```bash
./my-program --ponysystematictestingseed 12345
```

A typical workflow:

1. Run the program repeatedly with different seeds until a bug manifests.
2. Note the seed from the failing run.
3. Replay with `--ponysystematictestingseed` to reproduce the bug deterministically.
4. Fix the bug and verify with the same seed that the fix holds.
