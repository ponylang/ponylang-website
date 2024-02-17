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
