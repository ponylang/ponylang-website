+++
title = "FAQ"
+++

## About Pony {#about-pony}

### How'd Pony come to be? {#early-history}

Check out ["An Early History of Pony"](https://www.ponylang.org/blog/2017/05/an-early-history-of-pony/).

### Why's it called "Pony"? {#why-the-name-pony}

Interesting question. We hear that a lot. If you read enough of ["An Early History of Pony"](https://www.ponylang.org/blog/2017/05/an-early-history-of-pony/), you'll get your answer.

### What makes Pony different? {#how-is-pony-different}

See the ["What makes Pony different"]({{< relref "discover/index.md#what-makes-pony-different" >}}) section of ["Discover"]({{< relref "discover/index.md" >}}).

### Why would I use Pony instead of language X? {#why-pony-instead-of-x}

That's a hard question to answer. Language X is probably very compelling for some problems. It's probably less compelling for others. Such is computers. In the end, the best we can do is tell you what Pony is good at and you can make the decision for yourself. To learn more about Pony, we suggest checking out the ["Discover"]({{< relref "discover/index.md" >}}) section of the website. There's a portion of that section called ["Why Pony"]({{< relref "discover/index.md#why-pony" >}}) that might answer your question.

## Code {#code}

### What does `Foo()` do if my `Foo` class has both `create()` and `apply()` methods? Does it call both? {#Foo()-create-apply}

Yes, it calls both. However perhaps not in the way you imagine. 

- `Foo` creates a new object instance using `create()`
- `()` is the `apply` call on the newly created `Foo` instance

This example program demonstrates what is going on:

```pony
use "debug"

class Foo
  new create() =>
    Debug("create called")
    
  fun apply() =>
    Debug("apply called")
    
actor Main
  new create(env: Env) =>
    Debug("call Foo()")
    Foo()
    
    Debug("call Foo")
    let foo = Foo
    
    Debug("call foo()")
    foo()
```

Check out [the example program in the [Pony Playground](https://playground.ponylang.org/?gist=26fce9986dd82a58f8bcd5197e22121f).

For more information see the [Sugar](https://tutorial.ponylang.org/expressions/sugar.html) section of the the tutorial.

## Compiling {#compiling}

### I get a "requires dynamic" error when compiling, how do I solve it? {#pic-compile-error}

```bash
/usr/bin/ld.gold: error: ./fb.o: requires dynamic R_X86_64_32 
  reloc against 'Array_String_val_Trace' which may 
  overflow at runtime; recompile with -fPIC
```

try running `ponyc` with the `--pic` flag.

For example:

```bash
ponyc --pic examples/helloworld
```

As of Pony 0.17.0, if you are building `ponyc` from source, you can have `--pic` automatically set for you. When building `ponyc`, run the following `make` command and your generated `ponyc` binary will always supply `--pic` without you having to set it.

```bash
make default_pic=true
```

## Ecosystem {#ecosystem}

### Does Pony have a package manager?

That would be yes and no. Package manager means different things to different people. What we have is a simple dependency manager called [pony-stable](https://github.com/ponylang/pony-stable) that we are planning on growing into a full featured tool. Whether that is a more full featured "dependency manager" or more full featured "package manager" depends on how you define the two terms.

## Runtime {#runtime}

### Does Pony have green threads?

The short answer is no. Pony doesn't have green threads. By default, the Pony scheduler starts 1 "actor thread" per available CPU. These threads are used to schedule actors. Each of these threads is a kernel thread.

The longer answer is "it depends". Actors are Pony's unit of concurrency and many people when asking if Pony has green threads really are asking about how concurrency is modeled. You, as a Pony programmer, never interact with scheduler threads directly, you never interact with any sort of thread. You worry about actors and sending messages between them.
