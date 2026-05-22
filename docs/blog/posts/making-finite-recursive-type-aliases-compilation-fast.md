---
date: 2026-05-21T21:00:00-04:00
title: "Making Finite Recursive Type Aliases Compilation Fast"
authors:
  - seantallen
categories:
  - ponyc
  - Finite Recursive Type Aliases
draft: false
---

This is the third post in a short series on finite recursive type aliases in Pony. The [first post](/blog/posts/eleven-years-to-a-finite-recursive-type-alias.md) told the story of the eleven years it took to allow them. The [second post](/blog/posts/meet-tarjans-scc.md) laid out the algorithm that decides which recursive aliases are legal.

That algorithm is correct. Correct isn't enough. Past a certain size, a tangle of type aliases that all refer to each other sent the compiler's type checker into exponential work. Slow at first. Then, on a bigger tangle, eleven minutes of churning with no end in sight. The compiler wasn't rejecting these programs — the algorithm accepts them. It just couldn't finish checking them in any reasonable time.

<!-- more -->

## The cycle matcher

The checking that wouldn't finish begins with the subtype check, the workhorse of type-checking: given a value of one type and a slot that requires another, it tests whether the first can be used as the second. Hand a `String` to something that requires `(String | None)` and the check finds `String` among the arms of that union: usable, done. A handful of rules settle the common cases on the spot.

Recursive type aliases can stress the subtype check in a way the common cases don't. A recursive alias is defined in terms of itself, so instead of settling, the check descends into its structure and comes back to the same type it started on. `JsonValue`, the type of an arbitrary piece of JSON, is one:

```pony
type JsonValue is
  (String | F64 | Bool | None | Array[JsonValue] | Map[String, JsonValue])
```

One of its arms is `Array[JsonValue]`, so the type is written in terms of itself. To test whether one `JsonValue` is a subtype of another, the check compares their arms. It reaches `Array[JsonValue]`, and comparing that means checking `JsonValue` against `JsonValue` — the test already underway. Compare the arms, reach `Array[JsonValue]`, start over. Nothing stops it.

The escape is to assume what you're trying to prove and back out only on a real contradiction. When the check on `JsonValue <: JsonValue` comes around the second time, it doesn't descend again; it takes the result as true and moves on. A cycle that never turns up a contradiction is one that holds. That's co-induction, the standard way to make a subtype check terminate on a self-referential type.

Making co-induction work means keeping track of which checks are in progress. The compiler keeps them on a stack — the assumption stack. Starting a subtype check on a pair `(S, T)` pushes the pair; finishing it pops the pair. Before each new check descends, the compiler scans the stack for the same pair — a check on the same `(S, T)` already in progress. If the pair is there, the check has hit a cycle, and it returns true instead of descending again. That lookup — matching the new check against the ones already on the stack — is the cycle matcher. It runs on every subtype check, and the rest of this post turns on it.

The subtype check already worked this way before recursive aliases. Pony has had self-referential types through classes and interfaces for years. Recursive aliases made other type operations recurse too — type equality, viewpoint adaptation, and others — so they needed the same handling. Adding it made recursive aliases terminate, and that was straightforward. The performance was not. In the cycle matcher, the cost grew fast once a recursive type got large.

## The reproducer

To measure the blow-up I needed a knob to turn, and mutual recursion among aliases is the knob.

Start from that same JSON type, but split it into three aliases instead of one:

```pony
type JsonValue is (String | F64 | Bool | None | JsonArray | JsonObject)
type JsonArray is Array[JsonValue]
type JsonObject is Map[String, JsonValue]
```

Same type, just spread out. `JsonValue` mentions `JsonArray` and `JsonObject`, and both mention `JsonValue` back. The three form a cycle: start at any one, follow the references, and you come back where you began. Draw the aliases as nodes and the references as arrows, and the cycle is a self-contained loop. A maximal set of nodes that can all reach each other is a strongly connected component — an SCC. These three aliases are one SCC, size three.

The reproducer makes SCC size a parameter. SCC-N is N aliases wired into a ring, each pointing at the next through an `Array`, the last pointing back to the first. All of them legal. SCC-3 is the JSON shape, SCC-4 adds an arm, and so on up.

Before any perf work, performance fell off a cliff as the ring grew:

- SCC-3: compiled in about 39 seconds.
- SCC-4: still running when I killed it at 90 seconds.
- SCC-50: still running when I killed it at eleven minutes.

