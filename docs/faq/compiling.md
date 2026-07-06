# Compiling

## What are Pony's supported CPU platforms? {:id="supported-CPUs"}

See [supported platforms](../learn/installing-pony.md#supported-platforms).

## I get a "requires dynamic" error when compiling, how do I solve it? {:id="pic-compile-error"}

```bash
/usr/bin/ld.gold: error: ./fb.o: requires dynamic R_X86_64_32
  reloc against 'Array_String_val_Trace' which may
  overflow at runtime; recompile with -fPIC
```

try running `ponyc` with the `--pic` flag.

For example:

```bash
ponyc --pic examples/helloworld
```

A `ponyc` built from source applies `--pic` by default, so you don't need to set it yourself when using such a compiler.

## On Windows I get `fatal error LNK1112: module machine type 'x86' conflicts with target machine type 'x64'` {:id="lnk1112"}

Only 64-bit Windows is supported.

Make sure you're running a `cmd.exe`/`powershell.exe` that does not include 32-bit VS environment variables.

This error occurs when ponyc is compiled in a 32-bit Visual Studio Developer Command Prompt.

## How can I link my program to a C library? {:id="custom-linker-parameters"}

Declare the library in your Pony source with a `use "lib:..."` statement, and ponyc links it for you. To link the library `Foo`:

```pony
use "lib:Foo"
```

If the library lives in a directory the linker doesn't search by default, add that directory with a `use "path:..."` statement:

```pony
use "path:/opt/foo/lib"
use "lib:Foo"
```

These statements can go in any source file in your program, and they work the same on every platform.

## Does Pony support WebAssembly? {:id="wasm-support"}

Not in any practical sense. Very simple programs have been compiled to WASM via emscripten, but no one is actively working on full support. Significant blockers remain around the runtime's IO subsystem, memory allocation, and browser interaction.

If you're interested in pushing this forward, come talk to us on the [Zulip](https://ponylang.zulipchat.com). We'd welcome the help.

## Does Pony do incremental compilation? {:id="incremental-compilation"}

No. Pony does whole-program compilation. The compiler analyzes your entire program together, which is what allows it to guarantee data-race freedom and other safety properties. The tradeoff is that compile times grow with program size.
