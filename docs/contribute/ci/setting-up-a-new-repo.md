# Setting Up a New Repo

Adding a new repository to the ponylang org requires CI, release automation, and breakage testing setup.

## Secrets

All standard secrets are org-level. A new repo in the ponylang org has access to them automatically — there is no repo-level secret setup unless the project has unique infrastructure (ponyc's playground server is the one current example).

See [tokens and secrets](tokens-and-secrets.md) for the full secret inventory.

## Workflow Setup

Copy the workflow files from [ponylang/templates](https://github.com/ponylang/templates). Then customize:

- `pr.yml` — set the container image and platform matrix for the project's build and test needs.
- `release.yml` — configure artifact building. If the project produces binaries, add Cloudsmith upload steps. If it produces library documentation, add documentation generation.
- `generate-documentation.yml` — set the library name and site URL.

See [CI image organization](ci-image-organization.md) for available container images and naming conventions. Use any existing ponylang library repo (e.g., [ponylang/appdirs](https://github.com/ponylang/appdirs)) as a reference for typical configuration.

The remaining workflow files need no project-specific changes.

## GitHub Pages Setup

Two settings are required for library documentation deployment:

1. Set the GitHub Pages source to "GitHub Actions" (not "Deploy from a branch").
2. Configure the `github-pages` environment to allow deployment from all branches.

## Initialize Repo Files

Create these files before the first release. Use any existing ponylang library repo as a template for the initial content.

- `CHANGELOG.md`
- `VERSION`
- `.release-notes/next-release.md`
- `.markdownlint.yml`
- `.markdownlintignore`

## Breakage Test Registration

A new repo does not receive nightly breakage tests until it is registered in two places.

**Linux breakage tests**: Add the repo to the dispatch matrix in `ponylang/shared-docker`'s `rebuild-ponyc-based-images.yml` — specifically the `send-builders-updated-event` job's `matrix.repo` list.

**macOS and Windows breakage tests**: Add the repo to ponyc's `cloudsmith-package-synchronised.yml` dispatch list.

See [nightly and breakage pipeline](nightly-and-breakage-pipeline.md) for how the cascade works.
