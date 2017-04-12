---
author: colinobrien
categories:
- Last Week in Pony
date: 2017-04-10T21:34:01-04:00
description: Last week's Pony news, reported this week.
draft: false
title: Last Week in Pony - April 10, 2017
---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](ponylang.org), our Twitter account [@ponylang](https://twitter.com/ponylang), our [users' mailing list](https://pony.groups.io/g/user) or join us [on IRC](https://webchat.freenode.net/?channels=%23ponylang).

Got something you think should be featured? Drop us an email at [last.week.in.pony@gmail.com](mailto:last.week.in.pony@gmail.com).
<!--more-->

## Items of note

Pony 0.13.0 released! It's a high priority release recommended for all Pony users. [PR #1868](https://github.com/ponylang/ponyc/pull/) fixed a type system problem identified by Paul Liétar. Paul is currently working on verifying the Pony type system as part of his final year project at Imperial College. Expect to see more high priority releases as we fix problems that Paul identifies.
[Complete release notes](https://www.ponylang.org/blog/2017/04/0.13.0-released/) are available.

## News and Blog Posts

- [Pony Community Survey](https://docs.google.com/forms/d/e/1FAIpQLScBNr5dPPCVYchRukAm-sFR3wipndVJiua3xHr8CslohVFRlg/viewform?c=0&w=1&usp=send_form)

- [Pony LLDB Cheatsheet](http://www.ponylang.org/reference/pony-lldb-cheatsheet/)

Ever wondered, how do I debug my Pony program? Well, things just got a little easier with the Pony LLDB Cheatsheet. We're hoping its a good way to get folks started with LLDB and Pony.

- [Initial Pony Support In Rouge](https://github.com/jneen/rouge/pull/651) 

PR opened to add Pony syntax highlighting to Rouge, a pure Ruby syntax highlighter akin to Python's Pygments.

- [Reference Capabiltiies - A Tutorial](http://www.ponylang.org/learn/#reference-capabilities)

Was recently added to the Ponylang website to help folks with learning reference capabilities. They are the biggest stumbling block for folks so we wanted to add a section to encourage folks and assist their learning:

- Standard Library documentation temporarily relocated

Ponylang.org was moved from being hosted on GitHub pages to being on Netlify: HTTPS access is now available. Unfortunately, as part of the move, we broke hosting of the standard library documentation. Previously it was at http://ponylang.org/ponyc/. Once we sort out the DNS, it will be at http://stdlib.ponylang.org but until the DNS is sorted, [http://stdlib.netlify.com](http://stdlib.netlify.com) will work.

## RFCs

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
