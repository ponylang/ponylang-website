---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - September 27, 2026"
date: 2026-09-27T07:00:00-04:00
---

Here's how it was: this past week was another week of "Sean breaks lots of stuff", but hey at least I'm breaking it in service of a drive towards Pony 1.0. My favorite change from this week though is getting the MacOS and Linux Pony targets using LLVM bitcode to compile and link. It opens up a bunch more optimizations and is a real "look ma! even faster!" moment. Which is really good. Now take this down, it's a real [money shot](https://www.youtube.com/watch?v=g9awHEExN7A).

<!-- more -->

## The Release That Wasn't (Yet)

I had a whole thing written up about releasing Pony 0.73.0 and some of the changes in it. But, Pony 0.73.0 didn't release this past week. One of the changes that went in this week has been causing issues with MacOS x86 builds. It's a small issue, but until it is resolved, any release I do would fail when trying to create the Intel MacOS build.

I've spent several days trying to fix it but without easy access to a development environment for it, it's been a pain. Enough of a pain that I briefly considered dropping support for the now "mostly abandoned by Apple" platform. But it isn't enough of a pain that I've done it yet.

So anyway, there's a Pony 0.73.0 release that is probably coming "very soon", perhaps even later today. In the meantime, what happened this week?

I fixed a number of bugs. Good bugs. Tasty bugs. But you can read the changelog to see those. So let's highlight what should really be highlighted.

I have a PR open to update our version of LLVM and in the process, fix linking on the latest version of MacOS. And can I just say, "wtf Apple, why are you making my life difficult this week?" Right right...

I've also done a number of improvements and additions to PonyCheck, our property-based testing framework. While working the last of those improvements, it became clear that a larger change was needed. So I'm in the process of integrating property-based testing directly into PonyTest instead of having it as an additional package. This will bring a number of API improvements with it and eliminate some footguns with the API, but will also mean everyone needs to redo their tests. Sorry, but, hey, we aren't 1.0 and I'm more interested in "get it right" than "preserve the tiny amount of Pony code out there".

And... DTrace and SystemTap support has been removed from the Pony runtime. I wanted to make using bitcode and the optimization improvements it can bring the default everywhere possible. However, all those places are a superset of the places where DTrace and SystemTap were supported and... DTrace and SystemTap do not work with bitcode so, I decided to kill the support for them. I'm starting to look at what I could do for built-in observability for the runtime and Pony programs that would be supported on all platforms. I have some vague ideas and hope that it would be able to be turned on and off at runtime rather than having to be compiled in. But, I'm straying from talking about the release. Let's get back to that.

As I noted in the intro, this past week I added LLVM bitcode-driven performance improvements for MacOS and Linux installations. The optimizations were particularly impressive with what they did to message passing which is a big deal for Pony — so... fuck yeah?!? Yeah. Fuck Yeah! That isn't even the only performance improvement I got in, but you'll need to read the changelog to get the rest of them.

## Items of Note

### Shared Docker SSL Builder Images

Now that [ponylang/ssl](https://github.com/ponylang/ssl) has been incorporated into the standard library, we're dropping support for most of the shared-docker SSL builder images. At the end of September, only the LibreSSL 4.2.1 builder will remain — the OpenSSL builders and the legacy x86-only builders are going away. If you're using one of the other SSL builder images, switch to LibreSSL 4.2.1. Community members who need the other images are welcome to fork and maintain them.

### Schedule

I won't be at Office Hours on the 28th. I'm traveling for work. And because of said work travel, there is no development sync on the 30th. I'll be around at Bug Bash Europe and Goto in Copenhagen. If you are there, come looking for me. You might find me on the floor, on the stage at Bug Bash, or you can always ask at the Antithesis booth.

### Office Hours

September 21, 2026

Office Hours was just Red and me. We started off with Red mentioning he had been playing around with [Jev](https://typesafe.ai/blog/introducing-system-one-models-and-jev). We discussed what he was using it for. I'm very interested to see how people who weren't deploying classifiers previously are thinking about using Jev. Those conversations are giving me lots of good ideas.

Over the course of the time we were talking, Red and I repeatedly came back to discussing the changes in [PR #6109](https://github.com/ponylang/ponyc/pull/6109). There's a lot going on with it and we went over the ramifications quite a bit.

Then we discussed all the ways that I am planning on "breaking everything" over the next few weeks when I deprecate [corral](https://github.com/ponylang/corral) and completely redo package handling and dependency management for Pony.

There was plenty of other stuff we discussed as well, but you didn't bother to show up and I'm not a stenographer, you are getting what you get and I am done giving it for now.

Perhaps I'll see you at an Office Hours in the future (but not next week!).

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang-website/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
