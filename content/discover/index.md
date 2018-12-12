+++
title = "Discover"
+++
## What is Pony?

Pony is an open-source, object-oriented, [actor-model](https://en.wikipedia.org/wiki/Actor_model), [capabilities-secure](https://en.wikipedia.org/wiki/Capability-based_security), high-performance programming language.

If you are looking to jump in and get started with Pony *right now*, you can try it in your browser using the [Pony Playground](http://playground.ponylang.io). Keep reading if you are interested in what makes Pony different and why you should consider using it.

If you are interested in the early history of Pony and how it came into existence, you're in luck: ["An Early History of Pony"](/blog/2017/05/an-early-history-of-pony/).

## What makes Pony different?

### Pony is type safe

*Really type safe*. There's a mathematical [proof](/media/papers/fast-cheap-with-proof.pdf) and everything.

### Pony is memory safe

There are no dangling pointers and no buffer overruns. The language doesn't even have the concept of null!

### Exception-Safe

There are no runtime exceptions. All exceptions have defined semantics, and they are *always* caught.

### Data-race Free

Pony doesn't have locks nor atomic operations or anything like that. Instead, the type system ensures at compile time that your concurrent program can never have data races. So you can write highly concurrent code and never get it wrong.

### Deadlock-Free

This one is easy because Pony has no locks at all! So they definitely don't deadlock, because they don't exist!

### Native Code

Pony is an ahead-of-time (AOT) compiled language. There is no interpreter nor virtual machine.

### Compatible with C

Pony programs can natively call C libraries. Our compiler is able to generate a C-header file for Pony libraries. Consequently, C/C++ programs can natively call Pony programs!

## Why Pony?

There's plenty to love about Pony, but more than anything else, what we love most is that Pony makes it easy to write fast, safe, efficient, highly concurrent programs. How? The Pony type system introduces a novel concept: "reference capabilities". [Reference capabilities](https://tutorial.ponylang.io/capabilities/reference-capabilities.html) allow you to label different bits of data based on how that data can be shared. The Pony compiler will then verify that you are in fact correctly using the data based on the labels you provide. Reference capabilities combined with Pony's actor model of concurrency makes for a powerful pairing. Let's dig in and take a quick look:

### Mutable state is hard

The problem with concurrency is shared mutable data. If two different threads have access to the same piece of data then they might try to update it at the same time. At best this can lead to those two threads having different versions of the data. At worst the updates can interact badly resulting in the data being overwritten with garbage. The standard way to avoid these problems is to use locks to prevent data updates from happening at the same time. This causes big performance hits and is very difficult to get right, so it causes lots of bugs.

### Immutable data can be safely shared

Any data that is immutable (i.e. it cannot be changed) is safe to use concurrently. Since it is immutable it is never updated and it's the updates that cause concurrency problems.

### Isolated data is safe

If a block of data has only one reference to it then we call it _isolated_. Since there is only one reference to it, isolated data cannot be _shared_ by multiple threads, so there are no concurrency problems. Isolated data can be passed between multiple threads. As long as only one of them has a reference to it at a time then the data is still safe from concurrency problems.

### Every actor is single threaded

The code within a single actor is never run concurrently. This means that, within a single actor, data updates cannot cause problems. It's only when we want to share data between actors that we have problems.

### Reference capabilities enforce safe data handling

By sharing only immutable data and exchanging only isolated data we can have safe concurrent programs without locks. The problem is that it's very difficult to do that correctly. If you accidentally hang on to a reference to some isolated data you've handed over or change something you've shared as immutable then everything goes wrong. What you need is for the compiler to force you to live up to your promises. Pony reference capabilities allow the compiler to do just that.

If you ask us, that's pretty damn cool and a hell of a reason to give Pony a try.

## Why not Pony?

There are many valid reasons to not use Pony. Amongst these are:

- Lack of API stability
- Lack of high-quality 3rd party libraries
- Limited native tooling

### API stability

Pony is pre-1.0. We regularly have releases that involve breaking changes. This lack of stability is plenty of reason for many projects to avoid using Pony.

### Batteries required

If your project is going to succeed or fail based on the size of community around the tools you are using, Pony is not a good choice for you. While it's possible to write stable, high-performance applications using Pony, you will have to do a decent amount of work. The pool of open source, ready to use Pony libraries is very small. If it's not in the standard library then odds are you are going to have to add it yourself, either by writing it from scratch in Pony or by wrapping an existing C library using Pony's excellent [C-FFI](https://tutorial.ponylang.io/c-ffi/) functionality.

### Tooling

There's a wide swath of tooling that some people have come to expect that isn't currently available for Pony. We don't have an IDE. You can use standard debuggers like GDB or LLDB but the experience still has some rough edges. If you are comfortable working with a basic text editor and using LLDB, VTune and other tools, you'll probably be ok. Just don't expect a full, robust ecosystem. We aren't there yet.

If your project isn't going to get a great deal of benefit from any of Pony's strengths, then you shouldn't use Pony. If you are writing a single threaded application without any overriding performance concerns, and you need access to a large community and wealth of libraries then you're much better off selecting another language. However, we hope that you see enough potential in Pony to start playing around with it even if it isn't right for your current project.

## The Pony Philosophy

In the spirit of [Richard Gabriel](http://www.jwz.org/doc/worse-is-better.html), the Pony philosophy is neither "the-right-thing" nor "worse-is-better". It is "get-stuff-done".

### Correctness

Incorrectness is simply not allowed. _It's pointless to try to get stuff done if you can't guarantee the result is correct._

### Performance

Runtime speed is more important than everything except correctness. If performance must be sacrificed for correctness, try to come up with a new way to do things. _The faster the program can get stuff done, the better. This is more important than anything except a correct result._

### Simplicity

Simplicity can be sacrificed for performance. It is more important for the interface to be simple than the implementation. _The faster the programmer can get stuff done, the better. It's ok to make things a bit harder on the programmer to improve performance, but it's more important to make things easier on the programmer than it is to make things easier on the language/runtime._

### Consistency

Consistency can be sacrificed for simplicity or performance.
_Don't let excessive consistency get in the way of getting stuff done._

### Completeness

It's nice to cover as many things as possible, but completeness can be sacrificed for anything else. _It's better to get some stuff done now than wait until everything can get done later._

The "get-stuff-done" approach has the same attitude towards correctness and simplicity as "the-right-thing", but the same attitude towards consistency and completeness as "worse-is-better". It also adds performance as a new principle, treating it as the second most important thing (after correctness).

## Guiding Principles

Throughout the design and development of the language, the following principles should be adhered to.

* Use the get-stuff-done approach.

* Simple grammar. Language must be trivial to parse for both humans and computers.

* No loadable code. Everything is known to the compiler.

* Fully type safe. There is no "trust me, I know what I'm doing" coercion.

* Fully memory safe. There is no "this random number is really a pointer, honest."

* No crashes. A program that compiles should never crash (although it may hang or do something unintended).

* Sensible error messages. Where possible use simple error messages for specific error cases. It is fine to assume the programmer knows the definitions of words in our lexicon, but avoid compiler or other computer science jargon.

* Inherent build system. No separate applications required to configure or build.

* Aim to reduce common programming bugs through the use of restrictive syntax.

* Provide a single, clean and clear way to do things rather than catering to every programmer's preferred prejudices.

* Make upgrades clean. Do not try to merge new features with the ones they are replacing, if something is broken remove it and replace it in one go. Where possible provide rewrite utilities to upgrade source between language versions.

* Reasonable build time. Keeping down build time is important, but less important than runtime performance and correctness.

* Allowing the programmer to omit some things from the code (default arguments, type inference, etc) is fine, but fully specifying should always be allowed.

* No ambiguity. The programmer should never have to guess what the compiler will do, or vice-versa.

* Document required complexity. Not all language features have to be trivial to understand, but complex features must have full explanations in the docs to be allowed in the language.

* Language features should be minimally intrusive when not used.

* Fully defined semantics. The semantics of all language features must be available in the standard language docs. It is not acceptable to leave behavior undefined or "implementation dependent".

* Efficient hardware access must be available, but this does not have to pervade the whole language.

* The standard library should be implemented in Pony.

* Interoperability. Must be interoperable with other languages, but this may require a shim layer if non-primitive types are used.

* Avoid library pain. Use of 3rd party Pony libraries should be as easy as possible, with no surprises. This includes writing and distributing libraries and using multiple versions of a library in a single program.
