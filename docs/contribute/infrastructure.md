# Infrastructure overview

The Pony project relies on a lot of different services. Here's a quick overview.

## 1Password

All core team members have access to the Ponylang 1Password account. Access information for most services is stored in the 1Password account.

Access is via individual accounts that are granted access by an existing administrative member.

## Cloudsmith

All our nightly and release artifacts are stored in [Cloudsmith](https://cloudsmith.io/).

Access is via individual accounts which can then be granted various levels of access. There's a "ponylang" account that can be used for some administrative tasks. Information for the ponylang account is stored in 1Password.

## GitHub Container Registry

All our docker images that are used across various CI and release jobs are stored in the GitHub Container Registry.

## ForwardMX

We have a paid account with [ForwardMX](https://forwardmx.io/). All `@ponylang.io` email addresses are set up with ForwardMX that then forwards them on to a set of aliases.

Access information is in the 1Password account.

## GitHub

All our code is stored on GitHub. All our CI is done via [GitHub actions](https://github.com/features/actions). You'll need a GitHub account to participate in almost all aspects of the Pony project.

### Access to GitHub is divided into three different teams.

#### Contributor

Members have [triage level](https://docs.github.com/en/github/setting-up-and-managing-organizations-and-teams/repository-permission-levels-for-an-organization#permission-levels-for-repositories-owned-by-an-organization) access to all projects.

#### Committer

Members have [maintainer level](https://docs.github.com/en/github/setting-up-and-managing-organizations-and-teams/repository-permission-levels-for-an-organization#permission-levels-for-repositories-owned-by-an-organization) access to all projects.

#### Core

Members have [owner level](https://docs.github.com/en/github/setting-up-and-managing-organizations-and-teams/repository-permission-levels-for-an-organization#permission-levels-for-repositories-owned-by-an-organization) access to all projects.

### We have two Pony related GitHub accounts:

#### [ponylang-main](https://github.com/ponylang-main)

Our standard "bot account". Personal access tokens for our various GitHub action powered bots are from this account; as such, it shows up as a contributor on a variety of Pony projects.

#### [ponylang-gists](https://github.com/ponylang-gists)

Account used to store gists of saved activity on the [pony playground](https://playground.ponylang.io).

Access information for both accounts is stored in the 1Password account.

## Gmail

We have a `ponylang.main` gmail account that is our administrative email for all shared accounts. Bills from paid services all go to this account along with other administrative related emails.

Access information is stored in the 1Password account.

## Linode

We have a paid account with [Linode](https://www.linode.com/). The [pony playground](https://playground.ponylang.io) is hosted on Linode.

Access information is stored in the 1Password account.

## Melpa

The pony emacs mode, [ponylang-mode](https://github.com/ponylang/ponylang-mode) is available via [Melpa](https://melpa.org/).

There's no access to Melpa. All updates are done by Melpa monitoring the ponylang-mode GitHub repo. There's nothing to administer.

## NearlyFreeSpeech.net

The [recordings of our weekly developers' sync](https://sync-recordings.ponylang.io/r/) are currently hosted on [NearlyFreeSpeech.net](https://nearlyfreespeech.net/).

The "admin" account is owned by Sean T. Allen. Andrew Turley has an account with upload access. Sean can grant upload access to others as needed.

All bills for hosting are paid by Sean and reimbursed via our OpenCollective. Unlike most other bills, the low balance/balance due notices are **not** sent to the ponylang.main gmail account.

## Netlify

Netlify hosts a number of our websites including [the pony website](https://ponylang.io), [the pony tutorial](https://tutorial.ponylang.io), and [the pony patterns book](https://patterns.ponylang.org).

Access is via individual accounts which can be granted various levels of access to different projects based on need.

## Open Collective

We have an account with [Open Collective](https://opencollective.com/ponyc) by which we can accept donations to support Pony development.

Access is via individual accounts that can be granted access by a user who already has administrative access.

## PyPI

We have a [PyPI](https://pypi.org) account, used to upload packaged releases of our [Mkdocs theme](https://github.com/ponylang/mkdocs-theme).

Access information is stored in the 1Password account.

## Twitter

We maintain a [ponylang Twitter account](https://twitter.com/ponylang).

Access information is stored in the 1Password account.

## Zapier

We use Zapier to trigger reminders about our weekly [developer sync meeting](pony-sync.md).

Access information for Zapier is stored in the 1Password account.

## Zoom

We have a paid Zoom account that is used primarily for the weekly [developer sync meeting](pony-sync.md), but is also sometimes used for hosting virtual users' groups.

Access information is stored in the 1Password account.

## Zulip

The hub of our community. If you don't know what Zulip is, think Slack. Anyone can sign up for the [Pony Zulip](https://ponylang.zulipchat.com/#).

Administrative access is granted by members who already have such access.
