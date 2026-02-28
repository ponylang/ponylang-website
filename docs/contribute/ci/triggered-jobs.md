# Triggered CI Jobs

Across a variety of repositories, we have a number of CI jobs that get triggered based on events in other repositories. This document is an attempt to give a broad overview of what exists and causes them to run. Please note, this list is not guaranteed to be up-to-date and you should check various repos for final confirmation.

The triggered jobs list was last updated February 28, 2026.

<!-- markdownlint-disable -->

## changelog-tool-released

### Sending workflows

- [changelog-tool: release](https://github.com/ponylang/changelog-tool/blob/main/.github/workflows/release.yml)

### Triggered workflows

- [shared-docker: release-a-library-update](https://github.com/ponylang/shared-docker/blob/main/.github/workflows/release-a-library-update.yml)

## ponyc-arm64-macos-nightly-released

### Sending workflows

- [ponyc: cloudsmith-package-synchronised](https://github.com/ponylang/ponyc/blob/main/.github/workflows/cloudsmith-package-sychronised.yml)

### Triggered workflows

- [corral: breakage-against-macos-arm64-ponyc-latest](https://github.com/ponylang/corral/blob/main/.github/workflows/breakage-against-macos-arm64-ponyc-latest.yml)
- [ponyup: breakage-against-macos-arm64-ponyc-latest](https://github.com/ponylang/ponyup/blob/main/.github/workflows/breakage-against-macos-arm64-ponyc-latest.yml)

## ponyc-x86_64-macos-nightly-released

### Sending workflows

- [ponyc: cloudsmith-package-synchronised](https://github.com/ponylang/ponyc/blob/main/.github/workflows/cloudsmith-package-sychronised.yml)

### Triggered workflows

- [corral: breakage-against-macos-x86-ponyc-latest](https://github.com/ponylang/corral/blob/main/.github/workflows/breakage-against-macos-x86-ponyc-latest.yml)
- [ponyup: breakage-against-macos-x86-ponyc-latest](https://github.com/ponylang/ponyup/blob/main/.github/workflows/breakage-against-macos-x86-ponyc-latest.yml)

## ponyc-windows-nightly-released

### Sending workflows

- [ponyc: cloudsmith-package-synchronised](https://github.com/ponylang/ponyc/blob/main/.github/workflows/cloudsmith-package-sychronised.yml)

### Triggered workflows

- [corral: breakage-against-windows-ponyc-latest](https://github.com/ponylang/corral/blob/main/.github/workflows/breakage-against-windows-ponyc-latest.yml)

## ponyc-nightly-image-pushed

### Sending workflows

- [ponyc: build-nightly-image](https://github.com/ponylang/ponyc/blob/main/.github/workflows/build-nightly-image.yml)

### Triggered workflows

- [library-documentation-action-v2: update-nightly-image](https://github.com/ponylang/library-documentation-action-v2/blob/main/.github/workflows/update-nightly-image.yml)
- [shared-docker: rebuild-ponyc-based-images](https://github.com/ponylang/shared-docker/blob/main/.github/workflows/rebuild-ponyc-based-images.yml)
- [shared-docker: release-a-library-update](https://github.com/ponylang/shared-docker/blob/main/.github/workflows/release-a-library-update.yml)

## ponyc-release-image-pushed

### Sending workflows

- [ponyc: build-release-image](https://github.com/ponylang/ponyc/blob/main/.github/workflows/build-release-image.yml)

### Triggered workflows

- [library-documentation-action: update-release-image](https://github.com/ponylang/library-documentation-action/blob/main/.github/workflows/update-release-image.yml)
- [library-documentation-action-v2: update-release-image](https://github.com/ponylang/library-documentation-action-v2/blob/main/.github/workflows/update-release-image.yml)
- [shared-docker: rebuild-ponyc-based-images](https://github.com/ponylang/shared-docker/blob/main/.github/workflows/rebuild-ponyc-based-images.yml)
- [shared-docker: release-a-library-update](https://github.com/ponylang/shared-docker/blob/main/.github/workflows/release-a-library-update.yml)

## shared-docker-builders-updated

Sent after our various Linux builders hosted in the shared-docker repo have been rebuilt.

### Sending workflows

- [shared-docker: rebuild-ponyc-based-images](https://github.com/ponylang/shared-docker/blob/main/.github/workflows/rebuild-ponyc-based-images.yml)

### Triggered workflows

- [appdirs: breakage-against-ponyc-latest](https://github.com/ponylang/appdirs/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [changelog-tool: breakage-against-ponyc-latest](https://github.com/ponylang/changelog-tool/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [corral: breakage-against-linux-ponyc-latest](https://github.com/ponylang/corral/blob/main/.github/workflows/breakage-against-linux-ponyc-latest.yml)
- [crdt: breakage-against-ponyc-latest](https://github.com/ponylang/crdt/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [fork_join: breakage-against-ponyc-latest](https://github.com/ponylang/fork_join/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [github_rest_api: breakage-against-ponyc-latest](https://github.com/ponylang/github_rest_api/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [hobby: breakage-against-ponyc-latest](https://github.com/ponylang/hobby/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [http: breakage-against-linux-ponyc-latest](https://github.com/ponylang/http/blob/main/.github/workflows/breakage-against-linux-ponyc-latest.yml)
- [http_server: breakage-against-ponyc-latest](https://github.com/ponylang/http_server/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [json: breakage-against-ponyc-latest](https://github.com/ponylang/json/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [json-ng: breakage-against-ponyc-latest](https://github.com/ponylang/json-ng/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [lori: breakage-against-ponyc-latest](https://github.com/ponylang/lori/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [mare: breakage-against-ponyc-latest](https://github.com/ponylang/mare/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [peg: breakage-against-ponyc-latest](https://github.com/ponylang/peg/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [ponyup: breakage-against-linux-ponyc-latest](https://github.com/ponylang/ponyup/blob/main/.github/workflows/breakage-against-linux-ponyc-latest.yml)
- [postgres: breakage-against-ponyc-latest](https://github.com/ponylang/postgres/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [reactive_streams: breakage-against-ponyc-latest](https://github.com/ponylang/reactive_streams/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [redis: breakage-against-ponyc-latest](https://github.com/ponylang/redis/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [rfc-tool: breakage-against-ponyc-latest](https://github.com/ponylang/rfc-tool/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [semver: breakage-against-ponyc-latest](https://github.com/ponylang/semver/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [ssl: breakage-against-ponyc-latest](https://github.com/ponylang/ssl/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [stallion: breakage-against-ponyc-latest](https://github.com/ponylang/stallion/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [uri: breakage-against-ponyc-latest](https://github.com/ponylang/uri/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [valbytes: breakage-against-ponyc-latest](https://github.com/ponylang/valbytes/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)
- [web_link: breakage-against-ponyc-latest](https://github.com/ponylang/web_link/blob/main/.github/workflows/breakage-against-ponyc-latest.yml)

<!-- markdownlint-restore -->
