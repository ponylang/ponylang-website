# LLM Skills

[ponylang/llm-skills](https://github.com/ponylang/llm-skills) is a collection of skills for working with Pony in LLM coding harnesses. Each skill is a self-contained reference that your LLM loads on demand during coding sessions. Some skills provide Pony-specific knowledge (language reference, testing patterns). Others provide language-agnostic methodology (code review, debugging protocols, software design). All skills use a `pony-` prefix as an org namespace to avoid collisions with skills from other sources — the prefix is about where they come from, not what languages they apply to.

The skills require a harness that supports sub-agents. They're tested with [Claude Code](https://docs.anthropic.com/en/docs/claude-code) and compatible with [OpenAI Codex](https://developers.openai.com/codex), which loads the same `SKILL.md` format. If your harness supports sub-agents and can load skill files, the skills themselves are harness-agnostic.

If you're just getting started, load `pony-skills`. It's a routing index — it points you to the right skill for the task at hand, so it's the single trigger that covers all the others. For Pony coding sessions, `pony-ref` is the one to load every time. The rest are available when you need them.

## Installation

Clone the repo and run the install script. It detects which harnesses you have installed and symlinks each skill into their skills directory, so the skills stay up to date when you pull.

```bash
git clone https://github.com/ponylang/llm-skills.git
cd llm-skills
python install.py
```

With no arguments, `install.py` installs for every harness it detects: Claude Code (into `~/.claude/skills/`) and Codex (into `~/.agents/skills/`). To target a specific harness regardless of what's detected, pass `--claude` and/or `--codex`.

Start a new session and the skills are available.

To update:

```bash
cd llm-skills
git pull
```

No re-install needed. The symlinks point to your clone, so pulling new content updates the skills automatically.

To uninstall:

```bash
python install.py --uninstall
```

This removes the symlinks from your detected harnesses, or just the one you name with `--claude`/`--codex`. Your clone stays put.

## Skills

### Routing

#### pony-skills

A routing index for the other skills. Load it — or reference it from a project's `CLAUDE.md` or `AGENTS.md` — and it tells you which `pony-` skill to load for each task. It's the single-trigger alternative to wiring up every skill's trigger by hand, and a good place to start.

### Pony Language

#### pony-ref

The Pony language reference. Covers the capabilities table, subtyping rules, viewpoint adaptation, common gotchas, PonyCheck property-based testing patterns, and standard library pitfalls. Behind the quick reference, deeper documents are available for the LLM to read on demand: the full text of the nine Pony papers as PDFs, type-system and runtime/GC synopses distilled from them, and snapshots of the tutorial, patterns cookbook, and main website.

The reference documentation updates nightly from the Pony website and tutorial. Pull the repo often.

### Project Conventions

#### pony-examples-readme

Conventions for writing `examples/README.md` files in ponylang projects. Structure, description format, ordering, what to omit.

#### pony-library-readme

Conventions for writing Pony library project READMEs. Required sections, optional sections, what ponylang library READMEs deliberately omit.

#### pony-release-notes

How to write release notes and manage CHANGELOG entries in ponylang projects. Writing style, mechanics, changelog labels, and workflows. Assumes the target repo uses [changelog-bot-action](https://github.com/ponylang/changelog-bot-action) and [release-notes-bot-action](https://github.com/ponylang/release-notes-bot-action).

### Development Workflow

#### pony-software-design

Disciplines for software design work — APIs, type systems, features, system boundaries. Counters the tendency to retrieve familiar patterns instead of discovering what the problem needs. Has full (8-persona) and lightweight (5-persona) modes.

#### pony-code-review

Ensemble code review with specialized reviewer personas. Personas cover correctness, security, performance, API design, test quality, adversarial scenarios, design principles, and wildcard concerns. Has full (8-persona, iterative re-review) and lightweight (3-persona, single pass) modes.

#### pony-docs-review

Ensemble documentation review — the prose counterpart to `pony-code-review`, for documentation-only changes like tutorials, READMEs, and reference pages. Personas cover accuracy, completeness, clarity, structure, consistency, reader experience, design principles, and wildcard concerns. Has full (8-persona, iterative re-review) and lightweight (3-persona, single pass) modes.

#### pony-test-design

Two-stage ensemble for planning meaningful tests. Counters the tendency to write tests that exercise the stdlib instead of your code. Has full (8-persona) and lightweight (5-persona) modes.

#### pony-pbt-patterns

Property-based and generative testing patterns, built on one idea: chance is not coverage, so a generator has to bias toward where bugs live. Covers biasing toward important values, swarm testing (varying which operations are enabled so emergent state reaches the extremes), the valid/invalid/mixed boundary triad, compositional generators, and multi-angle oracles. Maps directly onto PonyCheck.

#### pony-debug

Structured debugging protocol with checkpoints. Provides an OODA-loop investigation process: characterize the failure, gather context, build a minimal reproduction, then iterate through hypothesis/experiment/observe cycles. Load it before forming any hypothesis about the cause.

### Infrastructure

These skills are internal plumbing used by the ensemble skills above. You don't invoke them directly.

#### pony-ensemble

The mechanical process for producing higher-confidence outputs through decorrelated reasoning paths. Multiple agents work the same problem with different attention focuses, then a synthesizer integrates their outputs. This is infrastructure — `pony-software-design`, `pony-code-review`, and `pony-test-design` build on it.

#### pony-synthesize

Fixed instructions for the ensemble synthesizer — integrates multiple agent outputs into a single result. Infrastructure loaded by `pony-ensemble` during the synthesis step.

## Using Skills

### Manual invocation

Load a skill on demand when you need it for the current task but don't want it loaded every session. In Claude Code, type the skill name as a slash command:

```text
/pony-ref
```

In Codex, skills load automatically based on their description, or you can name one explicitly with `$pony-ref`. Either way, the LLM loads the skill's reference material into context.

### CLAUDE.md and AGENTS.md triggers

Claude Code reads `CLAUDE.md` files at the start of every session — one global (`~/.claude/CLAUDE.md`) and one per project; Codex reads `AGENTS.md` the same way. You can add instructions to these files that tell the LLM when to load skills automatically. Each trigger is a sentence or two describing the condition and the action.

The simplest setup is a single trigger that loads `pony-skills`, the routing index, which then points to whatever the task needs:

```markdown
**Load `pony-skills` at the start of Pony work**: At the start of work in a
Pony project, load the `pony-skills` skill — a routing index that tells you
which `pony-` skill to load for each task.
```

Prefer to wire up skills individually? For example, to load the language reference at the start of every Pony coding session:

```markdown
**Load `pony-ref` proactively when working on Pony code**: At the start of
any conversation where the working directory is a Pony project (contains
`corral.json` or `*.pony` files), load `pony-ref` before doing any work.
Also load it mid-conversation when hitting capabilities, type system, runtime,
or testing questions.
```

To load the debugging protocol when needed:

```markdown
**Load `pony-debug` when you start debugging**: Before forming any hypothesis
about the cause of a non-trivial issue, load `pony-debug`.
```

To load code review for PRs:

```markdown
**Load `pony-code-review` for code reviews**: When conducting a code review
of a PR, branch, or local changes, load `pony-code-review`.
```

The trigger text is natural language. Write it so the LLM can match the condition to the current situation. The [ponylang/llm-skills README](https://github.com/ponylang/llm-skills#suggested-triggers) has suggested triggers for every skill.
