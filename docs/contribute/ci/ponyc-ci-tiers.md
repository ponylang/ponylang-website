# ponyc CI Tiers

ponyc organizes its CI into three tiers to balance fast feedback against comprehensive coverage. There's also a set of weekly checks that exist outside the tier system.

## Tier 1

Tier 1 jobs run on every non-draft PR. These are the primary platforms that most users target and where regressions are most likely to be caught. A PR must pass all Tier 1 jobs before merging.

- x86-64 Linux (glibc and musl)
- arm64 macOS
- x86-64 Windows

Tier 1 jobs are defined in the [pr-ponyc](https://github.com/ponylang/ponyc/blob/main/.github/workflows/pr-ponyc.yml) workflow.

## Tier 2

Tier 2 jobs are expensive and rarely catch issues that Tier 1 misses. They run on a daily schedule (1 AM UTC) rather than on every PR, gated on whether there were commits in the last 24 hours.

- arm64 Linux (glibc and musl)
- arm64 Windows
- x86-64 macOS
- `riscv64` Linux (cross-compiled)
- arm Linux (cross-compiled)
- armhf Linux (cross-compiled)

Tier 2 jobs are defined in the [ponyc-tier2](https://github.com/ponylang/ponyc/blob/main/.github/workflows/ponyc-tier2.yml) workflow. They can also be triggered manually via workflow dispatch with a `ref` input to test a specific branch, tag, or SHA on demand.

## Tier 3

Tier 3 jobs test platforms where ponyc support is maintained on a best-effort basis. They run on a weekly schedule (Saturday 3 AM UTC), gated on whether there were commits in the last 7 days. These platforms run in QEMU-based VMs.

- x86-64 FreeBSD 14.3
- x86-64 FreeBSD 15.0
- x86-64 OpenBSD 7.8

Tier 3 jobs are defined in the [ponyc-tier3](https://github.com/ponylang/ponyc/blob/main/.github/workflows/ponyc-tier3.yml) workflow. They can also be triggered manually via workflow dispatch with a `ref` input to test a specific branch, tag, or SHA on demand.

## Weekly Checks

Weekly checks build and test with non-default compiler directives and sanitizers. They're valuable for catching breakage in code paths that don't get exercised during normal builds, but they rarely surface issues beyond confirming that nothing has been broken. They run on a weekly schedule (Sunday 3 AM UTC), gated on whether there were commits in the last 7 days.

- Use directive variants (`dtrace`, `pool_memalign`, `pool_retain`, `runtimestats`, `runtime_tracing`)
- Sanitizers (address sanitizer, undefined behavior sanitizer)

Weekly checks are defined in the [ponyc-weekly-checks](https://github.com/ponylang/ponyc/blob/main/.github/workflows/ponyc-weekly-checks.yml) workflow. They can also be triggered manually via workflow dispatch with a `ref` input to test a specific branch, tag, or SHA on demand.
