# ponylang.github.io

This repository contains the source files and published web assets for the Pony language website ([ponylang.org]).

## Prerequisites

The Pony language website is a static site generated using the following tools and libraries:

  - [Hugo] 0.16

## Notes and Instructions

Two main git branches in use in this repository are `master` and `gh-pages-hugo`:

  - `master` branch contains the published web assets that is used to serve [ponylang.org]
  - `gh-pages-hugo` branch contains the source files (HTML layouts, CSS, assets, etc.) to generate the published website via [Hugo]

All development activities / website changes should be restricted on the `gh-pages-hugo` branch, only when those changes are ready to be published then it is pushed upstream to `master`. A typical publishing step, assuming that you have just cloned and checked out the `gh-pages-hugo` branch, are as follows:

  1. Pull the latest published website from `master` into the current branch under the `/public` subfolder
     ```shell
     git subtree add --prefix=public git@github.com:ponylang/ponylang.github.io.git master --squash
     git subtree pull --prefix=public git@github.com:ponylang/ponylang.github.io.git master
     ```
  1. Make any changes necessary on the source files:
     - Use `hugo server` to start a localhost server (for preview)
     - Commit changes and push upstream as per usual, it will only affect `gh-pages-hugo` branch (and not published)
  1. Once the changes are ready to be published to the live website, you can either:
     - Run the `deploy.sh` script to commit and push upstream to both `master` and `gh-pages-hugo` branches, or
     - Publish to `/public` using `hugo` command, commit and push upstream on the git subtree:
     ```shell
     hugo
     git add -A
     git commit -m "Updating site" && git push origin gh-pages-hugo
     git subtree push --prefix=public git@github.com:ponylang/ponylang.github.io.git master
     ```

For more details, you can refer to this tutorial on the [Hugo] website: [Hosting on Github]     


[Hosting on Github]: https://gohugo.io/tutorials/github-pages-blog/
[Hugo]: https://gohugo.io
[ponylang.org]: http://www.ponylang.org
