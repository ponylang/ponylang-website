# Building ponyc from Source

This page covers building ponyc from source for development and contribution work. For prerequisites and platform-specific dependency installation, see ponyc's [BUILD.md](https://github.com/ponylang/ponyc/blob/main/BUILD.md).

## Build Workflow

Building ponyc from source is a multi-stage process:

```bash
make libs              # Build vendored LLVM (one-time, takes hours)
make configure         # Configure the CMake build directory
make build             # Compile ponyc and the runtime
make test              # Run the test suite
sudo make install      # Install to /usr/local (or use prefix=/foo)
```

`make libs` only needs to run once. You'll need to rerun it if the vendored LLVM submodule changes or if you run `make distclean`.

To speed up the LLVM build, pass parallel build flags:

```bash
make libs build_flags="-j6"
```

To clean up:

- `make clean` — removes the ponyc build artifacts but keeps the LLVM libraries.
- `make distclean` — deletes the entire `build` directory, including LLVM. You'll need to rerun `make libs` after this.

## Build Configuration

The main configuration variables are:

| Variable | Default | Description |
|---|---|---|
| `config` | `release` | Build type: `release` or `debug` |
| `arch` | `native` | CPU architecture |
| `tune` | `generic` | CPU tuning |
| `build_flags` | `-j2` | Flags passed to the underlying build tool |

Configuration is set at the `make configure` step and carried through to `make build`:

```bash
make configure config=debug
make build config=debug
```

## Compiler Selection

The build system defaults to clang if it's available. To use GCC instead:

```bash
make configure CC=gcc CXX=g++
```

The C and C++ compilers must be a matching pair. The build will error if you mix clang with g++ or gcc with clang++.

## Performance Options

### Link-Time Optimization

LTO provides a performance improvement and is worth enabling if you're building ponyc for regular use. It's off by default because it requires clang as the linker — with other linkers, LTO has occasionally produced incorrect binaries. On macOS, an XCode upgrade will require rebuilding ponyc when LTO is enabled.

```bash
make configure lto=yes
make build
```

### Runtime Bitcode

With clang, you can build the Pony runtime as LLVM bitcode. This enables cross-module optimizations between your Pony code and the runtime — essentially "super LTO" for the runtime. Optimization times can be significantly longer.

```bash
make configure runtime-bitcode=yes
make build
```

Then compile programs with:

```bash
ponyc --runtimebc
```

## Instrumentation

The `use=` option enables various instrumentation features. It is only valid with `make configure`. Multiple options can be combined with commas:

```bash
make configure use=address_sanitizer,undefined_behavior_sanitizer
```

The available options:

| Option | Description |
|---|---|
| `valgrind` | Valgrind-aware memory allocator annotations |
| `address_sanitizer` | Detect buffer overflows, use-after-free |
| `thread_sanitizer` | Detect data races |
| `undefined_behavior_sanitizer` | Detect undefined behavior |
| `dtrace` | USDT probes for DTrace/SystemTap |
| `systematic_testing` | Deterministic scheduler (requires `scheduler_scaling_pthreads`) |
| `scheduler_scaling_pthreads` | Pthread-based scheduler scaling |
| `coverage` | Code coverage instrumentation |
| `runtimestats` | Runtime statistics collection |
| `runtimestats_messages` | Runtime statistics with message tracking |
| `runtime_tracing` | Runtime tracing/profiling |
| `pooltrack` | Pool memory tracking |
| `pool_memalign` | Pool allocator with memalign |

For detailed usage of valgrind, sanitizers, DTrace, and systematic testing, see [Custom ponyc Builds](../../use/compiler/custom-ponyc-builds.md).

## IDE Integration

To generate a `compile_commands.json` for clangd and other LSP tools:

```bash
make configure CMAKE_FLAGS='-DCMAKE_EXPORT_COMPILE_COMMANDS=ON'
```

Then symlink the generated file into the project root:

```bash
ln -sf build/build_release/compile_commands.json compile_commands.json
```

Replace `build_release` with `build_debug` if you're using a debug configuration.

## Platform-Specific Notes

### FreeBSD, OpenBSD, and DragonFly BSD

Use `gmake` instead of `make` for all build commands. On OpenBSD, use `doas` instead of `sudo` for installation.

### 32-bit Raspbian

Only GCC works on 32-bit Raspbian — clang is not supported. You also need to override the `tune` option:

```bash
make libs
make configure tune=native
make build
```

### 64-bit Raspbian

You need to pass `pic_flag=-fPIC` to both the `libs` and `configure` steps, and override the `arch`. The `arch` override is also needed at install time:

```bash
make libs pic_flag=-fPIC
make configure arch=armv8-a pic_flag=-fPIC
make build
sudo make install arch=armv8-a
```

### Asahi (M1 Linux)

Override the `arch` option:

```bash
make libs
make configure arch=armv8
make build
```

## Debugging Tests

The `usedebugger` variable wraps test binaries in a debugger that captures crash information — backtraces, register state, and local variables. This is useful for investigating test failures:

```bash
make test usedebugger=lldb
make test usedebugger=gdb
```

When a test crashes, the debugger runs automatically and prints diagnostic output before exiting with a non-zero status.
