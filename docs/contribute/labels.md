# Issue and PR Labels

We've standardized on a base set of labels across our various projects. You can see the default set in the [ponylang org settings](https://github.com/organizations/ponylang/settings/repository-defaults).

Occasionally, a repository will remove labels or add new ones as needed. However, those are generally specialized repositories that are about "more than code". We want to keep our "code repos" like [ponyc](https://github.com/ponylang/ponyc), [corral](https://github.com/ponylang/corral), [ponyup](https://github.com/ponylang/ponyup), [http_server](https://github.com/ponylang/http_server), et al with the same set of labels. This consistency makes it easier for folks to understand what labels mean and perhaps more importantly, makes it easier to automate various tasks. For example, all our code repositories have "changelog labels" and in turn, a [bot that manages changelog entries](https://github.com/ponylang/changelog-bot-action).

Below, we'll break down the different labels into various categories and give a short explanation of each.

## Changelog labels

Changelog labels are added to pull requests that should be added to the CHANGELOG.md for a project. Our changelogs are divided into three sections: `Added`, `Changed`, `Fixed`.

When adding a changelog label to a PR, make sure that the title of the PR is a good "public facing comment" as the title will be the text that appears in the changelog along with a link to the PR itself. Check out the [ponyc CHANGELOG.md](https://github.com/ponylang/ponyc/blob/main/CHANGELOG.md) if you need an example.

| label | description |
| --- | --- |
| changelog - added | The entry will be added to the "Added" section of the CHANGELOG. This is generally used for new features. |
| changelog - changed | The entry will be added to the "Changed" section of the CHANGELOG. This is generally applied to breaking changes. |
| changelog - fixed | The entry will be added to the "Fixed" section of the CHANGELOG. This is generally used for bug fixes |

**N.B.** sometimes a given PR encompasses more than 1 different entry type. That's ok. While rare, we do sometimes list the same PR in multiple sections of the corresponding CHANGELOG.md. You should feel free to add multiple changelog labels if appropriate.

## Not ready for work labels

Not ready for work labels are added to issues when additional work is needed. If someone is interested in contributing, they can jump in my working on resolving the work blocker. They should not however, start work and then open a PR until the cause of the "not ready for work" label has been resolved.

| label | description |
| --- | --- |
| needs discussion | Added when we aren't sure how we want to resolve. |
| needs investigation | Added when someone needs to look into the issue further.|

In general:

* "needs discussion" is a group activity that is blocking the issue from being ready for work.
* "needs investigation" can be a solo activity and is often a great way for someone to get started contributing to Pony. It's a label often seen on bugs whose cause isn't yet known.

## Signaling labels

Signaling labels are used on issues to signal to folks who aren't part of the Pony team which issues we would like their assistance with and which might be a good place to get started.

| label | description |
| --- | --- |
| good first issue | Add this label if you think someone with limited experience in the codebase could get started with it. |
| help wanted | Add this label to any issue that we are open to having a non-committer work on. |

You might think that all issues are "help wanted", however, that isn't the case. Sometimes an issue is more of a reminder to ourselves that something needs to be done (like an upcoming release). Others require a large amount of intimate knowledge and we want to make sure a Pony committer is doing the work.
So yes, most issues will usually have "help wanted" added to them, but not all.

## Type labels

Type labels are added to issues to classify them.

| label | description |
| --- | --- |
| bug | Incorrect behavior that needs to be fixed. |
| documentation | Documentation rather than code related. |
| enhancement | A new feature or an improvement to an existing feature. |

## Uncategorized labels

These labels don't fall into a category but are, nonetheless, useful.

| label | description |
| --- | --- |
| do not merge | Applied to PRs when that shouldn't be merged for some reason. The reason for adding do not merge to a PR should be given in a corresponding comment on the PR. |
| triggers release | Added to issues that we consider so important that once they are fixed, we should do an "immediate" release to a fix out. |
