---
date: 2026-03-01T14:00:00-05:00
title: "Pony Networking, Take Two"
authors:
  - seantallen
categories:
  - Development
draft: false
---

Pony's standard library has a networking package. It works. If you're writing a simple TCP server or client, it'll get you there. But if you've ever tried to build something serious on top of it, something with real protocol logic, backpressure that you control, or TLS upgrades mid-connection, you know where the walls are.

I hit those walls years ago at Wallaroo. We ended up forking the standard library's TCP code and writing our own. That experience is where [lori](https://github.com/ponylang/lori) came from.

<!-- more -->

## The notifier pattern

The standard library's networking code uses the [notifier pattern](https://patterns.ponylang.io/code-sharing/notifier). You create a `TCPConnection` actor, and you hand it a `TCPConnectionNotify` object. The connection actor owns the socket, manages the read loop, and calls methods on your notifier when things happen: data arrives, the connection closes, backpressure kicks in.

It looks something like this:

```pony
class MyNotify is TCPConnectionNotify
  fun ref connected(conn: TCPConnection ref) =>
    // we're connected
  fun ref received(conn: TCPConnection ref, data: Array[U8] iso,
    times: USize): Bool
  =>
    // data arrived
    true
  fun ref closed(conn: TCPConnection ref) =>
    // connection is gone

actor Main
  new create(env: Env) =>
    TCPConnection(TCPConnectAuth(env.root),
      recover MyNotify end, "localhost", "8989")
```

For a demo or a simple service, this is fine. You implement a few callbacks, the connection actor handles the rest, and you're up and running. The notifier pattern is good at getting you started.

It's not good at much else.

## Where the standard library's networking breaks down

The notifier pattern is part of the problem, but it's not the whole story. The standard library's networking code has a collection of limitations. Some are caused directly by the notifier pattern. Others are independent design choices that could theoretically be fixed without changing the pattern. But the notifier pattern makes them harder to fix, because you don't own the actor where the decisions are made.

The notifier problem itself is straightforward. Your application logic lives inside a class that's owned by an actor you don't control. A notifier is a class, not an actor. It can't receive messages. If another part of your system needs to tell a connection to do something, to change its behavior based on external state, to coordinate with other connections, the notifier can't participate in that conversation. It's trapped inside the connection actor's callback cycle. You end up routing everything through the connection actor, which becomes a bottleneck and a tangle. That's a direct consequence of the pattern.

The performance story is tangled up with the notifier pattern in a different way. The connection actor controls the read loop. It decides when to read, how much to read, and when your code runs. Under heavy inbound traffic, the connection actor can monopolize a scheduler thread, starving other actors of CPU time. You get some knobs (`received()` returning `false` to yield, a configurable read count), but they're baked into the actor. You could imagine adding better yield control to the standard library's `TCPConnection`, but because you don't own that actor, any solution has to be general enough for everyone. Your application can't adapt the yield policy to its specific needs.

Backpressure is a similar situation. The standard library's `write()` is a behavior, an async message to the connection actor. It silently queues data. If the remote end isn't reading, that queue grows without bound. You get `throttled()` and `unthrottled()` callbacks as advisory signals, but `write()` never says no. It'll happily accept data it can't send until memory runs out. That's not inherently a notifier pattern problem. It's a design choice. But fixing it requires changing the connection actor's internals, and the notifier pattern means you can't.

TLS is where the notifier pattern causes problems directly. SSL in the standard library is a wrapper around the notifier. `SSLConnection` decorates your `TCPConnectionNotify` with an SSL layer. It works for connections that start with TLS, but mid-stream upgrades (STARTTLS, the kind PostgreSQL and SMTP need) aren't supported. The layering goes the wrong direction. SSL needs to be a concern of the connection, not a notifier wrapper, but the notifier pattern pushes you toward wrapping.

At Wallaroo, we were building a distributed stream processing engine in Pony. We needed fine-grained control over connection behavior, per-connection backpressure decisions, and the ability to coordinate connection state with the rest of the application. The notifier pattern couldn't give us any of that. We forked the TCP code and wrote our own.

That fork worked. It solved our problems. But it was a fork, tied to Wallaroo's specific needs and not something anyone else could use. After Wallaroo, I kept thinking about the underlying design questions. What would a networking library look like if it was built from scratch around the idea that your actor should own the connection, not the other way around? I started playing with ideas, sketching out different approaches, trying to figure out which Pony patterns would compose into something clean. Eventually that exploration turned into [lori](https://github.com/ponylang/lori).

I started the project years ago. Got the core idea roughed out and then didn't do much with it. Life got in the way. Other priorities took over. Lori sat there, dormant.

That changed recently. Over the past few weeks, lori has gone from that dormant experiment to the foundation we're building Pony's next networking story on. And the ideas that make it work come from two patterns that, when they come together, solve the problems the notifier pattern can't.

## Two patterns that make lori work

