---
name: ponylang-prose-review
description: Ensemble review of ponylang blog and Last Week in Pony prose. Runs lens personas in parallel — house voice, narrative, reader-orientation, tightness, content-honesty, plus a conditional accuracy lens — checks the draft against the AGENTS.md editorial guidelines and the craft rules, and returns Fix/Park findings. Self-contained: no dependency on any other skill. Load after a draft exists, before the post PR.
disable-model-invocation: false
---

# Review for ponylang prose

The review that applies the ponylang Last Week in Pony house style and the craft rules to a
draft with fresh, decorrelated eyes. A single generic copy-editor pass collapses every
concern into "looks fine" and misses the failures that matter — enumeration instead of
narrative, prose reproduced from a linked source, an invented framing, an unearned promise, a
fabricated characterization, a wrong technical claim. This decomposes the review so each gets
its own lens.

This skill is **self-contained** — it loads no other skill. All the ensemble mechanics it
needs are inlined below; nothing comes from `pony-ensemble` / `pony-synthesize` or any
personal skill. A contributor with only this repo's `.claude/` can run it.

## When to run

After a draft of ponylang prose exists, before it ships:

- Last Week in Pony posts (the main case).
- Other ponylang blog posts.
- The Pony Development Sync issue comment produced by `dev-sync-summary`, if you want more
  than its built-in self-review.

## Two rulebooks this skill reads

- **The AGENTS.md "Last Week in Pony" section** — the house voice (tone, em-dash frugality,
  backtick technical terms, Office Hours singular, `owner/repo` naming, conversational not
  clipped). The House-voice persona reads it.
- **`references/craft-rules.md`** (alongside this skill) — narrative, reader-orientation,
  tightness, content-honesty/source-fidelity. The other craft personas read the relevant
  sections.

## Mode selection by size

Count the draft's **prose paragraphs**: blank-line-separated blocks of running prose. Do not
count fenced code blocks, YAML front matter, headings, or list items.

```
PARAGRAPH_THRESHOLD = 2
```

- **> 2 prose paragraphs → full review.** The five-lens ensemble below — six when the draft
  has code or technical claims, where the conditional Accuracy lens joins. A post is always
  full.
- **≤ 2 prose paragraphs → cheap inline pass.** No subagents. The orchestrator reads the
  draft once against the AGENTS.md house style and the content-honesty section of
  `craft-rules.md` (pulling the source bundle if a claim needs checking), plus the mechanical
  pre-check, and returns Fix/Park findings directly.

`PARAGRAPH_THRESHOLD` is one line on purpose — move it when the size heuristic misjudges an
artifact.

## Source bundle

The content-honesty and tightness personas can only catch fabricated claims, flattened source
voice, and reproduced-source if they have the source. Assemble it per artifact and hand it to
**both** of those personas (the house-voice, narrative, and orientation personas work from the
draft and their rulebook):

| Artifact | Source bundle |
|---|---|
| LWIP post | the rotated issue + all its comments; linked prior posts; release notes (`gh release view`); linked PRs/issues (`gh`) |
| other blog post | linked posts; release notes / `gh release view`; the originating discussion or issue |
| dev-sync comment | the raw summary; the linked PRs/issues/RFCs (`gh`) |

A raw meeting summary and machine-generated recaps are leads to verify, not copy — pull facts
from them, never trust their wording or their number-to-title mapping.

## Mechanical pre-check (scripted, not an agent)

Run before spawning personas; feed results to synthesis. LWIP and blog posts live in this
repo's buildable, cspell'd site, so all of these apply:

- **cspell** over the file.
- **`mkdocs build --strict`** (set up the venv per the project README/CLAUDE.md if needed).
- **em-dash count** (flag heavy use).
- **link-target sanity** — does each link's text match what it points at?

For a dev-sync issue comment (not a repo file): em-dash count + link sanity only.

## Full process

1. **Identify the artifact and assemble the source bundle** (tables above).
2. **Run the mechanical pre-check.** Capture results.
3. **Make an evidence dir:** `~/tmp/prose-review-<timestamp>/`. Each persona writes its
   detailed evidence to a file there; pass the path in the prompt.
4. **Spawn the lens personas in parallel**, each a fresh-context subagent on your most capable
   model. Five always run: House-voice, Narrative, Orientation, Tightness, Content-honesty. A
   sixth, **Accuracy**, joins **only when the draft has code or makes technical/behavioral
   claims about a system** (compiler internals, an API, a release); skip it otherwise. Each
   prompt includes:
   - The persona document, read from `personas/<lens>.md`.
   - Its rulebook slice: the **House-voice** persona gets the AGENTS.md "Last Week in Pony"
     section and 2–3 recent posts from `docs/blog/posts/` for calibration; the Narrative,
     Orientation, Tightness, and Content-honesty personas get the relevant sections of
     `references/craft-rules.md`. The **Accuracy** persona reads the actual source instead.
   - The draft in full.
   - For the **Content-honesty** and **Tightness** personas: the full source bundle.
   - For the **Accuracy** persona: the source the draft describes (the repo/files, release
     notes, the version it targets).
   - The shared persona output format (below).
   - "You are an ensemble agent — return findings to the orchestrator, take no external
     actions, edit nothing."
