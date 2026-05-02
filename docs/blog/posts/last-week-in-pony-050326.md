---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - May 3, 2026"
date: 2026-05-03T07:00:06-04:00
---

This week's theme song is ["Voodoo Child"](https://www.youtube.com/watch?v=n_E-h2O4Moo) by Monica Valli. Trust me on this one.

Big release week. ponyc 0.63.4 ships two new pony-lsp features. Signature help pops up the parameters of the method you're calling and highlights the one you're filling in. Type hierarchy navigation lets your editor walk between a type, its supertypes, and its subtypes. The release also fixes a link failure on Fedora-family distributions, a multilib `crt1.o` gotcha, and a match exhaustiveness hole on `Bool` tuples. The RFC front was busy too: three new proposals and one across the finish line. Let's get into it.

<!-- more -->

## ponyc 0.63.4

[ponyc](https://github.com/ponylang/ponyc) 0.63.4 keeps the pony-lsp work rolling. A pair of build problems on RPM-based distributions get fixed. A match exhaustiveness gap on `Bool` tuples finally closes.

Signature help is the big one. Type the opening paren on a method call and your editor pops up the full signature with the active parameter highlighted. Type a comma and the highlight moves to the next one. The popup includes the method's docstring when the method has one. It's driven by the compiled AST and needs the file to be saved, so you won't see hints mid-keystroke on unsaved edits. For the common case of "I forgot what this method takes," it's exactly what you want.

Type hierarchy navigation also landed. Put your cursor on a class, trait, actor, interface, primitive, or struct and your editor exposes "Show Type Hierarchy", "Go to Supertypes", and "Go to Subtypes" commands. Supertypes walks the entity's `is` list. Subtypes does a cross-package walk and finds every entity whose `is` list directly includes the type you're sitting on. If you've been navigating type relationships by grep, you can stop.

Two smaller pony-lsp items. Parameter type annotations now get the same capability inlay hints that other type annotations already had, so a parameter declared as `name: String` shows the inferred `val` next to it. Two spurious-hint bugs also got fixed. Primitive types were emitting extra inlay hints they shouldn't have, and the document outline was including synthesized `eq`/`ne` entries on bare primitives that happened to appear last in a file. Both gone.

The Fedora linker fix is one for anyone who wants to run Pony on a Fedora-family distribution. Embedded lld came in with 0.61.1. It turned out to not be able to locate the C runtime startup objects on RPM-based distributions, so linking on Fedora, RHEL, CentOS, Rocky, or openSUSE failed with `could not find libc CRT objects in sysroot ''`. The first user to try it reported the bug this week, and the fix went in inside 24 hours. ponyc now locates the C runtime startup objects on RPM-based distributions and links cleanly. While the fix was being put together, the related multilib failure also got sorted out. On an x86_64 host with `glibc-devel.i686` installed, ponyc was picking up the 32-bit `crt1.o` and the link blew up with a confusing arch-mismatch error. ponyc now validates the architecture of each candidate `crt1.o` and skips the wrong-arch ones. If no match is found, the error message names the target architecture instead of dumping you into a lower-level linker error.

Match exhaustiveness on `Bool` value patterns inside tuples is fixed. Code like this used to require an `else` clause even though `(_, true)` and `(_, false)` together cover every value of `(String, Bool)`:

```pony
primitive Foo
  fun apply(x: (String, Bool)): Bool =>
    match x
    | (_, true) => true
    | (_, false) => false
    end
```

The compiler now recognizes the cover. Nested tuples, multiple `Bool` elements, and `Bool` type aliases all participate.

Two operational changes round out the release. ponyc 0.63.4 ships prebuilt binaries for Ubuntu 26.04 on both arm64 and amd64, completing the Ubuntu 26.04 story that started with ponyup last week. The `binutils-gold` package has been removed from the `ponylang/ponyc` nightly and release Docker images. Nothing in ponyc uses gold, upstream has deprecated the package, and distros are dropping it from their repos. If your build inside one of those images depended on `binutils-gold` being present, install it explicitly with `apk add binutils-gold`.

See the [release notes](https://github.com/ponylang/ponyc/releases/tag/0.63.4) for the full list.

## Items of Note

### Pony Development Sync

The [recording](https://vimeo.com/1187911044) of the April 29, 2026 Pony Development Sync is up. The team worked through a queue of RFCs and pull requests across several repositories. [RFC 223](https://github.com/ponylang/rfcs/pull/223), the proposed `JSON.print` API for the standard `json` package, opened the meeting. I raised concerns about the testing approach and floated alternatives for the function name. The group then turned to [RFC 225](https://github.com/ponylang/rfcs/pull/225) (remove the `serialise` package from the standard library), which I agreed to take on. [PR 580](https://github.com/ponylang/pony-tutorial/pull/580) in [ponylang/pony-tutorial](https://github.com/ponylang/pony-tutorial) covering if-type documentation came up next, and the team made some adjustments to the examples to improve clarity. Several ponyc PRs followed: fixes for spurious name errors and compiler crashes tied to recursive type aliases, plus the `Bool` exhaustiveness work that landed in 0.63.4 and the LSP AST handling work in [PR 5227](https://github.com/ponylang/ponyc/pull/5227). [PR 5246](https://github.com/ponylang/ponyc/pull/5246) (finite recursive type aliases) drew the longest discussion. I pushed back on option 3, which involves string comparisons and threading. The meeting wrapped up on issue tickets, including documentation for `UDPSocket.writev` behavior and the state of an older RFC for compile-time expressions that never got proper implementation details.

### Office Hours

Adrian, Red, and I were there. Two Zulip threads ran most of the conversation. The first, [a possible compiler intrinsic for getting the size of a type](https://ponylang.zulipchat.com/#narrow/channel/189952-compiler-discussion/topic/compiler-intrinsic.20for.20getting.20the.20size.20of.20a.20type), started with a proposal from Matthias Wahl and turned into a real implementation. Red wrote a working version using `LLVMABISizeOfType` and opened [a PR](https://github.com/ponylang/ponyc/pull/5267). Adrian raised questions about which LLVM size measurement to use, plus alignment, padding, and what the function should do for unions. Questions worth an RFC. Red wrote [RFC 229](https://github.com/ponylang/rfcs/pull/229). The other thread, [`pony_alloc` vs `pony_alloc_final`](https://ponylang.zulipchat.com/#narrow/channel/189985-beginner-help/topic/pony_alloc.20vs.20pony_alloc_final), was Red asking whether to use `pony_alloc_final` for a raw C buffer because he'd seen it described as faster than `pony_alloc`. It isn't faster. The `_final` suffix means the allocation has a finalizer attached, not that you can't realloc it. And using it for raw bytes is actively unsafe: at GC sweep, the runtime takes the first 8 bytes of any final-tracked allocation and calls a finalizer through them. For raw bytes, those 8 bytes are whatever you wrote there. The right pattern is a Pony wrapper class with a `_final()` method that frees the buffer.

The rest of the conversation wandered. We worked through C++20's [memory ordering reference](https://en.cppreference.com/cpp/atomic/memory_order), the spec behind the runtime ordering changes that landed in 0.63.3. And Adrian brought up something Gemini had told him that didn't make sense to me. Turns out he's been using Gemini through its web interface. It doesn't read the ponyc source, so it's mostly guessing. That's the lesson: if you want an LLM doing real work on Pony code, it needs to read your source. Claude Code and Codex do. A purely web-based LLM doesn't, and it shows. From there we got into the [Pony-specific LLM skills](https://github.com/ponylang/llm-skills) I've been building and the loops they run inside: review loops, principle-review loops, ensemble loops. Lots of loops.

### I'm Away Next Week

I'm traveling for work and won't be at Office Hours on May 4 or the Pony Development Sync on May 6. Office Hours will be open as usual.

## Releases

- [ponylang/ponyc 0.63.4](https://github.com/ponylang/ponyc/releases/tag/0.63.4)

## RFCs

### Accepted

- [Remove serialise package from stdlib](https://github.com/ponylang/rfcs/pull/225)

### New

- [Withdraw RFC 53: Compile-Time Expressions](https://github.com/ponylang/rfcs/pull/227)
- [Socket runtime three-state result](https://github.com/ponylang/rfcs/pull/228)
- [Type Layout functions added to compiler to better support C-FFI](https://github.com/ponylang/rfcs/pull/229)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
