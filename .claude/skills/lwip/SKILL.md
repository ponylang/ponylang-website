---
name: lwip
description: Create a new "Last Week in Pony" blog post from the open GitHub issue
disable-model-invocation: true
---

Create a new "Last Week in Pony" blog post.

## Who reads this

People who write Pony, and people following the language. Not people who work
on whatever subsystem an item happens to be about.

**What they know.** They know Pony and they write Pony programs. They don't
know the internals of ponyc, of lori, or of whatever library an item covers,
and they have not read the changelogs, the PRs, or the design docs you read to
write the post. A fact that only lands for someone who has read what you read
buries the item, however true and however well sourced it is.

**Why they are reading.** Some of them write Pony and want the practical news:
what will break their code, what to upgrade for, what fixes a problem they
might have hit. A lot of them are lookie-loos who don't use Pony and never will
act on any of it. They read because it's interesting to watch a language get
built. Both halves matter. An item that's useful but dull serves half the
audience, and detail only a maintainer could care about serves neither.

The job is to give the major news and entertain people who want to know what's
going on with Pony. It is not to account for everything that happened. Leaving
things out is part of the work.

## What state is the work in

How much an item gets depends on what a reader can do with it.

**Released.** They can go get it. Say what it does for them. The release notes
carry the full detail, so don't reproduce them — a post that re-explains every
fix does the release notes' job twice and buries its own news doing it.

**Merged but not released.** They can't get it yet, so per-fix detail helps
nobody. Say what's coming, when, and why it's worth knowing about now.

**Not merged.** Say what's coming, why, whatever is genuinely settled — that
it's a breaking change, roughly when — and link to where they can follow along.
Nothing else. The design docs and PRs behind unfinished work contradict each
other and use provisional names, because that's what unfinished work looks
like. Mining them for mechanism produces detail that's wrong as often as it's
right, and the links carry it for anyone who wants it.

**Real but far off.** A plan that won't be real for a long time is a
distraction rather than news. Every fact about it can be true and sourced and
it still costs the reader more than it gives them. Wait until there's something
to do about it.

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

The interview in step 6 is where most of this gets settled. The goal is
correctness and narrative interestingness, not speed to getting a draft
up. Multiple rounds of questions are fine.

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
   this project's AGENTS.md for format, tone, and domain-specific notes.

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

3. **Rotate the issue first**: Run
   `gh issue list --repo ponylang/ponylang-website --label last-week-in-pony --state open`
   to identify the current issue. Calculate the next Sunday from today's
   date. Create a new empty issue in `ponylang/ponylang-website` titled
   `Last Week in Pony - {next Sunday: Month Day, Year}`, add the
   `last-week-in-pony` label, and pin it. Then remove the
   `last-week-in-pony` label from the current week's issue, unpin it, and
   close it.

   Why first: until you rotate, the current issue is still the live,
   pinned target. If you collect the week's items and *then* rotate,
   anything posted in between lands on an issue you've already read and
   closed — lost from both this post and next week's. Rotating first
   moves the live target to the new issue, freezing this week's set
   before you read it.

4. **Read the rotated-out issue**: Read the now-closed issue with all its
   comments. This is the frozen set of items for the post.

5. **Read release notes**: For any release items in the rotated-out
   issue, fetch the release notes (e.g.,
   `gh release view TAG --repo ORG/REPO`) and evaluate whether the
   release has noteworthy content deserving its own section.

6. **Interview the author, then verify**: Interview before you draft.
   Always, not only when something looks like it's missing — you can't
   tell that it is. The answers that matter most are in the author's head
   and appear in no issue, PR, or release note, so no amount of reading
   surfaces them and a pile of verified facts feels like coverage while
   the gaps stay invisible.

   Ask what they've been working on that isn't in the issue, what they
   think matters most this week, what's coming that people should know
   about, and what's actually shipped versus still sitting on a branch.
   Those work because none of them require you to have spotted a gap
   first. Follow the answers rather than the list, and go more than one
   round.

   Then verify: list every characterization you intend to make about
   history, severity, duration, or impact, and confirm each from sources
   (issue/PR/release notes, `git log`, `gh`) or from the author.
   Correctness and narrative interestingness beat draft speed.

7. **Write the draft**: Create the post following the format in AGENTS.md.
   Use the date from the issue title for the filename and front matter.

8. **Review**: Run the `ponylang-prose-review` skill on the draft (full
   mode — a post is always more than two paragraphs). It runs the house-voice,
   narrative, reader-orientation, tightness, and content-honesty lenses as
   parallel reviewers (plus a conditional accuracy lens when the post has code
   or technical claims), checks the draft against the AGENTS.md editorial
   guidelines and the craft rules with the week's source bundle (the rotated
   issue and its comments, linked posts, release notes, cited PRs/issues) in
   hand, and runs the mechanical pre-check (cspell, `mkdocs build --strict`,
   em-dash count, link sanity). Apply its Fix findings; for each Park finding,
   incorporate it if you agree, or present the dispute to the user for a
   ruling. The ensemble synthesizes in one pass — there's no per-round
   re-spawn loop.

9. **Commit and PR**: Create a branch, commit the new post with the message
   `Last Week in Pony - Month Day, Year`, and open a PR. Report the PR URL
   to the user.

