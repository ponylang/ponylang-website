---
date: 2017-05-06T10:55:40-04:00
title: An Early History of Pony
author: sylvan
description: foo
categories:
- History
draft: false
---
Sean T. Allen says I should write an early history of Pony. He says people might be interested. He's generally right about this stuff, but I feel a bit awkward about the process. I know I will forget things, or worse, forget people. Fortunately, Sean gave me an outline on Slack based on stuff I've told him, so here goes.

## Sean: You’ve told me this story many times.

I had been telling friends for years that I would eventually write a programming language. Way back when (starting in 2001), I had written a flight simulator engine that I worked on for years. I ended up building an asynchronous message queue system for doing the physics simulation end of it. And struggling with memory bugs, of course.

When the flight sim company folded in 2010, I went to work for a financial market data company. I was still thinking a lot about the flight sim, and about other systems, I had worked on over the years (embedded operating systems, distributed cryptographic systems, peer-to-peer VOIP, that kind of stuff) and yet again I was struck by how many of the same problems kept cropping up.

Anyway, I spent a lot of time reading academic papers at this point. A lot of time. Papers on type systems, on garbage collectors, on distributed schedulers, back to type systems, that sort of thing. Interestingly, a research group called SLURP (Sound Languages Underpin Reliable Programming) at Imperial College London was connected to a lot of the papers; particularly Professor Sophia Drossopoulou.

I also chatted a lot with Thomas Munro, Harry Richardson, and Andy McNeil. Andy worked elsewhere, but Thomas and Harry were at the same financial market data firm. I didn't stay there very long.

## Sean: C based actor library. Goes vroom.

It totally went vroom. In 2011 I started working for a major investment bank, running their European electronic trading infrastructure team. I had two of the best contractors ever (Alex and Albert) and we built up a great team in London. The point of this part of the story is that while we did a bunch of different stuff, one of the main things we did was write infrastructure code for low-latency (a few microseconds) high-throughput (hundreds of thousands of messages per second) applications.

As part of this, I decided to write a library for writing actors in C. I used some fast queues based on Dmitry Vyukov's work, wrote a work-stealing scheduler, had complex macros for writing behaviour handlers, that sort of stuff. Other teams used it to deploy some high-performance applications, and it was really fast.

## Sean: Why did that not work?

Because C. And C++ too, of course - the application level code was generally written in C++. Over and over again, programmers ran into memory errors. And not just the usual problems with dangling pointers (premature free) and leaks (postmature free?) but persistent problems with data-races.

