---
draft: false
authors:
  - seantallen
description: "Let's talk about debugging."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony June 11, 2023"
date: 2023-06-11T07:00:06-04:00
---

There is an excellent Zulip thread that was opened this week by Victor Morrow that is a wonderful jumping off point to talk some about debugging and common debugging mistakes. Plus, a bit of synchronicity between part of an Office Hours conversation and a blog post that Adrian came across the next day.

<!-- more -->

## Items of Note

### An Interesting Zulip Thread

Victor Morrow opened an interesting thread in [beginner help stream](https://ponylang.zulipchat.com/#narrow/stream/189985-beginner-help) of the [Pony Zulip](https://ponylang.zulipchat.com/) this week.

["Stop Garbage collection when waiting for ffi callback"](https://ponylang.zulipchat.com/#narrow/stream/189985-beginner-help/topic/Stop.20Garbage.20collection.20when.20waiting.20for.20ffi.20callback) is interesting for a couple reasons I want to highlight.

The first part of the thread is an excellent example of "What you think is going wrong might not be going wrong". Victor came in making an assumption about what his bug was based on a correlation he was seeing. Folks in the stream answered his question directly about how to do X. In particular, keep Pony objects that are being used in C code via FFI from being garbage collected. It's valuable information and will serve Victor well in his project. However, that wasn't the problem.

An important question to ask yourself when debugging a problem is "am I sure the bug is X"? It's important to remember a couple of key points.

- Things that are correlated to a crash are often not the cause of the crash
- If you "fix" an issue but you don't understand how it fixed the issue, you might not have fixed it, you just worked around it and the "underlying cause" is still there.

As the stream progresses, Victor has tried the fixes to what he thought the problem was but still gets a runtime crash. His belief at that time is that his callback that C code is executing is "going away" as it worked at point X but not point Y. However, Victor has no proof that his callback is going away.

Adrian and I convince Victor that he needs to use [`GDB`](https://en.wikipedia.org/wiki/GNU_Debugger) or [`LLDB`](https://lldb.llvm.org/) to get more information. Victor has never used a command line debugger before and is filled with trepidation about doing it. However, he returns not long later with information that he got starting from zero with debugger knowledge that shows that his crash was not happening where he thought it was and that in fact, he original suppositions appear to be based on correlation and not causation.

The problem hasn't been resolved at this time, but it looks like the problem is a "fundamental design issue" where threads that haven't been registered with the Pony runtime are trying to call Pony runtime code that requires a "Pony context". Only threads that have been registered with the runtime will have a "Pony content" and calling any code that requires a context and doesn't have one will result in a segfault.

I think this thread is an incredible learning resource; not just for Victor but others who read as well.

Remember, when asking for help, don't ask how to fix the problem you think you have. Tell what you did, what you are experiencing and let folks help you figure out what is wrong.

The "O, X must be my problem" is the biggest source of problems people have in getting help in general. There's a ton of "how to ask questions on the Internet" posts that cover this exact point.

The best part is- even the most experienced people fall into the assumptions and correlations trap.

And also remember, even if you've never used a step-wise debugger, they are incredibly useful for some problems and easy to get started with. Something as simple as a backtrace for crash yields and incredibly amount of useful information and you can learn how to get one in a very short period of time.

### Pony is mentioned in a blog post

Adrian Boyko noted on Zulip that Pony was mentioned in a blog post called ["10 Lesser-Known Programming Languages Worth Exploring"](https://levelup.gitconnected.com/10-lesser-known-programming-languages-worth-exploring-fb2ef988e0d5).

Pony was listed as position 1, followed by Nim, Julia, Elixir, Rust, Haxe, Agda, Idris, Gosu, and Kotlin.

My take, if you are a Pony person and you were going to learn one of those, do Idris. Why? Because I love dependent typing and the creator of Idris is an awesome fellow.

### Pony Development Sync

[Audio](https://sync-recordings.ponylang.io/r/2023_06_06.m4a) from the June 6th, 2023 sync is available.

There was no agenda for this week's meeting. We devoted the entire meeting to discussing how to integrate [mutation testing](https://en.wikipedia.org/wiki/Mutation_testing) "into the Pony compiler". Note this was for mutation testing that can be used by end users on their Pony code, not mutation testing *of* the Pony compiler.

During the call, a couple links were shared, those were:

- [Mull it over: mutation testing based on LLVM](https://arxiv.org/abs/1908.01540)
- [Pitest mutators](https://pitest.org/quickstart/mutators/)

### Office Hours

We have an open Zoom meeting every Friday for the community to get together and well, do whatever they want. In theory, Sean T. Allen "owns" the meeting and will often set an agenda. Anyone is welcome to show up and participate. Got a Pony related problem you need help solving and prefer to do it synchronously? Give Office Hours a try.

Office Hours attendees this week were Sean T. Allen, Adrian Boyko, Jason Carr, Red Davies, and Dipin Hora.

As is usual with Office Hours, conversation ranged all over; often touching on non-programming and non-Pony topics. On the Pony front, Adrian asked Sean about code that involves 2 actors that need to communicate with one another and where synchronous interaction would be better.

Sean noted that given Pony's model, if 2 actors communicate a lot and need to do it in a synchronous fashion then they should a single actor. Sean further stated that he thinks that "async/await" is a broken paradigm and Sean and Adrian started trading example of problems with the "async/await" approach and various foot guns with.

Sean stated that "if you want async/await" then what you really want is "a different concurrency model than what your language provides". As an example, Sean noted that [actor model](https://en.wikipedia.org/wiki/Actor_model) languages like Pony conflate ownership of regions of memory with the execution of code over that memory. A simple definition of an actor is a thing with a queue of messages for actions to take and a collection of memory that can only be "accessed" by sending the actor messages. Two concepts have been conflated here. There's nothing wrong with that conflation, it makes a lot of things easy, but it also causes some issues.

Going back to Adrian's example, actor's are a unit of concurrency. If you have 2 actors that should be communicating in a synchronous fashion and you make them one, you lose the ability for other actors that that only need some of the functionality to communicate with "the different parts" independently.

By moving memory that is often accessed together, but not always into the same actor, we've lost a level of concurrency granularity. We've lost it because of the previously mentioned conflating.

The [Verona project](https://github.com/microsoft/verona) from Azure Research is very similar to Pony in a lot of ways. Many of the people who have worked on Verona have also worked on Pony. Sylvan Clebsch started Pony and Verona started from a conversation about "how would you write a database in Pony" between Sylvan and Matt Parkinson. There's a ton of overlap, but the concurrency models are quite different. They are different because Verona does not conflate ownership of a region of memory with concurrency. Verona allows for multiple regions of memory to be obtained by a given chunk of code that can then access both regions concurrently.

Verona allows for solving Adrian's problem without giving up concurrency because it has a different concurrency model. Sean gave all this as an example of "if you want async/await" then what you really want is "a different concurrency model than what your language provides".

Both Dipin and Red brought up Erlang's [selective receive](https://blog.ndpar.com/2010/11/10/erlang-selective-receive/) and how it can be used to solve the problem. Issues with selective receive were also raised.

Conversation then moved on to what "macros" would look like in Pony with Sean asking Red to give examples of the code he would like to write and the resulting code. Red is planning on doing that and coming back to a future Office Hours with examples.

Conversation ranged over the differences between "macros" in "loosely typed" languages like "scheme" and [Dylan](https://en.wikipedia.org/wiki/Dylan_(programming_language)) and more "hard typed" ones like [Haskell](https://www.haskell.org/) and Pony. [Template Haskell](https://wiki.haskell.org/Template_Haskell) came up as part of the conversation.

[Idris](https://www.idris-lang.org/) came up from that conversation when Red asked if it was compiled to Haskell and Sean and Jason discussed how it wasn't anymore and now compiles to [Chicken Scheme](https://www.call-cc.org/).

Sean has a personal relationship with the creator of Idris, Edwin Brady, and explained why Edwin decided to compile to Scheme instead of something like LLVM despite Sean and Sylvan trying on more than one occasion to convince Edwin it was a good idea.

That lead the conversation to its end point... Red stated he wanted to learn the LLVM API and thought he should create a little programming language to play around with it. Sean asked Red if he had ever created a programming language. A quick "no" later and Sean was presenting an idea...

Rather than shave a ton of yaks of learning how to do lexing and parsing and all the rest that is involved with creating even a simple programming language, if you goal is to learn the LLVM API, do something simpler. Create a C or C++ program that will use the LLVM API to create LLVM IR that can then be linked using LLVM tools that when run will "do something simple" like "print something to the console". This way, the approach is focused on what Red wants to learn "the LLVM API" and not everything else that comes with creating a programming language.

If you'd be interested in attending an Office Hours in the future, you should join some time, there's a [calendar you can subscribe to](https://calendar.google.com/calendar/ical/4465e68ae24131ae00461a40893f2637a2c9ac510e311a44ff78680e2f183ce3%40group.calendar.google.com/public/basic.ics) to stay up-to-date with the schedule. We do our best to keep the calendar up-to-date.

## Community Resource Highlight

We like to take a moment in each Last Week in Pony to highlight a community resource. There are many community resources that can go unappreciated until _just the right time_ when someone hops into the Ponylang Zulip asking a question or facing a problem we have all had at one time or another. Well here in Last Week in Pony, we make it **just the right time** to highlight one of our excellent community resources.

This week's community resource highlight was inspired by the "Stop Garbage collection when waiting for ffi callback" Zulip thread. The ["Exiting User?"](https://www.ponylang.io/reference/) section of the Pony website has a number of resources aimed at user's of Pony looking to get more advanced than what they've learned from the [Pony Tutorial](https://tutorial.ponylang.io/).

The [debugging section](https://www.ponylang.io/reference/#debugging) contains 3 helpful entries including a ["Pony LLDB Cheat Sheet"](https://www.ponylang.io/reference/pony-lldb-cheatsheet/). The cheat sheet includes a few LLDB basics plus some Pony specific information.

If you are using Pony's C-FFI functionality, you are going to end up needing to use either GDB or LLDB. Be sure to check out the cheat sheet when you get started.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
