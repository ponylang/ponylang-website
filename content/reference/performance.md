+++
title = "Pony Performance Cheatsheet"
+++

## Performance, it's a word in the dictionary 

If you know what you are doing, Pony can make it easy to write high-performance code. Pony isn't, however, a performance panacea. There are plenty of things that you as a programmer can do to hurt performance.

We'd categorize most of the information in this document as either "know how computers work" or "know how Pony works." The former applies to any programming language. What you learn here is probably applicable in other languages that you use every day.

Martin Thompson has an excellent talk [Designing for Performance](https://www.youtube.com/watch?v=03GsLxVdVzU) that talks about writing performance sensitive code in the large. We firmly advise you to watch it. Performance tuning can be a massive rabbit hole If the topic excites you, put ["mechanical sympathy"](https://duckduckgo.com/?q=mechanical+sympathy) into your favorite search engine; you'll come up for air in a few months knowing a ton.

All of this is to say; performance is complicated. It's more art than science. What we are presenting here is rules of thumb. Many are not always good or always bad. Like most things in engineering, there are tradeoffs involved. Be mindful. Be empirical. Be sure to measure the performance of your code before and after you change anything based on this document.

It's our belief that the best way to get to awesome performance is [baby steps](https://www.youtube.com/watch?v=ncFCdCjBqcE). Don't try to make a ton of changes at once. Make a small performance oriented change. Measure the impact. Repeat. Take one tiny step at a time towards better performance.

And remember, invest your time where it's valuable. Worrying about possible performance problems in code that get executed once at startup won't get you anything. You need to "mind the hot path." Performance tune your code that gets executed all the time. For example, if you are writing an HTTP server and want to make it high-performance, you definitely should focus on the performance of your HTTP parser, it's going to get executed on every single request.

If you get stuck, fear not, we have a [welcoming community](https://www.ponylang.org/learn/#getting-help) that can assist you. 

## Pony performance tips

### It's probably your design


### Watch the asynchrony! {#e-too-many-actors}


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

Machine words like U8, U16, U32, U64, etc. are going to be better for performance than classes. Machine words have less overhead than classes. However, if we aren't careful, we can end up "boxing" machine words and add cost. In hot path code, that boxing can have a large impact.

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

You probably won't be proud of that code, but you'll be proud of the performance improvement you get. The `-1` idiom is one that should be quite familiar to folks with a C background. If you aren't familiar with C, you might be thinking: "Wait, that's a `USize`, an unsigned value. What on earth is `-1` there?" And that's a good question to ask. The answer is numeric types wrap overflow and wrap around. So `-1` is equivalent to the max value of a `U64`. Keep that in mind because if you find your value in index `18,446,744,073,709,551,615`, you'll be treating it as not-found. That might be a problem, but we doubt it.

### Avoid `error` {#avoid-error}

Pony's `error` is often confused with exceptions from languages like Java. `error` while having some similarities, isn't the same. Amongst other differences, `error` carries no runtime information like exception type. It's also cheaper to set up a Pony `error` than it is an exception in languages like Java. Many folks hear that and think, "I can use `error` without worrying about performance." Sadly, that isn't the case. 

`error` has a cost. It's a good rule of thumb to avoid using `error` in hot path code. You should instead favor using union types where one value represents your "success" value, and the other represents your "error" value.
Below you'll see two versions of a contrived `zero_is_bad` function. The first utilizes `error`; the second is implemented using a union type.

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

Which is better for performance? Well, it depends. How often is the input to `zero_is_bad` going to be 0? The more often it is, the worse the error version will perform compared to the union type version. If the `i` parameter to `zero_is_bad` is rarely 0, then the error version will perform better than the union type version.

Our union type version contains additional logic that will be executed on every single call. We have to match against the result of `zero_is_bad` to determine if you got a `U64` or `None`. You are going to pay that cost *every single time*. 

How do you know which is the best version? Well, there is no best version. There is only a version that will work better based on the inputs you are expecting. Pick wisely. Here's our general rule of thumb. If it's in hot path code, and you are talking about `error` happening in terms that are less than 1 in millions, you probably want the union type. But again, the only way to know is to test.

By the way, did you notice our union type version introduced a different problem? It's [boxing the `U64` machine word]({#boxing-machine-words}). If `zero_is_bad` was returning a `(FooClass | None)` that wouldn't be an issue. Here, however, it is. Be mindful that when you address one possible performance problem that you don't introduce a different one. It's ok to trade one potential performance problem for another; you just need to be mindful.

### Mind the garbage collector {#garbage-collector}

### Maybe you have too many threads {#ponythreads}


### Profile it! {#profiling}
