# Release Pipeline

Releasing a ponylang project is a chain of three tag pushes. A human pushes the first tag. Each workflow pushes the tag that triggers the next. After that first push, the rest runs unattended. Each project's `RELEASE_PROCESS.md` has the human-facing steps for starting a release.

Every step in the chain uses `RELEASE_TOKEN` to push its tag. `GITHUB_TOKEN` pushes do not trigger workflows — GitHub enforces this to prevent infinite loops. If any step uses `GITHUB_TOKEN` instead of `RELEASE_TOKEN`, the next workflow never runs and the release stalls with no error. See [tokens and secrets](tokens-and-secrets.md) for the full explanation.

## Step 1: push release-X.Y.Z

A committer pushes a `release-X.Y.Z` tag. This triggers `prepare-for-a-release.yml`, which:

- Checks out main using `RELEASE_TOKEN`.
- Runs `changelog-tool release` to version `CHANGELOG.md`.
- Writes the version to `VERSION`.
- Updates the version in `corral.json`.
- Updates version references in `README.md`.
- Pushes an `X.Y.Z` tag (using `RELEASE_TOKEN`, so it triggers step 2).
- Adds a new "unreleased" section to `CHANGELOG.md`.
- Deletes the `release-X.Y.Z` tag.

## Step 2: X.Y.Z tag

The `X.Y.Z` tag triggers `release.yml`, which:

- Validates that `CHANGELOG.md` was properly versioned.
- Creates an empty GitHub Release so build jobs can attach artifacts to it.
- Builds artifacts. The specifics are project-dependent — compiling for all platforms, uploading to Cloudsmith.
- For libraries: generates documentation and deploys to GitHub Pages.
- Pushes an `announce-X.Y.Z` tag.

## Step 3: announce-X.Y.Z tag

The `announce-X.Y.Z` tag triggers `announce-a-release.yml`, which:

- Publishes release notes and `CHANGELOG.md` to the GitHub Release.
- Posts to the Zulip announce stream.
- Comments on the open Last Week in Pony (LWIP) issue in ponylang/ponylang-website.
- Rotates release notes (clears `.release-notes/next-release.md`).
- Deletes the `announce-X.Y.Z` tag.

## Concurrency protection

Release workflows use a flat `"release"` concurrency key — one release at a time per repo. This prevents parallel runs from corrupting shared state: `CHANGELOG.md`, `VERSION`, and tags.

## Action repos: the image swap

Some repos are themselves GitHub Actions (changelog-bot-action, release-bot-action, and others). For these, the release process swaps `action.yml` to reference a prebuilt Docker image during step 2, then swaps it back during step 3. Without the swap, a Dockerfile dependency change after release breaks the action.
