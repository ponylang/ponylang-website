---
date: 2026-04-03T07:00:00-04:00
title: "Persistent Data Structures for Concurrent Programs"
authors:
  - seantallen
categories:
  - Development
draft: false
---

In my [last post](pony-gets-a-new-json-library.md), I mentioned that the new `json` package uses persistent data structures under the hood. Every `JsonObject` is backed by a CHAMP Map. Every `JsonArray` is backed by a HAMT Vec. I glossed over why, and I want to fix that.

<!-- more -->

This is a story about data structures, concurrency, and what happens when the two actually get along.

## The problem with mutable data in a concurrent world

The original standard library `json` package was built around a mutable tree. You'd parse some JSON, get back a bunch of objects and arrays backed by regular mutable `Map` and `Array` types, and then you'd want to share the result between actors. That's when the trouble starts.

In Pony, mutable data is owned. A `ref` reference means "I can read and write this, and nobody else can." If you want to send that parsed JSON to another actor, you have two options, and neither is good. You can make the whole thing `iso` (unique ownership), which means you surrender it entirely when you send it. The parsing actor no longer has access. Or you can copy the entire structure into something immutable. For a big JSON document, that's a lot of copying.

This isn't a Pony quirk. It's the fundamental tension of concurrent programming. Mutable shared state is where bugs live. Every language deals with this, usually with locks or by giving up and copying everything. Pony's reference capabilities make the compiler enforce the rules instead of hoping programmers follow them. But that enforcement has teeth. If your data structures don't play nice with the capability system, you spend your time fighting the compiler instead of writing your program.

Persistent data structures sidestep all of it.

## What "persistent" means here

The word "persistent" in this context has nothing to do with databases or disk storage. A persistent data structure is one where every version of it is preserved. When you "update" a persistent map, you get back a new map. The old one still exists, unchanged. Both the old and new versions are valid, usable values.

The naive way to do this is to copy everything on every update. That would be correct but absurdly expensive. The trick that makes persistent data structures practical is structural sharing: the new version shares as much of the old version's internal structure as it can. Only the parts that actually changed get new nodes. Everything else is reused.

In Pony, a persistent data structure is naturally `val`. Globally immutable. No actor anywhere can modify it. You can send it to fifty actors simultaneously, and each gets a reference to the same underlying data. No copies, no locks, no synchronization. The compiler guarantees it's safe.

## Tries all the way down

Both the CHAMP Map and the HAMT Vec are trie-based. If you haven't encountered tries outside of autocomplete implementations, the core idea is simple: instead of storing data at a single location determined by a hash or index, you use the hash or index as a path through a tree. Each level of the tree consumes a few bits, branching into children.

For our purposes, both structures use 32-way branching. Each level consumes 5 bits (2^5 = 32). A 32-bit hash gives you 6 levels of trie before you run out of bits. That means lookups traverse at most 6 or 7 nodes regardless of collection size. It's O(log n) technically, but with a branching factor of 32, "log n" is about 6 for a billion elements. You won't notice the difference from O(1).

The 32-way branching also makes structural sharing cheap. When you update a single element, you clone the nodes along the path from root to that element. That's 6 or 7 nodes at most. Everything else, the other 31 children at each level, is shared between old and new versions. Change one key in a hundred-key map and you create maybe four or five new nodes. The other ninety-five percent of the tree is reused verbatim.

## CHAMP Maps

