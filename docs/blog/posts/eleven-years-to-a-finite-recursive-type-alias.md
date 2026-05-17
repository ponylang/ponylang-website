---
date: 2026-05-17T16:00:00-04:00
title: "Eleven years to a finite recursive type alias"
authors:
  - seantallen
categories:
  - ponyc
  - Finite Recursive Type Aliases
draft: false
---

There's a pull request open against the Pony compiler. It's in review right now. When it lands, and it will land soon, you'll be able to write this:

```pony
use "collections"

type JsonValue is
  ( String
  | F64
  | Bool
  | None
  | Array[JsonValue]
  | Map[String, JsonValue])
```

Today the compiler rejects it. `JsonValue` mentions `Array[JsonValue]`, which mentions `JsonValue`, and ponyc throws up its hands: `type aliases can't be recursive`. That has been true for the entire history of the language. It's about to stop being true, and the pull request that changes it closes out the oldest open issue in the ponyc repository.

<!-- more -->

## The workaround

That JSON type is how you describe JSON in a language that has union types. A JSON value is a string, or a number, or a boolean, or null, or an array of JSON values, or an object mapping strings to JSON values. The definition refers to itself because JSON refers to itself. An array holds more JSON. An object holds more JSON. You cannot write the shape down without the shape pointing back at itself.

Pony has had union types from very early on. What it has not had is an alias that can point at itself. So without that, you write your JSON types like this:

```pony
type JsonValue is (String | F64 | Bool | None | JsonArray | JsonObject)

class JsonArray
  var data: Array[JsonValue]

class JsonObject
  var data: Map[String, JsonValue]
```

The scalars go straight into the union. The recursive parts, the array and the object, get wrapped in classes, because a class is allowed to mention whatever it wants. It works. It is the only thing that works. But you are writing those wrapper classes to get around the type system, not because your design asked for them. Every place you touch a JSON array you are really touching a `JsonArray` that holds the array you actually wanted.

None of that code stops working. The wrapper-class types you have already built keep compiling. Recursive aliases are a new option, not a migration. The change is all additive.

Not every recursive alias is going to be legal once this lands. `type Loop is Loop` is nonsense, and the compiler will still say so. The rule, in one sentence: the recursion has to pass through something that holds its contents behind a pointer, like `Array` or `Map`, and there has to be a way out, some option in a union that does not loop back. `Array[JsonValue]` clears the first bar. `String` and `None` and the rest of that union clear the second. `type Loop is Array[Loop]` clears the first and fails the second, and it will be rejected. How the compiler works that out is a story for another day.

## The nag

The oldest open ponyc issue is number 267. Joe Eli McIlvain opened it on July 23rd, 2015. He was writing a pure-Pony JSON library, hit the recursive alias wall, and filed a bug with a JSON type as the example. Eleven years later, that JSON type is the example in the pull request that closes his issue.

Two hundred sixty-seven. ponyc's issue and PR numbers are well past five thousand now. Number 267 is the oldest issue still open. When this pull request merges, it will not be.

## Why it waited eleven years

An issue does not stay open for eleven years because nobody noticed it. People noticed. People wanted it. It stayed open because fixing it is genuinely hard. Here is why.

Type aliases in Pony were never really things. They were text. When you wrote `type JsonArray is Array[JsonValue]`, the compiler did not write down "there is an alias named JsonArray." It found every place you used `JsonArray` and pasted `Array[JsonValue]` in. A few passes into compilation, the alias was gone. There was no `JsonArray` anywhere in the program the compiler was looking at. Just `Array[JsonValue]`, written out longhand everywhere you had used the short name.

You cannot make text substitution recursive. If `JsonArray` expands into something containing `JsonValue`, and `JsonValue` expands into something containing `JsonArray`, the pasting never stops. The compiler loops until it dies. So it did not allow it. Not because recursive aliases are a bad idea, but because the machinery underneath them had no room for the concept.

Sylvan Clebsch, who created Pony, said as much on the issue back in 2015:

> The problem is we are disallowing all type alias recursion, when we should only disallow infinite type alias recursion. [...] Checking this is certainly possible, but non-trivial. But we should do this.

Non-trivial, but we should do this. That is the whole history of the issue in six words. Sylvan came back in 2018 and wrote down the actual roadmap. Stop expanding aliases. Make them first-class things the compiler carries around and reasons about. Teach the whole type system to understand them. He called that "a significant amount of work." And then, about the final step, the part that actually detects which recursion is safe and which is not, he wrote:

> This should be relatively easy.

Hold onto that line.

That is the first reason the issue waited: the change is deep. It runs from the front of the compiler to the back. But there is a second reason, and it is the one I did not understand until I was inside it. The change is not just deep. It is a grind.

## Seventy-nine commits

I started from the same place Sylvan would have. Stop expanding aliases, make them first-class, teach the type system. That is the part we both thought would be a significant amount of work, and I braced for it. It is the foundation the whole feature stands on. If there was going to be a slog, that is where the slog would be.

It took two or three days.

I was not doing it alone. I have been doing a lot of my Pony work lately with Claude Code. I think. Claude executes. And the foundation, the part I had braced for, went fast. Way faster than I imagined. I remember the feeling exactly. "Well, would you look at that. This is going to be not so bad. Thanks, robot."

I was calling it daylight. It was barely even dusk.

Here is what I had missed. The part of the roadmap that Sylvan called "a significant amount of work," the foundation, that is the part that went in two or three days. The part he called "relatively easy," detecting which recursion is finite and which runs forever, that is the part still in review. That is the part with seventy-nine commits on it and counting. Seventy-nine commits on one pull request. Not spread across the three it took to get here. On the last one alone.

Sylvan was wrong about which part was easy. So was I, and I have spent about a decade inside this compiler. I looked at the roadmap and came to the same conclusions as Sylvan. This isn't surprising. We often think alike, but still. There I was. I too thought the foundation was the mountain, the rest was the walk down. We both knew this compiler well. And neither of us saw the swarm of locusts on the horizon.

What do seventy-nine commits look like? They look like threading one piece of information through one function, then the next function, then the next, across dozens of files, because some corner of the type checker now needs to know something it never needed to know before. They look like a couple of days spent building an approach, and then a couple more days spent backing out of it because it was the wrong approach. None of it is hard the way a clever algorithm is hard. It is hard the way digging a long ditch is hard. It does not take brilliance. It takes not stopping.

That is where Claude actually earned its keep. Not in the two or three days that felt like magic. That part was a tease. It earned it in the long stretch after, where the work is mechanical and endless and every instinct I had was telling me to go do something more interesting. I took a wrong turn that cost me two days. Without Claude, it would have cost me two weeks. And spending two weeks to find out I had taken the wrong approach entirely is the kind of thing that would have made me close the laptop and not come back. Claude made the boring, punishing parts survivable. That's a load and a half.

All that pain is the real answer to why issue 267 waited eleven years. It was not waiting on an idea. Sylvan had the idea in 2015 and the roadmap in 2018. It was waiting on someone willing to grind through it. For eleven years nobody was. Handed this exact task a few years ago, I would not have been either. I do not think I have gotten this far because I got more determined than the people before me. I think I have gotten this far because the grind finally got cheap enough to do.
