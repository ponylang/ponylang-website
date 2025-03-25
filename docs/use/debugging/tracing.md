# Tracing Pony Programs

The Pony runtime can be built to be able to either write a trace to file in the background or work in a "flight recorder" mode where events are stored into in memory circular buffers and written to stderr in case of abnormal program behavior (SIGILL, SIGSEGV, SIGBUS, etc).

Runtime tracing is helpful in understanding how the runtime works and for debugging issues with the runtime.

Traces are written in chromium json format and trace files can be viewed with the perfetto trace viewer.

## Usage

A number of Pony runtime options are enabled when tracing is enabled. The details can be found by running `<pony program> --ponyhelp` (e.g.: `./helloworld --ponyhelp`) and looking at the options that begin with `--ponytracing*` for how to enable and configure tracing.

Once a trace has been captured, it can be viewed with the [perfetto trace viewer](https://perfetto.dev/).

## Building ponyc to enable tracing

Tracing is a costly affair and is not enabled by default. Pony runtime needs to be built separately to enable tracing.

This is a two step process:

- Configuring Pony

   We need to ensure that at the time of configure step, `-DUSE_RUNTIME_TRACING=true` are passed to the cmake at the configure step.

    - For windows, this implies adding the `-DUSE_RUNTIME_TRACING=true` in the [configure](https://github.com/ponylang/ponyc/blob/make.ps1) section of make.ps1

    - For Makefile based builds, passing appropriate arguments to the make [invocation](https://github.com/ponylang/ponyc/blob/Makefile)

   There after, we run the [configure command as usual](https://github.com/ponylang/ponyc/blob/main/BUILD.md)

- Build

  After the `configure` step we build pony from source as per the platform. We get `ponyc` enabled with tracing in the folder `build/release-runtime_tracing` folder.
