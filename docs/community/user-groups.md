# Virtual Users' Group

Pony has a rather small community. That community is spread out across the world. We've tried one a couple of occasions to start in-person users' groups. It has never really worked out. There simply aren't enough people in any one location to sustain a group.

We have had some success with a virtual users' group. We've had a few meetings. We've had some presentations. We've had some discussions. It's been fun. We'd like to do more of it.

If you're interested in participating in a virtual users' group, please join the [virtual users' group stream](https://ponylang.zulipchat.com/#narrow/stream/426066-virtual-users'-group) in the Pony Zulip. We use that channel to coordinate meetings and to discuss topics.

To keep up to date with VUG meetings, you can subscribe to the [VUG event calendar](https://calendar.google.com/calendar/ical/042ceam97bfg4eseqt3sagq1rk%40group.calendar.google.com/public/basic.ics).

## Past Meetings

### An informal tour of the Pony backpressure system

Recording of a Pony office hours where Sean T. Allen goes through an informal presentation of the inter-actor backpressure system in the Pony runtime.

- [Video](https://vimeo.com/707155973)

### Exploration of a bug

Recording of a Pony office hours where Sean T. Allen goes through a deep dive of a nasty Pony runtime bug. Includes discussion of TOCTOU issues, the ABA problem, a ton about the Pony runtime, and a whole lot more.

- [Video](https://vimeo.com/695067236)

### Pony via a GitHub REST API

Explore a bit about Pony with Sean T. Allen via a walk-through of the in progress GitHub REST API package.

- [Video](https://vimeo.com/592434464)

### Pony vs Rust: "Or how they both drive you mad at compile time"

Matthias Wahl is giving a birds eye view of the mechanics through which Pony and Rust achieve both Memory Safety and Data Race Freedom.

- [Video](https://vimeo.com/574893226)

### CastXML2Pony: Automatically(ish) building Pony libraries to wrap C-FFI calls

Pony is a strongly typed and safe language that provides many guarantees. If you want to call code from other languages then you can, but you'll lose those guarantees. This talk introduces CastXML2Pony, a tool designed to autogenerate safe(r) wrapping for your C-FFI calls.

- [Video](https://vimeo.com/563948627)

### Prime Cuts: The Best Pieces Of Pony

On the surface, Pony may seem like another strongly-typed object-oriented programming language with a touch of functional programming on the side. But the most powerful part of Pony's design is the way that it uses actors and reference capabilities to guarantee that programs are free of data races. This talk will provide a general overview of the Pony programming language, followed by a deeper look at how actors and reference capabilities are used in Pony to give the programmer powerful options for working with data across multiple threads of execution.

- [Video](https://vimeo.com/202387915)
- [Slides](https://www.slideshare.net/aturley_slides/pony-vug-prime-cuts-the-best-pieces-of-pony)

### Designing an Actor Model Game Architecture with Pony

Pony’s high performance and its object-oriented approach already makes it interesting for game development which has been dominated by the C++ programming language for decades. By introducing actors at language level and a new language concept called capabilities, Pony prevents common multi-threading pitfalls and becomes an exciting candidate for game development and real-time application development in general.

With `PonyGame` we propose an architecture for building games with Pony.

- [Video](https://vimeo.com/187451870)

### The Art of Forgetting - Garbage Collection in Pony

Pony uses several novel techniques to manage memory and to reclaim memory that is no longer being used by a program. These techniques take advantage of some of the features of the language that set it apart from other languages, including the use of actors and reference capabilities. By understanding how memory management and garbage collection work in Pony, one can more easily reason about the space and time trade-offs between different solutions to a problem, as well as more quickly look for the sources of performance issues. This talk will cover object and actor collection in the Pony runtime, consequences of the design and implementation of the garbage collector, and methods for monitoring GC performance.

- [Video](https://vimeo.com/181099993)

### A Principled Design of Capabilities in Pony

An overview of a formal model of the Pony language which allows us to prove Pony's guarantees about freedom from data-races while having more permissive definitions than the existing implementation. We also briefly discuss bugs found in the language implementation during development of the model.

- [Video](https://vimeo.com/178522513)

### Simple Value-Dependent Types In Pony

Luke Cheeseman discusses his work on adding simple value-dependent types to Pony. Luke walks us through how introducing value-dependent types and compile-time expressions into Pony to provides developers access to a wider variety of efficient, flexible containers.

- [Video](https://vimeo.com/175746403)

### The Actor Model and Pony

Willem Wyndham takes us through the actor model and its usage in Pony.

- [Video](https://vimeo.com/172129187)

### Managing external processes using the Pony process package - Using the Pony FFI in Anger

Markus Fix walks us through how he used Pony's FFI facilities while creating the Pony Process Manager package.

- [Video](https://vimeo.com/168247590)

### Writing Generic Code

Sylvan Clebsch, creator of the Pony programming language, walks through advanced type system features that are used when writing generic code.

- [Video](https://vimeo.com/163871856)