CHAMP stands for Compressed Hash-Array Mapped Prefix-tree. It comes from a [2015 OOPSLA paper](https://michael.steindorfer.name/publications/oopsla15.pdf) by Michael Steindorfer and Jurgen Vinju, and it's an evolution of Phil Bagwell's original [Hash Array Mapped Trie](https://lampwww.epfl.ch/papers/idealhashtrees.pdf) from 2001. Bagwell's HAMT is what powers Clojure's `PersistentHashMap` and was, for a long time, the gold standard for persistent maps. CHAMP improves on it in ways that matter in practice.

A naive trie node would allocate an array of 32 slots, most of them empty. Wasteful. Bagwell's insight was to use a bitmap: one bit per possible slot, and a compact array holding only the occupied entries. You convert from slot index to array index using `popcount` (count the set bits below your position). This gives you the memory efficiency of a dense array with the lookup speed of a sparse one.

CHAMP's contribution is splitting that single bitmap into two. One bitmap (`data_map`) tracks which slots contain key-value entries stored directly at this node. The other (`node_map`) tracks which slots contain child sub-trees. Data entries go first in the array, sub-nodes second.

Why does this matter? Three reasons. First, cache locality. When you're scanning entries at a node, they're contiguous in memory instead of interleaved with sub-tree pointers. Second, traversal becomes simpler. You don't need to inspect each element to figure out if it's a value or a sub-tree. The bitmaps tell you. Third, and this is the subtle one: CHAMP maps have a canonical form. Two maps with the same logical content have the same physical structure. This makes equality checking inexpensive, because you can short-circuit the moment two bitmaps disagree.

Steindorfer and Vinju's benchmarks showed CHAMP beating Clojure's HAMT-based map by 83% on iteration speed and 96% on equality checking. Scala replaced its `immutable.HashMap` with a CHAMP implementation in version 2.13. It's battle-tested.

In Pony's `collections/persistent` package, the implementation looks like this:

```pony
class val _MapSubNodes[K, V, H]
  embed nodes: Array[_MapNode[K, V, H]] iso
  var node_map: U32
  var data_map: U32
```

Two bitmaps, one compact array. When you call `update` to set a key, the implementation clones this node (just this one, not the whole tree), mutates the clone in place, and returns it as `val`. The old nodes are still `val`, still shared by whatever earlier version of the map is still hanging around. Path copying at its most economical.

## HAMT Vecs

If CHAMP Maps give you persistent key-value storage, HAMT Vecs give you persistent indexed sequences. Same trie-based approach, but instead of routing by hash bits, you route by index bits. The trie structure gives you O(log32 n) access to any element by index.

The implementation includes an optimization borrowed from Clojure's `PersistentVector`: tail optimization. The rightmost leaf of the vector is kept in a separate field rather than in the trie. This means the most common operation, appending an element with `push`, avoids trie traversal entirely as long as the tail has room (up to 32 elements). You're just appending to a small array. When the tail fills up, it gets flushed into the trie and a new tail starts.

This matters for JSON parsing. Arrays are built left to right by sequential pushes. With tail optimization, most of those pushes are cheap array appends. The expensive trie operations only happen every 32 elements.

```pony
fun val push(value: val->A): Vec[A] =>
  let tail = recover val _tail.clone() .> push(value) end
  if tail.size() < 32 then
    _create(_root, tail, size', _depth)
  // ...
```

Updates work the same as CHAMP: clone the nodes along the path, share everything else.

## Where Pony's capability system fits in

Persistent data structures are immutable by construction. Every "mutation" produces a new value. Pony's reference capability system is built around distinguishing mutable from immutable data at compile time. The two fit together like they were planned that way.

In Pony, `val` means globally immutable. No actor can write to a `val` reference, and the compiler checks this statically. Persistent collections are `val` by declaration:

```pony
class val HashMap[K: Any #share, V: Any #share, H: mut.HashFunction[K] val]
```

The `#share` constraint on keys and values means everything stored in the map must itself be safely shareable (`val` or `tag`). It's `val` all the way down. You can send a persistent map to any number of actors, and the compiler knows at compile time that none of them can modify it or anything inside it.

This is what makes structural sharing safe. When two versions of a map share internal nodes, those shared nodes are `val`. No actor can reach in and modify a shared node out from under another actor. The compiler won't let you write the code that would try. So the memory optimization (sharing nodes between versions) and the concurrency guarantee (safe to read from any actor) come from the same property: immutability, enforced by the type system.

## Putting it all together

The new `json` package makes all of this concrete. `JsonObject` wraps a `Map[String, JsonValue]`. `JsonArray` wraps a `Vec[JsonValue]`. The entire `JsonValue` union is `val`-compatible:

```pony
type JsonValue is (JsonObject | JsonArray | String | I64 | F64 | Bool | None)
```

Parse a JSON document once, and the result is a deeply immutable tree that any actor can read. Send it to your HTTP handler, your database writer, your logging actor, and your metrics collector all at the same time. Each gets a reference to the same data. Zero copies.

The lens system shows where structural sharing really pays off. When you update a deeply nested value through a lens, each level of the JSON tree creates a new node wrapping the modified child, sharing everything else with the original. Change one field three levels deep in a hundred-key object, and you create a handful of new nodes. The rest of the document is shared between the old and new versions.

```pony
fun update(input: JsonValue, value: (JsonValue | _Delete))
  : (JsonValue | JsonNotFound)
=>
  try
    let intermediate = _a(input) as JsonValue
    let inner_result = _b.update(intermediate, value) as JsonValue
    _a.update(input, inner_result)
  else
    JsonNotFound
  end
```

Each call to `_a.update` rebuilds one level of the path. The rest is shared. You can hold onto both the original document and the modified version simultaneously with negligible memory overhead. In a web service handling concurrent requests, this means you can process a configuration update without invalidating the in-flight requests that are still reading the old version.

## When to reach for mutable collections instead

Persistent data structures aren't a silver bullet. They're the right tool when data crosses actor boundaries or when you need multiple versions to coexist. They're the wrong tool when you don't.

If a collection lives and dies within a single actor and never gets sent anywhere, use a mutable `Map` or `Array`. You're paying the allocation cost of path copying for a safety guarantee you don't need. Mutate in place. It's faster.

If you're doing a hot loop with thousands of mutations, the intermediate allocations from persistent updates add up. Build with a mutable collection inside a `recover` block, then freeze the result to `val` when you're done. You get the performance of mutation during construction and the shareability of immutability afterward.

If you need to hand off a collection for someone else to keep modifying, that's `iso` semantics: unique ownership transferred between actors. Persistent collections give you shared reading. They don't give you transferred writing.

The rule of thumb: persistent collections for data that gets shared or versioned, mutable collections for data that gets built or churned through privately. In practice, parsed data, configuration, lookup tables, and API responses are almost always the first category. Working buffers, intermediate computations, and builder state are almost always the second.

## The bigger picture

The new `json` package didn't choose CHAMP Maps and HAMT Vecs because they're clever (although they are). It chose them because they're the natural fit for a language that takes data-race freedom seriously. Pony's capability system creates a demand for immutable, shareable data structures. Persistent data structures supply exactly that, with the structural sharing to make it efficient.

Bagwell published the HAMT paper in 2001. Steindorfer and Vinju published CHAMP in 2015. Clojure and Scala have been using these ideas for years. Pony's contribution isn't the data structures themselves. It's the compiler guarantee that wraps them. In other languages, you choose persistent data structures because you're disciplined. In Pony, the compiler won't let you do the undisciplined thing in the first place.

That's a different kind of safety. And it's why building a JSON library in Pony in 2026 is more interesting than it might sound.
