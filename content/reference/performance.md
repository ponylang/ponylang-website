+++
title = "Pony Performance Cheatsheet"
+++

##

If you know what you are doing, Pony can make it easy to write high-performance code. Pony isn't, however, a performance panacea. There are plenty of things that you as a programmer can do to hurt performance.

Martin Thompson's [Designing for Performance](https://www.youtube.com/watch?v=03GsLxVdVzU)

### Mind the hot path


### It's probably your design


### Watch your allocations {#avoid-allocations}


### Give in to your "primitive obsession" {#primitive-obsession}

Many collections of programming "best practices" teach you to avoid ["primitive obsession"](https://refactoring.guru/smells/primitive-obsession). This great advice, normally. It's not such great advice if you are worried about performance. Let's take two ways you can represent a short form American zip code:

```pony
// primitive obsession!
let zip: U64

// proper OO!
class ZipCode
  let _zip: U64

  new create(zip: U64) =>
    _zip = zip
```

The problem with our right and proper OO version that avoids primitive obsession are that you are going to end up creating a new object. Do that in a hot path, and it will add up. As we said earlier, [watch you allocations](#avoid-allocations)!

Perhaps our zip code example feels a little contrived? Here's another one. It's a somewhat familiar pattern to avoid using floating point numbers to represent monetary values. That's wise, floating point numbers are not good for accuracy, and most of us want our monetary calculations to be accurate. A standard solution to this problem might look like the `Money` class below:

```pony
class Money
  let _dollars: U64
  let _cents: U8

  new create(dollars: U64, cents: U8) =>
    _dollars = dollars
    _cents = cents
```

That's the beginning of a beautiful Money class. However, it's also the start of a lot of potential allocations. If we give in to our primitive obsession, we can avoid the object allocation by using a tuple:

```pony
type Dollars is U64
type Cents is U8
type Money is (Dollars, Cents)
```

### Avoid boxing machine words {#boxing-machine-words}

Machine words like U8, U16, U32, U64, etc. are going to be better for performance than classes. Machine words have less overhead then classes. However, if we aren't careful, we can end up "boxing" machine words and add cost. In hot path code, that boxing can have a large impact.

The easiest way to end up boxing a machine word is by including it in a union type. Take a look at the following code:

```
class Example
  let _array: Array[U64] = _array.create()

  fun index_for(find: U64): (USize | None) =>
    """
    Return the index position for `find` or `None` if it isn't in `Example`
    """
    for (index, value) in _array.pairs() do
      if value == find then
        return index
      end
    end

    None
```

This code is excellent and quite reasonable. The return type is very clear. We either get a `USize` or `None`. The problem here is that we need to box the `USize` that we return and it's going to have a performance impact. For hot path code, you should give in to your inner C programmer and write the following:

```
class Example
  let _array: Array[U64] = _array.create()

  fun index_for(find: U64): USize =>
    """
    Return the index position for `find` or `-1` if it isn't in `Example`
    """
    for (index, value) in _array.pairs() do
      if value == find then
        return index
      end
    end

    -1
``` 

You probably won't be proud of that code, but you'll be proud of the performance improvement you get. The `-1` idiom is one that should be quite familiar to folks with a C background. If you aren't familiar with C, you might be thinking: "Wait, that's a `USize`, an unsigned value. What on earth is `-1` there?" And that's a good question to ask. The answer is numeric types wrap overflow and wrap around. So `-1` is equivalent to the max value of a `U64`. Keep that in mind because if you find your value in index `18,446,744,073,709,551,615`, you'll be treating it as not-found. That might be problem but we doubt it.

### Avoid `error` {#avoid-error}

#### Error version

```pony
use "debug"

class Foo
  fun zero_is_bad(i: U64): U64 ? =>
    if i == 0 then
      error
    end

    i * 2

class UsesFoo
  let _foo: Foo = Foo

  fun bar(i: U64) =>
    try
      let x = _foo.zero_is_bad(i)?
      Debug("good things happened " + x.string())
    else
      Debug("error happened")
    end
```

#### Union type version

```pony
use "debug"

primitive ZeroIsBad

class Foo
  fun zero_is_bad(i: U64): (U64 | ZeroIsBad) =>
    if i == 0 then
      ZeroIsBad
    else
      i * 2
    end

class UsesFoo
  let _foo: Foo = Foo

  fun bar(i: U64) =>
    match _foo.zero_is_bad(i)
    | let x: U64 =>
      Debug("good things happened " + x.string())
    | ZeroIsBad =>
      Debug("zero is bad")
    end
```

### Mind the garbage collector {#garbage-collector}

### Watch the asynchrony! {#e-too-many-actors}

### Maybe you have too many threads {#ponythreads}


### Profile it! {#profiling}
