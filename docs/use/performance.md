# Performance

We advertise Pony as a high-performance language. And Pony can definitely be fast. We have personal experience with making Pony applications fast. We also have experience with people writing Pony code that is rather slow.

Writing fast code isn't easy. Some languages make it easier than others. Some languages make it harder than others. But, you can write slow code in any language. Trust us, we know. We've done it. All this it to let you know, you can write very fast code with Pony, but it will require some effort. There is no language that you can use that will make your code fast without effort.

We've collected together some resources to help you write fast Pony code. In addition to these resources, we have a [performance help stream](https://ponylang.zulipchat.com/#narrow/stream/190362-performance-help) on Zulip. If you have questions about performance, drop by and ping us.

## Microbenchmarking

The Pony standard library contains a microbenchmarking package called `pony_bench`. Microbenchmarking is the process of measuring the performance of small pieces of code. It's a useful tool for understanding the performance characteristics of small sections code.

It won't help you make your entire application fast, but it can help you make small sections of your code fast. We recommend only spending time using Pony Bench on code that will be used in a "hot path". That is, code that will executed many times. And by "many times", we mean "millions" or "billions".

- [Pony Bench](https://stdlib.ponylang.io/pony_bench--index/)

## Performance Cheat Sheet

We've collected together a ton of information about making Pony programs fast.
It covers a ton of topics. Some are related to how to design programs for speed. Some are related to how to maximize the performance of code you write. Some are related to optimizing the environment your Pony program runs in.

- [Pony Performance Cheat Sheet](performance/pony-performance-cheat-sheet.md)

## Performance Testing

Performance testing is very hard to get right. Most people do it poorly. That's just a fact. The environment you use to test is very important, we suggest you take a look at the documentation we've put together for [testing Pony runtime changes](/contribute/developer-resources/performance-testing-setup.md). It might give you some inspiration for doing better testing of your own programs.
