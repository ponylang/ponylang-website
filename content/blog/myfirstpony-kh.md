---
date: 2017-07-09T16:55:40-04:00
title: My First Pony
author: kevinhoffman
categories:
- My First Pony
draft: false
---
This weekend I found myself with a couple of spare hours available to squeeze in between some yard work and making sure the baby is still alive and fed. Typically, I would use this time to play with _Go_ or continue my love/hate learning relationship with _Rust_. This weekend, I decided to play with _Pony_.

## I'm Prejudiced and I Admit it
The best way to get over our prejudices is to admit them. I readily admit that anytime I see someone talking about a new language with an _Actor Model_ implementation, I roll my eyes and think "YAAM" (Yet Another Actor Model).

I've done extensive work with the Actor model in Scala and Akka, and have built some basic apps in Elixir/OTP, and have used actor-like implementations like Channels in Go, and even toyed with a few "actor native" languages that no longer exist.

So, in a deliberate effort to overcome this admitted bias, I asked on Twitter if anyone had any reason to believe that Pony was more than just "Yet Another Actor Model". I mean, if I can already code in Elixir, why would I use anything else?

I've been unable to track down the quote for attribution, but there's a phrase floating around that goes something like, "..._any sufficiently distributed system will eventually be thrown away and re-rewritten in Erlang_..."

## Hello, Pony
After getting some inspiring replies on Twitter from **@ponylang** and the Pony community, I decided to give it a go. I started reading. 

While walking around the house picking up after the tornado of toys my daughter leaves, I read through the tutorials and other getting started guides on my phone.

I think the documentation could use improvement, but if this is the biggest problem a language has, then things are looking good. Documentation is easy to fix, bad language design isn't.