Two patterns come together in lori's design: [Mixin](https://patterns.ponylang.io/code-sharing/mixin) and [Embed and Delegate](https://patterns.ponylang.io/code-sharing/embed-and-delegate). These patterns started in lori and were refined as they found use elsewhere, then documented on the [Pony Patterns](https://patterns.ponylang.io) site. Understanding each one makes the whole design click.

### Mixin: sharing stateful logic through traits

Pony doesn't have mixins as a language feature, but you can emulate them with trait default methods. The trick is abstract getters and setters. A trait defines methods that provide default implementations, and it accesses state through abstract functions that the implementing class must provide:

```pony
trait CounterIncrementer
  fun _current_counter_value(): U64
  fun ref _set_counter_value(v: U64)

  fun ref _increment_counter() =>
    let v = _current_counter_value() + 1
    _set_counter_value(v)
```

Any class that implements `CounterIncrementer` has to define `_current_counter_value()` and `_set_counter_value()`, but it gets `_increment_counter()` for free. The trait provides behavior. The implementing class provides the state it operates on.

This works well for small amounts of shared logic. When the logic grows to hundreds of lines with dozens of fields, the abstract getter/setter ceremony becomes unwieldy. That's where the next pattern picks up.

### Embed and Delegate: the class inside the actor

When shared logic gets large, pull it out of the trait and into a dedicated class. The actor embeds the class as a field and delegates behavior calls to it. A thin delegation trait provides the forwarding code so multiple actor types can reuse it without duplicating the plumbing:

```pony
class Connection
  var _notify: (ConnectionNotify ref | None)

  new none() =>
    _notify = None

  new create(notify: ConnectionNotify ref) =>
    _notify = notify

  fun ref connected() =>
    match _notify
    | let n: ConnectionNotify ref => n.on_connected()
    end

trait ConnectionActor is ConnectionNotify
  fun ref _connection(): Connection

  be connected() =>
    _connection().connected()
```

The `none()` constructor is a Pony-specific trick. Actor fields must be initialized before `this` becomes `ref`, but the class needs a reference back to the actor. The `none()` constructor creates a placeholder that satisfies field initialization. Then in the actor's constructor body, where `this` is fully initialized, you create the real instance.

Notice the word "Notify" in the code. It looks like the notifier pattern, and the resemblance is intentional, but it's doing something fundamentally different. In the standard library's notifier pattern, the notifier is how you specialize an actor you don't own. You hand a `TCPConnectionNotify` to the `TCPConnection` actor, and the actor calls your notifier's methods. The notifier is your application's window into someone else's actor.

Here, `ConnectionNotify` is a communication contract between a class and its enclosing actor. The class lives inside your actor. You own both sides. The "notify" trait isn't specializing a foreign actor. It's giving the embedded class a way to communicate with the actor that contains it.

That distinction is subtle but it changes everything. Your application implements the notify trait to get feedback from the connection class as it drives it. That's the opposite of the notifier pattern, where the connection actor drives your notifier. Here, your actor is in control. The class is a tool it uses, and the notify trait is how that tool reports back.

This separation gives you reuse (multiple actor types can embed the same class) and testability (the class can be tested synchronously without the actor runtime).

## Your actor IS the connection

These two patterns come together in lori's central design principle: your actor is the connection.

In the standard library, `TCPConnection` is an actor. Your code lives in a notifier object owned by that actor. You don't control the actor. You can't add fields to it, define behaviors on it, or integrate it into your application's message flow. The actor is the framework's territory.

In lori, `TCPConnection` is a class. Your actor owns it:

```pony
actor MyServer is (TCPConnectionActor & ServerLifecycleEventReceiver)
  var _tcp_connection: TCPConnection = TCPConnection.none()

  fun ref _connection(): TCPConnection =>
    _tcp_connection

  fun ref _on_received(data: Array[U8] iso) =>
    // your logic here

  fun ref _on_closed() =>
    // your logic here
```

That's Embed and Delegate. `TCPConnection` is the embedded class holding ~1400 lines of connection management (socket setup, read/write buffering, backpressure, SSL, idle timeouts). `TCPConnectionActor` is the delegation trait, ~40 lines of behavior forwarding. `ServerLifecycleEventReceiver` is the callback trait with default no-op implementations for every lifecycle event. Your actor mixes in both traits (Mixin pattern), provides `_connection()` returning its embedded `TCPConnection`, and overrides the callbacks it cares about.

The result: a concrete server actor built on lori is about 17 lines of application logic. All the networking complexity lives in the class. Your actor just plugs in what makes your application different.

But the real win isn't code reduction. It's that your actor is a full participant in Pony's message-passing system. Other actors can send it behaviors. It can hold application state alongside connection state. It can coordinate with other parts of your system through its mailbox, not through notifier callbacks. The connection is part of your actor, not a foreign actor your code is stuck inside.

### What this unlocks

Once you own the actor, a bunch of things become possible that the notifier pattern makes hard or impossible.

**Scheduler fairness with `yield_read()`**. When a connection is flooded with data, its read loop can starve other actors. In lori, your `_on_received()` callback can call `yield_read()`. This sends a self-message (`_read_again()`) and returns from the read loop. Because `_read_again()` is a behavior, the Pony scheduler will process other actors' messages before coming back to yours. You decide the yield policy: every N messages, every N bytes, whatever makes sense for your application.

