# GitHub Actions and Security

We heavily leverage GitHub Actions not just for CI testing but do execute code to accomplish a wide variety of Ponylang organization tasks.

Most of the executed code is created and published by either us or GitHub. We also use some actions that are published by additional 3rd parties.

## Our Rules for GitHub Actions

- PRs are not allowed to run actions without approval unless the person opening the PR is a member of the Ponylang organization
- Only actions from GitHub's `actions` organization and our own organization can run using a Docker image or references a git branch or tag
- All "additional 3rd party" actions **MUST** only for a specific git commit hash
- Only "additional 3rd party" actions that have been reviewed and considered trustworthy can be used
- Only Docker images that have been marked by DockerHub or GitHub as Official Images can be used as base images for images that we use as part of our CI process if the image is referenced by a tag
- Docker images not blessed by DockerHub or GitHub can be used as base images for images we use as part of our CI process if the image is referenced by it's SHA and the image has been reviewed for trustworthiness

## Security Concerns

Because actions execute within our organizational trust boundary, there are security concerns that need to be considered when using actions.

### RepoJacking

RepoJacking is when someone takes over the organization/username of an account that used to exist on GitHub and creates a repository that is already referred to by other repositories.

For example, Fred creates a very popular action at `github.com/fred/awesome-action`. Over time, hundreds of other repositories depend on Fred's action. Eventually, Fred renames his user to Freddie. GitHub starts redirecting `github.com/fred/awesome-action` to `github.com/freddie/awesome-action` and existing awesome-action users continue chugging along. Eventually, the redirect expires and GitHub makes Fred eligible a new user to create an account for.

Malevolent Mark grabs Fred when it becomes available, creates a repo called awesome-action and now has the ability to run code within the repositories of any repository still using `github.com/fred/awesome-action` instead of `github.com/freddie/awesome-action` that hasn't implemented some basic repojacking concerns.

### Unexpected Updates

In addition to repojacking, a repository can become "compromised" in a number of ways. The owner's account could be compromised and nefarious code added. The owner could turn over maintenance to someone else who adds nefarious code. Or the owner might have built up good will in hopes of being able to exploit it some day.

## Basic Defenses

### Reference Commit Hashes

We can protect ourselves from repojacking and unexpected updates by only using 3rd party actions by commit hash. When using an action, we reference it something like this:

`github.com/fred/awesome-action@VERSION`

where `VERSION` is any git tag, branch, or commit hash. Tags and branches can be changed while maintaining the same name. Commit hashes are almost impossible to duplicate while also adding an exploit. Someday, someone will manage it, but, it is so improbable that we can consider it "impossible".

To protect ourselves, all "additional 3rd party" actions should only be using commit hashes to select a version of an action to run. For example, here is our configuration for using the Zulip send-message action.

```yml
- name: Send alert on failure
  if: ${{ failure() }}
  uses: zulip/github-actions-zulip/send-message@e4c8f27c732ba9bd98ac6be0583096dea82feea5
  with:
    api-key: ${{ secrets.ZULIP_SCHEDULED_JOB_FAILURE_API_KEY }}
    email: ${{ secrets.ZULIP_SCHEDULED_JOB_FAILURE_EMAIL }}
    organization-url: 'https://ponylang.zulipchat.com/'
    to: notifications
    type: stream
    topic: ${{ github.repository }} unattended job failure
    content: ${{ github.server_url}}/${{ github.repository }}/actions/runs/${{ github.run_id }} failed.
```

Note how we reference the action version by it's hash: `b62d5a0e48a4d984ea4fce5dd65ba691963d4db4`.

However, tieing to a commit hash is limiting. We don't automatically get any updates including security fixes. If we were willing to place more trust in the owners of the `zulip` GitHub organization, we could use a version instead.

It is our policy to not trust any 3rd party except for GitHub and therefore, always use the commit hash for actions from those 3rd parties.

### Control Running Actions

All our repositories are set to only run actions when a PR is opened by a member of the Ponylang organization. Before we allow any code to run, if the person opening the PR is not a member of our organization, we can inspect the code and see if it is making nefarious actions related changes including changing scripts that run as part of the CI process.

Every change to a PR has to be approved if the person who opened the PR is not a member of our organization.

## Threat Model

Our threat model for using actions states that we:

- Can not trust anyone who opens a PR unless they already have commit rights.
- Do not trust any organizations except our own and GitHub
- Trust that GitHub will not rename their `actions` organization and expose it to possible repojacking
- Assume that GitHub as an organization is more likely to fix security flaws in their updates than they are to introduce nefarious code
- Trust that official Docker images that have been blessed by GitHub and DockerHub are more likely to fix security flaws in their updates than they are to introduce nefarious code
