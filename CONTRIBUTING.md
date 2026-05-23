# Contributing to the Pony website

Hi there! Thanks for your interest in contributing to the Pony website.

Please note, that by submitting any content to the Pony website you are agreeing that it can be licensed under our [license](LICENSE.md). Furthermore, you are testifying that you own the copyright to the submitted content and indemnify the Pony developers from any copyright claim that might result from your not being the authorized copyright holder.

## AI-assisted contributions

We appreciate contributions, whatever the source. If AI tools help you contribute to Pony, we're glad to have you. Many of us use them too.

That also means we know what AI-assisted writing looks like when no one's reviewed it, and we won't merge PRs that read that way. If your contribution is clearly AI-assisted, you have an extra responsibility before opening it.

The Pony project publishes a set of LLM skills at [ponylang/llm-skills](https://github.com/ponylang/llm-skills). Familiarize yourself with what's there and make sure your contribution uses the ones that apply to it.

One skill isn't optional: `pony-docs-review`. We recommend running it against any contribution. For clearly AI-assisted PRs, we require it. Run it. Understand every finding. Then address it — by fixing it, or by dismissing it with a justification you can defend in the PR. The review surfaces the kind of issues a human maintainer would catch, but it isn't infallible. What you can't do is skip a finding because you didn't understand it. Don't open the PR until you've worked through them all.

If the review surfaces something you don't understand or don't know how to answer, stop. Don't open the PR. Come to the [Pony Zulip](https://ponylang.zulipchat.com/) and ask. We are happy to teach. We enjoy helping people learn Pony.

What we won't do is teach an AI. If a PR's open questions can only be resolved by maintainers explaining things to you so you can relay them to your AI for the next round, that's not a review. That's us teaching a tool that won't remember any of it. Our time is better spent on the contributor who came to Zulip first.

You don't have to disclose AI use, though saying so up front often makes review faster. What you do have to do is stand behind the work. If you can't answer questions about why your PR looks the way it does, it isn't ready.

### Junk PRs

This isn't new policy. Long before AI tools were any good, low-effort PRs that wasted maintainer time could get a contributor blocked. That hasn't changed. What's changed is how easy it has become to produce a junk PR. One won't get you blocked. A pattern of them will. How many makes a pattern is our call.

We don't owe anyone our time. We choose to give it. Don't waste it.

## mkdocs

The Pony website is generated using [mkdocs], a static website generator. If you are making larger changes to the site, you will need to install `mkdocs` locally to verify your changes are working.

## Ponylang.io hosting

Ponylang.io is hosted using [Netlify].

## Deploying the website

Any update to the `main` branch kicks off a build process on Netlify that will result in the website being updated. Previews of changes are available via our PR process.

Netlify offers "deploy previews" that allow you to view the results of a PR before it goes live. Each PR will kick off the creation of a preview you can use to view changes before merging. The Netlify preview is available as part of the PR as a "check".

To see the preview, on the PR page select `Show all checks` and then click `Details` next to `deploy/netlify - Deploy preview is ready!`

## Developing locally with mkdocs

To do larger changes, you'll want to install mkdocs locally so you can test your changes. For detailed instructions on using [mkdocs], please refer to its website.

For simpler tasks, once you have mkdocs installed, you should be able to:

```bash
cd ponylang-website
mkdocs serve
```

Which will start up a local webserver that will serve the Ponylang website on `http://localhost:8000`.

Once you are happy with your changes, commit them and submit a PR. Before doing that, please read the following 'How to submit a pull request' section.

## How to submit a pull request

Once your content is done, please open a pull request against this repo with your changes. Based on the state of your particular PR, a number of requests for change might be requested:

* Changes to the content
* Changes to where the content is stored in the repo
* Changes to how the content falls into the overall site organization
* Changes to make sure that new content works across a variety of devices

Be sure to keep your PR to a single topic or logical change. If you are working on multiple changes, make sure they are each on their own branch and that before creating a new branch that you are on the main branch (others multiple changes might end up in your pull request). To repeat, each PR should be for a single logical change. We request that you create good commit messages as laid out in ['How to Write a Git Commit Message'](http://chris.beams.io/posts/git-commit/).

If your PR is for a single logical change (which it should be) but spans multiple commits, we'll squash them into a single commit when we merge. Please make sure your first comment is the message we should use as the final commit message.

## Relative vs Absolute links

Favor relative links for any content on ponylang.io. Absolute links that point to `https://www.ponylang.io` don't play well with Netlify deploy previews. Absolute links will redirect you off the preview website and onto the live website. For this reason, relative links are preferred.

[mkdocs]: https://www.mkdocs.org/
[Netlify]: https://www.netlify.com/
