# Nightly and Breakage Pipeline

A chain of events runs daily, starting from ponyc and reaching every library repo. Each step triggers the next. A nightly ponyc build triggers breakage tests across the org.

## The nightly cascade

### Step 1: ponyc nightly build

A cron job runs `nightlies.yml` in the ponyc repo at midnight UTC. It builds ponyc for all release platforms and uploads packages to Cloudsmith and GHCR.

### Step 2: Cloudsmith webhook

When a package finishes syncing, Cloudsmith fires a webhook to ponyc's `cloudsmith-package-synchronised.yml`. That workflow dispatches platform-specific events to downstream repos (corral, ponyup, lori, and others) for macOS and Windows breakage tests.

### Step 3: Docker image build

The Alpine packages trigger `build-nightly-image.yml`, which builds the `ghcr.io/ponylang/ponyc:nightly` Docker image for x86-64 and arm64.

### Step 4: Downstream dispatch

After the Docker image is pushed, dispatch events go to `ponylang/shared-docker` and `ponylang/library-documentation-action-v2`.

### Step 5: shared-docker rebuild

`ponylang/shared-docker` rebuilds all builder images from the new ponyc nightly. When the rebuild finishes, it dispatches `shared-docker-builders-updated` to all downstream repos.

### Step 6: Library breakage tests

Each downstream repo runs its test suite against the nightly builder. Failures go to Zulip.

See [triggered jobs](triggered-jobs.md) for the full list of dispatch events and their receivers.

## Release image chain

The same pattern runs for releases. A ponyc release triggers `ponyc-release-image-pushed`, which triggers `ponylang/shared-docker` to rebuild release builders, which triggers library breakage tests against the release. See the [release pipeline](release-pipeline.md) for the tag chain that starts a release.

## Failure alerting

Every scheduled and automated workflow includes a failure alert step. Alerts go to the Zulip `notifications` stream under the topic `<repo> unattended job failure`.

PR workflows do not include failure alerts. A human is already watching.

## Cloudsmith webhook auto-disable

Cloudsmith auto-disables webhooks after repeated failures. When this happens, the nightly pipeline from Cloudsmith onward stops silently — zero workflow runs, zero alerts.

`verify-nightly-image-freshness.yml` runs daily at 06:00 UTC in the ponyc repo. It checks that `ghcr.io/ponylang/ponyc:nightly` was updated within the last 36 hours. A stale nightly image means something upstream broke silently. This watchdog covers the Docker image path. The macOS and Windows paths through Cloudsmith have no equivalent watchdog.

See [infrastructure](../infrastructure.md) for Cloudsmith admin access.
