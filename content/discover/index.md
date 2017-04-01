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

... content here ...

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
