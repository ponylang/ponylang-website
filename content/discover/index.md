+++
title = "Discover"
+++

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
