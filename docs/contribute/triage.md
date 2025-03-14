# Triaging Issues

Users regularly open issues against various [Pony repositories](https://github.com/orgs/ponylang/repositories). Staying on top of them and moving them along to a conclusion is an important part of the development process.

A great way assist with the development of Pony is to triage issues. The following guide is written to help understand how you can triage [issues related to the ponyc compiler](https://github.com/ponylang/ponyc/issues).

While details might vary from repository to repository, the general principles can be applied across our repositories.

## For anyone

The vast majority of the triaging process can be done by any member of the community, all the following steps require no special commit access to the `ponyc` repository.

### Request missing relevant information

Has the user reported all information that might be needed to diagnose? It can be quite hard to diagnose issues if relevant details are missing.

Commonly needed information includes:

* Source code that demonstrates the problem
* Did they install from a package or source?
* What version or commit are they using?
* What platform are they on? FreeBSD? Linux? macOS? Windows?
* What version of the platform? If Linux, what distribution?
* What compiler including version?
* What linker including version?
* If they built from source, what options did they use?
* Are they running a release or debug build of the compiler?
* Are they running debug version of their program?
* What CPU are they running on?

Mind you, answers to every one of the questions aren't required. As you become a better at triaging, you'll develop a sense of which questions are required for different sorts of problems.

### Verify the issue

Can you reproduce? It's an important first step. A user is going to be reporting a problem on a specific platform. Can you reproduce using that platform? Can you reproduce on another?

If a Debian Linux user reports a bug, it's helpful to know if it impacts other platforms such as Windows. We want to find out how broad the bug is based on any of the following relevant factors:

* OS, distribution, and version
* LLVM version
* Pony version
* Compiler version
* Linker version
* CPU

### Find a minimal case

Users will often provide source code to demonstrate the problem they are experiencing that is rather expansive in scope. The smaller the scope of the source code, usually the easier it will be to locate the problem. See if you can find a smaller minimal case than what has currently been provided.

### Locate the regression point

Not every problem a user reports will be caused by a bug introduced in `ponyc`. Some will be bugs in LLVM, Clang, GCC, the OS and what not. However, bugs will often be in `ponyc`, for these bugs, locating the point the bug was introduced vastly speed up the time to diagnose and fix.

Git-bisect is an amazing tool for tracking down when a regression was introduced. If you aren't familiar with git-bisect, it's a great tool to learn and will serve you well as a developer. Even without git-bisect, you can still locate a regression point. The process goes something like this:

* Create a minimal example that easily demonstrates the problem.
* Pick a commit from the past.
* Build `ponyc` from that commit
* Run the minimal example and see if the bug still exists
* If it does, move to an earlier and repeat
* If it doesn't, move to a later commit and repeat

Through the above process, you can often find when a regression was introduced. If you are able to, report the commit on the issue.

### Find related issues

There might be existing open or closed issues that relevant to this issue.

* If the problem has already been fixed in a later version, you can note that on the issue.
* If workaround documentation exists, point the user to that documentation.
* If there are open (or closed) issues that you think are similar and they might shed light on the issue, note those issues (with issue numbers).

### @ domain experts

Do you know of someone who should be able to help diagnose the problem? @ them on the issue to draw it to their attention.

## For committers

There's only one additional step that committers can perform to help move the triaging process forward. Provide the proper labels and classification for the issue. GitHub provides two basic means for categorizing issues: labels and types. There are 3 types, "bug", "feature", and "task". Labels are defined by each project. Below, we discuss the important triaging related labels (and classification).

### Bug

If it has been determined that the issue is, in fact, a bug. The "Bug" type should be applied. If the source of the bug isn't known, also add "needs investigation".

### Feature

The issue isn't a bug but a request for new functionality. If the new functionality meets our RFC criteria then the issue should be politely closed and the user directed to the RFC process. It's important to explain why the enhancement requires an RFC. If the new functionality doesn't meet the RFC criteria, then the "Feature" type should be applied

### discuss during sync

The agenda for each Pony development weekly sync automatically generated by looking for issues labeled with "discuss during sync". The label is automatically added to issues/pull requests that see activity. In general, a human almost never adds this label. By the same token, if an update was made to the issue that eliminates the need for discussion, remove the label. Most issues will have "discuss during sync" removed after they have been discussed at a sync meeting.

### help wanted

Applied to any issue where the Pony committers are looking for assistance from "the community". Almost every issue gets "help wanted" added to it. There are few issues that we consider to be "committer only" issues.

### good first issue

"good first issue" is applied to any issue that should be easy for someone with limited domain knowledge to pick up and work on.

### needs discussion

The issue in question requires additional discussion.

Common reasons for adding the label include:

* You are doing initial triaging on an issue and are unsure of if its a bug or not.
* You are doing initial triaging, are certain it's a bug but are unsure of what the fix is.
* An action required comment has been addressed. For example, the user supplied additional requested information.

Common reasons for removing the tag include:

* It has been determined that additional information is required before moving forward. In which case, "needs investigation" would be added.

### needs investigation

Applied to any issue that isn't ready for work because additional work is needed to get a full understanding of the issue in question.

### triggers release

Should be applied if the resolution of the issue triggers a Pony release. This label is generally only applied to severe bugs.

Generally, most issues will not have triggers release set.

### do not merge

"do not merge" is applied to pull requests that for some reason, shouldn't be merged. It's a bright red reminder to not merge. The reason for not merging yet is usually noted somewhere in the conversation about the pull request.

### changelog - *

The various "changelog" labels are only applied to pull requests. If the label is applied then release notes are required (a bot will prompt for them if they are missing). When the PR is merged, it will be added to the changelog by a bot.

The correct label should be applied to any pull request that implements a user facing change that should appear in the changelog.

### documentation

Added to issues that involve improvements to documentation. Documentation issues require a different set of skills from "code fixes" and labeled to make them easier to find.

