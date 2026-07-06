# Building ponyc from Source

This page covers building ponyc from source for development and contribution work. For prerequisites and platform-specific dependency installation, see ponyc's [BUILD.md](https://github.com/ponylang/ponyc/blob/main/BUILD.md).

## Build Workflow

The build system is CMake. Presets in `CMakePresets.json` set up the build directories, compiler, and flags for you, and a small CMake runner (`lib/build-libs.cmake`) builds the vendored LLVM and support libraries. You run `cmake` and `ctest` directly — there's no wrapper.

Building ponyc from source is a multi-stage process:

```bash
cmake -P lib/build-libs.cmake          # Build vendored LLVM (one-time, takes hours)
cmake --preset release                 # Configure the build directory
cmake --build --preset release         # Compile ponyc and the runtime
ctest --preset release -L ci-core      # Run the compiler, runtime, and stdlib tests
sudo cmake --install build/build_release   # Install to /usr/local
```

`cmake -P lib/build-libs.cmake` only needs to run once. You'll need to rerun it if the vendored LLVM submodule changes or if you delete the `build` directory. To speed up the LLVM build, pass `-DJOBS` (LLVM is memory-hungry, so keep it modest):

```bash
cmake -DJOBS=6 -P lib/build-libs.cmake
```

The compiled `ponyc` lands in `build/release`. The CMake build directory itself is `build/build_release` — that's the path `cmake --install` takes, not `build/release`. To install somewhere other than `/usr/local`, pass `--prefix`:

```bash
sudo cmake --install build/build_release --prefix /foo
```

To clean up:

- `rm -rf build/build_release build/release` — removes the ponyc build but keeps the LLVM libraries. A debug or architecture build uses the matching directory names (`build/build_debug` and `build/debug`, and so on).
- `rm -rf build` — deletes the entire `build` directory, including LLVM. You'll need to rerun `cmake -P lib/build-libs.cmake` after this.

## Build Configuration

Each preset configures its own out-of-source build directory. The two you'll use most are `release` and `debug` (both native architecture). Pick one at the configure step and use the matching preset to build and test:

```bash
cmake --preset debug
cmake --build --preset debug
ctest --preset debug -L ci-core
```

A debug build lands in `build/debug`, with its CMake build directory at `build/build_debug`.

