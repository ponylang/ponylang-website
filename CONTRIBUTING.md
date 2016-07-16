# Contributing to the Pony website

Hi there! Thanks for your interest in contributing to the Pony website. 

Please note, that by submitting any content to the Pony Tutorial book you are agreeing that it can be licensed under our [license](LICENSE.md). Furthermore, you are testifying that you own the copyright to the submitted content and indemnify the Pony developers from any copyright claim that might result from your not being the authorized copyright holder.

## Hugo

The Pony website is generated using [Hugo]: a static website generator. If you are making larger changes to the site, you will need to install Hugo locally to verify your changes are working. 

## How this repo is organized

All Hugo source content is stored in the `source` branch in this repo. All generated content is stored in the `master` branch. No human should ever be making changes to the `master` branch.

## Deploying the website

Any push to the `source` branch, including merging of PRs, will cause [TravisCI] to build the website using Hugo and will deploy the final content to the `master` branch where it will be served via GitHub pages. You, as a human, should never attempt to manually deploy the website. If you are interested how the process works, check out the `.travis.yml` and `deploy.sh` files.

## Developing locally with Hugo

To do larger changes, you'll want to install Hugo locally so you can test your changes. As of now, we are using Hugo v0.16. For detailed instructions on using [Hugo], please refer to its website.

For simpler tasks, once you have Hugo installed, you should be able to:

```bash
cd ponylang.github.io
hugo server
```

Which will start up a local webserver that will serve the Ponylang website on `http://localhost:1313`. Generated content will be placed in the `public` folder which is ignored by git. Do not check in any generated content to the `source` branch.

Once you are happy with your changes, commit then and submit a PR. Before doing that, please read the following 'How to submit a pull request' section.

## How to submit a pull request

Once your content is done, please open a pull request against this repo with your changes. Based on the state of your particular PR, a number of requests for change might be requested:

* Changes to the content
* Changes to where the content is stored in the repo
* Changes to how the content falls into the overall site organization
* Changes to make sure that new content works across a variety of devices

Be sure to keep your PR to a single topic or logical change. If you are working on multiple changes, make sure they are each on their own branch and that before creating a new branch that you are on the master branch (others multiple changes might end up in your pull request). To repeat, each PR should be for a single logical change. We request that you create a good commit messages as laid out in ['How to Write a Git Commit Message'](http://chris.beams.io/posts/git-commit/).

If your PR is for a single logical change (which is should be) but spans multiple commits, we'll ask you to squash them into a single commit before we merge. Steve Klabnik wrote a handy guide for that: [How to squash commits in a GitHub pull request](http://blog.steveklabnik.com/posts/2012-11-08-how-to-squash-commits-in-a-github-pull-request).

[Hugo]: https://gohugo.io
[TravisCI]: https://travis-ci.org
