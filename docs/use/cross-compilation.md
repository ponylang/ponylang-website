# Cross-Compilation

Cross-compilation is building a program on one platform that runs on a different one. You compile on your x86-64 Linux workstation, and the resulting binary runs on a RISC-V board or an ARM device. The compiler does all the work on your machine; the target hardware only needs to run the result.

ponyc has built-in support for cross-compiling to Linux targets. The compiler embeds the [LLD](https://lld.llvm.org/) linker, so it can produce binaries for a different architecture without needing an external cross-linker installed. You still need a few things from the target platform (its C library and runtime objects), but ponyc handles the linking itself.

## How It Works

When you tell ponyc to compile for a different Linux target, it detects the cross-compilation scenario automatically and uses its embedded LLD linker. Three conditions trigger this:

1. No `--linker` flag is set.
2. The target is Linux.
3. The target triple differs from the host.

If you do pass `--linker`, ponyc falls back to the legacy path and invokes that linker externally. This serves as an escape hatch if embedded LLD doesn't work for your situation.

## What You Need

Cross-compiling a Pony program requires three things:

- **A ponyc with embedded LLD.** Any ponyc built from source since the LLD integration or installed via ponyup from a recent release has this.

- **A cross-compiled Pony runtime.** The Pony runtime library (`libponyrt`) and CRT objects must be compiled for the target architecture. These are not yet included in ponyc distributions, so you currently need to build them from the ponyc source tree. We plan to include pre-built cross-compiled runtimes in future ponyc releases ([ponylang/ponyc#4968](https://github.com/ponylang/ponyc/issues/4968)) to eliminate this step.

- **A target sysroot.** This is a directory containing the target platform's C library (libc), CRT startup objects (`crt1.o`, `crti.o`, `crtn.o`), and system libraries. Installing a cross-compiler package for your target typically provides this.

## Building the Cross-Compiled Runtime

Until pre-built runtimes ship with ponyc releases, you need to build the runtime from the ponyc source. This requires a full build environment including LLVM (built via `make libs`).

```bash
git clone https://github.com/ponylang/ponyc.git
cd ponyc
make libs build_flags=-j8
make configure config=release
make build config=release
```

Then build the cross-compiled runtime for your target:

```bash
make cross-libponyrt config=release \
  CC=<cross-compiler> CXX=<cross-c++> \
  arch=<arch> \
  cross_cflags="<target-cflags>" \
  cross_lflags="<target-lflags>"
```

The output goes into a directory named after the architecture (e.g., `build/rv64gc/release/`). You point `PONYPATH` at this directory when compiling your program.

See the target-specific guides below for the exact commands for each supported target.

For full source build prerequisites, see [Building ponyc from Source](../contribute/compiler/building-ponyc-from-source.md).

## Compiler Flags

These flags control cross-compilation. Most are "rarely needed" in normal use, but essential when targeting a different platform.

| Flag | Description |
|------|-------------|
| `--triple` | Target triple (e.g., `riscv64-unknown-linux-gnu`). Defaults to the host. |
| `--cpu` | Target CPU (e.g., `generic-rv64`, `cortex-a9`). Defaults to the host CPU. |
| `--features` | CPU features to enable or disable (e.g., `+m,+a,+f,+d,+c`). |
| `--abi` | Target ABI (e.g., `lp64d`). Defaults to the host ABI. |
| `--link-arch` | Linking architecture (e.g., `rv64gc`, `armv7-a`). |
| `--sysroot` | Path to the target system root. Auto-detected from common cross-toolchain locations if not specified. |
| `--linker` | Override the linker command. Bypasses embedded LLD and uses the specified external linker instead. |

The `--sysroot` flag tells ponyc where to find the target's libc CRT objects and system libraries. If you don't specify it, ponyc searches these locations in order:

1. `/usr/<system-triple>/`
2. `/usr/local/<system-triple>/`
3. `/usr/<system-triple>/libc/`
4. `/usr/local/<system-triple>/libc/`

If auto-detection fails, ponyc tells you which paths it searched and asks you to specify `--sysroot` explicitly.

## Supported Targets

These targets are tested in ponyc's CI and have step-by-step setup guides:

- [RISC-V 64-bit Linux (glibc)](cross-compilation/riscv64-linux.md)
- [ARM Linux (glibc, soft-float)](cross-compilation/arm-linux.md)
- [ARM Linux (glibc, hard-float)](cross-compilation/armhf-linux.md)

Other Linux targets may work with the appropriate triple, sysroot, and runtime build, but these three are the ones we actively test.

## Verifying with QEMU

If you don't have the target hardware handy, [QEMU](https://www.qemu.org/) user-mode emulation lets you run cross-compiled binaries on your host machine. Each target guide includes QEMU verification instructions. QEMU is also how ponyc's own CI tests cross-compiled binaries.
