# Runtime Options

Compiled Pony programs accept `--pony*` command-line flags that control scheduler, garbage collection, cycle detector, and other runtime behavior. These flags are passed to the compiled binary, not to `ponyc`.

Run any compiled Pony program with `--ponyhelp` to see the full list of available options.

## Scheduler Options

### `--ponymaxthreads`

Use N scheduler threads. Defaults to the number of physical cores (not hyperthreads) available. This can't be larger than the number of cores available.

See the [thread count](../performance/pony-performance-cheat-sheet.md#ponythreads) and [thread pinning](../performance/pony-performance-cheat-sheet.md#pin-your-threads) sections of the Performance Cheat Sheet for guidance on tuning this value.

### `--ponyminthreads`

Minimum number of active scheduler threads allowed. Defaults to 0, meaning that all scheduler threads are allowed to be suspended when no work is available. This can't be larger than `--ponymaxthreads` if provided, or the number of physical cores available.

Can't be used with `--ponynoscale`.

### `--ponynoscale`

Don't scale down the scheduler threads. This disables scheduler thread suspension by making the minimum active scheduler threads equal to the total number of scheduler threads.

Can't be used with `--ponyminthreads`.

### `--ponysuspendthreshold`

Amount of idle time in milliseconds before a scheduler thread suspends itself to minimize resource consumption. Defaults to 1 ms. Min 1 ms, max 1000 ms.

### `--ponynoyield`

Do not yield the CPU when no work is available.

## Garbage Collection Options

### `--ponygcinitial`

Defer garbage collection until an actor is using at least 2^N bytes. Defaults to 2^14 (16 KB).

See the [garbage collector](../performance/pony-performance-cheat-sheet.md#garbage-collector) section of the Performance Cheat Sheet for more on GC tuning.

### `--ponygcfactor`

After GC, an actor will next be GC'd at a heap memory usage N times its current value. This is a floating point value. Defaults to 2.0.

## Allocator Options

### `--ponymemoryprofile`

Trade the allocator's resident memory against throughput on a scale from 1 to 10: 1 returns freed memory quickly for the smallest footprint, 10 holds it for the most throughput. Defaults to 3 — the scale has little room below it for less memory and much more above it for throughput, so the balanced default sits low on it.

## Cycle Detector Options

### `--ponycdinterval`

Run cycle detection every N milliseconds. Defaults to 100 ms. Min 10 ms, max 1000 ms.

### `--ponynoblock`

Do not send block messages to the cycle detector. Setting this to true disables the cycle detector entirely.

See the [cycle detector](../performance/pony-performance-cheat-sheet.md#the-dead-actor-collector-ie-cycle-detector) section of the Performance Cheat Sheet for when and why you might want to disable the cycle detector.

## CPU Pinning Options

See the [thread pinning](../performance/pony-performance-cheat-sheet.md#pin-your-threads) section of the Performance Cheat Sheet for a detailed walkthrough of CPU pinning with `cset` and `numactl`.

### `--ponypin`

Pin scheduler threads to CPU cores. The ASIO thread can also be pinned if `--ponypinasio` is set.

### `--ponypinasio`

Pin the ASIO thread to a CPU the way scheduler threads are pinned to CPUs. Requires `--ponypin` to be set to have any effect.

### `--ponypinpinnedactorthread`

Pin the pinned actor thread to a CPU the way scheduler threads are pinned to CPUs. Requires `--ponypin` to be set to have any effect.

## Stats and Diagnostics

### `--ponyprintstatsinterval`

Print actor stats before an actor is destroyed and print scheduler stats every X seconds. Defaults to -1 (never).

## Runtime Information

### `--ponyversion`

Print the version of the compiler used to build the program and exit.

### `--ponyhelp`

Print the runtime usage options and exit.

## Tracing Options

These options control the runtime's built-in tracing system for recording actor, scheduler, and GC events. When no tracing flags are passed, the runtime checks a single boolean at each trace point and skips the call — the overhead is not measurable. See [Tracing Pony Programs](../debugging/tracing.md) for usage details.

### `--ponytracingmode`

Mode for tracing. Valid options:

- `file` — write trace events to a file
- `flight_recorder` — save events to a per-thread in-memory circular buffer; events are written to stderr when the program crashes (a fatal signal such as SIGSEGV, SIGILL, SIGBUS, or SIGFPE on Linux and macOS, or a fault such as an access violation on Windows)

Defaults to `file`.

### `--ponytracingformat`

Output format for tracing in file mode. Valid options:

- `json` — Chromium trace JSON format (viewable with [Perfetto](https://perfetto.dev/))

Defaults to `json`.

### `--ponytracingoutput`

Output file for tracing in file mode. Valid options:

- `-` — stdout
- `~` — stderr
- any string — filename/path to write to

Defaults to `ponytrace.json`.

### `--ponytracingcategories`

Tracing categories to enable, as comma-separated glob patterns. Valid categories:

- `actor` — basic actor events
- `actor_behavior` — actor behavior run events
- `actor_gc` — actor garbage collection events
- `actor_state_change` — actor state change events
- `scheduler` — basic scheduler events
- `scheduler_messaging` — inter-scheduler messaging events
- `systematic_testing` — systematic testing events
- `systematic_testing_details` — detailed systematic testing events

Defaults to all categories disabled.

### `--ponytracingforceactortracing`

Force tracing for actors. Valid options:

- `all` — force tracing for all actors
- `cd_only` — only force tracing for the cycle detector
- `none` — do not force tracing for any actors

Defaults to `none`.

### `--ponytracingflightrecorderbuffer`

Number of events to buffer per-thread in flight recorder mode. The value is rounded up to the nearest power of 2; the minimum allowed is 1. Defaults to 16384.

### `--ponytracingflightrecorderhandletermint`

Also trap on SIGINT (Ctrl-C) and SIGTERM in flight recorder mode.

### `--ponypintracingthread`

Pin the tracing thread to a CPU the way scheduler threads are pinned to CPUs. Requires `--ponypin` to be set to have any effect.

## Programmatic Overrides

Runtime option defaults can be overridden programmatically by adding a `@runtime_override_defaults` function to your `Main` actor. This function receives a `RuntimeOptions` struct whose fields you can modify.

Command-line arguments still override any values set via `@runtime_override_defaults`.

```pony
actor Main
  new create(env: Env) =>
    env.out.print("Hello, world.")

  fun @runtime_override_defaults(rto: RuntimeOptions) =>
    rto.ponymaxthreads = 4
    rto.ponynoblock = true
```
