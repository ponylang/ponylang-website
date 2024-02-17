# Infrastructure

The Pony Developers maintain a number of repositories that contain tools designed to make it easier to manage and run projects associated with the Pony programming language. Each of the repositories is used extensively by us.

We encourage the community to use and contribute to these repositories. If you'd like to discuss contributing to any of the repositories, please stop by the [contribute to Pony stream](https://ponylang.zulipchat.com/#narrow/stream/192795-contribute-to-Pony).

To get assistance using any of the infrastructure tools, please stop by the [tooling stream](https://ponylang.zulipchat.com/#narrow/stream/190367-tooling).

## Container Images

The [shared-docker](https://github.com/ponylang/shared-docker) repository contains the Dockerfiles and scripts used to build the Docker images used by the Pony Developers.

We have a variety of different types of images available. See the repository for more information. A variety of different images are available including:

- Build environments with the Pony compiler and SSL libraries installed. These are updated nightly and for each release of the Pony compiler.
- Build environment with the Pony compiler and PCRE installed. It is updated nightly and for each release of the Pony compiler.

## Tools

### [changelog-tool](https://github.com/ponylang/changelog-tool)

Tool for modifying "standard Pony" changelogs.

## GitHub Actions

### [changelog-bot-action](https://github.com/ponylang/changelog-bot-action)

Bot to update a Pony format changelogs with new entries.

### [library-documentation-action-v2](https://github.com/ponylang/library-documentation-action-v2)

Generates documentation for Pony packages.

### [release-bot-action](https://github.com/ponylang/release-bot-action)

Bot that handles the standard release process for ponylang projects.

### [release-notes-bot-action](https://github.com/ponylang/release-notes-bot-action)

Bot to update release notes with new entries.

### [release-notes-reminder-bot-action](https://github.com/ponylang/release-notes-reminder-bot-action)

Bot to remind that release notes are needed when a "CHANGELOG label" is added to a PR.
