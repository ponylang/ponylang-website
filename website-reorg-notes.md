# Website Reorganization Notes

## The Three-Persona Model

The site serves three audiences at different stages of the same journey:

1. **Discover** — "Should I invest my time learning Pony?"
2. **Learn** — "I've decided to learn. Guide me."
3. **Use** — "I'm a Pony programmer. What do I need day-to-day?"

## What Shipped (PR #1151)

### Homepage replaces the Discover tab

The old homepage was a flat list of links. The new one absorbs the Discover
content directly:

- **Hero** with tagline and three CTA buttons (Get Started, Try It in Your
  Browser, Install)
- **What Pony Guarantees** — the feature list (type safe, memory safe,
  data-race free, deadlock-free, exception-safe, native code, C-compatible)
- **Code sample** — party invitations (Option B) showing three actors
  coordinating via message passing, with a link to run it in the Playground
- **Pony's Design Philosophy** — condensed Philosophy and Guiding Principles,
  reframed as promises to the user, with links to the full pages
- **Why Pony / Why Not Pony** — teaser paragraphs with links to the full pages
- **Start Learning** — focused call to action for someone who just finished
  the Discover journey

The full Why Pony, Why Not Pony, Philosophy, and Guiding Principles pages
still exist and are linked from the homepage.

### Nav changes

- **Discover** tab removed (content on homepage)
- **Sponsors** tab removed (link in footer)
- Current tabs: Home, Learn, Use, Contribute, Community, Blog, FAQ

### Footer

Structured Material theme footer via the `copyright` field in `mkdocs.yml`:

- **Resources**: Blog, FAQ, Releases, Planet Pony
- **Project**: Sponsors, Community Norms, Contributing
- Social icons: GitHub, Twitter, Zulip

## Research: How Other Language Sites Handle This

Reviewed Rust, Go, Elixir, Zig, Gleam, Erlang, Nim, and Crystal.

**Key finding**: Every site puts the evaluation/pitch content directly on the
homepage. None have a separate "Discover" tab. The homepage does that job.

Common homepage pattern:

1. Hero (tagline + CTA)
2. Key differentiators (3-4 pillars or features)
3. Code sample(s)
4. Use cases or social proof
5. Community/getting started CTAs

Two things Pony's site was missing that others do well:

- **Code on the homepage.** Nearly every other language site shows actual code.
  (Now addressed.)
