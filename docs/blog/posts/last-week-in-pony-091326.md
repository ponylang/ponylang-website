---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - September 13, 2026"
date: 2026-09-13T07:00:00-04:00
---

It's been a crazy week with lots of breaking changes. I promised lots of breaking changes in the last "Last Week in Pony" and I delivered. Two ponyc releases each with its own set of changes and a slew of ponylang org library releases to go along with them. With a week like that, there's clearly only one song that could serve as this week's theme song... [bring on the dickies](https://www.youtube.com/watch?v=flMS2gHFOH0)!

<!-- more -->

## Lori Graduates

It started years ago while I was visiting Sylvan at Microsoft Research UK in Cambridge. It was part seeing a friend and part that friend doing a stealth recruiting effort.

Sylvan and I had been discussing the problems that we had at Wallaroo with the Pony standard library's TCP classes. Our answer at Wallaroo was to write our own. It certainly worked but it sucked to have to redo all the logic of TCP networking so that we could add behaviors to handle Wallaroo specific things.

The problem was that the standard library classes used [the notifier pattern](https://patterns.ponylang.io/code-sharing/notifier.html?h=noti) which meant we couldn't add new behaviors to the actors. Our only option was to rewrite.

While I was in Sylvan's office I had the idea for "turning the problem inside out". Within a couple months I had mocked up the idea and started lori as an initial project. But I didn't do much with it because I had plenty of other things to do.

Less than a year ago, after puttering with lori for years, I transferred from my personal GitHub organization to the Ponylang one. And then I started building on it and pushing it and improving it and this week, it finally achieved its goal and graduated to the standard library. The old notifier based `net` classes are no more. There's only the more flexible and powerful lori [embed and delegate](https://patterns.ponylang.io/code-sharing/embed-and-delegate) style plus a notifier pattern style in `net/notifier` for those occasions when you just need something [quick-n-dirty](https://www.youtube.com/watch?v=XXTzm5GtqVo). And I guess now that lori is "dead", it is time to share where the dumb-ass name came from.

When I started working on lori, I thought of it as a "Netty for Pony". So of course from that "Petty". But that was too obvious but I do have 3 favorite Pettys: Tom, Richard, and Lori. I decided Lori was the best name for a library. That "Tom" and "Richard" were "too human and ordinary sounding" and so the library was born.

I hope you enjoy the new Pony networking experience. It is a lot better for building "real-world" applications than the old one. If not... [*shrug*](https://www.youtube.com/watch?v=CGtf9QfITQw).

## Pony Releases

As I noted in the intro, there were two pony releases this week. Both with breaking changes.

The big news, I already covered. ponylang/lori is now part of the standard library so lots of breakage from that. The other big change was breaking changes that resulted from improving how PonyCheck does shrinking. Refer to the release notes for more details as there's a few other changes tucked into the two releases.

## Items of Note

### What's Coming

I noted last week a number of things [that were coming](https://www.ponylang.io/blog/2026/09/last-week-in-pony---september-6-2026/#whats-coming).

Moving lori into the standard library is done.

PonyCheck improvements are underway.

You aren't seeing any end user visible changes from the package system reworking yet, but it is coming and I'm hoping to have it done before I head off to [Bug Bash Europe](https://gotocph.com/2026/pages/bug-bash-eu) for work.

"Bring back case methods" has turned into [method overloading](https://github.com/ponylang/ponyc/discussions/6010) and I plan on doing that "soon". We'll see how the mood strikes me and exactly when it happens. But, you should expect it "soon".

So hey, expect more breaking changes soon. There's a ton to break as I march towards a version 1.0 and march I shall.

### ponylang/ssl 6.0.0

O, and I forgot, as part of that Lori graduates, `ssl/net` in [ponylang/ssl](https://github.com/ponylang/ssl) was removed. Lori now rolls SSL in directly in a way that works much better than the old net classes. If by some weird chance, you happened to be using `ssl/net` independent of the standard library's old `net`, you will be impacted by this.

### contact-red/meminfo

Red released [contact-red/meminfo](https://github.com/contact-red/meminfo) [0.0.1](https://github.com/contact-red/meminfo/releases/tag/0.0.1). It measures how much heap memory a Pony object actually occupies by poking into parts of the runtime that aren't public API. Any ponyc release can break it, or worse, break it in a way that gives you bad yet plausible data. It comes with a permanent disclaimer: _Das hafermotor ist nicht für gefingerpoken und mittengrabben_. There are property tests that should validate correctness, but if you use this, yolo. Treat it as a debugging tool.

### ponylang/llm-skills Updates

I updated [ponylang/llm-skills](https://github.com/ponylang/llm-skills) again. If you use them, grab the latest.

### Pony Development Sync

The September 9th Pony Development Sync wasn't recorded. Just me and Red talking.

### Schedule Changes

I won't be at Office Hours this week and there's no Pony Development Sync either.

## Releases

- [contact-red/equestuia 0.1.3](https://github.com/contact-red/equestuia/releases/tag/0.1.3)
- [contact-red/meminfo 0.0.1](https://github.com/contact-red/meminfo/releases/tag/0.0.1)
- [contact-red/odbc 0.2.0](https://github.com/contact-red/odbc/releases/tag/0.2.0)
- [ponylang/courier 0.9.0](https://github.com/ponylang/courier/releases/tag/0.9.0)
- [ponylang/courier 0.10.0](https://github.com/ponylang/courier/releases/tag/0.10.0)
- [ponylang/github_rest_api 0.11.0](https://github.com/ponylang/github_rest_api/releases/tag/0.11.0)
- [ponylang/github_rest_api 0.12.0](https://github.com/ponylang/github_rest_api/releases/tag/0.12.0)
- [ponylang/hobby 0.13.0](https://github.com/ponylang/hobby/releases/tag/0.13.0)
- [ponylang/hobby 0.14.0](https://github.com/ponylang/hobby/releases/tag/0.14.0)
- [ponylang/hobby 0.15.0](https://github.com/ponylang/hobby/releases/tag/0.15.0)
- [ponylang/livery 0.10.0](https://github.com/ponylang/livery/releases/tag/0.10.0)
- [ponylang/livery 0.11.0](https://github.com/ponylang/livery/releases/tag/0.11.0)
- [ponylang/lori 0.21.0](https://github.com/ponylang/lori/releases/tag/0.21.0)
- [ponylang/lori 0.22.0](https://github.com/ponylang/lori/releases/tag/0.22.0)
- [ponylang/mare 0.9.0](https://github.com/ponylang/mare/releases/tag/0.9.0)
- [ponylang/mare 0.10.0](https://github.com/ponylang/mare/releases/tag/0.10.0)
- [ponylang/multipart_mime 0.2.0](https://github.com/ponylang/multipart_mime/releases/tag/0.2.0)
- [ponylang/ponyc 0.71.0](https://github.com/ponylang/ponyc/releases/tag/0.71.0)
- [ponylang/ponyc 0.72.0](https://github.com/ponylang/ponyc/releases/tag/0.72.0)
- [ponylang/postgres 0.11.0](https://github.com/ponylang/postgres/releases/tag/0.11.0)
- [ponylang/postgres 0.12.0](https://github.com/ponylang/postgres/releases/tag/0.12.0)
- [ponylang/ssl 6.0.0](https://github.com/ponylang/ssl/releases/tag/6.0.0)
- [ponylang/stallion 0.12.0](https://github.com/ponylang/stallion/releases/tag/0.12.0)
- [ponylang/stallion 0.13.0](https://github.com/ponylang/stallion/releases/tag/0.13.0)
- [ponylang/templates 0.5.0](https://github.com/ponylang/templates/releases/tag/0.5.0)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang-website/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
