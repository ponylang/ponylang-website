---
date: 2026-03-20T07:00:00-04:00
title: "Pony Gets a New JSON Library"
authors:
  - seantallen
categories:
  - Development
draft: false
---

For the first time in three years, Pony has a `json` package in its standard library. And this one has some tricks the old one never did.

<!-- more -->

## A brief history of JSON in Pony

Pony used to ship a `json` package in its standard library. It worked. It parsed JSON and gave you objects you could poke at. But it had a fundamental design problem: the whole thing was built around a mutable tree. That's fine if you're constructing or modifying JSON documents, but it's a poor fit for the thing you most often want to do in Pony: parse some JSON and share the result between actors. Mutable data and Pony's reference capabilities don't mix well. You'd end up doing a lot of copying or a lot of fighting with the type system.

Beyond that, having an "official" JSON library in the standard library discouraged alternatives. The ecosystem had a couple of interesting third-party JSON libraries with different design philosophies, but the existence of a blessed stdlib version meant most people never looked at them. And the stdlib version itself was stuck. It was beta-quality software trapped behind the RFC process, unable to iterate quickly enough to improve.

In early 2023, we removed it. [RFC 0078](https://github.com/ponylang/rfcs/blob/main/text/0078-remove-json-package-from-stdlib.md) moved `json` out of the standard library and into its own repository at [`ponylang/json`](https://github.com/ponylang/json). The idea was simple: let the ecosystem figure out what a good Pony JSON library looks like, and when something proves itself, bring it back.

That took about three years. The new `json` package is the result, and it draws heavily from those community libraries that the old stdlib version had been overshadowing. [jay](https://github.com/patroclos/jay) pioneered immutable JSON with lenses in Pony, and that lens-based access pattern made it into the new library directly. [pony-immutable-json](https://github.com/mfelsche/pony-immutable-json) combined immutable JSON with builders and JSONPath support, proving that a query language was practical in pure Pony. [pony-jason](https://github.com/jemc/pony-jason) took a streaming token parser approach that influenced how the new library handles parsing. Each of those libraries explored a different part of the design space. The new `json` package pulls the best ideas from all of them into a single, coherent library.

## Why now

The timing isn't an accident. Over the past few weeks, we've been building out the pieces you need to write web services in Pony. [`ponylang/stallion`](https://github.com/ponylang/stallion) gives you an HTTP/1.1 server built on [`ponylang/lori`](https://github.com/ponylang/lori). [`ponylang/hobby`](https://github.com/ponylang/hobby) layers a web framework on top of Stallion with routing, middleware, and static file serving. [`ponylang/mare`](https://github.com/ponylang/mare) landed a WebSocket server implementation in February. We're rapidly closing in on a great web development story for Pony.

But a web stack without a good JSON library is like a horned frog without legs. It might scoot around a little, but it's not getting far. The new `json` package fills that gap. It parses JSON, it serializes JSON, and it does both with an API designed around Pony's strengths instead of fighting them. Everything is immutable. Errors are data, not exceptions. The whole thing plays nicely with reference capabilities because it was built with them in mind from the start.

That alone would be worth a blog post. "Hey, we have a JSON library again and this one actually fits the language." But there's some technically interesting stuff going on under the hood, and I want to dig into it.

## JSONPath

JSONPath is a query language for JSON, the same way [XPath](https://www.w3.org/TR/xpath-31/) is a query language for XML. You hand it a JSON document and a path expression and it hands you back the matching values. It's standardized as [RFC 9535](https://www.rfc-editor.org/rfc/rfc9535) and the `json` package implements the full specification.

The basic syntax looks like what you'd expect. Given a document:

```json
{
  "store": {
    "book": [
      {"title": "Moby Dick", "price": 8.99},
      {"title": "The Great Gatsby", "price": 12.99},
      {"title": "War and Peace", "price": 15.00}
    ]
  }
}
```

The expression `$.store.book[0].title` gives you `"Moby Dick"`. `$.store.book[*].title` gives you all three titles. `$..title` descends through the entire document and gives you every `title` value it finds, regardless of depth.

So far, not that exciting. The interesting part starts with filter expressions.

### Filter expressions

`$.store.book[?@.price < 10]` gives you every book where the price is under 10. The `?` introduces a filter. The `@` refers to the current element being tested. You get the full set of comparison operators, logical AND/OR/NOT, and nested path queries inside filters.

You can also use functions. `$.store.book[?length(@.title) > 10]` finds books with long titles. `$.store.book[?match(@.title, "^The")]` finds books whose titles start with "The." The `match` and `search` functions use [I-Regexp](https://www.rfc-editor.org/rfc/rfc9485) (RFC 9485), a restricted regular expression syntax designed for interoperability.

All of this is implemented in pure Pony. The JSONPath parser is a recursive descent parser that produces an AST of segments and selectors. The evaluator walks that AST against a JSON document, threading a node list through each segment. Child segments apply selectors to the current set of nodes. Descendant segments do a depth-first traversal and apply selectors at every level.

The regex engine behind `match` and `search` is a [Thompson NFA](https://swtch.com/~rsc/regexp/regexp1.html). It compiles I-Regexp patterns into a nondeterministic finite automaton and simulates it against the input. No backtracking, which means no pathological performance on adversarial patterns. There's a hard cap of 10,000 NFA states to prevent resource exhaustion from absurdly complex expressions.

## Three ways to navigate

JSONPath is the most powerful navigation tool in the library, but it's not the only one. There are three access patterns, each suited to different situations.

`JsonNav` is the simplest. It wraps a value and lets you chain field access. Navigate into an object by key, into an array by index, and extract at the end. If anything along the path is missing, the failure propagates silently until you try to extract a terminal value. It's one-shot: you build a chain, you get a result, you're done.

`JsonLens` separates the path from the document. You build a lens that describes a location in a JSON structure, and then you can apply that lens to any document. Read a value, set a value, remove a value. Lenses compose: you can chain them, combine them with fallbacks, and reuse them across different documents. The path description is a value you can store and pass around.

`JsonPath` is the full query language. Where Nav and Lens give you a single value at a known location, Path gives you a set of values matching an expression. Wildcards, recursion, slicing, filters. It's the tool you reach for when you don't know the exact shape of the document or when you need to select across repeated structures.

## Persistent data structures

The other technically interesting piece is the foundation. Every `JsonObject` is backed by a [CHAMP](https://michael.steindorfer.name/publications/oopsla15.pdf) Map. Every `JsonArray` is backed by a [HAMT](https://lampwww.epfl.ch/papers/idealhashtrees.pdf) Vec. Both come from Pony's persistent collections package, and they're what make the whole "everything is immutable" design practical.

CHAMP stands for Compressed Hash-Array Mapped Prefix-tree. It's an evolution of Phil Bagwell's [Hash Array Mapped Trie](https://en.wikipedia.org/wiki/Hash_array_mapped_trie) (HAMT) optimized for memory layout and cache performance. The basic idea: instead of a traditional hash map that stores everything in a flat array with collision handling, a CHAMP map uses the hash code as a path through a tree. Each level of the tree consumes a few bits of the hash, branching into child nodes. The tree is wide and shallow, so lookups are fast.

The "compressed" part matters. A naive implementation would allocate a full array at every node, wasting space for empty slots. CHAMP uses a bitmap to track which slots are occupied and packs only the occupied entries into a compact array. Two bitmaps per node: one for entries stored directly at this level, one for subtrees. This gives you O(log n) operations with good constant factors and, critically, structural sharing.

Structural sharing is why these data structures work for JSON. When you "update" an immutable map, you don't copy the whole thing. You create a new path from the root to the changed node, reusing every other node in the tree. If your object has a hundred keys and you change one, you create maybe four or five new nodes and share the rest. The old version of the object still exists, unchanged, referencing the same shared nodes.

HAMT Vec applies the same trie-based approach to indexed sequences. Instead of hash bits routing you through the tree, array indices do. Push, pop, and indexed access are all O(log n) with a branching factor large enough that "log n" is effectively constant for any realistic array size.

For the `json` package, this means updating a deeply nested JSON document is cheap. Each lens `set` or object `update` creates a thin layer of new nodes along the path to the change, sharing everything else with the original. You can hold onto both the old and new versions simultaneously with negligible memory overhead. In a language built around immutable data flowing between actors, that's exactly what you want.

## The whole picture

The `json` package is one piece of a larger effort to make Pony a practical choice for web development. It's early days. Lori, Stallion, Hobby, Mare, and the new JSON package all have a way to go. But the foundation is solid and it's coming together fast. We have HTTP, WebSockets, a simple web framework, and now a JSON library with parsing, serialization, a query language, composable lenses, and persistent immutable data structures. All built around the things that make Pony worth using in the first place.

And for those of you who want more than "simple" from a web framework, there's something else in the works. More on that soon.

In the meantime, give `json` a try and let us know what you think.
