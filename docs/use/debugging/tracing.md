# Tracing Pony Programs

The Pony runtime can be built to be able to either write a trace to file in the background or work in a "flight recorder" mode where events are stored into in memory circular buffers and written to stderr in case of abnormal program behavior (SIGILL, SIGSEGV, SIGBUS, etc).

Runtime tracing is helpful in understanding how the runtime works and for debugging issues with the runtime.

Traces are written in chromium json format and trace files can be viewed with the perfetto trace viewer.

## Usage

A number of Pony runtime options are enabled when tracing is enabled. The details can be found by running `<pony program> --ponyhelp` (e.g.: `./helloworld --ponyhelp`) and looking at the options that begin with `--ponytracing*` for how to enable and configure tracing.

Once a trace has been captured, it can be viewed with the [perfetto trace viewer](https://perfetto.dev/).

## Building ponyc to enable tracing

Tracing is not enabled by default. You need to build ponyc from source with the `runtime_tracing` option:

```bash
make configure use=runtime_tracing
make build
```

The resulting `ponyc` binary is in `build/release/`. Use it in place of your system `ponyc` to compile programs with tracing enabled.

For full source build instructions, see [Custom ponyc Builds for Debugging](custom-ponyc-builds.md).
