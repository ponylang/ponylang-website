# Standard Workflows

Most ponylang repos use 14 workflow files copied from [ponylang/templates](https://github.com/ponylang/templates). They fall into four groups: PR checks, on-merge automation, release automation, and maintenance.

## PR / CI workflows

These run when a pull request is opened or updated.

| Workflow | Trigger | What it does |
| --- | --- | --- |
| `pr.yml` | `pull_request` on code changes | Builds and tests on Linux (in a container), macOS, and Windows |
| `pony-lint.yml` | `pull_request` on `.pony` files | Lints Pony source against nightly ponyc |
| `pr-repo-hygiene.yml` | `pull_request` | Lints markdown, lints shell scripts, verifies `CHANGELOG` format |
| `lint-action-workflows.yml` | `pull_request` | Lints GitHub Actions workflow YAML with actionlint |

### Concurrency

PR workflows use concurrency groups keyed on `github.ref` with `cancel-in-progress: true`. A new push to the same PR cancels the prior run.

### Path filters

The main build (`pr.yml`) excludes `*.md`, `*.yml`, and `*.yaml` from triggering it. The workflow file itself is re-included so that changes to the workflow still run the build.

## On-merge workflows

These run when a pull request merges to main. Each workflow invokes a custom GitHub Action maintained in its own repo — see [bot actions](bot-actions.md) for what those actions do internally.

| Workflow | Trigger | What it does |
| --- | --- | --- |
| `changelog-bot.yml` | `push` to main | Updates `CHANGELOG.md` from merged PR labels |
| `release-notes.yml` | `push` to main | Aggregates `.release-notes/` files into `next-release.md` |
| `release-notes-reminder.yml` | `pull_request_target` (labeled) | Comments reminding the contributor to add release notes |

## Release workflows

These run during the three-tag release chain.

| Workflow | Trigger | What it does |
| --- | --- | --- |
| `prepare-for-a-release.yml` | `release-X.Y.Z` tag | Versions `CHANGELOG.md`, writes `VERSION`, pushes the `X.Y.Z` tag |
| `release.yml` | `X.Y.Z` tag | Builds artifacts, creates the GitHub Release |
| `announce-a-release.yml` | `announce-X.Y.Z` tag | Publishes release notes, posts to Zulip, comments on the Last Week in Pony issue |
| `generate-documentation.yml` | `workflow_dispatch` (manual) | Generates and deploys library documentation |

See [release pipeline](release-pipeline.md) for how the three-tag chain works.

## Maintenance workflows

These run on schedules or in response to cross-repo dispatch events.

| Workflow | Trigger | What it does |
| --- | --- | --- |
| `breakage-against-ponyc-latest.yml` | `repository_dispatch` | Tests the project against the latest nightly ponyc |
| `add-discuss-during-sync.yml` | Issue/PR events | Adds the "discuss during sync" label |
| `remove-discuss-during-sync.yml` | Issue/PR closed | Removes the "discuss during sync" label |

Some repos split the breakage workflow into per-platform files (e.g., separate workflows for Linux, macOS, and Windows).

See [nightly and breakage pipeline](nightly-and-breakage-pipeline.md) for how the nightly cascade dispatches these tests. See [CI image organization](ci-image-organization.md) for the Docker image naming and tagging conventions used across workflows.

## Repos that diverge from the template

### ponyc

Beyond the standard workflows, ponyc has nightlies, tiered testing, stress tests, Docker image management, Cloudsmith webhook handling, LLVM libs-cache management, and playground updates. The PR workflow classifies changed files into suites and runs only the relevant tests.

### ponylang-website

No release workflows, no changelog bot, no nightlies. Instead it has `validate-site-on-pr.yml` and `verify-site-builds.yml`. Deployment is outside GitHub Actions.

### shared-docker

No release or changelog workflows. Has `rebuild-ponyc-based-images.yml` (rebuilds all CI builder images) and `build-linter-images.yml`.
