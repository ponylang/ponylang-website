# Triggered CI Jobs

Across a variety of repositories, we have a number of CI jobs that get triggered based on events in other repositories. This document is an attempt to give a broad overview of what exists and causes them to run. Please note, this list is not guaranteed to be up-to-date and you should check various repos for final confirmation.

The triggered jobs list was last updated September 14, 2021.

<!-- markdownlint-disable -->

## changelog-tool-released

### Sending workflows

- [changelog-tool: release](https://github.com/ponylang/changelog-tool/blob/main/.github/workflows/release.yml)

## Triggered workflows

- [shared-docker: release-a-library-update](https://github.com/ponylang/shared-docker/blob/main/.github/workflows/release-a-library-update.yml)

## ponyc-x86_64-macos-nightly-released

### Sending workflows

- [ponyc: cloudsmith-package-synchronised](https://github.com/ponylang/ponyc/blob/main/.github/workflows/cloudsmith-package-sychronised.yml)

### Triggered workflows

- [corral breakage-against-macos-arm64-ponyc-latest](https://github.com/ponylang/corral/blob/main/.github/workflows/breakage-against-macos-arm64-ponyc-latest.yml)
- [corral breakage-against-macos-x86-ponyc-latest](https://github.com/ponylang/corral/blob/main/.github/workflows/breakage-against-macos-x86-ponyc-latest.yml)
- [ponyup: breakage-against-macos-arm64-ponyc-latest](https://github.com/ponylang/ponyup/blob/main/.github/workflows/breakage-against-macos-arm64-ponyc-latest.yml)
- [ponyup: breakage-against-macos-x64-ponyc-latest](https://github.com/ponylang/ponyup/blob/main/.github/workflows/breakage-against-macos-x86-ponyc-latest.yml)

## ponyc-musl-nightly-released

### Sending workflows

- [ponyc: cloudsmith-package-synchronised](https://github.com/ponylang/ponyc/blob/main/.github/workflows/cloudsmith-package-sychronised.yml)

### Triggered workflows

- [shared-docker: linux-arm64-builder-update](https://github.com/ponylang/shared-docker/blob/main/.github/workflows/linux-arm64-builder-update.yml)
- [shared-docker: linux-x86-builder-update](https://github.com/ponylang/shared-docker/blob/main/.github/workflows/linux-x86-builder-update.yml)
- [shared-docker: release-a-library-update](https://github.com/ponylang/shared-docker/blob/main/.github/workflows/release-a-library-update.yml)

## ponyc-musl-released

### Sending workflows

- [ponyc: cloudsmith-package-synchronised](https://github.com/ponylang/ponyc/blob/main/.github/workflows/cloudsmith-package-sychronised.yml)

### Triggered workflows

- [shared-docker: linux-arm64-builder-update](https://github.com/ponylang/shared-docker/blob/main/.github/workflows/linux-arm64-builder-update.yml)
- [shared-docker: linux-x86-builder-update](https://github.com/ponylang/shared-docker/blob/main/.github/workflows/linux-x86-builder-update.yml)
- [shared-docker: release-a-library-update](https://github.com/ponylang/shared-docker/blob/main/.github/workflows/release-a-library-update.yml)

## ponyc-windows-nightly-released

### Sending workflows

- [ponyc: cloudsmith-package-synchronised](https://github.com/ponylang/ponyc/blob/main/.github/workflows/cloudsmith-package-sychronised.yml)

### Triggered workflows

- [corral: breakage-against-windows-ponyc-latest](https://github.com/ponylang/corral/blob/main/.github/workflows/breakage-against-windows-ponyc-latest.yml)
- [http: breakage-against-windows-ponyc-latest](https://github.com/ponylang/http/blob/main/.github/workflows/breakage-against-windows-ponyc-latest.yml)

## shared-docker-linux-builders-updated

Sent after our various linux builders hosted in the shared-docker repo have been rebuilt.

### Sending workflows

- [shared-docker: linux-builder-update](https://github.com/ponylang/shared-docker/blob/main/.github/workflows/linux-builder-update.yml)

### Triggered workflows

- [appdirs: breakage-against-ponyc-latest](https://github.com/ponylang/appdirs/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [changelog-tool: breakage-against-ponyc-latest](https://github.com/ponylang/changelog-tool/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [corral: breakage-against-linux-ponyc-latest](https://github.com/ponylang/corral/blob/main/.github/workflows/breakage-against-linux-ponyc-latest.yml)
- [crypto: breakage-against-ponyc-latest](https://github.com/ponylang/crypto/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [glob: breakage-against-ponyc-latest](https://github.com/ponylang/glob/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [http: breakage-against-linux-ponyc-latest](https://github.com/ponylang/http/blob/main/.github/workflows/breakage-against-linux-ponyc-latest.yml)
- [http_server: breakage-against-ponyc-latest](https://github.com/ponylang/http_server/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [lori: breakage-against-ponyc-latest](https://github.com/ponylang/lori/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [net_ssl: breakage-against-ponyc-latest](https://github.com/ponylang/net_ssl/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [peg: breakage-against-ponyc-latest](https://github.com/ponylang/peg/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [ponydoc: breakage-against-ponyc-latest](https://github.com/ponylang/ponydoc/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [ponyup: breakage-against-linux-ponyc-latest](https://github.com/ponylang/ponyup/blob/main/.github/workflows/breakage-against-linux-ponyc-latest.yml)
- [reactive_streams: breakage-against-ponyc-latest](https://github.com/ponylang/reactive_streams/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [regex: breakage-against-ponyc-latest](https://github.com/ponylang/regex/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [rfc-tool: breakage-against-ponyc-latest](https://github.com/ponylang/rfc-tool/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [semver: breakage-against-ponyc-latest](https://github.com/ponylang/semver/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [shared-docker: linux-builder-update](https://github.com/ponylang/shared-docker/blob/main/.github/workflows/linux-builder-update.yml)
- [valbytes: breakage-against-ponyc-latest](https://github.com/ponylang/valbytes/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)

<!-- markdownlint-restore -->
