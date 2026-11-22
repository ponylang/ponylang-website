---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - November 22, 2026"
date: 2026-11-22T07:00:00-04:00
---

Would you look at that? I made it through a whole week without doing a Pony release. Huzzah?!? I mean, it is nice for y'all to have a breather right? Let's say yes and [clap your hands](https://www.youtube.com/watch?v=9Ra0DsbiNs0) and stomp your feet to the beat. Still, even though there was no release this past week, there is still some big damn stuff coming down the pike.

<!-- more -->

## What's Cooking

So let's talk about what I've been up to. And what is coming "soon". Lots is coming "in a slightly longer term" and I want to focus on the "soon". "For reasons", I've been working on getting it so the Pony runtime can garbage collect during behaviors. The current version I have, works and on a performance benchmark is only 0.4% slower. The agent says it isn't right for me to call that noise. I am still calling it "noise like". Currently, I am at the point of reviewing what the agent came up with from my initial specification and the goal of "now make it as fast as possible".

It is possible there's extra work that isn't needed going on. It's possible that the change resulted for the benchmark in a slightly different code layout that is just a little different with the CPU caches on our Pony performance testing machine. Almost anything is possible right now, because I got a small way into reviewing and found something I wanted broken out into its own change and that is as far as I've gotten. Hopefully, this holds up to scrutiny and I land it soon. For folks who are interested, I suspect that the most likely reason for that 0.4% is that the compiler is putting "can I gc" checks in at a number of places where it is "just extra work". For example if we are running 100 small behaviors in a row for an actor and each doesn't need any gc to occur but we have a possible gc checkpoint added inside the behavior in addition to the check after each behavior, then we have doubled the "check to see if we should gc" work. Smarter compiler analysis could make it so we don't put the extra gc check in for behaviors where it "just isn't going to help". We are not doing that analysis at the moment. Anyway... that's where "intrabehavioral garbage collection" is at currently.

The other big thing I have been working on is adding [mutation testing](https://en.wikipedia.org/wiki/Mutation_testing) directly into the compiler. Here's roughly the idea: the biggest quality of tests boost I got so far when using agents was to tell them that they have to intentionally break every test they write and verify it actually breaks. I was kind of shocked by how many vacuous tests that caught. Mutation testing is kind of like that on steroids.

At the moment, a working implementation of mutation testing is on main and going out in nightlies. It ships with a mutate runner program called `pony-mutate` that actually runs your test program with different mutations on and collates the results. I am still working on the usage ergonomics and am currently working through the most difficult "UI" aspect of mutation testing: equivalence.

Let's say you have an expression `x > y`. One mutation we would apply to that is `x != y`. It is possible in your program that `x` will never be equal to `y` so that mutation won't have any observable impact on your tests. That is "bad". It's bad because mutation testing fails its suite if any mutant survives, aka doesn't cause a test to fail. But, some mutants will always be equivalent for a given bit of code and there needs to be a way to filter out the noise of "equivalent mutations". That "filtering out the noise" is what I am currently working on. The mutation testing is usable now and there are some rather ham-fisted mechanisms in place to deal with equivalent mutations. What I'm currently up to is trying to give some fine-grained controls in addition to ham-fisted ones.

## Items of Note

### x86 macOS Support

Our x86 macOS support has gotten a bit tenuous. We use Homebrew as part of the setup process for test, build, and release environments. When you try to update Homebrew on x86 macOS now, it fails. We are still able to take Homebrew that is installed on the old GitHub runners and use it — for now at least. We continue to stick to our plan to drop support when GitHub drops x86 macOS runners. That is currently scheduled for August of 2027. However, the recent Homebrew update erroring out gives me pause. We shall see if it is actually tenable to keep the x86 macOS support up all the way through August of 2027 or if something will force our hand into dropping support earlier.

### ponylang/llm-skills Updated

[ponylang/llm-skills](https://github.com/ponylang/llm-skills) have been updated. If you are using our llm-skills, you should update.

## Releases

- [ponylang/ponyup 0.16.4](https://github.com/ponylang/ponyup/releases/tag/0.16.4)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang-website/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
