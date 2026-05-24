---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - May 24, 2026"
date: 2026-05-24T07:00:06-04:00
---

One theme song wasn't going to cover this week, so you're getting three, and all of them are gospel. [PR 5246](https://github.com/ponylang/ponyc/pull/5246) merged. Finite recursive type aliases are in ponyc, and the oldest open issue in the repository, eleven years on the books, is closed. I have been buried in this for weeks. It's done. So we open with Johnny Cash, ["It Was Jesus"](https://www.youtube.com/watch?v=EgqnTPtZ6gI) and ["Swing Low, Sweet Chariot"](https://www.youtube.com/watch?v=CMRWsOvFwP4), and then the Blind Boys of Alabama, ["Jesus Gonna Be Here Soon"](https://www.youtube.com/watch?v=ejUP4qD2Ja8). Hallelujah. It was a glorious week and I'm in the mood to celebrate.

There's more than the merge. Three blog posts went up telling the whole story behind the alias work, and we put our stance on AI-assisted contributions in writing. An exploratory port of Pony to Haiku opened, which made two old BeOS hands very happy. And the old HTTP libraries are on their way out.

<!-- more -->

## Eleven Years On: Finite Recursive Type Aliases Land

Here's the thing you can write now that you couldn't write a week ago:

```pony
type JsonValue is
  ( String
  | F64
  | Bool
  | None
  | Array[JsonValue]
  | Map[String, JsonValue])
```

That's the shape of JSON. A JSON value is a string, a number, a boolean, null, an array of JSON values, or an object mapping strings to JSON values. The definition points back at itself because JSON points back at itself. Until [PR 5246](https://github.com/ponylang/ponyc/pull/5246) merged, ponyc rejected it outright: `type aliases can't be recursive`. You got around that by wrapping the recursive parts in classes the compiler would accept. It worked. It was never what your design asked for.

The issue that asked for this is number 267. Joe Eli McIlvain opened it on July 23rd, 2015, while writing a pure-Pony JSON library. He hit the recursive alias wall and filed a bug with a JSON type as the example. Eleven years later, that same JSON type is the example in the pull request that closed his issue. Number 267 was the oldest open issue in ponyc. It isn't anymore.

I wrote three posts on it while the work was underway, and they run in order. ["Eleven years to a finite recursive type alias"](https://www.ponylang.io/blog/2026/05/eleven-years-to-a-finite-recursive-type-alias/) is the story of why it took so long, and why issue 267 sat open for over a decade. ["Inside Pony's Finite Recursive Type Aliases"](https://www.ponylang.io/blog/2026/05/inside-ponys-finite-recursive-type-aliases/) gets into the algorithm that decides which recursive aliases are legal, because not all of them are. `type Loop is Loop` is still nonsense, and the compiler still says so. ["Making Finite Recursive Type Aliases Compilation Fast"](https://www.ponylang.io/blog/2026/05/making-finite-recursive-type-aliases-compilation-fast/) is about the part that nearly sank the whole thing: a legality check that was correct, but on a big enough tangle of mutually recursive aliases sent the type checker into eleven minutes of churning with no end in sight. Correct wasn't enough. It had to finish.

## Items of Note

### Office Hours

Office Hours on May 18. Red, Adrian, and me. Red has a script that tracks RFC status, and we spent a while on that. From there it wandered into C-FFI, and the trouble that comes from a C union and a Pony union not being the same animal when you're binding C. Red got onto codegen, macros, and comptime, and the Pony he wishes he had. That got us onto [spooky action at a distance](https://www.seantallen.com/posts/spooky-action-at-a-distance/), which I've written about. Case methods came up too.

### Pony Development Sync

The [recording](https://vimeo.com/1194768508) of the May 20 Pony Development Sync is up, and RFCs led the meeting. [RFC 223](https://github.com/ponylang/rfcs/pull/223), the proposed `Json.print` API, moved to final comment period. I still have a slight hesitation about the implementation not being stringable, but agreed to let it proceed. [RFC 229](https://github.com/ponylang/rfcs/pull/229), the ABI memory layout work, had Red walking through his use case, which is generating documentation, and my take was that the piece he needs might fit better in C than in Pony.

On the ponyc side, the group approved a batch of fixes for compiler crashes around type checking and trait default methods. They also worked through the AI-assisted contributions policy doc and a PR that reworks how Pony implements errors, replacing the current stack-unwinding approach.

The discussion I'd flag: Joe and I went back and forth on a pure-Pony `String.f32` and `String.f64`, and Joe pointed at the Ryu algorithm as a better approach than what's there now. And Red announced a conference talk coming up, "Teaching AI to Code Pony."

### No Office Hours on May 25

I won't be hosting Office Hours on May 25. It's Memorial Day here in the US and I'm taking it off. The room will be open, so if you want to drop in and have a good time, go right ahead.

### Pony's AI-Assisted Contributions Policy Is Now Official

We wrote down what's been informal practice for a while. [A PR](https://github.com/ponylang/ponyc/pull/5357) merged into ponyc's `CONTRIBUTING.md` that makes the policy explicit. Contributions are welcome whatever the source. But an AI-assisted PR needs to have gone through `pony-code-review` from [ponylang/llm-skills](https://github.com/ponylang/llm-skills) first, with every finding understood and addressed. We recommend that same workflow for any contribution. It also restates the junk-PR policy we've always had, now that AI has made producing junk effortless. The same language has gone out across the rest of the repos, and every "pony" and "documentation" repo now carries an `AGENTS.md` that points AI users at our llm-skills, tells them to keep them current, and sends them to read the contributing guide.

### A Big Week for the llm-skills

The [llm-skills](https://github.com/ponylang/llm-skills), the Pony coding skills for AI assistants, had a busy week, and one change in there matters enough that you should update right away. A handful of the skills, `pony-code-review`, `pony-test-design`, `pony-software-design`, and `pony-ensemble`, used to read the design principles they work from out of my own global config. If you weren't running my exact setup, and almost nobody is, those skills were running without the principles they're built around. That's fixed. The principles are bundled into the skills now, so they hold up no matter whose machine they run on.

There's more than the fix. A new `pony-docs-review` skill landed, an ensemble review for documentation-only changes, the prose counterpart to `pony-code-review`. The skills run on OpenAI Codex now, not just Claude Code. `pony-pbt-patterns` got reworked around swarm testing and important-values techniques for generative tests. And the `pony-ref` reference papers are bundled as PDFs the skill reads from directly. If you use the skills, [pull the latest](https://github.com/ponylang/llm-skills).

### An Exploratory Port to Haiku

Marcin Konicki opened [an exploratory port of Pony to Haiku](https://github.com/ponylang/ponyc/pull/5358). [Haiku](https://www.haiku-os.org/) is the open-source heir to [BeOS](https://en.wikipedia.org/wiki/BeOS), and since Sylvan and I were both BeOS developers back in the day, this one made us smile. It's early and it's open, not merged. The port passes the full test suite with a couple of platform-specific accommodations, and the examples run. There are still rough edges to sort out around runtime tracing and systematic testing. Getting it into CI would mean running Haiku under QEMU, which Marcin says would be a little hacky. Early days, but a fun one to watch.

### OpenBSD Support

[OpenBSD 7.9](https://www.openbsd.org/79.html) shipped recently. In the near future, we'll move the supported OpenBSD for Pony over to it.

### ponylang/http and ponylang/http_server Are Headed Out

Two libraries are on their way out. [ponylang/http](https://github.com/ponylang/http), the HTTP client, and [ponylang/http_server](https://github.com/ponylang/http_server), the HTTP server, are being deprecated. The replacements are [ponylang/courier](https://github.com/ponylang/courier) for the client side and [ponylang/stallion](https://github.com/ponylang/stallion) for the server. If you're building HTTP into a Pony app, that's where things are headed.

### contact-red/libxml2 1.2.0

[contact-red/libxml2](https://github.com/contact-red/libxml2), Red's Pony bindings to the libxml2 C library, put out [1.2.0](https://github.com/contact-red/libxml2/releases/tag/1.2.0), and there's real meat in it. The headline for anyone parsing untrusted XML: parsing is safe by default now. `parseDoc` and `parseFile` route through libxml2 with no network access, no entity substitution, and no external DTD loading unless you ask for them, which closes off the usual XXE and SSRF holes without every caller having to know to opt in. Parsing and XPath also stopped raising on failure. They hand you back a union of the result or a structured `Xml2Error` you can match on and read. There are new namespace-aware accessors for documents that use XML namespaces. And a memory leak got fixed: every call that read an attribute or a node's content used to leak the underlying C string, so a tree-walk over a big document grew memory without bound. The error change and the safe-by-default change are both breaking, so a 1.2.0 upgrade comes with some migration, but that leak fix alone is worth the trip.

## Releases

- [contact-red/libxml2 1.2.0](https://github.com/contact-red/libxml2/releases/tag/1.2.0)

## RFCs

### Final Comment Period

- [Json.print() api in stdlib json package](https://github.com/ponylang/rfcs/pull/223)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