**Explicit backpressure**. Lori's `send()` is a synchronous method call, not an async behavior. It returns `(SendToken | SendError)`. If the socket can't accept data, you get `SendErrorNotWriteable`. If the connection is down, you get `SendErrorNotConnected`. The library doesn't silently queue data until memory runs out. Your application decides what to do when a send fails: queue it yourself, drop it, close the connection. The `SendToken` you get back is an opaque value that tracks your send. When the data is fully handed to the OS, `_on_sent(token)` fires. If the connection dies with data in flight, `_on_send_failed(token)` fires. Every send gets an explicit outcome.

**SSL as a first-class concern**. Instead of wrapping notifiers, SSL is built into `TCPConnection`. You pick a constructor:

```pony
// Plain TCP
TCPConnection.client(auth, host, port, from, enclosing, ler)

// SSL from the start
TCPConnection.ssl_client(auth, ssl_ctx, host, port, from, enclosing, ler)
```

The rest of your code is identical. For protocols that upgrade mid-stream, there's `start_tls()`:

```pony
fun ref start_tls(ssl_ctx: SSLContext val, host: String = ""):
  (None | StartTLSError)
```

It checks preconditions (connection must be open, no existing SSL, no buffered data that could be poisoned by a man-in-the-middle), creates the SSL session, and runs the handshake. When it's done, `_on_tls_ready()` fires. If it fails, you get `_on_tls_failure(reason)` with a typed reason. [`ponylang/postgres`](https://github.com/ponylang/postgres) uses this for SSL-upgraded database connections.

**Idle timeouts without extra actors**. `idle_timeout()` sets a per-connection ASIO timer. If no data is sent or received for the configured duration, `_on_idle_timeout()` fires. The timer uses a per-connection ASIO event directly. No shared `Timers` actor that could get muted during backpressure and disable your timeouts (which is [exactly what happened](https://github.com/ponylang/lori_http_server/issues/46) with the old approach).

**Structured failure reasons**. When a client connection fails, `_on_connection_failure(reason)` tells you why: `ConnectionFailedDNS`, `ConnectionFailedTCP`, or `ConnectionFailedSSL`. The standard library gives you `connect_failed()` with no reason. Knowing the difference between "DNS couldn't resolve the hostname" and "the TCP handshake timed out" matters when you're deciding whether to retry.

## The ecosystem on lori

Lori isn't theoretical. It's already the foundation for a growing stack of libraries:

- [`ponylang/stallion`](https://github.com/ponylang/stallion) -- HTTP/1.1 server
- [`ponylang/mare`](https://github.com/ponylang/mare) -- WebSocket server (RFC 6455)
- [`ponylang/courier`](https://github.com/ponylang/courier) -- HTTP/1.1 client
- [`ponylang/hobby`](https://github.com/ponylang/hobby) -- web framework (on stallion)
- [`ponylang/postgres`](https://github.com/ponylang/postgres) -- PostgreSQL driver
- [`ponylang/redis`](https://github.com/ponylang/redis) -- Redis client

They don't all use lori the same way. Stallion, mare, and hobby follow the "your actor IS the connection" pattern directly. Your actor embeds the TCP connection class and implements the lifecycle traits. Postgres and redis work differently. They provide a session actor that uses lori internally. Your application talks to the session actor, and the session actor owns the lori connection. You never see the TCP connection class.

But inside that session actor, it's the same embed and delegate pattern. The postgres driver implements the full PostgreSQL wire protocol (authentication, queries, prepared statements, LISTEN/NOTIFY) as a state machine on top of lori's TCP connection, with SSL upgrade via `start_tls()`. No notifiers anywhere in the stack.

These libraries replace the older `ponylang/http` and `ponylang/http_server` packages, which use the standard library's notifier-based networking. The older packages will eventually be retired.

## What's next

Lori isn't done. There's a [comprehensive discussion](https://github.com/ponylang/lori/discussions/199) tracking the gaps between lori and what the standard library provides. The big items still to come:

- **UDP support**, following lori's same two-tier design
- **DNS name resolution**, currently still in the standard library
- **A convenience API** for simple use cases. Lori's core API (class + trait composition) is the power-user interface. Not everyone needs that level of control, and having a simpler notifier-style layer on top would lower the barrier to entry. The irony isn't lost on me. Sometimes the notifier pattern really is the right tool. It's just not the only tool you should have.

Work continues. If you want to follow along, the [lori discussions](https://github.com/ponylang/lori/discussions) are where the design happens.

## About that name

The name "Lori" is an in-joke with an audience of "me". And because I like in-jokes with an audience of "me", I've got one for you.

If you can trace the logic from the problem I started with to the name "lori" and explain the chain, I'll mail you Pony stickers. Real, physical stickers. DM me in the [ponylang Zulip](https://ponylang.zulipchat.com) with your answer so more than one person can win. Not that I think anyone will get it. But if you do, I've got stickers.
