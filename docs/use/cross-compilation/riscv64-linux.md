# RISC-V 64-bit Linux

This guide covers cross-compiling Pony programs from an x86-64 Linux host to RISC-V 64-bit Linux (glibc). These are the same steps ponyc's CI uses to test RISC-V support.

## Install the Cross-Toolchain

On Debian/Ubuntu, install the RISC-V cross-compiler and QEMU for testing:

```bash
sudo apt-get install gcc-10-riscv64-linux-gnu g++-10-riscv64-linux-gnu qemu-user
```

This provides the cross-compiler for building the Pony runtime and a sysroot at `/usr/riscv64-linux-gnu/` containing the target's libc and system libraries.

??? note "GCC version"
    The package name includes the GCC major version (e.g., `gcc-10`). Your distribution may offer a different version. Adjust the `CC` and `CXX` values in the commands below to match what you install.

## Build the Cross-Compiled Runtime

The Pony runtime needs to be compiled for RISC-V. This requires the ponyc source tree with a full build environment. See the [cross-compilation overview](../cross-compilation.md#building-the-cross-compiled-runtime) for the initial setup.

From the ponyc source directory:

```bash
cmake -B build/rv64gc/build_release -S . \
  -DCMAKE_CROSSCOMPILING=true -DCMAKE_SYSTEM_NAME=Linux \
  -DCMAKE_SYSTEM_PROCESSOR=rv64gc \
  -DCMAKE_C_COMPILER=riscv64-linux-gnu-gcc-10 \
  -DCMAKE_CXX_COMPILER=riscv64-linux-gnu-g++-10 \
  -DPONY_CROSS_LIBPONYRT=true -DCMAKE_BUILD_TYPE=release \
  -DCMAKE_C_FLAGS="-march=rv64gc -mtune=rocket" \
  -DCMAKE_CXX_FLAGS="-march=rv64gc -mtune=rocket" \
  -DPONY_ARCH=rv64gc -DLL_FLAGS="-march=riscv64"
cmake --build build/rv64gc/build_release --config release --target libponyrt crt_objects
```

The output lands in `build/rv64gc/release/`.

## Compile a Pony Program

Create a simple test program:

```bash
mkdir hello && cat > hello/main.pony << 'EOF'
actor Main
  new create(env: Env) =>
    env.out.print("Hello from RISC-V!")
EOF
```

Compile it for RISC-V:

```bash
PONYPATH=build/rv64gc/release ponyc \
  --triple=riscv64-unknown-linux-gnu \
  --cpu=generic-rv64 \
  --abi=lp64d \
  --features=+m,+a,+f,+d,+c \
  --link-arch=rv64gc \
  --sysroot=/usr/riscv64-linux-gnu \
  hello
```

This produces a `hello` binary in the current directory.

## Verify with QEMU

Run the cross-compiled binary using QEMU user-mode emulation:

```bash
qemu-riscv64 -L /usr/riscv64-linux-gnu/lib/ ./hello
```

You should see:

```text
Hello from RISC-V!
```

The `-L` flag tells QEMU where to find the target's shared libraries.
