# Ponylang Website

## llms.txt

The `llmstxt` MkDocs plugin (configured in `mkdocs.yml`) auto-generates `llms.txt` and `llms-full.txt` during build. When making changes to docs content or nav structure, verify that the llms.txt output is updated accordingly.

The Contribute, Community, and Blog sections are intentionally excluded from llmstxt. They're operational and community content that would drown out the language-focused material (Learn, Use, FAQ, Discover) that LLMs actually need.

## External PDFs

All external, non-Pony PDFs linked from the site must be stored locally in
`docs/media/other-papers/` with a meaningful name (e.g.,
`champ-steindorfer-vinju-2015.pdf`, not `oopsla15.pdf`). Link to the local
copy instead of the external URL to avoid broken links.

## Internal Links

When linking to other pages within this site, use relative markdown paths with
`.md` extensions (e.g., `../use/debugging/pony-lldb-cheat-sheet.md`), not
URL-style paths (e.g., `/use/debugging/pony-lldb-cheat-sheet/`).

## Last Week in Pony

### Editorial Guidelines

The tone is informal and Hemingway-esque. Short sentences. Minimal adjectives
and adverbs except where they serve a conversational tone. The result should
not sound clipped or like a series of notes — it should read like a person
talking to you.

Study recent posts in `docs/blog/posts/` for voice calibration before writing.

### Domain-Specific Notes

- "Office Hours" is the title of a meeting and is singular. "Office Hours was
  attended by..." not "Office Hours were attended by..."
- The Pony Development Sync is sometimes called just "the sync" in casual
  context.
- Refer to repositories as `owner/repo` (e.g., `seantallen-org/msgpack`, not
  `msgpack`) — no one owns a name. This applies everywhere: section headings,
  inline prose, not just the releases list. Link to the repo on first mention.

### Post Format

**Filename**: `docs/blog/posts/last-week-in-pony-MMDDYY.md`

**Front matter**:

```yaml
---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - Month Day, Year"
date: YYYY-MM-DDTHH:MM:SS-04:00
---
```

**Structure** (in order):

1. Opening hook — 1-2 sentences, conversational, teasing what's in the post
2. `<!-- more -->` marker
3. `##` sections for highlighted items only (see the lwip skill for what
   qualifies — most items do not)
4. `## Items of Note` with `###` subsections — the default home for most
   content (community items, routine releases, Office Hours, Pony Development
   Sync, etc.)
5. `## Releases` — bullet list of all releases with links, format:
   `- [org/repo version](release-url)`
6. `---` separator
7. Footer boilerplate (always the same):

```
_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
```

### Releases in Posts

Releases always appear in the `## Releases` bullet list. When a release has
noteworthy content (bug fixes affecting users, new features, breaking changes),
it also gets a `###` subsection under `## Items of Note` with a short
write-up. Only releases that meet the highlighting criteria (first release,
major version bump, or explicitly flagged in the issue) get promoted to a
top-level `##` section. Read the release notes to determine what treatment a
release warrants. Routine releases with nothing interesting just go in the
list.

### Issue Rotation

Issue rotation happens early in the LWIP workflow — right after reading the
current issue — to avoid race conditions. The steps:

1. Calculate the next Sunday from today. The post usually goes out on Sunday
   but occasionally slips to Monday — the issue title always uses the Sunday
   date regardless.
2. Create a new empty issue in `ponylang/ponylang-website` titled
   `Last Week in Pony - {next Sunday: Month Day, Year}`.
3. Add the `last-week-in-pony` label and pin the new issue.
4. Remove the `last-week-in-pony` label from the current week's issue.

After the LWIP PR is merged, the only remaining cleanup is to unpin and close
the old issue.

### Reviewer Prompt

When spawning a copy-editing reviewer subagent, use a prompt along these lines:

> You are a copy editor reviewing a "Last Week in Pony" blog post. Check for
> grammar, spelling, clarity, and concision. The tone should be informal and
> Hemingway-esque. Short sentences. Conversational, not clipped. Avoid flowery
> language, minimize adjectives and adverbs except where they serve the tone.
> The result should read like a person talking to you, not like AI output.
>
> Style conventions for this project:
>
> - Em dashes (—) are fine but use them sparingly. Heavy em dash use reads as
>   AI-generated. If a period, comma, colon, or parentheses works just as
>   well, prefer that. Do NOT replace em dashes with double hyphens (--).
> - Technical terms (type names, function names, system calls, language
>   keywords) should be in backticks: `HashMap`, `writev`, `None`, not
>   HashMap, writev, None.
> - Repositories are referred to as `owner/repo` (e.g., `ponylang/ponyc`, not
>   just `ponyc`) on first mention and in section headings. Short names in
>   lowercase are fine in subsequent prose.
> - "Office Hours" is the title of a meeting and is singular ("Office Hours
>   was attended by..." not "Office Hours were attended by...").
> - The opening hook should unfurl naturally, not read as a bullet list of
>   topics.
>
> Leave the mkdocs metadata as is. Return the full corrected markdown and then
> list what changes you made and why.
