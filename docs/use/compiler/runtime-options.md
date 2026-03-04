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

When `ponyc` is built with runtime tracing enabled, additional `--ponytracing*` options become available for tracing actor, scheduler, and GC events. See [Trace Pony Programs](../debugging/tracing.md) for details.

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
