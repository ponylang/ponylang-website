# The Pony Philosophy

In the spirit of [Richard Gabriel](http://www.jwz.org/doc/worse-is-better.html), the Pony philosophy is neither "the-right-thing" nor "worse-is-better". It is "get-stuff-done".

## Correctness

Incorrectness is simply not allowed. _It's pointless to try to get stuff done if you can't guarantee the result is correct._

## Performance

Runtime speed is more important than everything except correctness. If performance must be sacrificed for correctness, try to come up with a new way to do things. _The faster the program can get stuff done, the better. This is more important than anything except a correct result._

## Simplicity

Simplicity can be sacrificed for performance. It is more important for the interface to be simple than the implementation. _The faster the programmer can get stuff done, the better. It's ok to make things a bit harder on the programmer to improve performance, but it's more important to make things easier on the programmer than it is to make things easier on the language/runtime._

## Consistency

Consistency can be sacrificed for simplicity or performance.
_Don't let excessive consistency get in the way of getting stuff done._

## Completeness

It's nice to cover as many things as possible, but completeness can be sacrificed for anything else. _It's better to get some stuff done now than wait until everything can get done later._

The "get-stuff-done" approach has the same attitude towards correctness and simplicity as "the-right-thing", but the same attitude towards consistency and completeness as "worse-is-better". It also adds performance as a new principle, treating it as the second most important thing (after correctness).
