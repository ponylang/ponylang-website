# Tracing Pony Programs

The Pony runtime records actor, scheduler, and GC events as trace data. Traces can be written to a file in the background or kept in per-thread in-memory ring buffers ("flight recorder" mode) that dump to stderr on a crash signal (Linux and macOS) or fault (Windows).

Traces are written in Chromium trace JSON format and can be viewed with the [Perfetto trace viewer](https://perfetto.dev/).

When no tracing categories are enabled, the runtime checks a single boolean at each trace point and skips the call. The overhead is not measurable.

## How tracing gates work

Tracing has two independent gates. Both must be active for an event to be emitted.

**Categories** control which kinds of events are recorded:

| Category | Events |
|----------|--------|
| `scheduler` | Basic scheduler events |
| `scheduler_messaging` | Inter-scheduler messaging events |
| `scheduler_stealing` | Scheduler work-stealing events |
| `actor` | Actor lifecycle and scheduling events |
| `actor_behavior` | Actor behavior run events |
| `actor_gc` | Actor garbage collection and GC threshold change events |
| `actor_state_change` | Actor state change and batch size change events |
| `runtime` | Runtime lifecycle events (init, start, shutdown) |
| `systematic_testing` | Systematic testing events |
| `systematic_testing_details` | Detailed systematic testing events |

All categories are disabled by default.

**Actor tracing mode** controls which actors emit actor-level events:

- `none` — no actors emit actor-level events (default)
- `all` — all actors emit actor-level events
- `cd_only` — only the cycle detector emits actor-level events

The actor-level categories are `actor`, `actor_behavior`, `actor_gc`, and `actor_state_change`. An event from one of these categories is recorded only when the category is enabled *and* the actor tracing mode includes the actor that produced it.

## Enabling tracing from the command line

Set categories and actor tracing mode at startup with `--ponytracingcategories` and `--ponytracingactors`:

```bash
./my_program --ponytracingcategories='actor,scheduler' --ponytracingactors=all
```

See the [Tracing Options](../compiler/runtime-options.md#tracing-options) reference for the full flag list.

## Controlling tracing from code

The `runtime_tracing` standard library package toggles categories and actor tracing mode while a program is running. No trace output file is created until the first call that enables a category, so programs that never call the API pay no I/O cost.

### Category operations

- `RuntimeTracing.enable_categories` — add the listed categories to the active set. Returns `false` if the trace output file cannot be opened.
- `RuntimeTracing.disable_categories` — remove the listed categories from the active set.
- `RuntimeTracing.set_categories` — replace the active set with exactly the listed categories. Pass an empty collection to disable all. Returns `false` if the trace output file cannot be opened.

### Actor tracing mode

- `RuntimeTracing.set_actor_tracing` — set the mode to `ActorTracingNone`, `ActorTracingAll`, or `ActorTracingCycleDetectorOnly`.

All operations require a `RuntimeTracingAuth`, obtained from `AmbientAuth`.

### Specifying categories

Categories are passed as a collection of primitives — typically an array literal:

```pony
RuntimeTracing.enable_categories(
  auth, [SchedulerTracing; ActorBehaviorTracing])
```

The category primitives are: `SchedulerTracing`, `SchedulerMessagingTracing`, `SchedulerStealingTracing`, `ActorTracing`, `ActorBehaviorTracing`, `ActorGCTracing`, `ActorStateChangeTracing`, `RuntimeLifecycleTracing`, `SystematicTestingTracing`, and `SystematicTestingDetailsTracing`.

### Example

This program enables tracing at startup, does some work, narrows the active categories, and then disables tracing:

```pony
use "runtime_tracing"

actor Worker
  let _env: Env

  new create(env: Env) =>
    _env = env
    do_work()

  be do_work() =>
    _env.out.print("Worker running")

actor Main
  new create(env: Env) =>
    let auth = RuntimeTracingAuth(env.root)

    // Enable scheduler and actor behavior tracing.
    RuntimeTracing.enable_categories(
      auth, [SchedulerTracing; ActorBehaviorTracing])

    // Trace all actors.
    RuntimeTracing.set_actor_tracing(auth, ActorTracingAll)

    // Spawn a worker — its behavior run will appear in the trace.
    Worker(env)

    // Narrow to just actor categories.
    RuntimeTracing.set_categories(
      auth,
      [ ActorTracing; ActorBehaviorTracing
        ActorGCTracing; ActorStateChangeTracing ])

    // Switch to cycle detector only.
    RuntimeTracing.set_actor_tracing(auth, ActorTracingCycleDetectorOnly)

    // Turn off all tracing.
    RuntimeTracing.set_categories(auth, [])
```

Run with tracing output flags if you want a custom output path (the defaults — JSON format, `ponytrace.json` — work without any flags):

```bash
./my_program --ponytracingoutput=my-trace.json
```

## Setting tracing defaults from code

Tracing configuration can be set before the runtime starts via `@runtime_override_defaults` on the `Main` actor. This sets initial values for all tracing flags. Command-line arguments still override them.

```pony
actor Main
  new create(env: Env) =>
    env.out.print("Hello, world.")

  fun @runtime_override_defaults(rto: RuntimeOptions) =>
    rto.ponytracingcategories = "scheduler,actor_behavior".cstring()
    rto.ponytracingactors = "all".cstring()
```

See [Programmatic Overrides](../compiler/runtime-options.md#programmatic-overrides) for more on `@runtime_override_defaults`.

## See also

- [Runtime Options: Tracing Options](../compiler/runtime-options.md#tracing-options) — full reference for all `--ponytracing*` command-line flags
- [Profiling Pony Programs](../performance/profiling.md) — CPU profiling with `perf`, Instruments, and Callgrind. Different from runtime tracing: profiling shows where CPU time went, while tracing records runtime events like actor scheduling and GC.
