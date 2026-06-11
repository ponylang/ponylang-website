---
name: dev-sync-summary
description: Turn a Pony Development Sync meeting summary into a fact-checked comment on the open "Last Week in Pony" issue
disable-model-invocation: true
---

Turn a raw Pony Development Sync meeting summary (for example, a Zoom AI recap)
into a polished, fact-checked comment on the open "Last Week in Pony" issue.

## Where this fits

This skill produces *raw material*, not a finished post. The comment it writes
lands on the open "Last Week in Pony" issue, where the `lwip` skill later reads
it (alongside the week's other comments) and weaves it into the blog post. Your
job here is one comment: an accurate, readable recap of one Pony Development
Sync. You are not writing the post.

## Critical: never fabricate; interview for anything uncertain

This is the whole job. Get it wrong and you have poisoned the raw material that
the post is built from.

Every factual claim in the comment must come from a verifiable source: the raw
summary itself, a linked PR/issue/RFC confirmed with `gh`, git history, or the
user. This applies to more than the obvious facts. It applies to PR and RFC
numbers, to their titles, to *the relationships between items* ("fixes the same
bug as", "the opposite of", "stacked on"), to who attended or said what, and to
every characterization — "intermittent", "crash", "long-standing", "minor",
"affects everyone". Duration, severity, history, and impact are factual claims.
If you cannot substantiate one, do not write it.

A raw meeting summary is often machine-generated and lossy. It will mangle
identifiers ("Pony C" for `ponyc`), guess at titles, and state relationships
nobody confirmed. Treat it as a set of leads to verify, not as copy to polish.

When the summary is ambiguous, when something will not verify, or when you feel
yourself reaching for a plausible-sounding detail to smooth a gap: **stop and
ask the user.** Multiple rounds of questions are expected, not a failure.
Correctness beats getting a draft up fast. Turn it into an interview if you need
to.

Never invent a type name. Never assert a relationship you have not read. Never
guess a repository or a number. The numbered steps below place the
stop-and-ask gates where they actually bite.

## Inputs

You need three things from the user:

- the raw meeting summary,
- the meeting date (for the comment header and front matter elsewhere), and
- the recording URL.

If any are missing, ask before proceeding. If the recording is not posted yet,
do not invent or guess a URL — ask whether to wait for it, omit the `Recording:`
line, or use a placeholder the user gives you.

## Voice and format

Write in the team's collective voice — "we" — in Sean's prose style: flowing
narrative, varied sentence length, opinions stated plainly, no AI tells. It is a
recap of a group meeting, so "we" is the subject. Do **not** write it in the
first person "I"; that voice belongs to the finished post, which `lwip` frames
itself.

Load the `seans-voice` skill for the voice. From this project's AGENTS.md, take
only two things: the tone notes (Hemingway-esque, conversational, not clipped)
and the `owner/repo` reference convention. Ignore the blog-post format in
AGENTS.md (front matter, `## Items of Note`, footer) — that is for the published
post, not for a comment. AGENTS.md is already in context via the project
CLAUDE.md, so reference it; do not copy it in.

No feature checklists. No choppy sequences of disconnected facts. If a paragraph
would lose nothing as a bullet list, rewrite it.

## Citing PRs, issues, and RFCs

Cite every PR, issue, and RFC as `owner/repo NNNN`, rendered as a markdown link
to its canonical URL — for example, `[ponylang/ponyc 5431](https://github.com/ponylang/ponyc/pull/5431)`.
No bare "PR 5431"; no one owns a number any more than they own a name.

Always resolve the real title with `gh`. Never trust the number-to-title mapping
in the raw summary. RFCs live in `ponylang/rfcs` and may be **issues or pull
requests** — check which before you link. (In the worked example below, "RFC
232" was issue #232, not a PR.)

## Steps

1. **Gather inputs.** Confirm you have the summary, the date, and the recording
   URL. Ask for anything missing (see Inputs).

2. **Extract and verify every reference.** Pull every PR/issue/RFC number out of
   the summary. For each, confirm it with `gh`:
   - `gh pr view N --repo ponylang/ponyc --json title,url`
   - `gh issue view N --repo OWNER/REPO --json title,url`

   Capture the real title and canonical URL from `gh`, not from the summary.
   **Stop gate:** if a number does not resolve — wrong repo, typo, transposed
   digits — do not guess the repo or change the number. Ask the user.

3. **Verify every claimed relationship.** Wherever the summary (or your draft)
   says two items relate — a contrast, a cause, "fixes the same bug", "the
   opposite symptom", "stacked on" — read the PR bodies (and the diffs if you
   need them) and confirm the claim holds. Fix it, drop it, or ask. Do not ship
   a relationship you inferred from titles alone.

4. **Verify characterizations.** For every "intermittent", "crash",
   "long-standing", "minor", "affects everyone", and the like, confirm it
   against the PR/issue or ask. Drop what you cannot substantiate.

5. **Write the narrative.** Team "we", Sean's prose style. Open with a sentence
   that frames the shape of the sync, then walk the items with connective
   tissue between them. Cite each reference as `owner/repo NNNN` linked to its
   URL.

6. **Find the open issue.** Run:

   ```
   gh issue list --repo ponylang/ponylang-website --label last-week-in-pony --state open
   ```

   **Stop gate:** if this returns zero issues or more than one, do not pick one.
   Ask the user which issue to use (or to open one).

7. **Guard against duplicates.** Read the open issue's comments
   (`gh issue view N --repo ponylang/ponylang-website --json comments`). If one
   already begins with `{Month Day, Year} Pony Development Sync.` for this date,
   stop and ask before adding a second — this skill always creates a new
   comment, so a re-run would otherwise duplicate.

8. **Pre-post checks.** Before posting:
   - **Fabrication audit.** Re-read the draft. Every number, title, link,
     relationship, and characterization must trace to a source you verified this
     session. Anything that does not — verify it or cut it.
   - **Voice self-review.** One anti-pattern at a time, per the `seans-voice`
     skill: anthropomorphizing, unclear antecedents, AI tells, inflated claims,
     choppy fact sequences.

9. **Post the comment.** Write the body to a temp file under `~/tmp` (create the
   directory first with `mkdir -p ~/tmp` if it is missing) and post a new
   comment:

   ```
   gh issue comment N --repo ponylang/ponylang-website --body-file ~/tmp/dev-sync-comment.md
   ```

   Use the format:

   ```
   {Month Day, Year} Pony Development Sync.

   Recording: {url}

   {narrative}
   ```

   Report the comment URL to the user, then delete the temp file.

## What good looks like

A real run, from the June 10, 2026 sync.

The raw input was a Zoom recap — lossy and not to be trusted as copy:

> The meeting focused on reviewing several pull requests and RFCs related to
> Pony programming language development. Sean presented PR 5431, which proposes
> splitting one pointer type into two distinct types [...] They also reviewed
> PR 5420 fixing intermittent crashes during multi-threaded compilation, PR 5423
> rejecting self-referential if-type constraints in lambdas and object literals,
> and PR 5443 fixing incorrect rejection and crashes for if-type conditions
> inside lambdas. The conversation ended with a brief discussion of RFC 232
> regarding allowing optimization options when using Pony C [...]

The posted comment, after verification:

> June 10, 2026 Pony Development Sync.
>
> Recording: https://vimeo.com/1200285225
>
> This week's sync was mostly a pass through the review queue, with one larger
> design conversation up front.
>
> That design conversation was [ponylang/ponyc 5431](https://github.com/ponylang/ponyc/pull/5431),
> which splits our single pointer type in two. [...] `Pointer` keeps the memory
> Pony owns and manages. `UnsafePointer` takes the foreign memory crossing the
> FFI boundary. [...]
>
> From there it was the queue. [ponylang/ponyc 5420](https://github.com/ponylang/ponyc/pull/5420)
> fixes the intermittent crashes we'd been hitting when compiling on multiple
> threads at once. The next two land on opposite sides of the same corner of the
> language. [ponylang/ponyc 5423](https://github.com/ponylang/ponyc/pull/5423)
> starts rejecting self-referential `iftype` constraints inside lambdas and
> object literals [...]. [ponylang/ponyc 5443](https://github.com/ponylang/ponyc/pull/5443)
> goes the other way [...].
>
> Last on the agenda was [ponylang/rfcs 232](https://github.com/ponylang/rfcs/issues/232),
> about allowing optimization options when using ponyc. [...]

What the verification changed, and why each step exists:

- **"Pony C" became `ponyc`** — the recap mangled the identifier. Step 2.
- **Every PR title came from `gh`, not the recap.** The recap's "fixing
  incorrect rejection and crashes for if-type conditions inside lambdas" was
  missing "and object literals", which `ponylang/ponyc 5443`'s real title
  includes. Step 2.
- **"RFC 232" was an issue, not a PR** — `ponylang/rfcs 232` links to
  `/issues/232`. Guessing `/pull/232` would have 404'd. Step 2.
- **The 5423/5443 "contrast" was confirmed by reading both PRs**, not inferred
  from titles: one tightens (rejects what was wrongly accepted), the other
  loosens (accepts what was wrongly rejected), and 5443 is stacked on 5423.
  Step 3.
- **`iftype` is the real keyword**, not "if-type". Voice/accuracy.
