+++
draft = false
author = "mwahl"
description = "Last week's Pony news, reported this week."
categories = [
    "Last Week in Pony",
]
title = "Last Week in Pony - June 18, 2018"
date = "2018-06-18T15:30:00+02:00"
+++
_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), our [users' mailing list](https://pony.groups.io/g/user) or join us [on IRC](https://webchat.freenode.net/?channels=%23ponylang). 

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
<!--more-->

## News and Blog Posts

- [Stephan Renatus](https://github.com/srenatus) is now a committer for [stable](https://github.com/ponylang/pony-stable). Welcome to the team, Stephan!

- [stable](https://github.com/ponylang/pony-stable), the Pony dependency manager, had a new version released: [0.1.4](https://www.ponylang.io/blog/2018/06/pony-stable-0.1.4-released/).
  Now it supports fetching dependencies from GitLab for all those folks who are #movingtogitlab.

- The [`net/http`](https://stdlib.ponylang.io/net-http--index) package containing code for creating HTTP/1 clients and servers, parsing, building and manipulating URLs is about to be removed from the standard library with the next Pony minor release.
  It will live in its own repository at https://github.com/ponylang/http and will be called `http`. It is already available as of now.
  Full information on the reasoning for the removal is available in [RFC 55: Remove HTTP packages from Stdlib](https://github.com/ponylang/rfcs/blob/master/text/0055-remove-http-server-from-stdlib.md).

## RFCs

### Final Comment Period

- [Add operators for partial integer arithmetic](https://github.com/ponylang/rfcs/pull/125)

- [Formal Viewpoint Adaptation](https://github.com/ponylang/rfcs/pull/122)

- [SSL ALPN](https://github.com/ponylang/rfcs/pull/127)

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