These programs are finite and legal — exactly the recursive type aliases ponyc should compile. One more alias between SCC-3 and SCC-4 turned a slow compile into one that didn't finish.

## The matcher was running the subtype check

Looking down a stack for a matching pair sounds cheap. It wasn't. The matching itself was expensive.

A subtype check works on a pair of types, and a type carries type arguments — the `JsonValue` inside `Array[JsonValue]`, say. To find whether the pair about to be checked matched one already on the stack, the cycle matcher (a function named `is_assumption_match`) compared their type arguments. It compared them by calling `is_eqtype`, the compiler's test for whether two types are equal.

That is the trap. `is_eqtype` is not a cheap, local comparison. Computing whether two types are equal runs the full subtype check — and the subtype check pushes a pair onto the assumption stack, scans the stack, and runs the cycle matcher on every entry. Which calls `is_eqtype`. Which runs the subtype check again.

So the cycle matcher, the step that bounds the subtype check, was running the subtype check to do its comparison. On a single self-referential type it doubled back on itself a handful of times, too few to notice. On a ring of aliases that all point at each other, every level of the ring multiplied the work of the level beneath it. I instrumented the smallest ring to count the calls. At SCC-3 (three aliases) the matcher was entered around twenty-five million times, and ten million of those entries ran back out through `is_eqtype` into a fresh subtype check. One alias more, and SCC-4 didn't finish.

The fix came from seeing that the matcher was doing more work than it needed. To break a cycle, you don't need to know whether two checks mean the same thing. You need to know whether they're the same check — the one already on the stack. Working out whether two types mean the same thing is exactly what `is_eqtype` does, and that's the expensive part. Checking whether they're the same check is a structural comparison: same node kind, same definition, same type arguments, settled without calling the subtype check at all.

So I replaced the `is_eqtype` call with that structural comparison, recursing into type arguments the way the matcher already walked unions, intersections, tuples, and arrows. It is conservative. Two checks that mean the same thing but are written differently won't be spotted as the same check, so the recursion takes one extra step before it stops. That is harmless. The matcher has to stop the loop; it doesn't have to stop it at the first possible point.

After the swap:

- SCC-3: about 39 seconds down to 1.0.
- SCC-4: from never finishing to 1.1 seconds.
- SCC-50: still didn't finish inside 90 seconds.

SCC-3 fell by more than an order of magnitude. SCC-4 went from not compiling to fast. SCC-50 was still broken, and the rest of the subtype work — a cache — is the next two sections.

## The cache

The matcher fix took out the worst of the blow-up, but the reproducer was still slow at larger sizes, and the reason was repeated work. Checking whether two generic types are equal, `is_eq_typeargs`, compares their type arguments in both directions — `A` against `B`, and `B` against `A`. Each direction is its own subtype check, and the two overlap heavily. They descend through the same nested types and re-run the same comparisons on the way down. A single small check — whether this type is a subtype of that one — gets computed over and over inside one top-level check, once for every path that reaches it.

The fix is a cache. Inside a single top-level subtype check, `subtype_cache` records the result of each small check the first time it runs, and returns the stored result on every repeat after that. It's a per-thread hashmap, keyed by the three things that pin down a check: the two types and the capability they're checked under. Pony types carry a reference capability, and subtyping depends on it. The key is `(sub, super, check_cap)`. A small scratch buffer builds those keys so a lookup doesn't allocate. The repeated checks collapse to one computation each.

Most of the module isn't the lookup; it's making the lookup safe to do. Not every result is unconditional. When a small check came out true only because it matched a cycle already on the assumption stack, that result holds only while that same assumption is still on the stack. Store it, then read it back later in a different part of the tree where the assumption is gone, and the result would be wrong. So the cache lasts only as long as one top-level subtype check: it's cleared each time a check starts fresh at the top, with the assumption stack empty, which is exactly the moment those cycle-dependent results stop being valid. And any check that emits an error skips the cache going in and coming out, so an error message is never lost to a cache hit.

After the cache:

- SCC-12: about 5 seconds down to 1.2.
- SCC-50: from not finishing to about 16 seconds.

## The cache doesn't close the gap

`subtype_cache` bounds the pathological case. It doesn't speed up the common one. On stdlib the hit rate is 1.5%; across subtype-heavy synthetics and mutually-recursive alias networks it runs 1 to 5 percent. Ordinary code doesn't produce these repeated checks. Recursive alias networks do, and that's the case the cache is built for.

