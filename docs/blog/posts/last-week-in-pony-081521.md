---
draft: false
authors:
  - theobutler
description: "There's a new public calendar for the Pony Virtual Users' Group meetings, and a new one is scheduled for Wednesday, August 25th at 15:00 US Eastern. A gist has been created that shows how to integrate VSCode and lldb for UI-based debugging of Pony code. A Pony project indexing site, ponyhub.org, has been updated to version 0.4.0."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - August 15, 2021"
date: 2021-08-15T19:06:02-04:00
---

There's a new public calendar for the Pony Virtual Users' Group meetings, and a new one is scheduled for Wednesday, August 25th at 15:00 US Eastern. A gist has been created that shows how to integrate VSCode and lldb for UI-based debugging of Pony code. A Pony project indexing site, ponyhub.org, has been updated to version 0.4.0.

<!-- more -->

## Items of note

- There's a new public calendar for the Pony Virtual Users' Group meetings.
You can subscribe via the iCal link at [https://calendar.google.com/calendar/iCal/042ceam97bfg4eseqt3sagq1rk%40group.calendar.google.com/public/basic.ics](https://calendar.google.com/calendar/iCal/042ceam97bfg4eseqt3sagq1rk%40group.calendar.google.com/public/basic.ics)

- A [gist](https://gist.github.com/tednaleid/47dcce6e1bc178b63180953cd654651c) has been created that shows how to integrate VSCode and `lldb` for UI-based debugging of Pony code, including:
  - breakpoints in the UI (including conditional ones)
  - watch statements
  - variable inspection with pretty printed Strings and Arrays (rather than just pointers)
  - `lldb` REPL/console
  - a debug target that pre-compiles a `ponyc --debug` before launching
![end result](https://gist.githubusercontent.com/tednaleid/47dcce6e1bc178b63180953cd654651c/raw/0e595669920e1bc75da850d14010c6002b6d4091/2_end_result.gif)

- Indexing site [https://ponyhub.org](https://ponyhub.org) was updated to version 0.4.0 on 2021-08-10. PonyHub indexes GitHub repositories that are marked with `ponylang` or `pony-language` tags as well as manually entered projects. The requirement is a `corral.json` in the top-level location. Indexes are backed by ElasticSearch. Written in Java (grrr!), suggestions, bug reports and other feedback is most welcome. [Source code](https://github.com/niclash/pony-hub).

---

Upcoming Pony Virtual Users' Group meeting...

On Wednesday August 25th at 15:00 US Eastern, Sean T. Allen will be "presenting" at the Pony VUG. You can join us on Zoom to [attend](https://us02web.zoom.us/j/86884459760?pwd=M2Zud2pVZFZwZVlEdnVYZW5jcEduZz09).

Sean will be walking through the [GitHub REST API](https://github.com/ponylang/github_rest_api/tree/initial) that is currently in progress. The walk through is less to discuss the API and more to spark conversations about Pony. Feel free to review the code before the meeting and come with questions like:

- Why did you decide to do X instead of Y?
- How does Z work?
- What's going on here?

Additionally, Sean will be demonstrating the new `flatten_next` functionality that was added the `Promise` in the standard library with the [0.43.1 Pony release](https://github.com/ponylang/ponyc/releases/tag/0.43.1). `flatten_next` was directly inspired by work he was doing on the GitHub REST API.

The GitHub repository is [ponylang/github_rest_api](https://github.com/ponylang/github_rest_api). Work is currently being done on the `initial` branch.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
