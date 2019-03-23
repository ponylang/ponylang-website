# How to...

This document contains an overview of how to do various Ponylang.io website tasks.

## Setup your author information for the website

Blog posts contain information about the author at the bottom. Check out any blog post on ponylang.io and you'll see it.

Author information includes:

1. Name
2. "Avatar" photo
3. Bio

To create your author information, create a new branch and open a PR adding your information. In `data/author` there are `.json` files for each author. Your "author name" in post metadata is the part of the file name that proceeds the `.json`. For example: `seantallen.json` leads to a metadata author name of `seantallen`.

Create a author file for yourself. After you've created it, you'll need to add a few fields. Author information is in JSON format and consists of 3 keys:

1. "name"
2. "bio"
3. "avatar"

Please see existing author info files for examples.

- "name" is your as it will appear on blog entries.
- "bio" is your bio. Please note, it can include markdown.
- "avatar" is the name of your avatar image.

After you have updated the author info, before opening your PR, you'll also need to add your avatar image. Place it in `static/avatars/` with a name that matches your "avatar" entry from your `.json` file. Note there is a `default.png` if you are boring and don't want your own avatar.

## "Last Week in Pony"

"Last Week in Pony" is a weekly synopsis of the previous week's Pony news. It's generally released every Sunday. Have a look through [previous versions](https://www.ponylang.io/categories/last-week-in-pony) to get an idea for the content that is common across weeks.

Each week, we open a new [GitHub issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony) to collect submissions for the next "Last Week in Pony". Feel free to submit items of interest to the Pony community.

Remember to set up your author information before creating a "Last Week in Pony".

### Creating a new "Last Week in Pony" file

Although you can create a new "Last Week in Pony" by hand, we recommend installing Hugo. Please see [Contributing](CONTRIBUTING.md) for more information on basic development setup and processes.

1. Checkout the `master` branch and make sure you are up to date.
2. Create a new branch for the "Last Week in Pony". If you were creating one for June 18, 2017 you would run:

`git checkout -b last-week-in-pony-061817`

3. Run Hugo to generate a new blog entry from the "Last Week in Pony" archetype:

`hugo new --kind lwip blog/last-week-in-pony-061817.md`

Note that the date of the post is part of the file name. It should be in the form MMDDYY. The created file will be in `content/blog`.

### "Last Week in Pony" metadata

Each generated blog post includes some Hugo metadata at the top. It looks something like:

```
draft = false
author = "Author Name"
description = "Last week's Pony news, reported this week."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - Month Day, Year"
date = "2017-07-01T15:54:19-04:00"
```

Each "Last Week in Pony" requires a couple of changes to the generated metadata. 

1. Update `author` from `Author Name` to your author name. For example, `seantallen`. You'll need to have set up your author info before this will work.
2. Change `date` from whatever value it has to the date the "Last Week in Pony" should be published. For example, if the blog will be published on Sunday June 18, 2017 you should update the `date` to `2017-06-18T00:00:01-04:00`.
3. Set the title. The `title` field should be updated to include the correct date information. For example, if the post will be published on June 18, 2017, the `title` would be updated to `Last Week in Pony - June 18, 2017`.

### "Last Week in Pony" content

Collect any content submitted from the current GitHub issue. Organize it in a way that makes sense to you. See previous posts for inspiration. Be sure to run the final content through a grammar checker. [Grammarly](http:www.grammarly.com) is a good online grammar checker that has a free option.

### Preparing to publish

Once you have your content complete, commit your changes on the branch and open a PR. As part of the PR process, Netlify will run and a preview of the deploy will be available. 

After the PR is open, close the current "Last Week in Pony" issue and open a new one. **Remember to add the `last-week-in-pony` label**. Without that label, the "submit content" link in the blog post will point to nothing.

### Publish

The current publishing process is as follows, feel free to change it if need be:

- Submit as new link on [/r/ponylang](https://www.reddit.com/r/ponylang/).
- Tweet about it as [@ponylang](https://twitter.com/ponylang).
- Announce in the #announce stream of the Zulip community using the topic ["LWIP"](https://ponylang.zulipchat.com/#narrow/stream/189932-announce/topic/LWIP).
- Tell all of your friends.

If you can't do a step by yourself, ask one of the elders of ponylang to do it for you.

## Release blog post

Each pony release is accompanied by a corresponding "Release" blog post. The purpose of the blog post is to inform the community of what changes were in a release. We announce the release by linking to the blog post. 

### Creating a "Release" file

Although you can create a new "Release" by hand, we recommend installing Hugo. Please see [Contributing](CONTRIBUTING.md) for more information on basic development setup and processes.

1. Checkout the `master` branch and make sure you are up to date.
2. Create a new branch for the "Release". If you were creating one for the release of 0.15.0:

`git checkout -b release-0.15.0`

3. Run Hugo to generate a new  entry from the "Release" archetype:

`hugo new --kind release blog/0.15.0-released.md`

Note that the version released is part of the file name.

### "Release" metadata

Each generated blog post includes some Hugo metadata at the top. It looks something like:

```
draft = false
author = "Author Name"
categories = [
    "Release",
]
date = "2017-07-01T15:54:24-04:00"
title = "0.14.3 Released"
```

Each "Release" requires a couple of changes to the generated metadata. 

1. Update `author` from `Author Name` to your author name. For example, `seantallen`. You'll need to have set up your author info before this will work.
2. Change `date` from whatever value it has to the date the "Release" should be published. If you are doing the release notes the same day you are publishing, you can leave this as is.

### "Release" content

If this is your first release, review previous release posts to get a feel for the general style we are aiming for. You can see examples of past releases [on the website](https://www.ponylang.io/categories/release).

Points you want to highlight:

- High priority fixes
- Significant changes of note (this is subjective)
- Breaking changes

In the case of breaking changes, you should provide examples of how to upgrade existing code to work with the breaking change. See the [0.14.0 released](https://www.ponylang.io/blog/2017/05/0.14.0-released/) post for an example.

### Preparing to publish

Once you have your content complete, commit your changes on the branch and open a PR. As part of the PR process, Netlify will run and a preview of the deploy will be available. 
