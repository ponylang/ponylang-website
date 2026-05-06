---
date: 2026-05-04T08:00:00-04:00
title: "pony-lint: Codifying the Style Guide"
authors:
  - seantallen
categories:
  - ponyc
draft: false
---

A couple months ago I wrote about [teaching Claude to write Pony](teaching-claude-to-write-pony.md). The shorthand version: treat the LLM like a junior developer with no memory, build up a CLAUDE.md, refine it as you find where Claude falls short. The CLAUDE.md got Claude most of the way there.

The piece it never quite covered was the style guide. There's one for the projects under the ponylang GitHub org. It has rules for indentation, line length, naming, where blank lines go. Claude would write code that compiled and worked but didn't follow the rules. Indentation that should have been two spaces would land on three. A type name would pick up an underscore. A function that belonged on three lines would end up jammed onto one. Stray trailing whitespace. Each one I'd correct. And correct it again. And again.

<!-- more -->

## The math changed

The [style guide](https://github.com/ponylang/ponyc/blob/main/STYLE_GUIDE.md) has been in the ponyc repo for years. For most of that time we got along fine without enforcing it with a tool. The ponylang contributor base has always been small. Reviewers know the rules. If a PR comes in with the wrong indentation, somebody comments. The math worked.

LLMs change the math. An LLM in the hands of one or two existing contributors generates a volume of code that a much larger team would. Same people, same standards — just a lot more code coming through. Whatever we got away with not automating stayed that way because the human volume was small. It doesn't stay that way at LLM volume.

We've been rolling [pony-lint](../../use/linting.md) into CI gradually. The lint keeps finding things that don't conform to the rules, including some of my own favorite formatting choices that I'd been writing for years thinking they conformed. Reviewers knew the rules in the abstract; in practice we'd been missing them. The math hadn't really been working. It just looked like it was, because at small volume the things we missed didn't add up to much.

pony-lint is the style guide as code. Same source of truth, applied the same way, every time. Claude can run it and correct itself. And I can too.

## What codifies cleanly

Most of what the style guide says about formatting and naming ports directly into a lint rule. "Lines should be under 80 columns" becomes a length check. "Type names should be `CamelCase`" becomes an AST walk. The lint reads almost like the style guide rewritten as code.

The rules that didn't port are the ones the style guide doesn't make for you. The style guide says lines should be under 80 columns; it doesn't say where to break a long one. The style guide says member names should be `snake_case`; it doesn't say what to actually name them. The style guide says public methods should have a docstring; it doesn't say what the docstring should say.

That's deliberate. The style guide draws boundaries; what you do inside them is your call. pony-lint enforces the boundaries.

## Footguns

pony-lint already has one rule that isn't pure style: `safety/exhaustive-match`. The `\exhaustive\` annotation lets you assert that a `match` handles every case of a union type. Without the annotation, when somebody later adds a new variant, the compiler quietly injects `else None` to cover the new case instead of telling you the match is no longer exhaustive. The rule flags exhaustive matches that lack the annotation, so a future variant addition breaks the build at the right place instead of inheriting an `else` nobody wrote.

What makes that rule interesting is the shape of the bug it prevents: code that compiles cleanly, runs without complaint, and only goes wrong when something else changes. Pony has plenty of bugs like that. Patterns that work fine in some places and bite you in others.

A linter is the right home for them. The compiler can't reject them because they aren't always wrong; there are legitimate uses for almost every pattern, and the compiler has no way to tell which case you're in. Tests catch the symptoms without catching the patterns; you fix the surface and the cause stays. And code review catches them when the reviewer happens to be the person who got bit by them last year — which is to say, sometimes.

That's a different question than "did you put a space after the comma." It's "is this what you actually meant?" pony-lint started by codifying the first kind of question. Most of where it has room to grow is in the second.

## What's next

So that's where we are right now. What's next?

More footguns. The shape exhaustive-match catches isn't the only one. I have ideas for others, but I also want to hear which ones you've run into.

And we're going to start playing with auto-fixing the easy violations. Trim trailing whitespace, normalize spaces around operators, the unambiguous cases where there's exactly one right answer and no formatting opinion gets baked in. The harder cases are a bigger commitment. Pony has a style guide; it doesn't have a formatter, and we're not building one by accident.

And we're going to keep rolling pony-lint out to more ponylang org repos. More code under the lint, more rule edges we hadn't seen, more things we'd been missing.

I started pony-lint because telling Claude where the spaces go was getting old. The list of things I'd rather catch before they bite is longer than that.

Got a footgun idea? An idea for something else pony-lint should do? [Let us know](https://github.com/ponylang/ponyc/discussions/categories/pony-lint).
