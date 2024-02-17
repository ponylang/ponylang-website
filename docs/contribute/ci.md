# CI

Information related to our various CI systems.

## CI systems in use

Our CI system is GitHub Actions.

A few pony project might still be using legacy CI setups with Appveyor, CircleCI, CirrusCI, or TravisCI. If you see any of these, you are encouraged to submit a PR to update them to using GitHub Actions.

## Additional infrastructure

All our CI for Linux is done in Docker images. See [CI image organization](ci/ci-image-organization.md) for more information about where you can find image definitions. All build images are stored in GitHub Container Registry. You can find a list under the [ponylang organization's packages](https://github.com/orgs/ponylang/packages).

---

- [CI Image Organization](ci/ci-image-organization.md)
- [GitHub Actions and Security](ci/gh-actions-security.md)
- [Scheduled Jobs](ci/scheduled-jobs.md)
- [Triggered Jobs](ci/triggered-jobs.md)
