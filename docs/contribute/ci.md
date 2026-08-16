# CI

The CI system is GitHub Actions. Most repos use a standard set of 14 workflow files from [ponylang/templates](https://github.com/ponylang/templates), covering PR checks, on-merge automation, release automation, and maintenance. A few repos — ponyc, ponylang-website, and shared-docker — diverge from the template.

All Linux CI runs in Docker containers. Build images are hosted on GitHub Container Registry under the [ponylang organization's packages](https://github.com/orgs/ponylang/packages).

A few Pony projects might still be using legacy CI setups with Appveyor, CircleCI, CirrusCI, or TravisCI. If you see any of these, you are encouraged to submit a PR to update them to use GitHub Actions.

---

- [Tokens and Secrets](ci/tokens-and-secrets.md) — `GITHUB_TOKEN` vs. `RELEASE_TOKEN` and the full secret inventory
- [Standard Workflows](ci/standard-workflows.md) — what the 14 template workflows do
- [Release Pipeline](ci/release-pipeline.md) — the three-tag release chain
- [Nightly and Breakage Pipeline](ci/nightly-and-breakage-pipeline.md) — the daily cascade from ponyc nightly to library breakage tests
- [Bot Actions](ci/bot-actions.md) — the custom GitHub Actions that automate changelog, release, and documentation tasks
- [Setting Up a New Repo](ci/setting-up-a-new-repo.md) — adding a new repo with CI, releases, and breakage testing
- [CI Image Organization](ci/ci-image-organization.md) — Docker image naming and tagging conventions
- [GitHub Actions and Security](ci/gh-actions-security.md) — action pinning, threat model, and security policies
- [ponyc CI Tiers](ci/ponyc-ci-tiers.md) — ponyc's tiered testing schedule
- [Scheduled Jobs](ci/scheduled-jobs.md) — all scheduled CI jobs and their times
- [Triggered Jobs](ci/triggered-jobs.md) — cross-repo dispatch events and their receivers
