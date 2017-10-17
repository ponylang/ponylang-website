---
date: 2017-10-17T17:52:40-04:00
title: My First Pony
author: "codecabc"
categories:
- My First Pony
draft: false
---

# My First Pony

**Editor's note:**

_This is the 2nd post in our "My First Pony" series. We ask new Pony user's to share their initial impressions. The good, the bad, the ugly and sometimes, and sometimes the factually wrong. We think we can all, as an industry, learn from how we all learn. So sit back and enjoy another issue of "My First Pony":_

## Background & How I discovered Pony?

Me: C#  developer mostly with Unity3D. 4 years professionally.

I think all languages are not equal and the “Good programmers will write good code in any language” is just wrong. Writing code is by itself a difficult task and programmers should welcome any tool/language available at their disposal to help them. When programming, I am only satisfied when my program does what I intended. Yet, when I execute my programs after adding/modifying the code, sometime they happen to crash or have an unwanted behavior -maybe I am a bad programmer after all :) -. 

Writing mostly C# -which I think is a decent language, especially considered its age-, this is often because I forgot to do a null check or handling an exception. When that happen I felt cheated because the compiler could have told me that I forgot to handle those cases and it didn't. Moreover, in most languages the focus on the happy path give a wrong impression on a programmer productivity. Writing a program that works on every edge case can usually take twice more time than writing a program that only works for the easy case. Yet, being able to show something that “kind of work” tend to gave non-programmer unrealistic expectation of an average programmer productivity. 

Anyway, when I started programming a few years ago, I saw the compiler as an angry tool that prevented my code from running. With time I started to see it as a friend that try to protect against myself doing stupid things. This is why I am a deep believer in static type systems too. By encoding more logic into the code, it is easier for me to reason about it and it is easier for the compiler to tell me when I do something wrong. For that reason, I started learning Rust some time ago and while not being fluent in it yet, I really like it. But sometime Rust feel really a bit too low level for my taste and I wish there were a higher level version of it that would trade the “no GC and zero cost abstraction” model for a more productive one (Still I will certainly continue to use Rust for some tasks). Then, while browsing [Github's languages' showcase's page](https://github.com/collections/programming-languages) I stumbled upon Pony which look close enough to that I want from a programming language and decided to give it a try.

To sum up, what is appealing to me in Pony is:

* Strict language with emphasis on correctness.
* Cannot crash (Except when out of memory and doing wild things with FFI).
* Error are part of the type system. Cannot forget to handle exceptions.
* Statically typed.
* Compile to binary, no virtual machine.
* Garbage collected but not a stop the world one, may be easier than Rust to deal with object cycle in memory.
* Seems to have a nice concurrency story, but that is not even the main selling point for me. I tried to learn the basic of the concurrency of the Actor model with Elixir some time ago but the lack of static typing make me lost motivation while the approach in itself seemed really interesting.

## First impression on pony so far:

### Good:

* Syntax is easy to pick up for the most part. The only drawback in my opinion is not using a whitespace sensitive syntax (a la F#). All the "end" statement are noise to me.
* The language have a nice set of features which make me believe a programmer can be quite productive once it master it.
* Compile time seems fine. But I only compiled rather small projects so far.
* The community is really friendly, helpful and open-minded. They will gladly hear what you think of the languages and what you think can be improved.

### Average:

* The "Getting started" documentation is a bit scary. But, it is actually quite easy to get started on Windows (especially since I already had Visual Studio and Windows SDK installed). I wish the playground was more advertised when I started learning the language. Typing "ponylang online" doesn't give a link to the playground but to [this page](http://sandbox.ponylang.org/) which is broken unfortunately. I hope with time an install script or an installer will come so by running it on a fresh install we can have a working pony compiler and tools.
* The dependency management is a bit scary too in my opinion. I have not used pony stable yet but I am not confident about only using a wrapper for Git as a dependency tool would result in a very stable (no pun intended) and robust dependency management tool. I did not see anything about using already compiled libraries too. It may be a problem for commercial projects. Still, the language try to provide a solution to the dependency management problem which is a good thing since I don't think a language can succeed today with poor tooling.
* The standard library documentation is useful but not easy to read. It would be nicer if there was a synthetic view as the top with link to each function. Moreover, a more pronounced delimitation between 2 functions would be easier on the eyes. Be able to fold a function would be a nice addition too.
* The error management seems a bit verbose. While, the basics are here I would like to have functions defined on “Partial type” to avoid boilerplate instead of having to use the full ```try … else … end``` construct.

```pony
    myArray(i)?.or_none() 
    //or 
    myArray(i)?.with_default(...)
``` 

* The language is missing namespace but has qualified import. Both would be neat.
* I would really love to have more sugar and auto-inference into the language. For example, the following code does not compile:

```pony
// Does not compile
let listOfNumbers = List[U32].from([1; 2; 3; 4])
let onlyOdd = listOfNumbers.filter({ n: => n % 2 == 1})
```

we have to specify a part of the type (the input type but not the output type) for the lambda because it is not inferred by the compiler. 

```pony
// Does compile
let listOfNumbers = List[U32].from([1; 2; 3; 4])
let onlyOdd = listOfNumbers.filter({(n: U32) => n % 2 == 1})
```

With the help of extension method a la C# to add methods to type that does not have them by default, it could help reduce the boilerplate in some cases. Maybe Pony can come with a thing to help in that area.
* The error messages are quite good for simple cases, but sometime a bit cryptic when mixing reference capabilities, generic and aliasing. An – explain option to the compiler to have an explanation of the issue with the possible solution would surely help beginners.

### Bad:

* The tutorial is sometimes hard to follow. Often it uses a notion before introducing it later on. It could be better to introduce upfront the things that are easy to pick up for newcomers and leaving the more advanced stuff for later. In that regard, it is a bit odd that reference capabilites come before pattern matching. Plus, I wish the ribbon the left had one more level for titles. It would make the tutorial more easy to browse. I often had trouble to find things in the tutorial because I did not even know where to look for. As an example, It would be obvious that the lambda's paragraphs is in the  "Object Literals" section rather than in the "Methods" one. The tutorial lacks examples in some place too. Often, it explains something without showing a bit of code. Finally, a button that load the sample on the playground in a new page would be a nice addition to experiment with the language.
* The collection is API is confusing. Some methods only exist for List while other are only for collections/persistent and Array have often not much in comparison. Loving LINQ, Pony has quite a bit to catch up in this area. Moreover, I did not understood if Array is a primitive type and can be used directly with FFI (for example using an Array[U8] as a parameter of a C function expecting a char pointer). While this can be understood since the language and the ecosystem is not mature yet, the tutorial could tell a bit more about it. Especially, List and Map are so commonly used that any non trivial project (even toys one) would need them. So a brief introduction to those 2 types in the tutorial would be a nice addition too.
* I don't think there is an auto-completion tool available for any IDE/Text editor yet. But this is quite understandable and I didn't miss it too much.

## General opinion about the language so far:

* I like what pony offer and I hope it will gain more traction and continue to grow. It seems that is quite alone in the space it fills (a compile to native, actor model, with emphasis on correctness, language). So far I have just started learning it and continue to do so. I have no specific goal with it, except enjoying my journey and learning a few things along the way. I don't know if I would recommend anyone to write a lot of pony code just now for anything serious because I think breaking changes can happen in the language and there are some rough edges in the ecosystem here and there. Still, Pony worth a look since it differs quite a bit from mainstream languages and newcomers will probably learn more with it than most other languages.

