---
date: 2026-04-10T08:00:00-04:00
title: "Claude You Some Pony for Great Good"
authors:
  - seantallen
categories:
  - Engineering
draft: false
---

Here's how it is:

Two months ago I wrote about [teaching Claude to write Pony](teaching-claude-to-write-pony.md). That post was about the process — mentoring an LLM like a junior developer, building up engineering principles, establishing review loops. Today, I'm here to talk about the LLM skills I've been working on. They're in [ponylang/llm-skills](https://github.com/ponylang/llm-skills), and if you're working on Pony with an LLM, you should try them.

<!-- more -->

My bar for the skills is the same bar I use for human contributors: output I would accept and merge. Not perfection. Projects grow by accepting anything that improves the situation. And they die by getting hung up on getting everything "just so". My goal as I've been building these skills is to make it easier for you to push your Pony project forward.

There are eleven skills in the repo covering everything from language reference material to multi-agent code review to release note conventions. I'm not going to walk through all of them. This post highlights three that I think are worth understanding in some depth: what they do, how they work, and what you can expect from them.

Results vary across the skills. Code review produces excellent results. I'm not happy with where the software design skill is yet. The skills are a work in progress — I'm refining them as I use them, and some areas are further along than others.

## What's a skill?

A skill is a block of instructions your LLM loads on demand. Think of it as a procedure manual for a specific kind of work. You don't carry the whole thing around — you load what you need when you need it. `/pony-ref` loads the Pony language reference before a coding session. `/pony-code-review` loads a multi-agent review process before reviewing a PR. `/pony-debug` loads a structured debugging protocol when you're tracking down a bug. Each one gives the LLM knowledge or structure it wouldn't have on its own.

Skills don't load themselves. You either invoke them manually — type `/pony-ref` and the LLM loads the Pony language reference — or you put an instruction in your CLAUDE.md that tells the LLM when to load them. My CLAUDE.md has an entry that says to load `/pony-ref` at the start of any conversation where the working directory is a Pony project. I never think about it. It just happens.