Programmers would send a pointer from one actor to another, convinced that it was safe, and it would turn out it wasn't. Sometimes they would then add non-message-passing based synchronisation (locks, lock-free algorithms, etc.) to the data types. This usually resulted in subtle deadlock conditions (which often only appeared occasionally under high load on production systems), but even when such bugs weren't encountered (which is different from saying they weren't there) there was a performance cost. And that was not good.

## Sean: This is not so good.

Yeah, exactly. While we could squeeze a lot of performance out of these systems, we weren't gaining productivity. We weren't really losing productivity either, of course, compared to programming with thread pools, work-bucketing, and synchronisation primitives, but the frustration of having what appeared to be an actor-model program die on memory problems was pretty severe.

## Sean: This could be so much better!

Yeah, exactly! I started spending my free time thinking about type systems. I had a feeling that it would be possible to express the actor memory isolation guarantees to prevent data races using some kind of type annotation.

The C actor library did message passing without making copies. Usually, actor-model languages make copies, like when Erlang sends a message. Using ahead-of-time compiled native code was important for performance, sure, but to be faster than existing C/C++ multithreading approaches, we couldn't spend all that time copying messages. This is of course what lead to the data races.

It also leads to the memory leaks and dangling pointers, of course, with confusion about which actor should be responsible for freeing some data. I experimented with reference counts but ran into the usual problems with performance (too many reference count updates) and restricted object graph shapes (no cyclic object graphs).

## Sean: A LANGUAGE.

Ok, sure, a language. But _never_ write a programming language. That's like rule #1. Everybody will just tell you it isn't needed and then argue about syntax.

Besides, so much of what I wanted was already available in C: an ahead-of-time optimizing native-code compiler, for example. I had been looking at compiler back-ends like C-- for some time, but around this time I started working with LLVM. We used LLVM at the investment bank to write a statically-typed ahead-of-time compiled Lisp variant that did no memory allocation (no really, there are some compelling use cases for that, strange as it sounds). In fact, I even managed to hire Harry and Andy, and Harry did all the real work on the Lisp thingy.

But then, so much wasn't available. Particularly a data-race-free type system and a garbage collector. I had been trawling through the literature for a while, and while I found some _brilliant_ stuff, nothing was quite what I wanted. A lot of stuff was very influential, but not quite exactly what I was looking for.

## Sean: Imperial.

Right, Imperial College London. I went back to school. Or rather, I started a Ph.D. program at Imperial, with Sophia Drossopoulou as my advisor. I was still working at the investment bank, so I did the Ph.D. program part-time. I had realised I would never be able to prove to myself that the type system and garbage collector ideas floating around in my head were sound unless I learned some formal skills.

## Sean: WHEEEE THIS IS FUN!

Super fun! Wow, amazing fun. Sophia taught me formal skills and we worked together on proving stuff sound. We did GC papers, type system papers, everything was coming together, it was fantastic. But my day job was still C/C++ on top of the C library.

Then I met Sebastian Blessing. Seb was doing a Masters at Imperial, and when Sophia and I advertised for a Masters student to do a project on extending our ideas to distributed computing, he jumped at it. And he did an amazing job.

But Sebastian went much further than that. He wanted a compiler and runtime to exist, and he thought the best way to do that was to start a company. A company that could build the compiler and runtime, and then offer commercial support. And the amazing part is, he made it happen.

So we started a company called Causality: Sebastian, Sophia, Constantine Goulimis, and me. I quit my job at the investment bank, and we even hired Andy, which was great, although for various reasons, not Harry, which was not great.

## Sean: A language is born to leverage the awesome of this runtime over here.

That's right! We did it. We built the thing. We started in June 2014 and by September 2014 we compiled and ran our first Pony program. The compiler and runtime improved, and in May 2015 we open sourced the whole thing.

When we did, I sent Sean a note telling him that I had built a thing. He wrote back. That turned out to be a _really_ big deal. Really big.

We continued to do research at the same time, refining the type system and the various runtime protocols. Juliana Franco started doing some of her Ph.D. work around the Pony garbage collector. Two more Imperial students, George Steed and Luke Cheeseman, did extensive projects. Tobias Wrigstad and Dave Clarke made the decision to base _their_ language, Encore, on the Pony runtime.

Unfortunately, a start-up based on a programming language is a notoriously bad idea. I'm not saying it's impossible - but there isn't a great track record for them, and unfortunately, Causality went the same way.

Fortunately, by then, we had a fantastic open source community. Sean Allen, Joe Eli McIlvain, Benoit Vey, Theo Butler, Perelandric, Reini Urban, Gordon Tisher, Dipin Hora, Jonas Lasauskas, John Mumm, Andy Turley, George Marrows, Darach Ennis, Tommy McGuire, Carl Quinn, Malthe Borch, Kevin Cantú, Markus Fix, Chris Double, Dan Connolly, Paul Liétar, and many others.

So now I work at Microsoft Research in Cambridge with some of the most amazing people I've ever met in my life, and I work on an open source programming language with some of the most amazing people I've ever met in my life, and hopefully we will continue to make great tools that great people want to use to do great things.

## Sean: To help.

Yes, literally that.

## Sean: May the pony be with you.

And also with you.

## Sean: The big reveal on why it's called "Pony"?

Back in the flight sim days, when I would make my friends groan by telling them yet again about all the things I was going to do when I wrote a programming language, one of the people I would tell was Nathan Mehl. And one time, when I gave him yet another laundry list, he said: "yeah, and I want a pony".

Also, Harry likes horses.
