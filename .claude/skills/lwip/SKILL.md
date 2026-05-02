---
name: lwip
description: Create a new "Last Week in Pony" blog post from the open GitHub issue
disable-model-invocation: true
---

Create a new "Last Week in Pony" blog post.

## Critical: don't fabricate

Every factual claim in the post must come from a verifiable source: the
issue or its comments, linked PRs/releases, git/gh history, or the user.
This applies especially to *characterizations* — how long something
existed, how widely it affected users, the history behind a fix, the
severity of a bug. Don't invent backstory to make a routine item sound
dramatic. Duration, impact, and history are factual claims; if you can't
substantiate them, don't write them.

When you're tempted to add color about history, severity, or impact:

1. **Verify first.** Use `gh issue view`, `gh pr view`, `gh release view`,
   `git log`, release notes. The actual history is usually one command
   away.
2. **Ask the user** if you can't verify and the characterization adds
   value.
3. **If neither, drop the characterization.** A flat description of what
   happened beats a fabricated dramatic one. The hyperbolic-language rule
   ("flair in *how* things are said, not in inflating what they are")
   applies to phrasing. This rule applies to facts.

Turn it into an interview session if needed. The goal is correctness and
narrative interestingness, not speed to getting a draft up. Multiple
rounds of questions are fine.

## Additional Notes

- **Most items go under `## Items of Note`** as `###` subsections. Top-level
  `##` sections are reserved for highlighted items only. The default home for
  any item is Items of Note — only promote to `##` when there's a specific
  reason. Things that warrant highlighting:
  - Changes in Pony team membership (new committers, new core team members,
    departures).
  - Libraries with a 0.1.0 release — describe what the library provides and
    why you'd want it. Don't cover libraries that haven't had a first release
    yet.
  - Major version bumps (1.0.0, 2.0.0, etc.) — cover what changed and why it
    matters.
  - Items explicitly flagged for highlighting in the issue comments.
- **Every release goes in the `## Releases` bullet list.** When a release
  has noteworthy content (bug fixes affecting users, new features, breaking
  changes), it also gets a `###` subsection under `## Items of Note` with a
  short write-up. Read the release notes to determine what treatment a
  release warrants. Routine releases with nothing interesting just go in the
  list.
- New library sections should be feature overviews, not per-version
  changelogs. When a library has multiple releases in one week, describe
  what it does as a whole. Don't enumerate what changed in each version.
