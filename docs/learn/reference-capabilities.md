# Reference Capabilities

If you are like most people learning Pony, your biggest stumbling block is going to be [reference capabilities](https://tutorial.ponylang.io/capabilities/reference-capabilities.html). Reference capabilities look like a very foreign concept to most folks. This isn't surprising as they are one of the ideas that make Pony unique. Lots of folks get frustrated while learning reference capabilities and end up thinking that Pony has "too much type system" or is "too hard". While we don't agree with such assessments, we will agree that they can be quite hard for some folks to get a handle on.

## What are reference capabilities

Reference capabilities allow you the programmer to use the Pony type system to guarantee that you are safely handling data in your application. If you try to do something unsafe, your program won't compile.

## What background do I need?

We've noticed that folks who have the easiest time with reference capabilities tend to have a couple things in common:

- Familiarity with at least one strongly-typed language
- Experience working in a highly concurrent, non-actor based language

If you are coming from a dynamically typed background then reference capabilities are probably going to be doubly hard for you. Why? Well, you are going to be learning to navigate general type errors in general and then, you'll have the added overhead of reference capabilities related type errors. It's quite possible to get over the hump but just be aware you are in for a bit more work. More important than your type system background is your "concurrency background".

While reference capabilities might seem exotic, they aren't really. They codify in the type system safe data handling practices that many programmers have learned over the course of time. If you have previously worked in a highly-concurrent, thread-based programming language like Java or C++ then there's a chance that you have a leg up on learning reference capabilities.

We're not going to pretend that all programmers know how to safely handle data when using threads. If they did, we wouldn't need Pony. The sad fact is, handling data correctly when you have many threads is hard. Even the most experienced programmer makes mistakes and they are really hard to go back and find. That said, if you are at least used to thinking about how different threads interact with data in your program, you have a leg up. Reference capabilities are all about describing for the compiler how data should be handled.

So, if you are coming from a single-threaded language like Ruby or Python, odds are, you haven't thought a lot about many threads safely accessing your variables. That's ok, it just means you are going to have more work to do on understanding the concepts that the various reference capabilities represent.
If you get hung up on something, don't worry. [We're here to help](getting-help.md).

## Reference capabilities resources

!!! note "A note about code samples"

    All recommended resources are incredibly helpful but represent Pony at a given point in time. While the core concepts will remain static, it's possible that individual code examples will no longer compile with the latest versions of Pony. Pony is pre-1.0 and breaking changes are still quite common. If you run into code that doesn't work, reach out and [get help](getting-help.md).

There are 4 primary resources that we currently recommend for understanding reference capabilities:

- [Safely Sharing Data: Reference Capabilities in Pony][SAFELY-SHARING-DATA]
- [Reference Capabilities, Consume and Recover in Pony][CONSUME-RECOVER]
- [Pony VUG #1: Sylvan Clebsch - Writing Generic Code][VUG1]
- [Bang, Hat and Arrow in Pony][BANG-HAT-ARROW]

We suggest you start with John Mumm's excellent overview "[Safely Sharing Data: Reference Capabilities in Pony][SAFELY-SHARING-DATA]" and Chris Double's "[Reference Capabilities, Consume and Recover in Pony][CONSUME-RECOVER]". They are both good general overviews of reference capabilities and why they exist. From there, continue on and watch Sylvan's Pony Virtual Users' Group presentation on "[Writing Generic Code][VUG1]". A lot of what you see and watch in that video is going to go over your head. Don't worry, that happens to everyone. We suggest that you pair it with "[Bang, Hat and Arrow in Pony][BANG-HAT-ARROW]". It's an excellent write-up of the concepts introduced in the video. If you are looking for a slightly more academic take, [Adrian Colyer](https://twitter.com/adriancolyer) did an excellent write up of [Deny Capabilities for Safe, Fast Actors](https://web.archive.org/web/20241207181100/https://blog.acolyer.org/2016/02/17/deny-capabilities/). It's an overview of Pony's reference capabilities.

Generics and references capabilities are the hardest things to get a handle on while learning Pony so don't get frustrated. It's not just you. We all go through this. During the video, you'll hear one of our core team members, Sean T. Allen, commenting at numerous points that he was sort of following everything but not all of it. Sean now has a strong grasp on all the concepts. It takes time.

Our recommendation is to [watch the video][VUG1], read "[Bang, Hat and Arrow in Pony][BANG-HAT-ARROW]" and then try writing code that uses generic classes like collections. Once you have a handle on using generic classes, move on to trying to write your own generic classes. All the while, repeatedly return to watching the video and reading the accompanying blog post.

Don't worry. You will get it. And remember, the [helpful Pony community](/learn/getting-help.md) is waiting to assist.

[SAFELY-SHARING-DATA]: http://jtfmumm.com/blog/2016/03/06/safely-sharing-data-pony-reference-capabilities/
[VUG1]: https://vimeo.com/163871856
[BANG-HAT-ARROW]: https://bluishcoder.co.nz/2016/05/04/bang-hat-and-arrow-in-pony.html
[CONSUME-RECOVER]: https://bluishcoder.co.nz/2017/07/31/reference_capabilities_consume_recover_in_pony.html
