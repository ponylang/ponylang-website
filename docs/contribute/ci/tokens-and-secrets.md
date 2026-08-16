# Tokens and Secrets

## GITHUB_TOKEN vs. RELEASE_TOKEN

GitHub provides a `GITHUB_TOKEN` automatically for every workflow run. It can read and write the current repo. But pushes made with `GITHUB_TOKEN` do not trigger other workflows. GitHub enforces this to prevent infinite loops.

The ponylang release pipeline is a chain of tag pushes, each triggering the next workflow. If any step pushes a tag with `GITHUB_TOKEN`, the next workflow never runs. No error, no alert — the chain stops silently.

`RELEASE_TOKEN` is a personal access token (classic, `public_repo` scope) owned by the Ponylang Main Bot account. Pushes made with `RELEASE_TOKEN` do trigger other workflows, so the release chain can proceed from step to step.

The changelog bot is the reverse case. When it pushes a CHANGELOG update to main, that push should not trigger itself again. `GITHUB_TOKEN` is correct there.

## The bot account

Ponylang Main Bot is a regular GitHub account, not a GitHub App. All PATs used across the org are owned by this account. Automated commits use the name "Ponylang Main Bot" and the email `ponylang.main@gmail.com`.

See [infrastructure](../infrastructure.md) for more about the bot account.

## Secret inventory

All secrets except the `PLAYGROUND_*` group are org-level — available to every repo in the ponylang org automatically. No per-repo setup is needed for standard workflows.

| Secret | What it is | What it's for |
| --- | --- | --- |
| `GITHUB_TOKEN` | Automatic, per-run | GitHub Container Registry (GHCR) login, package read/write, checkout, bot pushes that should not trigger further workflows |
| `RELEASE_TOKEN` | PAT, `public_repo` scope | Release tag chain, GitHub Release publishing, Last Week in Pony (LWIP) posting, release artifact uploads |
| `PONYLANG_MAIN_API_TOKEN` | PAT, cross-repo scope | `repository_dispatch` events to other repos, "discuss during sync" label automation, release notes reminder bot |
| `CLOUDSMITH_API_KEY` | API key | Uploading release and nightly packages to Cloudsmith. Only repos with distributable binaries (ponyc, corral, ponyup, changelog-tool) |
| `PONYLANG_MAIN_DELETE_PACKAGE_TOKEN` | PAT, `delete:packages` scope | Pruning old nightly Docker images from GHCR (>90 days) |
| `PONYLANG_MAIN_READ_PACKAGE_TOKEN` | PAT, `read:packages` scope | Reading packages cross-repo for libs-cache management (ponyc only) |
| `ZULIP_SCHEDULED_JOB_FAILURE_API_KEY` | Zulip bot credential | Posting failure alerts to the notifications stream |
| `ZULIP_SCHEDULED_JOB_FAILURE_EMAIL` | Zulip bot credential | Paired with `ZULIP_SCHEDULED_JOB_FAILURE_API_KEY` |
| `ZULIP_RELEASE_API_KEY` | Zulip bot credential | Posting release announcements to the announce stream |
| `ZULIP_RELEASE_EMAIL` | Zulip bot credential | Paired with `ZULIP_RELEASE_API_KEY` |
| `PLAYGROUND_HOST` | SSH hostname | SSH into the Pony Playground server after release image builds. ponyc only, repo-level |
| `PLAYGROUND_ADMIN_USER` | SSH username | Paired with `PLAYGROUND_HOST` |
| `PLAYGROUND_KEY` | SSH private key | Paired with `PLAYGROUND_HOST` |

## Fork PRs and secrets

Pull requests from forks get a read-only `GITHUB_TOKEN`. This is a GitHub security feature. Forks have no access to org secrets.

PR CI tests are designed to work without custom secrets. If a workflow requires custom secrets to run PR tests, that is a bug.

One practical consequence: fork PRs against ponyc cannot write to the GHCR libs cache, so they rebuild LLVM from scratch instead of using the cache.
