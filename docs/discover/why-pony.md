# Why Pony? {:id="why-pony"}

There's plenty to love about Pony, but more than anything else, what we love most is that Pony makes it easy to write fast, safe, efficient, highly concurrent programs. How? The Pony type system introduces a novel concept: "reference capabilities". [Reference capabilities](https://tutorial.ponylang.io/capabilities/reference-capabilities.html) allow you to label different bits of data based on how that data can be shared. The Pony compiler will then verify that you are in fact correctly using the data based on the labels you provide. Reference capabilities combined with Pony's actor model of concurrency makes for a powerful pairing. Let's dig in and take a quick look:

## Mutable state is hard

The problem with concurrency is shared mutable data. If two different threads have access to the same piece of data then they might try to update it at the same time. At best this can lead to those two threads having different versions of the data. At worst the updates can interact badly resulting in the data being overwritten with garbage. The standard way to avoid these problems is to use locks to prevent data updates from happening at the same time. This causes big performance hits and is very difficult to get right, so it causes lots of bugs.

## Immutable data can be safely shared

Any data that is immutable (i.e. it cannot be changed) is safe to use concurrently. Since it is immutable it is never updated and it's the updates that cause concurrency problems.

## Isolated data is safe

If a block of data has only one reference to it then we call it _isolated_. Since there is only one reference to it, isolated data cannot be _shared_ by multiple threads, so there are no concurrency problems. Isolated data can be passed between multiple threads. As long as only one of them has a reference to it at a time then the data is still safe from concurrency problems.

## Every actor is single threaded

The code within a single actor is never run concurrently. This means that, within a single actor, data updates cannot cause problems. It's only when we want to share data between actors that we have problems.

## Reference capabilities enforce safe data handling

By sharing only immutable data and exchanging only isolated data we can have safe concurrent programs without locks. The problem is that it's very difficult to do that correctly. If you accidentally hang on to a reference to some isolated data you've handed over or change something you've shared as immutable then everything goes wrong. What you need is for the compiler to force you to live up to your promises. Pony reference capabilities allow the compiler to do just that.

If you ask us, that's pretty damn cool and a hell of a reason to give Pony a try.
