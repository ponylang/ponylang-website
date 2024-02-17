# Compiling

## What are Pony's supported CPU platforms? {:id="supported-CPUs"}

See [supported platforms](https://github.com/ponylang/ponyc?tab=readme-ov-file#supported-platforms) in the [ponyc](https://github.com/ponylang/ponyc) [README](https://github.com/ponylang/ponyc?tab=readme-ov-file).

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

As of Pony 0.17.0, if you are building `ponyc` from source, you can have `--pic` automatically set for you. When building `ponyc`, run the following `make` command and your generated `ponyc` binary will always supply `--pic` without you having to set it.

```bash
make default_pic=true
```

## On Windows I get `fatal error LNK1112: module machine type 'x86' conflicts with target machine type 'x64'` {:id="lnk1112"}

Only 64-bit Windows is supported.

Make sure you're running a `cmd.exe`/`powershell.exe` that does not include 32-bit VS environment variables.

This error occurs when ponyc is compiled in a 32-bit Visual Studio Developer Command Prompt.
