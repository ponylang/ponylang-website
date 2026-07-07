# Tracing Pony Programs

The Pony runtime can be built to be able to either write a trace to file in the background or work in a "flight recorder" mode where events are stored into in memory circular buffers and written to stderr when the program crashes — a fatal signal such as SIGSEGV or SIGILL on Linux and macOS, or a fault such as an access violation on Windows.

Runtime tracing is helpful in understanding how the runtime works and for debugging issues with the runtime.

Traces are written in chromium json format and trace files can be viewed with the perfetto trace viewer.

## Usage

A number of Pony runtime options are enabled when tracing is enabled. The details can be found by running `<pony program> --ponyhelp` (e.g.: `./helloworld --ponyhelp`) and looking at the options that begin with `--ponytracing*` for how to enable and configure tracing.

Once a trace has been captured, it can be viewed with the [perfetto trace viewer](https://perfetto.dev/).

## Building ponyc to enable tracing

Tracing is not enabled by default. You need to build ponyc from source with the `runtime_tracing` option:

```bash
cmake --preset release -DPONY_USES=runtime_tracing
cmake --build --preset release
```

The resulting `ponyc` binary is in `build/release-runtime_tracing/` — enabling an option suffixes the output directory with the option name. Use it in place of your system `ponyc` to compile programs with tracing enabled.

The commands above are for the Unix build. To enable `runtime_tracing` on Windows, build ponyc from source following ponyc's [BUILD.md](https://github.com/ponylang/ponyc/blob/main/BUILD.md).

For full source build instructions, see [Custom ponyc Builds for Debugging](../compiler/custom-ponyc-builds.md).