- Describe libraries and tools by what happens when you use them, not by
  listing their contents. "Load it and Claude has the actual capability
  rules in context instead of guessing" tells the reader more than
  "capabilities, subtyping rules, common gotchas." Lead with the
  experience of using it, not the inventory. Focus on what it does for
  the user, not project-internal motivations (why it was built, what
  larger effort it's part of).
- **Re-establish context for libraries that evolve between posts.** When
  covering a new release of something that appeared in a previous LWIP,
  bring forward the context the reader needs. Don't assume they remember
  last week's post. If hobby introduced actor-per-request handlers in
  0.4.0 and this week's 0.5.0 adds interceptors that run before the
  handler actor is spawned, explain the model before referencing it.
- When referring to repos by short name in prose (not `owner/repo` format),
  use lowercase to match the actual repo name: `ponyc`, `corral`, `ponyup`,
  not `Ponyc`, `Corral`, `Ponyup`.
- The post is authored by seantallen. Write in first person ("I", "my"), not
  third person ("Sean", "his"). Third person is occasionally used as a joke
  but is not the default.
- Link targets should match what the link text describes. Don't link "Homebrew
  formula" to a Zulip thread about the formula — either link to the formula
  itself or use plain text.
- Be frugal with em dashes. A few per post is fine, but heavy use reads as
  AI-generated. Prefer periods, commas, colons, or parentheses when they
  work just as well.
- Issue comments are raw material, not copy. Turn them into flowing
  narrative. Avoid choppy sequences of disconnected sentences. But when
  the raw material has personality — colorful phrasing, genuine
  enthusiasm, humor — preserve and amplify it. Don't grind human voice
  down into flat declarative prose. Adapt it to fit the post's flow,
  but keep the energy.
- **Every section should be narrative, not a topic inventory.** A paragraph
  of independent facts separated by periods is just a bullet list without
  the bullets. Connect ideas: cause and effect, contrast, significance,
  what ties them together. The reader should feel a thread pulling them
  through, not a checklist they're being walked down. This applies
  everywhere — opening hooks, Items of Note subsections, release
  write-ups. If you could turn the paragraph into bullets and lose
  nothing, it needs rewriting.
- Keep voice consistent between adjacent sections. When two sections cover
  similar content (two new tools, two related libraries), they should read
  the same way.
- Use "ponyc" not "ponylang/ponyc" in prose and section headings. Only use
  `ponylang/ponyc` in the releases list.
- **The opening should match the energy of the week.** LWIP is community
  outreach and a hypefest. Not sales — genuine excitement. When there's
  a lot going on, the opening should convey that. Let the reader know
  whether it was a big week or a quiet one. Gab with them a little
  before diving in. If there are three big things happening, be excited
  about three big things happening. A flat "Let's get into it" after a
  stacked week undersells the content and the community behind it.
- `## RFCs` section (when applicable) goes after `## Releases`. Use `###`
  subsections by status change (`### New`, `### Accepted`,
  `### Final Comment Period`, `### Implemented`, etc.). Only include statuses
  that have entries that week.

## Steps

Follow these steps:

1. **Read editorial guidelines**: Read the "Last Week in Pony" section in
   this project's CLAUDE.md for format, tone, and domain-specific notes.

2. **Study recent posts and voice calibration**: Read the 2-3 most recent
   posts in `docs/blog/posts/last-week-in-pony-*.md`. Also read 2-3 posts
   from `~/code/seantallen/seantallen.com/content/posts/` to calibrate on
   Sean's personal writing voice. Key traits: he connects ideas into
   flowing narrative (not choppy fact sequences), tells you *why* things
   matter (not just what they are), shares opinions freely, uses natural
   asides and humor, and varies sentence length. The language is
   hyperbolic but the facts aren't — the flair is in *how* things are
   said ("gracing you with," "the whole thing"), not in inflating what
   they are. Don't write feature checklists ("X is supported. Y is
   supported.") — describe things the way you'd tell someone about them
   in conversation.

3. **Find the open issue**: Run
   `gh issue list --repo ponylang/ponylang-website --label last-week-in-pony --state open`
   to find the current issue, then read it with all comments.

4. **Rotate the issue**: Calculate the next Sunday from today's date. Create
   a new empty issue in `ponylang/ponylang-website` titled
   `Last Week in Pony - {next Sunday: Month Day, Year}`, add the
   `last-week-in-pony` label, and pin it. Then remove the
   `last-week-in-pony` label from the current week's issue, unpin it, and
   close it. The old issue is done once we've read it.

5. **Read release notes**: For any release items in the issue, fetch the
   release notes (e.g., `gh release view TAG --repo ORG/REPO`) and evaluate
   whether the release has noteworthy content deserving its own section.

6. **Verify and ask clarifying questions**: Before writing, list every
   characterization you intend to make about history, severity, duration,
   or impact. For each, verify it from sources (issue/PR/release notes,
   `git log`, `gh`) or ask the user. Also ask about anything vague or
   missing context. Batching into one round is fine when everything is
   straightforward, but turn it into an interview session if you need to
   — correctness and narrative interestingness beat draft speed.

7. **Write the draft**: Create the post following the format in CLAUDE.md.
   Use the date from the issue title for the filename and front matter.

8. **Review loop**:
   a. Spawn a reviewer subagent (using Task tool, subagent_type
      "general-purpose") with the copy-editing prompt from CLAUDE.md. Pass
      the full draft content. The reviewer has no conversation history — give
      it everything it needs in the prompt.
   b. For each finding: incorporate changes you agree with; if you disagree,
      present the dispute to the user for a ruling.
   c. If any changes were made, spawn a new reviewer on the updated content.
   d. Repeat until a reviewer comes back clean.
   e. If 3 rounds pass without a clean result, ask the user whether to
      continue. Check in every 3 rounds thereafter.

9. **Commit and PR**: Create a branch, commit the new post with the message
   `Last Week in Pony - Month Day, Year`, and open a PR. Report the PR URL
   to the user.

