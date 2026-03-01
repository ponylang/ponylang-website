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

## How can I supply custom linker parameters? {:id="custom-linker-parameters"}

So, you need to link your program to a custom library or otherwise pass a particular linker option? You can accomplish your goal using the  `ponyc` `--linker` option.

You'll need to know what your current linker is. To get it, compile a pony program and pass `--verbose 3`.

### On Linux, MacOS or other Unix-like

Then examine the output. You should see something like:

```bash
ld -execute -no_pie -dead_strip -arch x86_64 -macosx_version_min 10.8
  -o ./timer ./timer.o -L"/usr/local/lib/pony/0.9.0-e64bff88c/bin/"
  -L"/usr/local/lib/pony/0.9.0-e64bff88c/bin/../lib"
  -L"/usr/local/lib/pony/0.9.0-e64bff88c/bin/../packages"
  -L"/usr/local/lib" -lponyrt -lSystem
```

The `ld` is the linker command that is usually used on MacOS or Linux. If I wanted to link in the library `Foo` and needed to pass `-lFoo` then I would compile my program as:

`ponyc --linker="ld -lFoo"`

That would change the linker command that `ponyc` runs to:

```bash
ld -lFoo -execute -no_pie -dead_strip -arch x86_64 -macosx_version_min 10.8
  -o ./timer ./timer.o -L"/usr/local/lib/pony/0.9.0-e64bff88c/bin/"
  -L"/usr/local/lib/pony/0.9.0-e64bff88c/bin/../lib"
  -L"/usr/local/lib/pony/0.9.0-e64bff88c/bin/../packages"
  -L"/usr/local/lib" -lponyrt -lSystem
```

### On Windows

Compiling a pony program with `--verbose 3` will produce something like:

```powershell
cmd /C ""C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.11.25503\bin\HostX64\x64\link.exe"
  /DEBUG /NOLOGO /MACHINE:X64 /OUT:.\helloworld.exe .\helloworld.obj
  /LIBPATH:"C:\Program Files (x86)\Windows Kits\10\Lib\10.0.15063.0\ucrt\x64"
  /LIBPATH:"C:\Program Files (x86)\Windows Kits\10\Lib\10.0.15063.0\um\x64"
  /LIBPATH:"C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.11.25503\lib\x64"
  /LIBPATH:"C:\pony\ponyc\build\release-llvm-3.9.1"
  /LIBPATH:"C:\pony\ponyc\build\release-llvm-3.9.1\..\..\packages"
  kernel32.lib msvcrt.lib Ws2_32.lib advapi32.lib vcruntime.lib legacy_stdio_definitions.lib dbghelp.lib ucrt.lib libponyrt.lib "
```

The path ending in `link.exe` is the linker that the pony compiler is currently using.

To add options to the link command, I would compile my program as something like:

`ponyc --linker="C:\OtherPath\link.exe /LIBPATH:C:\Foo"`

## Does Pony support WebAssembly? {:id="wasm-support"}

Not in any practical sense. Very simple programs have been compiled to WASM via emscripten, but no one is actively working on full support. Significant blockers remain around the runtime's IO subsystem, memory allocation, and browser interaction.

If you're interested in pushing this forward, come talk to us on the [Zulip](https://ponylang.zulipchat.com). We'd welcome the help.
