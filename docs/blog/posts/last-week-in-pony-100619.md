---
draft: false
authors:
  - theobutler
description: "Last week's Pony news, reported this week."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - October 6, 2019"
date: 2019-10-06T11:57:30-04:00
---
_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!-- more -->

## Items of note

- Audio from the October 1st, 2019 Pony sync is available [here](https://vimeo.com/915531716). This call is a little different than our usual sync calls. We didn't discuss any open issues, PRs, and whatnot. Instead, we discussed some issues around how we are going to handle LLVM going forward.

- [Version 0.1.1 of the library-scaffolding-generator](https://github.com/ponylang/library-scaffolding-generator/releases/tag/0.1.1) has been released. It contains a fix for a syntax error in the generated Makefile. Thanks to Ryan H for the fix!

- There's been a change to how we build the `latest` and `alpine` ponyc Docker images. This probably doesn't affect you unless you have CI set up for a personal Pony project. Prior to Saturday, October 5th, the `latest` and `alpine` images were built on DockerHub. As of the 5th, the images are now built on CircleCI and pushed to DockerHub. Everything should be exactly the same as before other than a change in where the images are built. If you experience any oddities that you didn't experience prior to this change, please stop by [the zulip](https://ponylang.zulipchat.com/) and let us know.

- Andrew Turley started doing [Inktober](https://inktober.com/) using Pony to generate SVG images that he then plots. He's posting the images on [his Twitter account](https://twitter.com/casio_juarez) and has [a GitHub repo](https://github.com/aturley/follow-the-plot-2) where you can see the code.

## RFCs

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
