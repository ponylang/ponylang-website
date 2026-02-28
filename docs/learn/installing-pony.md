# Installing Pony

The easiest way to install Pony is through [ponyup](https://github.com/ponylang/ponyup), Pony's toolchain manager. Ponyup handles installing and updating the Pony compiler and related tools.

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

On Linux, the Pony compiler requires a C compiler and may need additional libraries depending on your distribution. See the [ponyc installation instructions](https://github.com/ponylang/ponyc/blob/main/README.md#installation) for distro-specific details.

## More information

See the [ponyup repository](https://github.com/ponylang/ponyup) for full documentation, including how to install nightly builds and manage multiple toolchain versions.
