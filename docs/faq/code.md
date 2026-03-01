# Code

## How can I turn a `ref` into a `val`? {:id="ref-to-val"}

Generally, you can't.

A `ref` may have any number of untracked mutable aliases, so it can't be declared immutable. If you start with `iso` or `trn` instead, you can guarantee that by consuming it you are destroying the only mutable reference, hence allowing it to become immutable. See [the capabilities section of the tutorial](https://tutorial.ponylang.io/reference-capabilities/reference-capabilities.html) for more information.

Similarly, a `ref` may sometimes be "lifted" to a `val` capability if it was created in the isolated region formed by a `recover` block, from which the compiler guarantees that no mutable references can leak. See [the recover section of the tutorial](https://tutorial.ponylang.io/capabilities/recovering-capabilities.html) for more information.

## What does `Foo()` do if my `Foo` class has both `create()` and `apply()` methods? Does it call both? {:id="Foo()-create-apply"}

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

Check out [the example program in the Pony Playground](https://playground.ponylang.io/?gist=0045ecb177ab3adf06b5477fc53bdfb7).

For more information see the [Sugar](https://tutorial.ponylang.io/expressions/sugar.html) section of the the tutorial.

## How can I write code that works for every kind of Number in Pony? {:id="code-for-all-numbers"}

If you want to support all kinds of numeric types for which Pony supports there are three ways to approach this problem:

- **Via Inheritance:**

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

- **Via Type Expressions:**

There are plenty of predefined union types for all classes of numbers in Pony. E.g. `type Signed is (I8 | I16 | I32 | I64 | I128 | ILong | ISize)`. There is also `Unsigned`, `Int`, `Float` and `Number`. Just pick what you need as your type.

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

- **Via Type Expressions AND Inheritance:**

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

## How do I create global constants or singletons? {:id="global-constants"}

Use primitives. A primitive in Pony is a singleton with no fields. It's always `val`, so it's globally readable and immutable. That makes it a natural fit for constants.

```pony
primitive Pi
  fun apply(): F64 => 3.14159265358979323846

primitive Colours
  fun red(): (U8, U8, U8) => (255, 0, 0)
  fun green(): (U8, U8, U8) => (0, 255, 0)
  fun blue(): (U8, U8, U8) => (0, 0, 255)
```

Primitives can't have fields, so they can't hold mutable state. That's intentional. Mutable global state is ambient authority, and Pony's capability-secure design doesn't allow ambient authority.

If you need shared read-only data that's expensive to construct, a large lookup table say, create it once and pass it to whatever needs it via constructors.

For more on primitives, see the [Primitives](https://tutorial.ponylang.io/types/primitives.html) section of the tutorial and the [Global Function](https://patterns.ponylang.io/code-sharing/global-function.html) pattern.

## How do I debug Pony programs? {:id="debugging"}

Most people start with printf-style debugging, and the standard library's `Debug` primitive makes that easy. `Debug` output only appears when you compile with `ponyc --debug`. In a release build, `Debug` calls compile out entirely. Zero cost.

When you need a step debugger, Pony compiles to native code with standard DWARF symbols, so LLDB and GDB work directly. We have a [Pony LLDB Cheat Sheet](/use/debugging/pony-lldb-cheat-sheet/) to get you started and a set of [Pony LLDB Extensions](https://github.com/ponylang/pony-lldb-extensions) that make inspecting Pony values easier.

There's more in the [Debugging](/use/debugging/) section of this website.

## How do I wait for an actor to finish? {:id="wait-for-actor"}

You don't. Pony is asynchronous. There is no way to block one actor while waiting for another.

This question usually comes from people accustomed to synchronous calls in other languages. In Pony, you flip it around. Instead of "wait for the result," you define what happens when the result arrives. Pass a reference to the calling actor to the worker. When the worker is done, it sends a message back.

The [`counter`](https://github.com/ponylang/ponyc/tree/main/examples/counter) example in `ponylang/ponyc` shows this pattern. `Main` passes `this` to a `Counter` actor, and `Counter` calls `main.display()` with the result.

If you need to coordinate across many actors, the [`ponylang/fork_join`](https://github.com/ponylang/fork_join) library provides a fork-join coordination pattern. For more on asynchronous coordination patterns in general, see the [Actor Promise](https://patterns.ponylang.io/async/actorpromise.html) section of the Pony Patterns book.

## How do I read console input? {:id="console-input"}

There's no blocking `readLine()` call in Pony. All IO is asynchronous. You set up a notifier that gets called when input arrives rather than blocking a thread to wait for it.

The standard library's `term` package provides `Readline` and `ReadlineNotify` for interactive line-oriented input, complete with tab completion and history. The [`readline`](https://github.com/ponylang/ponyc/tree/main/examples/readline) example in `ponylang/ponyc` shows the full pattern.

It's more code than a blocking read in most languages. That's the tradeoff for non-blocking IO.

## Does Pony have reflection? {:id="reflection"}

No. There is no runtime reflection in Pony. You can't inspect an object's fields or methods at runtime the way you would in Java or C#.

If you need to serialize objects, build string representations, or do anything else that reflection typically handles, you write it by hand. There is an [open RFC issue](https://github.com/ponylang/rfcs/issues/57) for adding reflection, but designing reflection that doesn't violate Pony's safety guarantees is hard. No one has taken it on yet.

## Why can't I use `env` outside of `Main`? {:id="env-outside-main"}

Because that would be ambient authority. Pony is a capability-secure language. Access to the network, the filesystem, `stdout` — these are capabilities that have to be explicitly passed to whoever needs them. Nothing gets them for free.

If an actor or class needs to print, pass it an `OutStream`. If it needs file access, pass it a `FileAuth`. You decide exactly who gets what authority. That's the point.

For more on this design, see the [Object Capabilities](https://tutorial.ponylang.io/object-capabilities/object-capabilities.html) section of the tutorial.
