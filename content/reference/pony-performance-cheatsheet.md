+++
title = "Pony Performance Cheatsheet"
+++

## Performance, it's a word in the dictionary

If you know what you are doing, Pony can make it easy to write high-performance code. Pony isn't, however, a performance panacea. There are plenty of things that you as a programmer can do to hurt performance.

We'd categorize most of the information in this document as either "know how computers work" or "know how Pony works." The former applies to any programming language. What you learn here is probably applicable in other languages that you use every day.

Martin Thompson has an excellent talk [Designing for Performance](https://www.youtube.com/watch?v=03GsLxVdVzU) that talks about writing performance sensitive code in the large. We firmly advise you to watch it. Performance tuning can be a massive rabbit hole. If the topic excites you, put ["mechanical sympathy"](https://duckduckgo.com/?q=mechanical+sympathy) into your favorite search engine; you'll come up for air in a few months knowing a ton.

All of this is to say: performance is complicated. It's more art than science. What we are presenting here is rules of thumb. Many are not always good or always bad. Like most things in engineering, there are tradeoffs involved. Be mindful. Be empirical. Be sure to measure the performance of your code before and after you change anything based on this document.

It's our belief that the best way to get to awesome performance is [baby steps](https://www.youtube.com/watch?v=ncFCdCjBqcE). Don't try to make a ton of changes at once. Make a small performance oriented change. Measure the impact. Repeat. Take one tiny step at a time towards better performance.

And remember, invest your time where it's valuable. Worrying about possible performance problems in code that gets executed once at startup won't get you anything. You need to "mind the hot path." Performance tune your code that gets executed all the time. For example, if you are writing an HTTP server and want to make it high-performance, you definitely should focus on the performance of your HTTP parser, it's going to get executed on every single request.

If you get stuck, fear not, we have a [welcoming community](https://www.ponylang.io/learn/#getting-help) that can assist you.

## Pony performance tips

### It's probably your design {#design-for-performance}

A poor design can kill your performance before you ever write a line of code. One of the fastest ways to hurt your performance is by inserting bottlenecks. As an example, imagine a system where you have X number of "processing actors" and 1 "aggregating actor." Work is farmed out to each of the processing actors to undertake which in turn send their results to the aggregating actor. Can you spot the possible bottleneck? Our performance is going to be bound by the performance of the single aggregating actor. We haven't written a line of code yet, and we already have a performance problem.

This pattern plays out over and over in our software systems. For a variety of well-intentioned reasons, we introduce bottlenecks into our designs. And you know what? That's ok. It's about trade-offs. Sometimes the performance loss is worth whatever we are gaining. However, we need to be aware of the trade-offs we are making. If we are going to consciously lower our performance, we need to get something at least as valuable in return.

Fast code is highly concurrent. Fast code avoids coordination. Fast code relies on local knowledge instead of global knowledge. Fast code is willing to trade the illusion of consistency for availability and performance. Fast code does this **by design**.

There's a lot of material out there about writing high-performance, highly concurrent code. More than most people have time to absorb. Our advice? At least watch the Martin Thompson, and Peter Bailis talks below, then if you are hungry for more, ask the [community](https://www.ponylang.io/learn/#getting-help) what more you can learn.

- [Designing for Performance](https://www.youtube.com/watch?v=03GsLxVdVzU)
- [Silence is Golden: Coordination-Avoiding Systems Design ](https://www.youtube.com/watch?v=EYJnWttrC9k)

### Watch your allocations {#avoid-allocations}

Comparatively, creating new objects is expensive. Each object requires some amount of memory to be allocated. Allocations are expensive. The Pony runtime uses a pool allocator so creating a bunch of `String`s is cheaper than if you had to `malloc` each one. Allocation is not, however, free. In hot paths, it can get quite expensive.

If you want to write high-performance Pony code, you are going to have to look at where you are allocating objects. For example:

```pony
let output = file_name + ":" + file_linenum + ":" + file_linepos + ": " + msg
```

How many allocations does it take to create `output`? You need to know. We'll give you a hint:

```pony
// String.add
// commonly seen as "foo" + "bar"
fun add(that: String box): String =>
  """
  Return a string that is a concatenation of this and that.
  """
  let len = _size + that._size
  let s = recover String(len) end
  (consume s)._append(this)._append(that)
```

The point of this isn't that you need to know that `+` on `String` calls `add` which in turn creates a new object. The point is, you need to know how many allocations your code and the code you are calling is going to trigger. The following code has far fewer allocations involved:

```pony
let output = recover String(file_name.size()
  + file_linenum.size()
  + file_linepos.size()
  + msg.size()
  + 4) end

output.append(file_name)
output.append(":")
output.append(file_linenum)
output.append(":")
output.append(file_linepos)
output.append(": ")
output.append(msg)
output
```

It's going to perform much better than the former. You might find yourself wondering about the first part of the code, what's going on with:

```pony
let output = recover String(file_name.size()
  + file_linenum.size()
  + file_linepos.size()
  + msg.size()
  + 4) end
```

The answer once again is in the source. In this case in the source for `String.append` and `String.reserve`.

```pony
fun ref append(seq: ReadSeq[U8], offset: USize = 0, len: USize = -1) =>
  """
  Append the elements from a sequence, starting from the given offset.
  """
  if offset >= seq.size() then
    return
  end

  let copy_len = len.min(seq.size() - offset)
  reserve(_size + copy_len)

  match seq
  | let s: (String box | Array[U8] box) =>
    s._copy_to(_ptr, copy_len, offset, _size)
    _size = _size + copy_len
    _set(_size, 0)
  else
    let cap = copy_len + offset
    var i = offset

    try
      while i < cap do
        push(seq(i)?)
        i = i + 1
      end
    end
  end

fun ref reserve(len: USize) =>
  """
  Reserve space for len bytes. An additional byte will be reserved
  for the null terminator.
  """
  if _alloc <= len then
    let max = len.max_value() - 1
    let min_alloc = len.min(max) + 1
    if min_alloc <= (max / 2) then
      _alloc = min_alloc.next_pow2()
    else
      _alloc = min_alloc.min(max)
    end
    _ptr = _ptr._realloc(_alloc)
  end
```

`String.append` will make sure that it has enough room to copy the new data onto the string by calling `reserve`. `String.reserve` will result in a new allocation if you are trying to reserve more memory than you've already allocated. So...

```pony
let output = recover String(file_name.size()
  + file_linenum.size()
  + file_linepos.size()
  + msg.size()
  + 4) end
```

reserves enough memory for our string ahead of time and avoids allocations. The same principle can apply to a variety of collections. If you know you need to put 256 items in a collection, allocate space for 256 from the get go, otherwise, as you add items to the collection, allocations will be triggered.

"Limit allocations" doesn't only apply to knowing what happens in the code you are calling. You need to be aware of what your code is doing. You need to design your code to allocate as few objects as possible while triggering as few allocations from the pool allocator.

You can slaughter your performance if your object is growing in size and needs additional space and has to be copied into a newer roomier chunk of memory.

Just remember, if you want to maximise performance:

- You need to know when code you call is allocating new objects.
- You need to know when code you call results in memory copies

Some of you probably looked at the `String` performance enhancement above and thought, "doesn't the JVM do that for you?" You'd be right. That's a standard optimization in many languages. It's an optimization we are adding to Pony. However, the basic pattern applies. Be aware of triggering extra allocations that you don't need to. Your compiler and runtime can add many optimizations to avoid allocations, but it's not going to do everything for you. You still need to understand your allocations. They're called "your allocations" because in the end, you end up owning them and they end up owning your performance.

### Give in to your "primitive obsession" {#primitive-obsession}

Many collections of programming "best practices" teach you to avoid ["primitive obsession"](https://refactoring.guru/smells/primitive-obsession). This is great advice, normally. It's not such great advice if you are worried about performance. Let's take two ways you can represent a short form American zip code:

```pony
// primitive obsession!
let zip: U64

// proper OO!
class ZipCode
  let _zip: U64

  new create(zip: U64) =>
    _zip = zip
```

The problem with our right and proper OO version that avoids primitive obsession are that you are going to end up creating a new object. Do that in a hot path, and it will add up. As we said earlier, [watch your allocations](#avoid-allocations)!

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

By the way, did you notice our union type version introduced a different problem? It's [boxing the `U64` machine word](#boxing-machine-words). If `zero_is_bad` was returning a `(FooClass | None)` that wouldn't be an issue. Here, however, it is. Be mindful that when you address one possible performance problem that you don't introduce a different one. It's ok to trade one potential performance problem for another; you just need to be mindful.

### Watch the asynchrony! {#e-too-many-actors}

Actors are awesome. We love them. We wouldn't be using Pony if we didn't. However, we do see people getting a little too excited about them. Yes, actors are a unit of concurrency. However, you don't need to make everything an actor.

Sending a message from one actor to another is pretty fast; note the "pretty fast." A message send isn't free. The message has to be placed in the mailbox for the receiving actor which in turn needs to retrieve it. The multi-producer, single-consumer queue that powers actor mailboxes is highly tuned, but, it's still a queue. Sometimes you don't need another actor; you just need a class.

In addition to the queue costs you pay with a message send, depending on the contents of your message, you might be incurring additional garbage collection costs as well.

### Mind the garbage collector {#garbage-collector}

#### Things you should know about the Pony garbage collector

- Each actor has its own heap
- Actors might GC after each behavior call (never during one)
- Effectively, Pony programs are constantly, concurrently collecting garbage
- Garbage collection for an actor's heap uses a mark and don't sweep algorithm
- There are no garbage collection generations
- When an object is sent from one actor to another, additional messages related to garbage collection have to be sent
- If you send an object allocated in actor 1 to actor 2 and from there to actor 3, garbage collection messages will flow between actors 1, 2, and 3

#### Performance implications

There are two ways that Pony's garbage collection can impact your performance:

1. Time spent garbage collecting
2. Time spent sending garbage collection messages between actors

To minimize the impact of garbage collection on your application, you'll need to address anything that results in longer garbage collection times, and you'll want to reduce the number of garbage collection messages generated.

#### Advice:

- Watch your allocations!

If you don't allocate it, you don't have to collect it. Yaya, we [mentioned this already](#avoid-allocations); but really, it's an important component of your application's performance profile.

- Avoid sending objects between actors when you can

Remember our earlier [primitive obsession](#primitive-obsession) conversation? Here's another example of where primitive obsession can be your performance friend. Sending a "money tuple" like

```pony
// "money tuple"
type Dollars is U64
type Cents is U8
type Money is (Dollars, Cents)
```

from one actor to another will have no garbage collection overhead. Sending a "money class" such as

```pony
class Money
  let _dollars: U64
  let _cents: U8

  new create(dollars: U64, cents: U8) =>
    _dollars = dollars
    _cents = cents
```

will result in some garbage collection overhead. In the small, it won't make much of a difference, but in a hot-path? Look out. It can make a big difference. If you can send machine words instead of classes, do it.

- Avoid passing objects along long chains of actors

Sending 2 objects from Actor A to Actor B results in fewer garbage collection messages being generated than sending 1 object from Actor A to Actor B to Actor C. The can lead to some counter-intuitive performance improvements. For some applications that send objects down a long line of actors, it might make sense to create a copy of the object along the way and send the copy. Eventually, the cost of the memory allocation and copying will be less than the overhead from garbage collection messages.

Please note, this is not an issue that is going to impact most applications. It is, however, something you should be aware of.

- Avoid holding on to objects that were allocated by another actor

Pony's garbage collector is a non-generational mark and don't sweep collector. It will perform best when the number of objects in an actor's heap is kept low. The more objects on the heap, the longer a garbage collection cycle will take. All mark and don't sweep collectors share this trait. The complexity of generational garbage collection was added to address problems with long-lived objects.

Issues with high object count heaps interact interestingly with certain types of Pony applications. Take, for example, a network server. Clients open connections to it over TCP and exchange data. On the server side, data received from clients is allocated in the incoming TCP actors and then sent to other actors as an object or objects of some sort.

If our receiving actors hold onto the objects allocated in the TCP actors for an extended period, the number of objects in their heaps will grow. As the objects held grows, garbage collection times will increase.

Some applications might benefit from having receiving actors copy data once they get it from an incoming TCP actor rather than holding on to the data allocated by the TCP actor. Odds are, your application won't need to do this, but it's something to keep in mind.

### The dead actor collector (i.e cycle detector)

#### Things you should know about the Pony cycle detector

* The `cycle detector`s job is to identify and reap dead actors (including cycles of actors that are all dead)
* Every actor will send `block` messages to the `cycle detector` when it thinks it has no work left to do
* Every actor will send `unblock` messages to the `cycle detector` when it receives new work after it has already sent a block message
* The `cycle detector` will use the `block` and `unblock` messages along with actor dependencies tracked by the garbage collector to determine which actors or cycles of actors are dead and can never receive new work
* Once the `cycle detector` identifies dead actors, it will finalize and reap them freeing any memory used by them to be reused for other purposes

#### Performance implications

There are two ways that Pony's `cycle detector` can impact your performance:

1. Normal actors have to send `block`/`unblock` messages and respond to `conf` messages from the `cycle detector` with `ack` messages.
2. Time spent running the `cycle detector` to find cycles.

#### Advice:

If your application doesn't create many actors that need to be reaped over its lifetime or if you aren't worried about the extra memory wasted by dead actors, you can disable the `cycle detector`.

This can be accomplished by passing `--ponynoblock` option to the application.

Disabling the `cycle detector`:

1. Disables sending of `block`/`unblock` messages from normal actors to the `cycle detector`.
2. Disables running the `cycle detector` because it is never sent any messages.

### Maybe you have too many threads {#ponythreads}

Let's talk about the Pony scheduler for a moment. When you start up a Pony program, it will create one scheduler thread per available CPU. At least, that is what it does by default. Each of those scheduler threads will remain locked to a particular CPU. The scheduler threads can be suspended if there isn't enough work to do. Without going into a ton of detail, this is usually the right thing to do for performance and efficiency.

Pony schedulers use a work-stealing algorithm that allows idle schedulers to take work from other schedulers. In a loaded system, the work stealing algorithm can keep all the CPUs busy. When CPUs are underutilized, unused scheduler threads are suspended until there is enough work for them. In most cases, scheduler thread suspend/resume will have minimal negative impact on performance but significant positive impact on resource efficiency.

Depending on the workload and concurrency characteristics of a partiticular application, it might be worth tuning how things function. In some instances, where efficiency isn't a concern, you can specify `--ponyminthreads=X` to match `--ponythreads=X` in order to disable scheduler thread suspension by indicating that the minimum active scheduler threads required is the same as the total number of scheduler threads. This, however, can lead to work-stealing having a negative impact on performance due to CPU cache thrashing. In such cases, running with fewer threads might result in better performance. When you run your pony program, you can pass the `--ponythreads=X` option to indicate how many scheduler threads the program will create.

We suggest you rely on the default behavior where Pony scheduler threads automagically adjust to the workload. However, if you want to squeeze as much performance as possible, we suggest the following:

- Run your program under your expected workload.
- Start with 1 scheduler thread and work your way up to the number of CPUs you have available.
- Measure your performance with each `ponythread` setting with scheduler thread suspension disabled.
- Use the number of scheduler threads that gives you the best performance.

Work is ongoing to improve the work-stealing scheduler. Feel free to check in on the [developer mailing list](https://www.ponylang.io/contribute/) to get an update.

### Isolate and pin your scheduler threads {#pin-your-threads}

Multitasking operating systems are wondrous things. Without one, I wouldn't be able to write up these tips while listening to obscure Beastie Boys remixes. For me, at this moment in time, having multiple programs running at once is an awesome thing. There are times though when multitasking operating systems can be annoying.

Much like how the Pony scheduler schedules different actors, so they all get time to use a CPU, so your operating system does with various running programs. And this can be problematic for performance. If we want to get the best performance from Pony programs, we want them to have access to CPUs as much as possible. And, we want each scheduler thread to have sole access to its particular CPU.

Modern CPU architectures feature a hierarchical layering of caches. The caches are used to hold data that the CPU needs. The closer the cache is to the CPU, the faster it can execute operations on that data. In our ideal world, the data we need is always in the caches the closest to the CPU. We don't live in an ideal world, but we can do things to bring us closer to our ideal world.

One of those things is reserving CPUs for our programs. The benefits are two fold:

- Our application never loses CPU time to some other process
- Another process using the CPU doesn't evict our data from CPU caches

If your operating system supports process isolation and pinning, we suggest you use them. What you want to do is set your operating system and all "non-essential" programs to share 1, perhaps 2 CPUs; this frees up all your remaining CPUs for use by your Pony program.

On Linux, you'll want to use [cset](https://rt.wiki.kernel.org/index.php/Cpuset_Management_Utility/tutorial) to isolate your Pony programs and then use [numactl](https://linux.die.net/man/8/numactl) or [taskset](https://linux.die.net/man/1/taskset) to pin it to specific cpus. Let's have a look at an example:

```bash
sudo cset proc -s user -e numactl -- -C 1-4,17 chrt -f 80 \
  ./my-pony-program --ponythreads 4 --ponypinasio
```

This isn't a complete `cset` or `numactl` tutorial so I'm only going to focus on one option of each and I'll leave the rest to your investigation. Note the `-s user` option to `cset`; this tells `cset` to use the `user` process isolation zone where no system processes are allowed to run. Similarly, note the `-C 1-4,17` option to `numactl`; this will make only CPUs 1 to 4 plus CPU 17 available to our program `my-pony-program`.

```bash
--ponythreads 4 --ponypinasio
```

And those two additional options to our program? We've seen `--ponythreads` before. In this case, we are running with 4 scheduler threads. They will have exclusive access to CPUs 1 to 4. What about `--ponypinasio` and CPU 17?

In addition to scheduler threads, each Pony program also has an ASIO thread that handles asynchronous IO events. By supplying the `--ponypinasio` option, our ASIO thread will be pinned to a single CPU. Which CPU? Whichever available CPU is next after all scheduler threads have been assigned cpus which in this case is CPU 17. To sum up:

```bash
// Use "user" process isolation space
-s user
// Set aside 5 CPUs for this program
-C 1-4,17
// Run 4 scheduler threads and pin the ASIO thread
--ponythreads 4 --ponypinasio
```

### Hyper-threading {#hyperthreading}

For some workloads, hyper-threading improves performance, for others, it can not affect or can hurt performance. You should test your application with hyper-threading enabled and disabled. As a general rule of thumb, hyper-threading can often improve performance of your application if it's memory-bound and harm performance if it's CPU-bound. If you aren't familiar with hyper-threading, the [hyper-threading Wikipedia entry](https://en.wikipedia.org/wiki/Hyper-threading) is a good place to start.

If you are following our ["pin your scheduler threads"](#pin-your-threads) advice, you want to be especially aware of hyper-threading. If you have hyper-threading on, your operating system might be seeing logical cores from hyper-threading as real physical cores. Don't be fooled. If you want to maximize performance by pinning threads to a CPU, you probably want to turn off hyperthreading. Be especially wary in environments like AWS that present "virtual CPUs" aka VCPUs. In the case of AWS, your 8 VCPUs are 4 real cores and 4 hyper-threads. You only want to be using the real cores, not the hyper-threads.

### Tune your operating system {#tune-your-os}

Depending on what your program does, tuning your operating system might yield good results. Operating systems like Linux exposes a variety of options that you can use to optimize them. The internet is awash in various documents purporting to give you settings that will lower network latency, raise network throughput or improve application latency. Beware of every single one of those documents. Even if they were written by a knowledgeable person, they weren't written with your specific hardware in mind, with your specific operating system in mind, with your particular application in mind.

Now, warning aside, there's plenty you can learn about tuning your operating system, and it can sometimes have a large impact on your application. Just remember, mindlessly turning knobs you don't understand isn't likely to make things better. Do your research. Understand what you are doing. Be empirical; measure and then measure again.

### Build from source {#build-from-source}

The pre-built Pony packages are quite conservative with the optimizations they apply. To get the best performance, you should build your compiler from source. By default, Pony will then take advantage of any features of your CPU like AVX/AVX2. Additionally, you should try:

- Building with [link time optimization on](https://github.com/ponylang/ponyc#building-with-link-time-optimisation-lto).
- Building the [runtime as an LLVM bitcode file](https://github.com/ponylang/ponyc#building-the-runtime-as-an-llvm-bitcode-file).

And last but not least, make sure you build a `release` version of the compiler and that your pony binary wasn't compiled with `--debug`.

### Profile it! {#profiling}

Intuitions about program performance are often wrong. The only way to find out for sure is to measure. You are going to need to profile your code. It will help you find hotspots. You can use standard profiling tools like Instruments and VTune on your Pony application. At the moment, we don't have a handy guide to help you interpret the results you are getting, but we have one in the works. In the meantime, if you need help, the [community is waiting to help](https://www.ponylang.io/learn/#getting-help).