- **"What is this good for?"** Go has case studies, Rust has domain cards,
  Elixir has tagged case studies. Pony says what it *is* but not what you'd
  *build with it*. (Still a gap — see discussion #1152.)

## Decisions Made

- **"What is Pony?" and "What makes Pony different?" get absorbed into the
  homepage.** They're short and punchy enough to be homepage sections, not
  separate pages.
- **Philosophy and Guiding Principles are evaluation content, not internal
  project docs.** Knowing that correctness is valued above performance, that the
  project promises "no crashes" and "fully defined semantics" — these are
  commitments that affect what a user can expect. They belong in the Discover
  story, not in Learn or Contribute.
- **Not all Discover content belongs on the homepage.** The full Why Pony,
  Why Not Pony, Philosophy, and Guiding Principles pages are too much for a
  single page. The homepage has condensed/teaser versions with links to the
  full pages.
- **The Discover tab is removed.** Its deeper pages still exist and are linked
  from the homepage.
- **Sponsors tab is removed.** Linked from the footer instead.
- **Section headings avoid uniqueness claims.** "What Makes Pony Different"
  became "What Pony Guarantees" (many of those properties exist in other
  languages — the heading shouldn't invite pedantic objections). "How Pony
  Thinks" became "Pony's Design Philosophy" (direct and descriptive).
- **Bottom of homepage focuses on Learn, not wayfinding.** An earlier draft had
  a three-persona "Get Going" section (Learn / Use / Community). It felt like
  "just a bunch of stuff." The person who's read the whole homepage has finished
  Discover and is ready for Learn — so the bottom is a focused "Start Learning"
  section instead.

## Homepage Code Sample

### Research

Searched all Pony code in `ponylang/` and `seantallen-org/` repos. Best
existing candidates:

- **Counter** (`ponyc/examples/counter/`) — Two actors, 32 lines. Main creates
  a Counter, sends `increment()` messages, asks for result back via
  `get_and_reset(this)`. Counter replies by calling `main.display()`. Clear
  message passing, right size.
- **Ring** (`ponyc/examples/ring/`) — Actors linked in a circle passing
  messages. Compelling concurrency narrative but 129 lines as-is. Would need
  heavy trimming (remove CLI parsing) to get to ~20 lines.
- **Mailbox** (`ponyc/examples/mailbox/`) — Multiple senders, one receiver.
  Fan-in pattern. Less visually interesting.

Everything else (fan-in, http_server, postgres, lori, reactive streams, msgpack)
is too long, too domain-specific, or doesn't foreground actors.

### The Problem

None of the existing examples fully demonstrate "data-race freedom" in a way
that's immediately visible to a newcomer. Counter shows actors and message
passing, but a newcomer might think "I could do this with a function call."
The safety story is about what's *absent* — no locks, no mutexes, no
synchronization — and that's hard to show in code alone.

### Option A: Workers and Collector (not used)

Custom-written. Three Worker actors each receive a reversed string, reverse it,
and send the result to a Collector. The Collector streams results as they arrive
and prints a joined summary when all are in. Surrounding homepage text (not
inline comments) explains what's happening.

Shows: `val` (immutable strings passed between actors), `consume` (ownership
transfer), `iso` (return type of `reverse()` and `join()`), actors with private
mutable state (`_results`), no locks/synchronization.

```pony
actor Collector
  let _env: Env
  var _results: Array[String val] = _results.create()
  let _expected: USize

  new create(env: Env, expected: USize) =>
    _env = env
    _expected = expected

  be collect(result: String val) =>
    _results.push(result)
    _env.out.print(result)
    if _results.size() == _expected then
      let summary = " | ".join(_results.values())
      _env.out.print("---")
      _env.out.print("All done: " + consume summary)
    end

actor Worker
  let _collector: Collector

  new create(collector: Collector) =>
    _collector = collector

  be run(name: String val, task: String val) =>
    let reversed = task.reverse()
    let result: String val = name + " finished: " + consume reversed
    _collector.collect(result)

actor Main
  new create(env: Env) =>
    let collector = Collector(env, 3)

    Worker(collector).run("Alice", "atad ezylana")
    Worker(collector).run("Bob", "troper dnes")
    Worker(collector).run("Carol", "sgol kcehc")
```

Verified to compile. Runs instantly (playground-compatible). Tasks read as
gibberish in, english out ("Alice finished: analyze data").

### Option B: Party Invitations (shipped)

Custom-written. Main creates a Party actor and sends it three `add_friend`
messages. For each friend, Party creates a Friend actor inline and invites it.
Each Friend decides whether to attend (name length > 3) and sends an RSVP back
to the Party. When all responses are in, Party prints the guest list.

Shows: `val` (immutable strings passed between actors), actors with private
mutable state (`_guests`, `_expected`, `_responded`), lightweight inline actor
creation (`Friend(name).invite(this)`), three-hop message flow
(Main -> Party -> Friend -> Party), no locks/synchronization. Actor scheduling
means output order isn't guaranteed — demonstrates real concurrency.

Advantages over Option A: more relatable metaphor (everyone understands party
invitations), richer message flow (three hops vs two), Friend actors have
autonomy (they decide), inline actor creation shows how lightweight actors are.
Disadvantages: no visible `consume`/`iso` usage.

Playground gist: `https://playground.ponylang.io/?gist=965abaa0cb468c36d241582768265e29`

## Open Questions

Remaining open questions are tracked in discussion #1152:

- What should the Learn section look like?
- Should Contribute split into contributor vs. maintainer tiers?
- What happens to FAQ (keep as tab, fold into other sections, or demote to
  footer)?
- Should Blog stay as a top-level tab?
- Community and Contribute have overlapping content (Development Sync, Getting
  Help)

Content gaps also tracked there:

- "What is Pony good for?" — use cases / what people build with it
- Learning path content beyond outbound links
- Planet Pony staleness
