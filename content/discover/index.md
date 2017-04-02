+++
title = "Discover"
+++
## What is Pony?

Pony is an open-source, object-oriented, [actor-model](https://en.wikipedia.org/wiki/Actor_model), [capabilities-secure](https://en.wikipedia.org/wiki/Capability-based_security), high performance programming language. 

## What makes Pony different?

Pony is type safe
: *Really type safe*. There's a mathematical [proof](/media/papers/fast-cheap.pdf) and everything.

Pony is memory safe
: There are no dangling pointers and no buffer overruns. The language doesn't even have the concept of null!

Exception Safe
: There are no runtime exceptions. All exceptions have defined semantics, and they are *always* caught.

Data-race Free
: Pony doesn't have locks or atomic operations or anything like that. Instead, the type system ensures at compile time that your concurrent program can never have data races. So you can write highly concurrent code and never get it wrong.

Deadlock Free
: This one is easy, because Pony has no locks at all! So they definitely don't deadlock, because they don't exist!

Native Code
: Pony is a ahead-of-time (AOT) compiled language. There is no interpreter or virtual machine.

Compatible with C
: Pony programs can natively call C libraries. Our compiler is able to generate a C-header file for Pony libraries. Consequently, C/C++ programs can natively call Pony programs!

## Why Pony?

There's plenty to love about Pony, but more than anything else, what we love most is that Pony makes it easy to write fast, safe, efficient, highly concurrent programs. How? The Pony type system introduces a novel concept: "reference capabilities". [Reference capabilities](https://tutorial.ponylang.org/capabilities/reference-capabilities.html) allow you to label different bits of data based on how that data can be shared. The Pony compiler will then verify that you are in fact correctly using the data based on the labels you provide. Reference capabilities combined with Pony's actor model of concurrency are a powerful pairing. Let's dig in a take a quick look:

### Mutable state is hard

The problem with concurrency is shared mutable data. If two different threads have access to the same piece of data then they might try to update it at the same time. At best this can lead to the two threads having different versions of the data. At worst the updates can interact badly resulting in the data being overwritten with garbage. The standard way to avoid these problems is to use locks to prevent data updates from happening at the same time. This causes big performance hits and is very difficult to get right, so it causes lots of bugs.

### Immutable data can be safely shared

Any data that is immutable (i.e. it cannot be changed) is safe to use concurrently. Since it is immutable it is never updated and it's the updates that cause concurrency problems.

### Isolated data is safe

If a block of data has only one reference to it then we call it _isolated_. Since there is only one reference to it, isolated data cannot be _shared_ by multiple threads, so there are no concurrency problems. Isolated data can be passed between multiple threads. As long as only one of them has a reference to it at a time then the data is still safe from concurrency problems.

### Every actor is single threaded

The code within a single actor is never run concurrently. This means that, within a single actor, data updates cannot cause problems. It's only when we want to share data between actors that we have problems.

### Reference capabilities enforce safe data handling

By sharing only immutable data and exchanging only isolated data we can have safe concurrent programs without locks. The problem is that it's very difficult to do that correctly. If you accidentally hang on to a reference to some isolated data you've handed over or change something you've shared as immutable then everything goes wrong. What you need is for the compiler to force you to live up to your promises. Pony reference capabilities allow the compiler to do just that.

That's pretty damn cool and a hell of a reason to give Pony a try.

## Why not Pony?

There are many valid reasons to not use Pony. Amongst these are:

- Lack of API stability
- Lack of high quality 3rd party libraries
- Limited native tooling

### API stability

Pony is pre-1.0. We regularly have releases that involve breaking changes. This lack of stability is plenty of reasons for many projects to avoid using Pony. 

### Batteries required

If you project is going to succeed or fail based on the size of community around the tools you are using, Pony is not a good choice for you. While its possible to write stable, high-performance applications using Pony, you will have to do a decent amount of work. The pool of open source, ready to use Pony libraries is very small. If it's not in the standard library than odds are you are going to have to add it yourself, either by writing it from scratch in Pony or by wrapping an existing C library using Pony's excellent [C-FFI](https://tutorial.ponylang.org/c-ffi/) functionality.

### Tooling

There's a wide swath of tooling that some people have come to expect that isn't currently available for Pony. We don't have an IDE. You can use standard debuggers like gdb or lldb but the experience still has some rough edges. If you are comfortable working with a basic text editor and using lldb, vtune and other tools, you'll probably be ok. Just don't expect a full, robust ecosystem. We aren't there yet.

### Conclusion

If your project isn't going to get a great deal of benefit from any of Pony's strengths, then you shouldn't use Pony. If you are writing a single threaded application without any overriding performance concerns, and you need access to a large community and wealth of libraries then you're much better of selecting another language. However, we hope that you see enough potential in Pony to start playing around with it even if it isn't right for your current project. 