5. **Triage persona outputs** — confirm each addressed the actual draft and stayed on its
   lens. Drop nothing silently.
6. **Synthesize** (inlined below).
7. **Triage into Fix / Park** and act (below).

## Shared persona output format

Include in every persona prompt. Each persona produces two artifacts.

**Evidence file** (written to the provided path): every finding with the exact quoted text
from the draft, what's wrong, the rule it violates, and the concrete rewrite.

**Summary** (returned to the orchestrator):

- **Findings**, ordered by severity (Blocking > Should-fix > Minor). Each:
  - **Quote**: the exact span from the draft.
  - **Lens**: this persona.
  - **Problem**: what's wrong (concise — full reasoning is in the evidence file).
  - **Fix or Park**: is the right change obvious (Fix), or does it need the author's judgment
    (Park)? With the suggested rewrite (Fix) or the question (Park).
- **Passes**: key things checked that read true. Brief.
- **Uncertainties**: anything the persona couldn't judge without the author or more source.

## Synthesis (inlined)

The synthesizer is a fresh-context agent (or the orchestrator) given all persona summaries and
the mechanical-check results, with these instructions:

**Job:** integrate the persona findings into one deduplicated list. You are not averaging
opinions — you are assembling the strongest, non-redundant set of findings.

**Focus:**
- **Don't drop anything.** Every persona finding appears in the output or is explicitly merged
  into another. A review that surfaces a real problem and then loses it has wasted the
  discovery.
- **Cross-persona corroboration is high-confidence.** When two personas flag the same span
  from different angles, merge them into one finding marked high-confidence — never let each
  assume the other owns it and drop both.
- **Clusters signal structure.** Several small findings in one section often mean the section's
  shape is wrong (an enumeration, a reproduced source, a missing on-ramp). Call out the
  structural problem, not just the symptoms.
- **Severity stands.** If one persona says Blocking with evidence and another didn't mention
  it, it's Blocking. Don't soften by consensus.

## Fix / Park triage

Categorize every finding. Nothing is silently dropped.

- **Fix** — the right change is obvious: a misspelling, an unclear antecedent, a term used
  before it's introduced, an enumeration to reweave, prose reproduced from the linked source,
  an unbackticked technical term, an em-dash glut, a fabricated characterization to cut.
  Apply these directly.
- **Park** — needs the author: a framing or thesis the draft asserts that no source supports,
  a thematic hook, a tone call, a metaphor to keep or cut. **Never ship a parked call as
  final.** Batch parked items and present them as questions.

When run inside the `lwip` pipeline: apply the Fix items, list the Park items for the author,
and proceed. When run standalone: return both lists.

## Output format

```
## Prose review — <artifact>  (<full | inline pass>, N findings)

### Applied (Fix)
- <quote> → <change>  [lens]
...

### Raise with the author (Park)
- <quote> — <the question>  [lens]
...

### Mechanical
- cspell: <clean | issues>   build: <pass | fail>   em-dashes: <count>   links: <ok | …>

### Passes
- <brief confidence notes>
```

## The lenses

| Persona | Catches |
|---|---|
| `house-voice.md` | ponylang LWIP house style: tone (Hemingway, conversational not clipped), em-dash frugality, backtick technical terms, Office Hours singular, `owner/repo` naming, AI tells, clipped-imperative cadence. Reads the AGENTS.md guidelines; calibrates on recent posts. |
| `narrative.md` | enumeration vs story, at section **and** prop level (a snippet/line-count/parenthetical can be dead cargo inside a good section). |
| `orientation.md` | concept-before-use, unclear antecedents, missing on-ramps, offloaded context, compressed recaps that strip framing, missing prerequisites. |
| `tightness.md` | reproduced linked source, props that don't earn their place, filler, wrong altitude for the artifact. **Gets the source bundle.** |
| `content-honesty.md` | unsourced or fabricated claims, invented framing, invented quantitative characterizations, unearned promises, flattened source personality, lifted wording from unvetted sources, authorship/tense honesty. **Gets the source bundle.** |
| `accuracy.md` | **conditional** — runs only when the draft has code or technical/behavioral claims. Verifies code, API signatures, behavior and version claims, PR/issue numbers and titles against the actual source. |
