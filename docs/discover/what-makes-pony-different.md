# What makes Pony different? {:id="what-makes-pony-different"}

## Pony is type safe

*Really type safe*. There's a mathematical [proof](/media/papers/fast-cheap-with-proof.pdf) and everything.

## Pony is memory safe

There are no dangling pointers and no buffer overruns. The language doesn't even have the concept of null!

## Exception-Safe

There are no runtime exceptions. All exceptions have defined semantics, and they are *always* caught.

## Data-race Free

Pony doesn't have locks nor atomic operations or anything like that. Instead, the type system ensures at compile time that your concurrent program can never have data races. So you can write highly concurrent code and never get it wrong.

## Deadlock-Free

This one is easy because Pony has no locks at all! So they definitely don't deadlock, because they don't exist!

## Native Code

Pony is an ahead-of-time (AOT) compiled language. There is no interpreter nor virtual machine.

## Compatible with C

Pony programs can natively call C libraries using the foreign function interface.
