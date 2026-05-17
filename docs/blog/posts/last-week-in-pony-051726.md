---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - May 17, 2026"
date: 2026-05-17T07:00:06-04:00
---

This week's theme song is ["You Wreck Me"](https://www.youtube.com/watch?v=-3aGZZueg08) by Tom Petty. Tom Petty! It's been on rotation while I've been buried in [PR 5246](https://github.com/ponylang/ponyc/pull/5246), the finite recursive type aliases work. That's the big job I warned you about last week. The one eating my coding hours and keeping the Pony news drumbeat quiet. Tonight we ride. Because... Tom Petty!

Quiet doesn't mean nothing. A new blog post went up on why I pulled documentation generation out of the compiler. Office Hours had Adrian taking a CLI-based LLM tool for its first spin. And I filed an official RFC request for someone to design optimization options into ponyc.

<!-- more -->

## Items of Note

### New Blog Post: pony-doc: From the back pew to the front pew

I put up [a new blog post](https://www.ponylang.io/blog/2026/05/pony-doc-from-the-back-pew-to-the-front-pew/) covering why `ponyc --docs` is gone and how a separate Pony program, pony-doc, generates Pony API documentation now. The output is the same as what the old documentation pass produced. We switched the ponylang sites over from one to the other and no one noticed.

So why move it out at all? Contributor reach. The documentation generator was a libponyc pass written in C. Wanting to fix how a method signature rendered or add a small CLI option meant editing a libponyc pass, debugging C against the AST, plumbing a flag through `pass_opt_t`, and wondering whether your one-line tweak had broken something three passes downstream. Most Pony users have no reason to learn any of that. Pulling it out into a Pony program in its own repo, with its own issues and PRs, opens the front pew to anyone who knows the language.

### Office Hours

Office Hours on May 11. Red, Adrian, and me.

Adrian had a CLI-based LLM tool open for the first time, so a chunk of the conversation went there. We've covered this ground before. The last Office Hours I sat in on, we tracked his confusion about a piece of Pony back to a web-only Gemini that doesn't read source code. A CLI tool that reads your source is a different animal. He was kicking the tires.

On my end, I touched on the basics of Tarjan's strongly-connected-components algorithm. It's the algorithm the new alias legality pass in [PR 5246](https://github.com/ponylang/ponyc/pull/5246) leans on to find which type aliases form a cycle. Once you know the cycles, you check each one for a finite layout instead of walking blindly out from every alias. We didn't go deep. Just enough to sketch it out.

### Official RFC Request: Optimization Options for ponyc

I filed [an official RFC request](https://github.com/ponylang/rfcs/issues/232) asking someone to design optimization options into ponyc. Today the compiler hard-codes its choices. There's no CLI flag to say "optimize for size" or "lower the optimization level so I can debug a codegen problem." People have asked for both. The original report goes back to [ponylang/ponyc#2682](https://github.com/ponylang/ponyc/issues/2682) and is specifically about the linker `-O` flag. Discussion there made it clear there are at least two knobs that could move: the LLVM codegen optimization level set in `genopt.cc`, and the linker `-O` flag set in `genexe.c`. The RFC author can decide whether to address one or both.

The design has to account for more than the ponyc CLI. pony-lsp, pony-lint, and pony-doc all build on the same underlying compiler library. Whatever shape this takes on the CLI, the library API needs a coherent way for the tools to opt in or stay out.

If you want to take it, comment on the issue.

## Releases

- [contact-red/pony-ffi 0.1.1](https://github.com/contact-red/pony-ffi/releases/tag/0.1.1)
- [contact-red/odbc 0.1.1](https://github.com/contact-red/odbc/releases/tag/0.1.1)

## RFCs

### Accepted

- [Withdraw RFC 53: Compile-Time Expressions](https://github.com/ponylang/rfcs/pull/227)
- [Socket runtime three-state result](https://github.com/ponylang/rfcs/pull/228)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
