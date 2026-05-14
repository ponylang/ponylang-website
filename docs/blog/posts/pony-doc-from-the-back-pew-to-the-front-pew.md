---
date: 2026-05-14T08:00:00-04:00
title: "pony-doc: From the back pew to the front pew"
authors:
  - seantallen
categories:
  - ponyc
draft: false
---

`ponyc --docs` is how you used to generate Pony API documentation. For more than a decade, you'd run that command, point it at a package, and the compiler would write you documentation in [MkDocs](https://www.mkdocs.org/)-compatible format. It was quiet. It was reliable. It was boring.

Last month I deleted the documentation pass from the compiler. pony-doc, a separate Pony program, generates Pony documentation now. It creates the same output as the old documentation pass did. We switched all our sites over from one to the other and no one noticed.

So why move documentation generation out of the compiler? Why do work that has no discernible change for the user? Why now, after a decade of `ponyc --docs` working just fine?

<!-- more -->

## The pass that was

The Pony documentation generator was a libponyc pass. Written in C. It walked the AST and wrote files in MkDocs-compatible format. It did that quietly for years. If you've ever read the Pony standard library documentation, those pages were produced by it.

A compiler running with `--docs` isn't really doing compiler work. It's generating files. The compiler pass was the seam where that file generation lived, not where it had to live.

The cost was contributor reach. Wanting to fix how a method signature rendered or add a small CLI option meant editing a libponyc pass: debugging C against the AST, plumbing a flag through `pass_opt_t`, wondering whether your one-line tweak had broken something three passes downstream. Most Pony users have no reason to learn any of that.

## What the move makes possible

The compiler still does the parsing and AST construction. What pony-doc does after that is Pony code outside the compiler. It walks the AST and builds an intermediate representation — packages, types, methods, fields. A backend takes that and writes the output.

Want to change how a method signature renders? You open a Pony file. No needing to know C. No managing the memory for all the string construction.

Adding a flag to pony-doc means changing pony-doc and nothing else. Adding a flag to the old pass meant adding it to ponyc, where it had to make sense alongside `--debug`, `--release`, `--triple`, and every other compiler option. Documentation generation and compilation aren't the same job. They shared an interface because they shared a parser, not because the interface made sense.

There's a `Backend` trait now. It's an extension point where output formats hook in. Multi-backend documentation has been on the wish list since the early days of the `--docs` flag, and inside a compiler pass every output format was more C in libponyc. Outside the compiler, a backend means implementing the trait. Nothing else has to change.

## What's next

The first concrete sketch for a second backend is an [Info backend](https://github.com/ponylang/ponyc/discussions/5150). GNU Info is the format most GNU tools document themselves in — manpages with hypertext, basically: pages with cross-references, indexes you can jump from, navigation between sections. You read Info files with the `info` command, or from Emacs with `C-h i`. For Pony users who'd rather look up an API at the command line than in a web browser, an Info backend keeps them out of the browser.

If you want to write a backend for another format, the door is open. There's a [pony-doc discussion category](https://github.com/ponylang/ponyc/discussions/categories/pony-doc) in ponyc discussions for ideas — output formats, options, anything we haven't thought of.

Out of the compiler. In Pony. That's the part I wanted.
