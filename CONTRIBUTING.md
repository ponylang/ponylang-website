# Contributing to the Pony website

Hi there! Thanks for your interest in contributing to the Pony website.

Please note, that by submitting any content to the Pony Tutorial book you are agreeing that it can be licensed under our [license](LICENSE.md). Furthermore, you are testifying that you own the copyright to the submitted content and indemnify the Pony developers from any copyright claim that might result from your not being the authorized copyright holder.

## Hugo

The Pony website is generated using [`mkdocs`]: a static website generator. If you are making larger changes to the site, you will need to install `mkdocs` locally to verify your changes are working.

## Ponylang.io hosting

Ponylang.io is hosted using [Netlify].

## Deploying the website

Any update to the `main` branch kicks off a build process on Netlify that will result in the website being updated. Previews of changes are available via our PR process.

Netlify offers "deploy previews" that allow you to view the results of a PR before it goes live. Each PR will kick off the creation of a preview that can be view changes before merging. The Netlify preview is available as part of the PR as a "check".

To see the preview, on the PR page select `Show all checks` and then click `Details` next to `deploy/netlify - Deploy preview is ready!`

## Developing locally with mkdocs

To do larger changes, you'll want to install mkdocs locally so you can test your changes. For detailed instructions on using [mkdocs], please refer to its website.

For simpler tasks, once you have mkdocs installed, you should be able to:

```bash
cd ponylang.github.io
mkdocs serve
```

Which will start up a local webserver that will serve the Ponylang website on `http://localhost:8080`.

Once you are happy with your changes, commit then and submit a PR. Before doing that, please read the following 'How to submit a pull request' section.

## How to submit a pull request

Once your content is done, please open a pull request against this repo with your changes. Based on the state of your particular PR, a number of requests for change might be requested:

* Changes to the content
* Changes to where the content is stored in the repo
* Changes to how the content falls into the overall site organization
* Changes to make sure that new content works across a variety of devices

Be sure to keep your PR to a single topic or logical change. If you are working on multiple changes, make sure they are each on their own branch and that before creating a new branch that you are on the main branch (others multiple changes might end up in your pull request). To repeat, each PR should be for a single logical change. We request that you create a good commit messages as laid out in ['How to Write a Git Commit Message'](http://chris.beams.io/posts/git-commit/).

If your PR is for a single logical change (which is should be) but spans multiple commits, we'll quash them into a single commit when we merge. Please make sure your first comment is the message we should use as the final commit message.

## Relative vs Absolute links

Favor relative links for any content on ponylang.io. Absolute links that point to `https://www.ponylang.io` don't play well with Netlify deploy previews. Absolute links will redirect you off the preview website and onto the live website. For this reason, relative links are preferred.

[mkdocs]: https://www.mkdocs.org/
[Netlify]: https://www.netlify.com/.
