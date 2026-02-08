---
name: lwip
description: Create a new "Last Week in Pony" blog post from the open GitHub issue
disable-model-invocation: true
---

Create a new "Last Week in Pony" blog post. Follow these steps:

1. **Read editorial guidelines**: Read the "Last Week in Pony" section in
   this project's CLAUDE.md for format, tone, and domain-specific notes.

2. **Study recent posts**: Read the 2-3 most recent posts in
   `docs/blog/posts/last-week-in-pony-*.md` for voice calibration.

3. **Find the open issue**: Run
   `gh issue list --repo ponylang/ponylang.github.io --label last-week-in-pony --state open`
   to find the current issue, then read it with all comments.

4. **Read release notes**: For any release items in the issue, fetch the
   release notes (e.g., `gh release view TAG --repo ORG/REPO`) and evaluate
   whether the release has noteworthy content deserving its own section.

5. **Ask clarifying questions**: Ask the user about any items that are vague
   or need more context. Do this in a single round if possible — batch your
   questions.

6. **Write the draft**: Create the post following the format in CLAUDE.md.
   Use the date from the issue title for the filename and front matter.

7. **Review loop**:
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

8. **Commit and PR**: Create a branch, commit the new post with the message
   `Last Week in Pony - Month Day, Year`, and open a PR. Report the PR URL
   to the user.

9. **Post-merge issue rotation**: After the PR is merged, prompt the user:
   "PR is merged. Want me to do the post-merge issue rotation?" On
   confirmation:
   a. Find the open issue with the `last-week-in-pony` label in
      `ponylang/ponylang.github.io`.
   b. Unpin it, remove the `last-week-in-pony` label, and close it.
   c. Calculate the next Sunday from today's date.
   d. Create a new empty issue titled
      `Last Week in Pony - {next Sunday: Month Day, Year}`.
   e. Add the `last-week-in-pony` label and pin the new issue.
