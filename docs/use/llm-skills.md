# LLM Skills

[ponylang/llm-skills](https://github.com/ponylang/llm-skills) is a collection of skills for working with Pony in LLM coding harnesses. Each skill is a self-contained reference that your LLM loads on demand during coding sessions. Some skills provide Pony-specific knowledge (language reference, testing patterns). Others provide language-agnostic methodology (code review, debugging protocols, software design). All skills use a `pony-` prefix as an org namespace to avoid collisions with skills from other sources — the prefix is about where they come from, not what languages they apply to.

The skills require a harness that supports sub-agents. The installer currently targets [Claude Code](https://docs.anthropic.com/en/docs/claude-code). If your harness supports sub-agents and can load skill files, the skills themselves are harness-agnostic.

If you're just getting started, `pony-ref` is the one to load every session. The rest are available when you need them.

## Installation

Clone the repo and run the install script. It symlinks each skill into your harness's skills directory so they stay up to date when you pull.

```bash
git clone https://github.com/ponylang/llm-skills.git
cd llm-skills
python install.py
```

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

## Skills

### Pony Language

#### pony-ref

The Pony language reference. Covers the capabilities table, subtyping rules, viewpoint adaptation, common gotchas, PonyCheck property-based testing patterns, and standard library pitfalls. Behind the quick reference, deeper documents — academic papers on the type system, runtime and GC synopses, tutorial and patterns content — are available for the LLM to read on demand.

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

#### pony-test-design

Two-stage ensemble for planning meaningful tests. Counters the tendency to write tests that exercise the stdlib instead of your code. Has full (8-persona) and lightweight (5-persona) modes.

#### pony-pbt-patterns

Property-based and generative testing patterns. Covers the valid/invalid/mixed generator triad, compositional generator hierarchies, deriving generators from validation rules, and coverage strategies. Maps directly onto PonyCheck.

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

Type the skill name as a slash command in your session:

```text
/pony-ref
```

The LLM loads the skill's reference material into context. Use this when you need the skill for the current task but don't want it loaded every session.

### CLAUDE.md triggers

Claude Code reads `CLAUDE.md` files at the start of every session — one global (`~/.claude/CLAUDE.md`) and one per project. You can add instructions to these files that tell the LLM when to load skills automatically. Each trigger is a sentence or two describing the condition and the action.

For example, to load the language reference at the start of every Pony coding session:

```markdown
**Load `/pony-ref` proactively when working on Pony code**: At the start of
any conversation where the working directory is a Pony project (contains
`corral.json` or `*.pony` files), load `/pony-ref` before doing any work.
Also load it mid-conversation when hitting capabilities, type system, runtime,
or testing questions.
```

To load the debugging protocol when needed:

```markdown
**Load `/pony-debug` when you start debugging**: Before forming any hypothesis
about the cause of a non-trivial issue, load `/pony-debug`.
```

To load code review for PRs:

```markdown
**Load `/pony-code-review` for code reviews**: When conducting a code review
of a PR, branch, or local changes, load `/pony-code-review`.
```

The trigger text is natural language. Write it so the LLM can match the condition to the current situation. The [ponylang/llm-skills README](https://github.com/ponylang/llm-skills#suggested-triggers) has suggested triggers for every skill.
