# Releases

All ponylang projects have automated release processes. The detailed steps for releasing any given project are in the `RELEASE_PROCESS.md` file in the root of that project's repository.

A "triggers release" label marks bugs that affect runtime correctness — memory leaks, memory safety issues, crashes, or anything else that is degenerate for running programs. When a fix for one of these lands, a release happens as soon as safely possible rather than waiting for the next scheduled release.

## ponyc

The compiler is released roughly monthly. Versioning follows a `0.x.y` scheme where `x` increments for potentially breaking changes and `y` for non-breaking changes.

## Libraries

Pre-1.0 libraries follow the same `0.x.y` scheme as ponyc. Post-1.0 libraries use `x.y.z` with the same basic rules: the major version increments for breaking changes, minor for new features, and patch for bug fixes.

Libraries are released more frequently than ponyc. Most releases go out shortly after changes are merged.

## Tools

Tools like corral and ponyup follow a similar spirit: your existing automations using them shouldn't break across releases. Like libraries, they have a quicker release cadence than ponyc.
