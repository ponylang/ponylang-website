# Submitting Pull Requests

This page covers the workflow for submitting pull requests to Pony projects. The conventions are consistent across all repositories in the [ponylang](https://github.com/ponylang) organization.

## Fork and Branch

Fork the repository and create a branch for your work. One branch per feature or fix. Don't bundle unrelated changes into a single PR.

## Commit Messages

The commit message matters. In Pony projects, PRs are squash-merged, so the PR title and description become the final commit message. Write the PR description as if it were a commit message: explain *why* the change was made, not just *what* changed. The diff already shows the what.

Chris Beams' [How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit/) is a good guide for the principles, even though some specifics (like the 50-character subject line) don't map directly to PR titles.

## During Review

Don't squash your commits while a PR is under review. Push additional commits so reviewers can see what changed since their last review. The squash merge at the end collapses everything into one commit anyway.

## CI for Non-Members

CI requires approval from a committer before it runs on PRs from non-members. If you want faster feedback, set up CI on your own fork and test there before opening a PR against the main repository.

## Changelog Labels

Pull requests that introduce user-facing changes need a changelog label. The label determines which section of the CHANGELOG the entry appears in. The PR title becomes the changelog entry text, so make sure it reads well as a standalone description.

See [Issue and PR Labels](labels.md) for the full list of labels and their meanings.

## Features Require an RFC

New features that change the language or standard library require an RFC before implementation begins. If you're unsure whether your change needs one, ask on Zulip first.

See [RFC Process](rfcs.md) for details.

## Code Conventions

Each repository has a style guide or follows the conventions established in its existing code. For ponyc, see the [style guide](https://github.com/ponylang/ponyc/blob/main/STYLE_GUIDE.md).