Even for them, it doesn't close the gap. SCC-50 lands at about 16 seconds, over the 10-second bar I wanted for shipping. Closing the rest needs a second cache, on `typealias_unfold` — the routine that expands an alias reference into the type underneath it — and I parked that for a follow-up rather than grow the recursive-alias change any further. For any recursive alias a person would actually write, the cliff is gone. For a fifty-alias adversarial ring, it's farther off but still out there.

## An exponential depth-first search

That's the subtype side. The other part is the legality pass, the compiler pass that runs the legality algorithm and accepts or rejects each recursive alias. It had its own blow-ups, in code the subtype work never touched.

One of its rules is about where the recursion sits in an alias's body. Recursion that passes through a class like `Array` is fine — the contents live behind a pointer, so the value has a fixed size. Recursion straight through a union arm is not, because a value of that type would have to contain itself with no pointer in between, and nothing finite can. The pass builds a graph of the no-pointer references and searches it for a cycle. A cycle there is an alias whose value can't be laid out in memory, and it's rejected. (The [second post](/blog/posts/meet-tarjans-scc.md) has the full rule and the cases it covers.)

My first version of that search, in `check_base_cases`, marked only the nodes on the current DFS path — the route from the start node to where the walk is right now. It kept no record of the nodes it had already finished with. So a node reachable by two different routes had its whole subtree walked twice, once for each route, and a node reachable by many routes was walked many times over. On a dense graph — an ordinary sum-type modeling shape, with lots of aliases pointing at a handful of common ones — that compounds into 2<sup><em>V</em></sup> time. About 52 seconds in the legality pass alone at thirty-two aliases.

The fix is the standard three-color DFS. A node is white before it's visited, gray while it's on the current path, and black once its whole subtree has been walked. Black nodes are skipped instead of walked again. That takes the search to linear time, O(*V* + *E*), per component. The same search builds the alias path printed in the error message, so it got the same treatment.

## Three linear scans

With the blow-up gone, the next bottleneck showed up. A profile of a 100,000-alias illegal ring found three linear scans, all the same shape: a search through a list to find one entry by identity, sitting inside a loop that runs over the whole graph. Quadratic, and on a graph that size it dominated everything.

- About 62% of the time was in `node_for_def`, a scan to find the graph node for a given definition, run while collecting edges.
- About 25% was two more scans, one in `find_cycle_path` and one in `check_base_cases`, each looking through a component for a particular node.
- Together, 87% of a 14.5-second compile.

Two fixes for the one shape. `node_for_def` became a hashmap from definition to node, built once after the nodes are allocated and torn down with the graph; the scan became a lookup. The other two scans were searching a component's member list for a node, so each node got an `scc_pos` field recording its own position, filled in while the components are grouped. The search became a single read.

The illegal ring dropped from 14.5 seconds to 2.2, about six and a half times. What's left in the profile is the AST walking the pass can't avoid.

## Iterative Tarjan

The legality pass finds the alias cycles with Tarjan's algorithm for strongly connected components. Tarjan reads naturally as a recursion: visit a node, recurse into each neighbor, and the call stack holds the path back to the start. My first version was written that way, one C-stack frame per node on the path. A 130,000-link alias chain — one alias pointing at the next, in a single line that long — is a path 130,000 nodes deep, so the recursion ran 130,000 frames deep, overflowed the C stack, and crashed the compiler.

The fix is the iterative form of the same algorithm. The path that lived in C-stack frames moves onto two heap-allocated stacks, one for the component being built and one for the depth-first walk, each bounded by the number of aliases and free to grow as far as memory allows. Same algorithm, different bookkeeping.

A 130,000-link chain is pathological. No human writes one. But pathological is a word people use to defer fixing things, and a compiler that crashes on pathological input still crashes on input.

## Five fixes, no single shape

The matcher fix was a couple of days of being wrong about what the cycle matcher was doing, then a small change once I saw it. The cache was weeks of soundness reasoning that barely shows in the code. The three-color DFS, the hashmap, and the iterative Tarjan went in fast once a profile showed where the time was going. No single shape to any of it.

These weren't the only kind of commit. Plenty of others were threading one new fact through dozens of files, or backing out of an approach that didn't pan out, or arguing over the wording of an error message. But a real chunk of the seventy-nine were these: the work to make a correct algorithm cheap enough to compile the programs people will actually write.
