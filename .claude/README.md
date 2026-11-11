# Repository skills

Skills for working on the ponylang website with an AI assistant. Each lives in its own directory under `.agents/skills/` with a `SKILL.md`. They are self-contained — they don't depend on any personal or external skill, so a contributor with just this repo can use them.

Codex discovers the skills in `.agents/skills/`; invoke one with `$name` or browse `/skills`. Claude Code discovers relative directory symlinks in `.claude/skills/` that point to the same files; invoke one with `/name`. Edit the canonical files in `.agents/skills/`. The `dev-sync-summary` skill requires explicit invocation in both clients.

## Skills

- **`lwip`** — write the weekly Last Week in Pony blog post. Rotates the open "Last Week in
  Pony" issue, reads the week's collected items, verifies them, and drafts the post in the
  format and voice defined in the repo's `AGENTS.md`. Step 8 of its workflow reviews the draft
  with **`ponylang-prose-review`** before opening the post PR.

- **`dev-sync-summary`** — turn a raw Pony Development Sync recap (for example a Zoom AI
  summary) into a fact-checked comment on the open "Last Week in Pony" issue. It produces raw
  material for the post, not the post itself; `lwip` later weaves the comment in.

- **`ponylang-prose-review`** — ensemble review for ponylang blog and Last Week in Pony prose.
  Runs lens reviewers in parallel — house voice, narrative, reader-orientation, tightness,
  content-honesty, plus a conditional accuracy lens — checks the draft against the `AGENTS.md`
  editorial guidelines and its own craft rules, and returns findings to apply (Fix) or raise
  with the author (Park). Run it on any LWIP or blog draft before opening the post PR; `lwip`
  invokes it as part of its workflow.
