+++
title = "FAQ"
+++

## About Pony {#about-pony}

### How'd Pony come to be? {#early-history}

Check out ["An Early History of Pony"](https://www.ponylang.io/blog/2017/05/an-early-history-of-pony/).

### Why's it called "Pony"? {#why-the-name-pony}

Interesting question. We hear that a lot. If you read enough of ["An Early History of Pony"](https://www.ponylang.io/blog/2017/05/an-early-history-of-pony/), you'll get your answer.

### What makes Pony different? {#how-is-pony-different}

See the ["What makes Pony different"]({{< relref "discover/index.md#what-makes-pony-different" >}}) section of ["Discover"]({{< relref "discover/index.md" >}}).

### Why would I use Pony instead of language X? {#why-pony-instead-of-x}

That's a hard question to answer. Language X is probably very compelling for some problems. It's probably less compelling for others. Such is computers. In the end, the best we can do is tell you what Pony is good at and you can make the decision for yourself. To learn more about Pony, we suggest checking out the ["Discover"]({{< relref "discover/index.md" >}}) section of the website. There's a portion of that section called ["Why Pony"]({{< relref "discover/index.md#why-pony" >}}) that might answer your question.

### Where can I find the Pony roadmap?

There is no official roadmap. Pony is a volunteer driven project. Unlike many programming languages, we don't have corporate backing. Our users add features and fix issues based on their needs. Pony users solve the problems that matter to them, and we all benefit.

Many of us who are regular contributors share some general goals as we move towards an official 1.0 release. We are working towards making Pony a stable, rock-solid platform for writing high-performance, concurrent applications.

We invite you to join our small but growing community and help push Pony forward. We're still at an early stage, and new community members can have a huge influence on the language. Join us!

## Code {#code}

### How can I turn a `ref` into a `val`? {#ref-to-val}

Generally, you can't.

A `ref` may have any number of untracked mutable aliases, so it can't be declared immutable. If you start with `iso` or `trn` instead, you can guarantee that by consuming it you are destroying the only mutable reference, hence allowing it to become immutable. See [the capabilities section of the tutorial](https://tutorial.ponylang.io/reference-capabilities/reference-capabilities.html) for more information.

Similarly, a `ref` may sometimes be "lifted" to a `val` capability if it was created in the isolated region formed by a `recover` block, from which the compiler guarantees that no mutable references can leak. See [the recover section of the tutorial](https://tutorial.ponylang.io/capabilities/recovering-capabilities.html) for more information.

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

Check out [the example program in the Pony Playground](https://playground.ponylang.io/?gist=26fce9986dd82a58f8bcd5197e22121f).

For more information see the [Sugar](https://tutorial.ponylang.io/expressions/sugar.html) section of the the tutorial.

### How can I write code that works for every kind of Number in Pony? {#code-for-all-numbers}

If you want to support all kinds of numeric types for which Pony supports there are three ways to approach this problem:

1. **Via Inheritance:**

You pick the trait or interface that satisfies the operations you need from those numbers (e.g. support for `sub` is defined in `trait val Real[A: Real[A] val]`) and use this as a type or type parameter in Generics. This works fine for a lot of cases. But e.g. literal inference will not work here, as this example shows:

```pony
// does not compile
primitive OneForAllInheritance
  fun do_generic_stuff[T: Real[T] val](t: T): T ? =>
    if t == T.min_value() then
      error
    else
      t.divmod(1) // can be fixed by: t.sub(T.from[U8](1))
    end
```

. Why is that? Literal inference only works for the built-in primitive types, but  `Integer[T] val` could be extended by further not yet known classes.

2. **Via Type Expressions:**

There are plenty of pre-defined union types for all classes of numbers in Pony. E.g. `type Signed is (I8 | I16 | I32 | I64 | I128 | ILong | ISize)`. There is also `Unsigned`, `Int`, `Float` and `Number`. Just pick what you need as your type.

```pony
// does not compile
primitive OneForAllTypeExpressions
  fun do_generic_stuff[T: Int](t: T): T ? =>
    if t == T.min_value() then
      error
    else
      t.sub(1)
    end
```

But there is a problem with this approach. Not only do we state that `T` could be any element of `Int`. It could even be a combination of them. e.g. `( U8 | I16 )` and how you use `t` and `T` here must work for all possible instantiations of `Int`, that is every possible combination.

3. **Via Type Expressions AND Inheritance:**

To get rid of the literal inference problem and to make sure only single numeric types are accepted, not unions of them, in order to use the methods on the different integer types for our generic problem, we need to combine both the type unions and inheritance to get to a safe solution: `(Int & Integer[T] val)`. The reason why this works is that `Integer[T] val` can only be instantiated by a single concrete `Int` element, so we get rid of the combinations and at the same time make the literal inference work as we lock our generic `T` down to single concrete types being part of `Int`:

```pony
primitive OneForAllCombined
  fun do_generic_stuff[T: (Int & Integer[T] val)](t: T): T ? =>
    if t == T.min_value() then
      error
    else
      t.sub(1)
    end
```

**Nice!**

## Are there any examples of something complex built in Pony? {#real-world-pony-codebases}

Yes! Here's a few projects we regularly point people towards:

- [Jylis](https://github.com/jemc/jylis) - A distributed in-memory database for Conflict-free Replicated Data Types
- [Novitiate](https://github.com/jtfmumm/novitiate) - A procedurally generated RPG inspired by Rogue and written in Pony.
- [Ponycheck](https://github.com/mfelsche/ponycheck) - Property Based Testing for Pony
- [Wallaroo](https://github.com/wallaroolabs/wallaroo) - Distributed Stream Processor written in Pony

## Compiling {#compiling}

### What are Pony's supported CPU platforms?

As of `ponyc` release `0.26.0`, we provide the following support:

- Full support for 64-bit platforms
  - x86 and ARM CPUs only
- Experimental, incomplete, and/or buggy support for 32-bit platforms
  - x86 and ARM CPUs only
  - See GitHub issues
    [#2836](https://github.com/ponylang/ponyc/issues/2836)
    and
    [#1576](https://github.com/ponylang/ponyc/issues/1576)
    for more information.

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

### On Windows I get "fatal error LNK1112: module machine type 'x86' conflicts with target machine type 'x64'"

Only 64-bit Windows is supported.

Make sure you're running a cmd.exe/powershell.exe that does not include 32-bit VS environment variables.

This error occurs when ponyc is compiled in a 32-bit Visual Studio Developer Command Prompt.

## Ecosystem {#ecosystem}

### Does Pony have a package manager?

That would be yes and no. Package manager means different things to different people. What we have is a simple dependency manager called [pony-stable](https://github.com/ponylang/pony-stable) that we are planning on growing into a full featured tool. Whether that is a more full featured "dependency manager" or more full featured "package manager" depends on how you define the two terms.

### Is there SSL support?

Yes! There used to be SSL support in the Pony standard library, but it's been moved out [into its own library](https://github.com/ponylang/net-ssl).

## Linking {#linking}

### How can I supply custom linker parameters?

So, you need to link your program to a custom library or otherwise pass a particular linker option? You can accomplish your goal using the  `ponyc` `--linker` option.

You'll need to know what your current linker is. To get it, compile a pony program and pass `--verbose 3`.

#### On Linux, MacOS or other Unix-like

Then examine the output. You should see something like:

```bash
ld -execute -no_pie -dead_strip -arch x86_64 -macosx_version_min 10.8
  -o ./timer ./timer.o -L"/usr/local/lib/pony/0.9.0-e64bff88c/bin/"
  -L"/usr/local/lib/pony/0.9.0-e64bff88c/bin/../lib"
  -L"/usr/local/lib/pony/0.9.0-e64bff88c/bin/../packages"
  -L"/usr/local/lib" -lponyrt -lSystem
```

The `ld` is the linker command that is usually used on MacOS or Linux. If I wanted to link in the library `Foo` and needed to pass `-lFoo` then I would compile my program as:

`ponyc --linker="ld -lFoo"`

That would change the linker command that `ponyc` runs to:

```bash
ld -lFoo -execute -no_pie -dead_strip -arch x86_64 -macosx_version_min 10.8
  -o ./timer ./timer.o -L"/usr/local/lib/pony/0.9.0-e64bff88c/bin/"
  -L"/usr/local/lib/pony/0.9.0-e64bff88c/bin/../lib"
  -L"/usr/local/lib/pony/0.9.0-e64bff88c/bin/../packages"
  -L"/usr/local/lib" -lponyrt -lSystem
```

#### On Windows

Compiling a pony program with `--verbose 3` will produce something like:

```
cmd /C ""C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.11.25503\bin\HostX64\x64\link.exe"
  /DEBUG /NOLOGO /MACHINE:X64 /OUT:.\helloworld.exe .\helloworld.obj
  /LIBPATH:"C:\Program Files (x86)\Windows Kits\10\Lib\10.0.15063.0\ucrt\x64"
  /LIBPATH:"C:\Program Files (x86)\Windows Kits\10\Lib\10.0.15063.0\um\x64"
  /LIBPATH:"C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.11.25503\lib\x64"
  /LIBPATH:"C:\pony\ponyc\build\release-llvm-3.9.1"
  /LIBPATH:"C:\pony\ponyc\build\release-llvm-3.9.1\..\..\packages"
  kernel32.lib msvcrt.lib Ws2_32.lib advapi32.lib vcruntime.lib legacy_stdio_definitions.lib dbghelp.lib ucrt.lib libponyrt.lib "
```

The path ending in `link.exe` is the linker that the pony compiler is currently using.

To add options to the link command, I would compile my program as something like:

`ponyc --linker="C:\OtherPath\link.exe /LIBPATH:C:\Foo"`

## Runtime {#runtime}

### Does Pony have green threads?

The short answer is no. Pony doesn't have green threads. By default, the Pony scheduler starts 1 "actor thread" per available CPU. These threads are used to schedule actors. Each of these threads is a kernel thread.

The longer answer is "it depends". Actors are Pony's unit of concurrency and many people when asking if Pony has green threads really are asking about how concurrency is modeled. You, as a Pony programmer, never interact with scheduler threads directly, you never interact with any sort of thread. You worry about actors and sending messages between them.
