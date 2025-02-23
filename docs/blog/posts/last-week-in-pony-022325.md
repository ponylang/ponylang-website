---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - February 23, 2025"
date: 2025-02-23T07:00:06-04:00
---

Time to update your Pony installation. This weekend's release has a couple of very important fixes. We recommend updating as soon as possible.

<!-- more -->

## Items of Note

### Ponyc 0.58.11 Released

Hey! Saturday [ponyc 0.58.11](https://github.com/ponylang/ponyc/releases/tag/0.58.11) was released. You should update now.

There was a use-after-free that was unlikely to be triggered but after 3 years of being possible was finally triggered by Red earlier in the week and then Dipin figured out the race condition in the code that I wrote that was supposed to be "race condition free". Right there, that is why Pony is awesome. No nasty data races. Ah well, I love my Pony, I love C. What ya gonna do?

Hopefully, you are going to update, because a memory leak that was introduced in November was also fixed.

Those two right there should be enough to get you to upgrade. If not, hey, then surely the runtime stats and runtime info fixes will get you in the door.

And while you are updating, we suggest you sing [this little ditty](https://www.youtube.com/watch?v=KiWzCU3AzQI) to Pony.

### Pony Development Sync

The recording from this week's Development Sync is now [available on Vimeo](https://vimeo.com/1058598180).

### Office Hours

Monday was a holiday in the US and Canada. We had a lighter Office Hours contingent. Just Adrian, Red, and myself. There was some conversation about things. Mostly Pony related. It was good. Come join us.

## Releases

- [ponylang/ponyc 0.58.11](https://github.com/ponylang/ponyc/releases/tag/0.58.11)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
