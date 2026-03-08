# Working with the Compiler

This section covers compiler-related topics for Pony users: runtime flags for tuning compiled programs, building ponyc from source with instrumentation for debugging, and cross-compilation to other platforms.

## Runtime Options

Compiled Pony programs accept `--pony*` command-line flags for tuning scheduler threads, garbage collection, the cycle detector, and other runtime behavior. These flags are passed to the compiled binary, not to `ponyc`.

- [Runtime Options](compiler/runtime-options.md)

## Custom ponyc Builds

ponyc can be built from source with instrumentation options for debugging: Valgrind annotations, sanitizers (address, thread, undefined behavior), DTrace/SystemTap probes, and systematic testing for concurrency bugs.

- [Custom ponyc Builds for Debugging](compiler/custom-ponyc-builds.md)

## Cross-Compilation

ponyc can cross-compile Pony programs to run on a different architecture. The compiler embeds the LLD linker for cross-compiling to Linux targets, so you don't need an external cross-linker installed.

- [Cross-Compilation](cross-compilation.md)
