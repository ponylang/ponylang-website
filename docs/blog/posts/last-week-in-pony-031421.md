---
draft: false
authors:
  - theobutler
description: "We're migrating the Pony Tutorial and Pony Patterns to MkDocs-Material. There's a new tool for interactively exploring the Pony AST from a debugger. ponylang/http has been updated."
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - March 14, 2021"
date: 2021-03-14T21:58:45-04:00
---

We're migrating the Pony Tutorial and Pony Patterns to MkDocs-Material. There's a new tool for interactively exploring the Pony AST from a debugger. ponylang/http has been updated.
<!-- more -->

## Items of note

- The [Pony Patterns website](https://patterns.ponylang.io/) and the [Pony tutorial website](https://tutorial.ponylang.io/) have been switched to being built using Hugo to MkDocs. With Hugo, we were maintaining our own theme. With the switch to MkDocs, we can use [MkDocs-material](https://github.com/squidfunk/MkDocs-material) that receives far more attention and love than our little hand rolled Hugo one. Take a spin and check them out. (Did we mention "dark mode"?)

- [AST explorer](https://github.com/Trundle/pony-ast-explorer) is a new tool to interactively explore ponyc's *abstract syntax tree*. It visualizes the AST in your terminal and you can zoom out to parent nodes or follow data references. And it runs directly in GDB or LLDB, so you use it to step through any AST during compilation.

## Releases

- Version 0.2.8 of ponylang/http has been released.
See the [release notes](https://github.com/ponylang/http/releases/tag/0.2.8) for more details.

- Version 0.2.0 of ponylang/readme-version-updater-action has been released.
See the [release notes](https://github.com/ponylang/readme-version-updater-action/releases/tag/0.2.0) for more details.

- Version 0.5.0 of ponylang/release-bot-action has been released. See the [release notes](https://github.com/ponylang/release-bot-action/releases/tag/0.5.0) for more details.

---

@EpicEric writes:

Hi! We're working on migrating the Pony Tutorial and Pony Patterns to MkDocs-Material, which uses [Pygments](https://pygments.org/) as the syntax highlighter. The [Pony lexer](https://github.com/pygments/pygments/blob/master/pygments/lexers/pony.py) already exists but it was last updated in 2016 (!!), so it could use some updates if you have some Python knowledge and some free time.

As a base, you can use the [HighlightJS implementation of a Pony highlighter](https://github.com/highlightjs/highlight.js/blob/master/src/languages/pony.js), which is more up-to-date and still used/tested today, eg. for library docgen.

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony check out [our website](https://ponylang.io), our Twitter account [@ponylang](https://twitter.com/ponylang), or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

Interested in making a change, or keeping up with changes to Pony? Check out the [RFC repo](https://github.com/ponylang/rfcs). Contributors welcome!