The skills live at [ponylang/llm-skills](https://github.com/ponylang/llm-skills). Run `python3 install.py` and they're symlinked into your Claude Code skills directory.

I use these every day across all the Pony projects I work on, from the compiler and runtime to libraries like [ponylang/postgres](https://github.com/ponylang/postgres). They're not a side project I maintain when I get around to it. I'm actively developing and refining them as I work. Expect them to change often. The specifics of what I describe below may look different by the time you read this, possibly very different. That said, let's dive in.

## pony-ref

You know what is worse than slow code? An LLM crawling the internet trying to find Pony documentation and information. Trust me, it is infuriatingly slow. It took less than a couple days of working with Claude on Pony code for me to whip up the first version of pony-ref.

pony-ref is concentrated reference material that you should load at the start of every Pony coding session. It covers the capabilities table, subtyping rules, viewpoint adaptation, common gotchas, PonyCheck property-based testing patterns, and standard library pitfalls. Behind the quick reference, there are deeper documents — academic papers on the type system, runtime and GC synopses, tutorial and patterns content — that the LLM pulls from when it needs more depth. The reference documentation updates nightly from the Pony website and tutorial, so pull the repo often.

pony-ref helps a ton, but you'll need to keep an eye on the output. The LLM will produce far better code with the skill than without, but there will be mistakes. Code that even I, as someone who hates the word "idiomatic," thinks "isn't idiomatic".

## pony-code-review

A single LLM reviewing code does what you'd expect. It reads the code, checks for obvious problems, confirms the logic is correct. It's fine. It's also incomplete in the same way any single-pass review is. Every reviewer has blind spots.

pony-code-review runs multiple agents on the same code, each one approaching it with a different way of thinking. The correctness reviewer traces logic forward: given the inputs this code is designed to handle, does it handle them right? The adversarial reviewer starts from the other end: what would a bad outcome look like, and what specific inputs produce it? The tests reviewer applies counterfactual thinking: if the code under test were broken in exactly the way this test targets, would the assertion actually fire? There are more — security, API design, performance, consistency with project principles — and the skill selects which ones to deploy based on the scope of the change.

Same code. Different cognitive approaches. The findings go to a synthesis agent that combines them, resolving disagreements, cross-referencing uncertainties, and surfacing things that only become visible when you compare the outputs side by side.

I call it an ensemble because that's what it is — each agent's blind spots are different, and the combination covers more ground than any individual pass.

Running multiple agents costs more tokens than running one. Each agent runs its own internal review before returning results. The synthesis agent reviews its work too. It adds up. That's a deliberate choice. I'm trading tokens for quality, and the quality difference justifies the cost. A thorough review that catches a capabilities error or a test gap before it ships is worth more than the tokens it burned.

Fair warning, pony-code-review is not for the faint of heart. Your ego might get bruised. It can find tons of issues. It is very good at what it does and you will probably get knocked down a few pegs if you run it on your own code. And that's ok. Not everyone can score four touchdowns in a single game. Sometimes you just get beat up by the defense. Stop by [Office Hours](../../community/office-hours.md) and ask Red about the review his ODBC project got.

## pony-debug

LLMs can spend twenty minutes chasing a hypothesis they never tested. They'll confidently explain why the bug is in module A when it's actually in module B, fix a problem that doesn't exist while the real one sits untouched. This isn't because they can't reason. Give an LLM a genuinely hard problem — subtle type system interactions, concurrency bugs, root causes buried across thousands of lines — and when the reasoning chain connects, the results can seem almost magical. The problem is empiricism. LLMs reason about code instead of testing their assumptions. A developer who's been burned enough times will say "let me just check" before committing to a theory. An LLM without structure will build an elaborate model of what the bug must be, and when the evidence doesn't fit, it adjusts the model instead of questioning the premise.

pony-debug forces the discipline. Characterize the failure. Gather context. Build a minimal reproduction. Then iterate through hypothesis-experiment-observe cycles. The key word is *experiment*. Not "reason about what would happen if I changed this." Actually run the code. Read the output. Let the results update your understanding. Each step is a checkpoint — you don't move forward until the current one is solid. That usually keeps the LLM from doing what it wants to do, which is latch onto a theory in the first thirty seconds and spend the rest of the session making the evidence fit.

Just like with pony-ref, pony-debug helps a lot, but LLMs "have a mind of their own". You should still probably check in occasionally when it is debugging to make sure it isn't running in circles like a chicken with its head cut off.

## Skills are one piece

In [Teaching Claude to Write Pony](teaching-claude-to-write-pony.md), the biggest takeaway was that engineering principles matter more than anything else. Your CLAUDE.md — the principles, conventions, and working style you build up through use — shapes how the LLM approaches every task. The skills give it knowledge and process. Your CLAUDE.md gives it judgment.

pony-code-review produces better results when the LLM already has principles like "make illegal states unrepresentable" and "prefer explicit over implicit" to guide its decisions. pony-debug works better when the CLAUDE.md reinforces "verify empirically before asserting." The skills provide structure. The principles provide the values that guide decisions within that structure.

This isn't autopilot. You need to understand the code, review the output, and make the calls that require context the LLM doesn't have. The skills raise the floor. Your principles and your judgment set the ceiling.

If you have a shit CLAUDE.md, I expect the skills will give you shit results. If your CLAUDE.md is big rock candy mountain, then perhaps the sun really will shine every day on your Pony code.

## Before you install

I test with Claude Opus 4.6, high effort on. That's the configuration I use every day, and it's the only one I can vouch for. The install script is built for Claude Code. Any LLM harness that supports sub-agents should work in principle, but I haven't tested other harnesses or other models.

The ensemble skills burn tokens. That's by design. If cost is a concern, the non-ensemble skills — pony-ref, pony-debug, and the rest — work without the multi-agent overhead. But the ensemble skills exist because the quality is worth the cost, and I haven't regretted that tradeoff.

## Try them

The skills are at [ponylang/llm-skills](https://github.com/ponylang/llm-skills). Clone the repo, run the install script, and see what you think. And if you find yourself thinking they are pretty swell, follow along with changes via the [CHANGELOG](https://github.com/ponylang/llm-skills/blob/main/CHANGELOG.md).

If you get stuck, come find me on the [Pony Zulip](https://ponylang.zulipchat.com). The [#beginner help](https://ponylang.zulipchat.com/#narrow/stream/189985-beginner-help) stream is a good place to start.