I opened up **vi** (don't judge me) and created my first **main.pony** file that printed "Hello World."

As an author, I am intimately familiar with how utterly useless "Hello, World" is to the real world, but how essential it is to the learning experience. Without any autocomplete, I was about to guess my way through the first build, and I expected it to fail _spectacularly_. To my surprise, nothing failed!

Everything seemed pretty intuitive, but I hadn't gotten into anything complicated yet.

## Features that Intrigued Me
When you approach a new language, there are usually a couple of "wow!" moments. You'll be reading along in a sample or some documentation and you're getting bored. Then, all of a sudden, something catches your eye and you think "that's pretty cool". 

If you have enough of those moments, you might continue learning. If you don't, you walk away with your tail between your legs and go back to your old standby languages.

Things that stuck out during my first weekend with Pony:
* Compilation to a single, statically-linked binary
    * This was __huge__. Any language positioning itself near Go needs to have this or it's a non-starter.
* Generics
* Strongly-typed, generics-aware Actors (more on this in a bit)
* Reference Capabilities
* Pattern Matching
* Classes - as a **gopher** and a learner of **Rust**, I initially saw this as a negative. I had to struggle to keep my mind open on this.
* Structural types (e.g. go-style interfaces)
* Traits that can carry default implementations (like Rust or Scala traits)
* Partial application, anonymous functions, lambdas, etc.
* No data-races

As I mentioned, I've been learning **Rust**. Rust promises a lack of data races and safe memory utilization. It does so through the _borrow checker_, an entity I consider my arch nemesis. After weeks of spending my spare time in Rust, I still hate that damn thing and building _anything_ in Rust feels very high-friction.

I was skeptical of Pony at this point - surely a language as safe and fast as Rust must be hell on the developer?

Thankfully, I was wrong.

## But... Akka!?
I've written a number of applications still running in production today that were based on Akka. I presented at ScalaDays on multiplayer gaming with Akka as a backend. I was, and still am, a huge fan.

This contributes to my eye-roll when I hear "actor model". I just assume someone is re-inventing the wheel as a square and want to move on.

Akka's actors and Pony's actors share similar inspiration, but they aren't the same thing. There is no overarching actor system that I can globally manipulate, nor is there an underlying assumption that actors and messages can travel between nodes in a grid. This feels more like an actorized formalization of asynchronous, _in-process_, message processing and execution than a full-on distributed actor mesh.

I'm sure others will argue, but I think Akka is geared at solving a different problem.

For those who've used Akka, keep this in mind: Pony has generic-aware, strongly-typed actors that _don't suffer from type erasure_!

No JVM _and_ I get generics and Actors? Sign me up!

## But... Go!?
There's always room for *Go* in our lives, and anyone who says different is lying. I love Go, and people will pry my golang from my cold, dead hands. That said, I'm also a polyglot and believe strongly in using the best tool for the job. Under the definition of "best" we often find _developer productivity_.

I can honestly say that I reached a point in 6 hours of working with **Pony** (while distracted by a toddler) that I have _never_ reached in _any_ other language. Period. And I've learned a metric crap-ton of languages.

## Building a TCP Chat Server
When learning a new language, I used to always ask myself: _can I write a game in this_? Somewhere along the way, programming stopped being fun and I stopped asking myself that. Call it burnout, I suppose. Go made programming fun again for me.

When I read the Pony docs, I started getting that same inspired feeling I got from Go again. So I asked myself, _Could I write a [MUD](https://en.wikipedia.org/wiki/MUD) in this?_ (If you don't know what a MUD is, I'm old enough to be your ancestor).

Remember, I'm still only about 3 hours into my Pony experience, so I expected this to go _horribly_ wrong. I adapted the **TCPListener** sample from the [examples directory](https://github.com/ponylang/ponyc/blob/master/examples/net/server.pony) to suit my needs.

I started by emptying my **main.pony** file of everything except the main actor. I don't know if this is idiomatic Pony or not, but as a **gopher** I like my main files clean:

```pony
use "net"

actor Main
  new create(env: Env) =>
    try
      let cm = ConnectionManager(env.out)
      TCPListener(env.root as AmbientAuth, Listener(env.out, cm))
    else
      env.out.print("unable to use the network")
    end
```

This is basically a bootstrapper to start up my `Listener` class. I don't want to suck up blog post space with all the code as you can see it all in my [github repo](https://github.com/autodidaddict/ponychat).

One of the more important bits of the `Listener` class is here:

```pony
fun ref connected(listen: TCPListener ref): TCPConnectionNotify iso^ =>
    Server(_out, _cm)
```

When the TCP listener tells my class that someone connected, it returns a new `Server`. These things are `iso`, so _there can only be one_ of them (The Pony team may have missed an opportunity to call `iso` someting like `highlander` instead). In the sample above, `_cm` is an actor I created to hold the list of all connected clients.

Because actors are passed around as opaque tags, I don't have to worry about transmitting references to them (this is a _huge_ advantage, with subtle but powerful consequences). It was looking at how to send messages to actors, and the use of `consume` and `recover` and `tag` that I started to get my first appreciation for how amazing the reference capabilities system is (and how much more reading I need to do on it).

I put my connection manager actor in its own file. My favorite part of this actor is this one line of code, declaring the `_players` variable:

```pony
let _players: MapIs[TCPConnection, Player]
```

Tags can be compared with the `is` keyword. This means that every instance of every actor in the system can be compared for equality, _regardless of the alias holding that reference_. Again, _this is huge_. As someone who lost many hair follicles working with Akka, I love this.

`MapIs` (thanks to the folks on the IRC channel for this tip) lets me _directly_ map `TCPConnection`s (they are actors!) to players (also actors). You can think of the `_players` variable as a tag-to-tag mapping. Tags are the least burdensome of things to reference and send.

So now when I get a notification that text came in from a particular connection, my connection manager knows how to dispatch that text to a player for input parsing:

```pony
be cmdreceived(conn: TCPConnection, cmd: String) =>
    _out.print("[CM] received command text.")
    try 
        _players(conn).parsecommand(cmd)        
    end 
```

With some really useful help from the community and digging through docs and experimenting in the [Pony playground](http://playground.ponylang.org/), I was able to get a fully functioning multi-user telnet chat server running in Pony. It took me twice as long long to do that with my first exposure to Java a few centuries ago, and the code was exponentially more ugly.

This little bit here was so satisfying to do after just a few quick hours of learning:

```
$ telnet localhost 53598
Trying ::1...
Connected to localhost.
Escape character is '^]'.
Kevin
You've chosen a name.
Kevin has logged in.
Hello!
[Debug] You typed Hello!.
Kevin typed 'Hello!'
```

## Summary
After just a weekend (and only a few hours of it, really) with Pony, I am _hooked_. I now have a hobby backlog of a dozen projects I'd like to try out with Pony, and I'm probably going to continue messing with my chat sample to see how far down the rabbit hole I can go before I run into high-friction areas of the language.

A friend of mine once said you can't really call yourself a (insert language here) programmer unless you can name 3 things you hate about it.

So my new goal is to keep playing with Pony until I find something I don't like about it... and then see if I can fix it :)