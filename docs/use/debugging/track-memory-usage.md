# Tracking memory usage at runtime

## Tracking memory consumed by an actor

The Pony runtime can be built to track memory usage. This is helpful when trying to understand what components are using up memory.

When configured, the following functions are exposed:

- `ponyint_sched_static_mem_size`

returns the static memory used by the scheduler subsystem.

- `ponyint_sched_static_alloc_size`

returns the static memory allocated by the scheduler subsystem.

- `ponyint_sched_total_memory_size`

returns the total memory used by a scheduler thread.

- `ponyint_sched_total_alloc_size`

returns the total memory allocated by a scheduler thread.

- `ponyint_actor_mem_size`

returns the size of the given actor.

- `ponyint_actor_alloc_size`

returns the size of the memory pool allocated to the given actor.

- `ponyint_actor_total_mem_size`

returns the memory that is actively used by the runtime for the given actor.

- `ponyint_actor_total_alloc_size`

returns the memory allocated by the given actor whether it is actively used or not.

### Usage

The above functions can be used like any other [c functions](https://tutorial.ponylang.io/c-ffi/calling-c.html).
For example, in order to keep track of memory of any actor, we need to add the following in the beginning of a file.

```pony
use @ponyint_actor_total_mem_size[U64](a : Any tag)
```

Later, this function can be used to figure out the total memory used by an actor by using one of the following

```pony
    let size = @ponyint_actor_total_mem_size(this)
    env.out.print("my size = " + size.string())
```

or,

```pony
    some_actor = SomeActor.create(x, y, z)
    let size = @ponyint_actor_total_mem_size(some_actor)
    env.out.print("size of some actor " + size.string())
```

### Building ponyc to track memory usage

Memory tracking is not enabled by default. You need to build ponyc from source with the `runtimestats` and `runtimestats_messages` options:

```bash
make configure use=runtimestats,runtimestats_messages
make build
```

The resulting `ponyc` binary is in `build/release/`. Use it in place of your system `ponyc` to compile programs with memory tracking enabled.

For full source build instructions, see [Custom ponyc Builds for Debugging](custom-ponyc-builds.md).
