# ARM Linux (Soft-Float)

This guide covers cross-compiling Pony programs from an x86-64 Linux host to 32-bit ARM Linux (glibc, soft-float ABI). This targets ARMv7-A devices using software floating point. If your target uses hardware floating point, see [ARM Linux (Hard-Float)](armhf-linux.md) instead.

## Install the Cross-Toolchain

On Debian/Ubuntu, install the ARM cross-compiler and QEMU for testing:

```bash
sudo apt-get install gcc-arm-linux-gnueabi g++-arm-linux-gnueabi qemu-user
```

This provides the cross-compiler for building the Pony runtime. The sysroot location varies by distribution. On Debian/Ubuntu, it's typically at `/usr/arm-linux-gnueabi/` or `/usr/local/arm-linux-gnueabi/libc/`. ponyc searches both locations automatically.

## Build the Cross-Compiled Runtime

The Pony runtime needs to be compiled for ARM. This requires the ponyc source tree with a full build environment. See the [cross-compilation overview](../cross-compilation.md#building-the-cross-compiled-runtime) for the initial setup.

From the ponyc source directory:

```bash
make cross-libponyrt config=release \
  CC=arm-linux-gnueabi-gcc \
  CXX=arm-linux-gnueabi-g++ \
  arch=armv7-a \
  cross_cflags="-march=armv7-a -mtune=cortex-a9" \
  cross_lflags="-O3;-march=arm"
```

The output lands in `build/armv7-a/release/`.

## Compile a Pony Program

Create a simple test program:

```bash
mkdir hello && cat > hello/main.pony << 'EOF'
actor Main
  new create(env: Env) =>
    env.out.print("Hello from ARM!")
EOF
```

Compile it for ARM:

```bash
PONYPATH=build/armv7-a/release ponyc \
  --triple=arm-unknown-linux-gnueabi \
  --cpu=cortex-a9 \
  --link-arch=armv7-a \
  --sysroot=/usr/arm-linux-gnueabi \
  hello
```

This produces a `hello` binary in the current directory.

## Verify with QEMU

Run the cross-compiled binary using QEMU user-mode emulation:

```bash
qemu-arm -cpu cortex-a9 -L /usr/arm-linux-gnueabi/ ./hello
```

You should see:

```
Hello from ARM!
```

The `-cpu` flag tells QEMU which CPU to emulate, and `-L` points to the target's shared libraries. Adjust the `-L` path if your sysroot is in a different location (e.g., `/usr/local/arm-linux-gnueabi/libc`).