There are also architecture-specific preset families — `x86-64`, `armv8`, and `armv8-a` — each providing a runnable `-debug` and `-release` variant (for example, `armv8-a-release`; the bare family names aren't runnable on their own). For a CPU without a preset, start from the `release` or `debug` preset and set `PONY_ARCH` and the compiler flags yourself:

```bash
cmake --preset release -DPONY_ARCH=arm7 -DCMAKE_C_FLAGS="-march=arm7 -mtune=generic" -DCMAKE_CXX_FLAGS="-march=arm7 -mtune=generic"
cmake --build --preset release
```

To parallelize the ponyc build itself, pass `--parallel` to the build step:

```bash
cmake --build --preset release --parallel 6
```

## Compiler Selection

The presets default to clang. To use GCC instead, override the compiler at the configure step:

```bash
cmake --preset release -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++
```

You don't need to rebuild the LLVM libraries to switch the ponyc compiler this way — the libraries built with `cmake -P lib/build-libs.cmake` work with either. (On the platforms that must build with GCC — 32-bit Raspbian and DragonFly BSD — you build the libraries with GCC as well; see those sections below.) Use a matching pair — both clang or both gcc — rather than mixing a C compiler from one toolchain with a C++ compiler from another.

## Performance Options

### Link-Time Optimization

LTO provides a performance improvement and is worth enabling if you're building ponyc for regular use. It's off by default because it requires clang as the linker — with other linkers, LTO has occasionally produced incorrect binaries. On macOS, an XCode upgrade will require rebuilding ponyc when LTO is enabled.

```bash
cmake --preset release -DPONY_USE_LTO=true
cmake --build --preset release
```

### Runtime Bitcode

With clang, you can build the Pony runtime as LLVM bitcode. This enables cross-module optimizations between your Pony code and the runtime — essentially "super LTO" for the runtime. Optimization times can be significantly longer.

```bash
cmake --preset release -DPONY_RUNTIME_BITCODE=true
cmake --build --preset release
```

Then compile programs with:

```bash
ponyc --runtimebc
```

!!! note
    `--runtimebc` cannot be used with a compiler built for [DTrace/SystemTap probes](../../use/compiler/custom-ponyc-builds.md#dtrace-systemtap); ponyc rejects the combination with an error.

## Instrumentation

The `PONY_USES` option enables various instrumentation features. It is set at the configure step. Multiple options can be combined with commas:

```bash
cmake --preset release -DPONY_USES=address_sanitizer,undefined_behavior_sanitizer
cmake --build --preset release
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

!!! warning "Some options aren't available on OpenBSD or DragonFly BSD"
    On OpenBSD, `valgrind`, `address_sanitizer`, `thread_sanitizer`, `undefined_behavior_sanitizer`, `coverage`, and `dtrace` depend on a runtime, headers, or tooling that OpenBSD doesn't ship, so they can't be built there; configuring rejects them with an explanatory error instead of failing partway through the build. On DragonFly BSD, the three sanitizers (`address_sanitizer`, `thread_sanitizer`, `undefined_behavior_sanitizer`) can't be built because its `gcc13` toolchain ships no sanitizer runtime, and `dtrace` can't be built because DragonFly ships no DTrace-compatible probe-generation tool; as on OpenBSD, configuring rejects these four with an explanatory error instead of failing partway through the build. `valgrind` doesn't work there either: it builds, but DragonFly ships a Valgrind too old to run a Pony program ([ponyc#5435](https://github.com/ponylang/ponyc/issues/5435)). See ponyc's BUILD.md for the details.

## IDE Integration

To generate a `compile_commands.json` for clangd and other LSP tools, configure with `-DCMAKE_EXPORT_COMPILE_COMMANDS=ON`:

```bash
cmake --preset release -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
```

Then symlink the generated file into the project root:

```bash
ln -sf build/build_release/compile_commands.json compile_commands.json
```

Replace `build_release` with `build_debug` if you're using a debug configuration.

## Platform-Specific Notes

### FreeBSD, OpenBSD, and DragonFly BSD

On OpenBSD, use `doas` instead of `sudo` for installation. All three BSDs need `gmake` installed as a package (CMake and the LLVM build shell out to it), but you drive the build with `cmake` and `ctest` directly, the same as everywhere else.

On DragonFly BSD, the base compiler (GCC 8.3) cannot build the vendored LLVM. Install `gcc13` from packages and pass `-DCC=/usr/local/bin/gcc13 -DCXX=/usr/local/bin/g++13` to `cmake -P lib/build-libs.cmake`, and `-DCMAKE_C_COMPILER=/usr/local/bin/gcc13 -DCMAKE_CXX_COMPILER=/usr/local/bin/g++13` to the configure step. See ponyc's [BUILD.md](https://github.com/ponylang/ponyc/blob/main/BUILD.md#dragonfly) for full instructions.

### 32-bit Raspbian

Only GCC works on 32-bit Raspbian — clang is not supported. You also need to build for native CPU tuning:

```bash
cmake -DCC=gcc -DCXX=g++ -P lib/build-libs.cmake
cmake --preset release -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DCMAKE_C_FLAGS="-march=native -mtune=native" -DCMAKE_CXX_FLAGS="-march=native -mtune=native"
cmake --build --preset release
sudo cmake --install build/build_release
```

### 64-bit Raspbian

Build for the `armv8-a` architecture, and pass the position-independent-code flag to both the libs step (`-DPIC`) and the configure step (`-DPONY_PIC_FLAG`). The install reads the arch-specific build directory:

```bash
cmake -DPIC=-fPIC -P lib/build-libs.cmake
cmake --preset armv8-a-release -DPONY_PIC_FLAG=-fPIC
cmake --build --preset armv8-a-release
sudo cmake --install build/build_armv8-a-release
```

### Asahi (M1 Linux)

Build for the `armv8` architecture with its preset:

```bash
cmake -P lib/build-libs.cmake
cmake --preset armv8-release
cmake --build --preset armv8-release
sudo cmake --install build/build_armv8-release
```

## Debugging Tests

Setting the `PONY_TEST_DEBUGGER` environment variable wraps test binaries in a debugger that captures crash information — backtraces, register state, and local variables. This is useful for investigating test failures. The `.ci-scripts/test-debugger.sh` helper prints the debugger command for you; capture it into `PONY_TEST_DEBUGGER`, then run the tests. `ctest` runs the already-built tests without building them, so configure and build the preset first:

```bash
cmake --preset debug
cmake --build --preset debug
export PONY_TEST_DEBUGGER="$(.ci-scripts/test-debugger.sh lldb)"
ctest --preset debug -L ci-core
```

Pass `gdb` instead of `lldb` to use gdb. When a test crashes, the debugger runs automatically and prints diagnostic output before exiting with a non-zero status.
