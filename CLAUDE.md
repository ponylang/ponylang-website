# Ponylang Website

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
3. `##` sections for noteworthy items (important releases, announcements, etc.)
4. `## Items of Note` with `###` subsections (Office Hours, Pony Development
   Sync, community items)
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
it also gets its own `##` section higher in the post with a short write-up.
Read the release notes to determine if a release warrants its own section. Use
judgment — routine releases with nothing interesting just go in the list.

### Reviewer Prompt

When spawning a copy-editing reviewer subagent, use a prompt along these lines:

> You are a copy editor. Review the following markdown blog post for grammar
> and spelling issues. Copy edit for clarity and concision. The tone should be
> informal and Hemingway-esque — avoid flowery language, minimize adjectives
> and adverbs except where they serve a conversational tone. The result should
> not sound clipped or like a series of notes. The conversational aspect of the
> content should not be lost.
>
> Domain note: "Office Hours" is the title of a meeting and is singular.
>
> Leave the mkdocs metadata as is. Return the full corrected markdown and then
> list what changes you made and why.
