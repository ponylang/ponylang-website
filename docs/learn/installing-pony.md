# Installing Pony

The easiest way to install Pony is through [ponyup](https://github.com/ponylang/ponyup), Pony's toolchain manager. Ponyup handles installing and updating the Pony compiler and related tools.

## Supported platforms

<!-- Keep this matrix in sync with the copy in the ponyc repo: README.md -->

| OS \ CPU | `amd64` | `arm64` | `arm32` | `riscv64` |
|---|---|---|---|---|
| **Linux** | ✅ Released | ✅ Released | 🧪 Tested | 🧪 Tested |
| **macOS** | ✅ Released | ✅ Released | — | — |
| **Windows** | ✅ Released | ✅ Released | — | — |
| **FreeBSD** | 🧪 Tested | ✗ Unsupported | — | — |
| **OpenBSD** | 🧪 Tested | ✗ Unsupported | — | — |
| **DragonFly BSD** | 🧪 Tested | — | — | — |

* ✅ **Released** — official prebuilt binaries; also tested in CI
* 🧪 **Tested** — tested in CI; build from source (no prebuilt binary)
* ✗ **Unsupported** — no support
* — **Not applicable** — combination doesn't exist

On Windows, the minimum supported version is **Windows 11 / Windows Server 2022** (build 20348). Pony's networking uses an OS readiness API introduced in that build; earlier versions, including Windows 10, are unsupported.

Platforms marked 🧪 Tested have no prebuilt binary; you'll need to [build ponyc from source](https://github.com/ponylang/ponyc/blob/main/BUILD.md).

## Install ponyup

On Linux or macOS, run:

```bash
sh -c "$(curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/ponylang/ponyup/latest-release/ponyup-init.sh)"
```

## Install the Pony compiler

Once ponyup is installed, install the latest release of the Pony compiler:

```bash
ponyup update ponyc release
```

Prebuilt packages are only available for certain platforms. Check the [ponyc INSTALL.md](https://github.com/ponylang/ponyc/blob/main/INSTALL.md) for the current list of supported distributions. If yours isn't listed, you'll need to build from source.

## Additional dependencies

On Linux, the Pony compiler requires a C compiler and may need additional libraries depending on your distribution. See the [ponyc installation instructions](https://github.com/ponylang/ponyc/blob/main/INSTALL.md) for distro-specific details.

## More information

See the [ponyup repository](https://github.com/ponylang/ponyup) for full documentation, including how to install nightly builds and manage multiple toolchain versions.
