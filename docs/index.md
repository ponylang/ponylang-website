---
hide:
  - navigation
  - toc
---

# Pony

An open-source, object-oriented, actor-model, capabilities-secure, high-performance programming language.

[Get Started](learn/getting-started.md){ .md-button .md-button--primary }
[Try It in Your Browser](https://playground.ponylang.io/){ .md-button target=_blank }
[Install](https://github.com/ponylang/ponyc/blob/main/INSTALL.md){ .md-button target=_blank }

## Pony is...

### Type safe

*Really* type safe. There's a mathematical [proof](/media/papers/fast-cheap-with-proof.pdf) and everything.

### Memory safe

No dangling pointers. No buffer overruns. No null.

### Data-race free

Pony doesn't have locks or atomic operations. The type system ensures at compile time that your concurrent program can never have data races.

### Deadlock-free

Pony has no locks at all. They can't deadlock because they don't exist.

### Exception-safe

No runtime exceptions. All exceptions have defined semantics, and they are *always* caught.

### Native code

Pony is an ahead-of-time (AOT) compiled language. No interpreter. No virtual machine.

### Compatible with C

Pony programs can natively call C libraries using the foreign function interface.

## See It in Action

Three actors coordinate a party. `Main` tells `Party` to add friends. `Party` creates a `Friend` actor for each one and sends it an invite. Each `Friend` decides whether to attend and sends back an RSVP. When all responses are in, `Party` prints the guest list.

No locks. No mutexes. No synchronization primitives. The type system handles it.

```pony
actor Party
  let _env: Env
  var _guests: Array[String val] = _guests.create()
  var _expected: USize = 0
  var _responded: USize = 0

  new create(env: Env) =>
    _env = env

  be add_friend(name: String val) =>
    _expected = _expected + 1
    Friend(name).invite(this)

  be rsvp(name: String val, attending: Bool) =>
    _responded = _responded + 1
    if attending then
      _guests.push(name)
    end
    if _responded == _expected then
      _env.out.print("Party guest list:")
      for guest in _guests.values() do
        _env.out.print("  " + guest)
      end
    end

actor Friend
  let _name: String val

  new create(name: String val) =>
    _name = name

  be invite(party: Party) =>
    // friends with short names are too busy
    let attending = _name.size() > 3
    party.rsvp(_name, attending)

actor Main
  new create(env: Env) =>
    let party = Party(env)

    party.add_friend("Alice")
    party.add_friend("Bob")
    party.add_friend("Carol")
```

[Try this example in the Playground](https://playground.ponylang.io/?gist=965abaa0cb468c36d241582768265e29){ .md-button target=_blank }
[More examples](https://github.com/ponylang/ponyc/tree/main/examples){ .md-button target=_blank }

## Pony's Design Philosophy

Pony's philosophy is "get-stuff-done." Every design decision follows a clear priority order:

**Correctness** comes first. Incorrectness is simply not allowed. It's pointless to get stuff done if you can't guarantee the result is correct.

**Performance** is second. Runtime speed is more important than everything except correctness.

**Simplicity** is third. It's ok to make things a bit harder on the programmer to improve performance, but it's more important to make things easier on the programmer than on the language runtime.

This philosophy shapes concrete commitments: a program that compiles should never crash. All semantics are fully defined — nothing is left "implementation dependent." There is no ambiguity — the programmer should never have to guess what the compiler will do. There is no "trust me, I know what I'm doing" escape hatch.

[The Pony Philosophy](discover/pony-philosophy.md) | [Guiding Principles](discover/guiding-principles.md)

## Why Pony?

Pony makes it easy to write fast, safe, highly concurrent programs. The type system introduces *reference capabilities* — labels you put on data that describe how it can be shared. The compiler verifies you're handling data correctly based on those labels. Share only immutable data. Exchange only isolated data. The compiler enforces both. No locks needed.

If you ask us, that's pretty damn cool.

[Read the full argument](discover/why-pony.md)

## Why Not Pony?

We believe in being honest. Pony hasn't reached version 1.0. Breaking changes still happen. The pool of ready-to-use libraries is small. There's no IDE. If your project needs a large ecosystem and stable APIs right now, Pony isn't the right choice today.

But if you see the potential, we'd love for you to give it a try.

[Read more](discover/why-not-pony.md)

## Start Learning

- [Install Pony](https://github.com/ponylang/ponyc/blob/main/INSTALL.md)
- [Tutorial](https://tutorial.ponylang.io/)
- [Reference Capabilities](learn/reference-capabilities.md)
- [Example Applications](https://github.com/ponylang/ponyc/tree/main/examples)
- [Standard Library Documentation](https://stdlib.ponylang.io/)
- [Getting Help](learn/getting-help.md)
