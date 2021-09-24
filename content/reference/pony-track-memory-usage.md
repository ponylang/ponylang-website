+++
title = "Tracking memory usage at runtime"
+++

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

returns the size of the given actor.given an actor, this function returns the size of the actor.

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
Tracking memory is a costly affair and is not enabled by default. Pony runtime needs to be built separately to track memory usage.

This is a two step process

-  Configuring Pony

   We need to ensure that at the time of configure step, `-DPONY_USE_MEMTRACK=true -DPONY_USE_MEMTRACK_MESSAGES=true` are passed to the cmake at the configure step.

    - For windows, this implies adding the `-DPONY_USE_MEMTRACK=true -DPONY_USE_MEMTRACK_MESSAGES=true` in the [configure](https://github.com/ponylang/ponyc/blob/make.ps1) section of make.ps1
   - For Makefile based builds, passing appropriate arguments to the make [invocation](https://github.com/ponylang/ponyc/blob/Makefile)

   There after, we run [configure command as usual](https://github.com/ponylang/ponyc/blob/main/BUILD.md)

- Build
  
  After the `configure` step we build pony from source as per the platform. We get `ponyc` enabled with tracking memory in the folder `build/release-memtrack_messages` folder.

