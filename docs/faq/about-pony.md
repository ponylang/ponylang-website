# About Pony {:id="about-pony"}

## How'd Pony come to be? {:id="early-history"}

Check out ["An Early History of Pony"](/blog/posts/early-history-of-pony.md).

## Why's it called "Pony"? {:id="why-the-name-pony"}

Interesting question. We hear that a lot. If you read enough of ["An Early History of Pony"](/blog/posts/early-history-of-pony.md), you'll get your answer.

## What makes Pony different? {:id="how-is-pony-different"}

See ["What makes Pony different"](/discover/what-makes-pony-different.md).

## Why would I use Pony instead of language X? {:id="why-pony-instead-of-x"}

That's a hard question to answer. Language X is probably very compelling for some problems. It's probably less compelling for others. Such is computers. In the end, the best we can do is tell you what Pony is good at and you can make the decision for yourself. To learn more about Pony, we suggest checking out the ["Why Pony"](/discover/why-pony.md) section of the website. Hopefully, it answers your question.

## Where can I find the Pony roadmap? {:id="roadmap"}

There is no official roadmap. Pony is a volunteer driven project. Unlike many programming languages, we don't have corporate backing. Our users add features and fix issues based on their needs. Pony users solve the problems that matter to them, and we all benefit.

Many of us who are regular contributors share some general goals as we move towards an official 1.0 release. We are working towards making Pony a stable, rock-solid platform for writing high-performance, concurrent applications.

We invite you to join our small but growing community and help push Pony forward. We're still at an early stage, and new community members can have a huge influence on the language. Join us!

## Does Pony really prevent data races? {:id="data-race"}

So, this question usually comes in many different forms. And the question usually arises from a misunderstanding of the difference between a "data race" and a "race condition".

Pony prevents data races. It can't stop you from writing race conditions into your program.

To learn more about the differences between race conditions and data races, check out ["Race Condition vs. Data Race"](https://blog.regehr.org/archives/490) by John Regehr.

## Are there any examples of something complex built in Pony? {:id="real-world-pony-codebases"}

Yes! Here's a few projects we regularly point people towards:

- [Jylis](https://github.com/jemc/jylis) - A distributed in-memory database for Conflict-free Replicated Data Types
- [Novitiate](https://github.com/jtfmumm/novitiate) - A procedurally generated RPG inspired by Rogue and written in Pony.
- [Wallaroo](https://github.com/seantallen/wallaroo) - Distributed Stream Processor written in Pony

Note, we can't promise that any of the projects have been updated recently or that they compile with the most recent versions of the Pony compiler.

## Does Pony have a formatter? {:id="code-formatter"}

At this time, no. There is no formatter for Pony code. The lack of a formatter doesn't indicate that the Pony core team is opposed to code formatters. There is strong interest in having a code formatter for Pony.

An easy to maintain code formatter would share parsing code with the compiler. At this time, sharing said code is difficult. We are working towards making maintaining a code formatter and other parsing related tooling easier. We plan to introduce a code formatter in the future.
