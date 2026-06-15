# ponyc CI Tiers

ponyc organizes its CI into three tiers to balance fast feedback against comprehensive coverage. The split tracks release-target status: Tier 1 and Tier 2 are both platforms we ship release binaries for — Tier 1 is the subset gated on every PR for fast feedback, and Tier 2 holds the rest, run on a schedule. Tier 3 holds platforms we test but don't ship release binaries for. There's also a set of weekly checks that exist outside the tier system.

## Tier 1

Tier 1 jobs run on every non-draft PR. These are the primary platforms where we want fast feedback and where regressions are most likely to be caught. A PR must pass all Tier 1 jobs before merging.

- x86-64 Linux (musl)
- arm64 macOS
- x86-64 Windows

For x86-64 Linux, the per-PR job builds against musl; the glibc build runs in Tier 2.

Tier 1 jobs are defined in the [pr](https://github.com/ponylang/ponyc/blob/main/.github/workflows/pr.yml) workflow.

## Tier 2

Tier 2 covers the platforms we ship release binaries for that aren't already gated on every PR by Tier 1. They run on a daily schedule (1 AM UTC) rather than on every PR, gated on whether there were commits in the last 24 hours.

- x86-64 Linux glibc (deb and rpm)
- arm64 Linux (glibc and musl)
- x86-64 macOS
- arm64 Windows

Tier 2 jobs are defined in the [ponyc-tier2](https://github.com/ponylang/ponyc/blob/main/.github/workflows/ponyc-tier2.yml) workflow. They can also be triggered manually via workflow dispatch with a `ref` input to test a specific branch, tag, or SHA on demand.

## Tier 3

Tier 3 covers platforms we test but don't ship release binaries for. They run on a three-day-a-week schedule (Monday, Wednesday, and Friday at 2 AM UTC), gated on whether there were commits in the last 3 days.

- `riscv64` Linux (cross-compiled)
- arm Linux (cross-compiled)
- armhf Linux (cross-compiled)
- x86-64 FreeBSD 14.3
- x86-64 FreeBSD 15.0
- x86-64 OpenBSD 7.9
- x86-64 DragonFly BSD 6.4.2

The BSD platforms run in QEMU-based virtual machines. The cross-compiled Linux targets run in Docker containers under qemu-user emulation.

Tier 3 jobs are defined in the [ponyc-tier3](https://github.com/ponylang/ponyc/blob/main/.github/workflows/ponyc-tier3.yml) workflow. They can also be triggered manually via workflow dispatch with a `ref` input to test a specific branch, tag, or SHA on demand.

## Weekly Checks

Weekly checks build and test with non-default compiler directives and sanitizers. They're valuable for catching breakage in code paths that don't get exercised during normal builds, but they rarely surface issues beyond confirming that nothing has been broken. They run on a weekly schedule (Thursday 3 AM UTC), gated on whether there were commits in the last 7 days.

- Use directive variants (`dtrace`, `pool_memalign`, `pool_retain`, `runtimestats`, `runtime_tracing`)
- Sanitizers (address sanitizer, undefined behavior sanitizer)
- macOS sanitizer and `dtrace` smoke tests (arm64 and x86-64)

Weekly checks are defined in the [ponyc-weekly-checks](https://github.com/ponylang/ponyc/blob/main/.github/workflows/ponyc-weekly-checks.yml) workflow. They can also be triggered manually via workflow dispatch with a `ref` input to test a specific branch, tag, or SHA on demand.
