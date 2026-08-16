# Bot Actions

Ponylang maintains five active custom GitHub Actions, all Docker-based and hosted on GitHub Container Registry (GHCR). A sixth repo (accepted-rfc-bot-action) exists but is an inactive stub.

## changelog-bot-action

Runs on every PR merge to main. The workflow checks for changelog labels on the merged PR: `changelog - added`, `changelog - changed`, or `changelog - fixed`. If one is present, it runs [`changelog-tool`](https://github.com/ponylang/changelog-tool) to append an entry to `CHANGELOG.md` and pushes the commit.

The push uses `GITHUB_TOKEN` deliberately. A changelog commit should not trigger further workflows. See [tokens and secrets](tokens-and-secrets.md) for why this matters.

### Quirks

The GitHub search API sometimes returns `totalCount: 0` even when results exist. The workaround is retries and reading `results[0]` directly instead of checking `totalCount`.

Both the changelog bot and the [release notes bot](#release-notes-bot-action) may push to main at the same time after a PR merge. Both handle this with a pull-rebase-push retry loop — up to 5 retries with exponential backoff.

## release-bot-action

The core release automation. It is a single Docker image with multiple entrypoints, each invoked as a separate workflow step.

The entrypoints:

- `update-changelog-for-release`
- `update-version-in-VERSION`
- `trigger-artefact-creation`
- `trigger-release-announcement`
- `publish-release-notes-to-github`
- `send-announcement-to-pony-zulip`
- `add-announcement-to-last-week-in-pony`
- `rotate-release-notes`

See [release pipeline](release-pipeline.md) for how these steps chain together.

## release-notes-bot-action

Runs on every PR merge to main. The workflow checks for new files in `.release-notes/`.

If the merged PR had a changelog label, the bot appends the contents of those files to `next-release.md` and deletes the individual files. If there was no changelog label, it just deletes them.

Push-conflict handling is the same as the [changelog bot](#changelog-bot-action): a pull-rebase-push retry loop with up to 5 retries and exponential backoff.

## release-notes-reminder-bot-action

Runs when a changelog label is added to a PR. The workflow checks whether the PR already includes release notes files. If not, it posts a reminder comment.

The bot uses a hidden HTML sentinel (`<!-- release-note-reminder-bot -->`) to avoid posting duplicate reminders on the same PR.

## library-documentation-action-v2

Generates library documentation using `ponyc` and `mkdocs`, then deploys to GitHub Pages via `actions/deploy-pages`. This replaces v1, which pushed to a `generated-documentation` branch.

### Repo setup

For this action to work, the target repo needs two settings:

- GitHub Pages source must be set to "GitHub Actions" (not "Deploy from a branch").
- The `github-pages` environment must allow deployment from all branches.
