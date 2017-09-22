+++
title = "Triaging Ponyc"
+++
## For anyone

The vast majority of the triaging process can be done by any member of the community, all of the following steps require no special commit access to the `ponyc` repo.

### Request missing relevant information

Has the user reported all information that might be needed to diagnose? It can be very hard to diagnose issues if relevant details are missing.

Commonly needed information includes:

* Source code that demonstrates the problem
* Did they install from a package or source?
* What version or commit are they using?
* What platform are they on? Linux, FreeBSD, OSX?
* What version of the platform? If Linux, what distribution?
* What version of LLVM are they using?
* What compiler including version?
* What linker including version?
* If they built from source, what options did they use?
* Are they running a release or debug build of the compiler?
* Are they running debug version of their program?
* What CPU are they running on?

Mind you, answers to every one of the questions aren't required. As you become a better at triaging, you'll develop a sense of which questions are required for different sorts of problems.

### Verify the issue

Can you reproduce? It's an important first step. A user is going to be reporting a problem on a specific platform. Can you reproduce using that platform? Can you reproduce on another?

If a Debian Linux user reports a bug, it's very helpful to know if it impacts other platforms such as OSX. We want to find out how broad the bug is based on any of the following relevant factors:

* OS, distribution, and version
* LLVM version
* Pony version
* Compiler version 
* Linker version
* CPU

### Find a minimal case

Users will often provide source code to demonstrate the problem they are experiencing that is rather expansive in scope. The smaller the scope of the source code, usually the easier it will be to locate the problem. See if you can find a smaller minimal case than what has currently been provided.

### Locate the regression point

Not every problem a user reports will be caused by a bug introduced in `ponyc`. Some will be bugs in LLVM, Clang, GCC, the OS and what not. However, many bugs will be in `ponyc`, for these bugs, locating the point the bug was introduced vastly speed up the time to diagnose and fix.

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

There's only one additional step that committers can perform to help move the triaging process forward. Provide the proper labels on the issue. Below, we discuss the important triaging related labels. 

### needs discussion during sync

The agenda for each Pony development weekly sync is determined by looking for any issues, PRs etc that have the "needs discussion during sync" label. Anytime something happens with an issue that makes it one we should discuss during the sync, apply this label. By the same token, if an update was made to the issue that eliminates the need for discussion, remove the label.

Common reasons for adding the label include:

* You are doing initial triaging on an issue and are unsure of if its a bug or not.
* You are doing initial triaging, are certain it's a bug but are unsure of what the fix is.
* An action required comment has been addressed. For example, the user supplied additional requested information.
* You think the issue needs discussion at the sync

Common reasons for removing the tag include:

* The issue has just been discussed at the sync and additional action is required. A comment regarding action required would have been added to the ticket.
* It has been determined that additional information is required before moving forward.

### bug - *

If it has been determined that the issue is, in fact, a bug, one of the following labels should be applied:

_bug - needs investigation_: the cause of the bug is unknown. If the issue needs to be discussed during the sync, the "needs discussion during sync" label should also be added as well.

_bug - needs discussion_: the cause of the bug is known and discussion is needed to come up with a fix. If the discussion should happen during the sync as well as on the issue, the "needs discussion during sync" label should be added as well.

_bug - ready for work_: someone could start working on fixing the issue. 

_bug - in progress_: someone has already started working on fixing the issue. 

### enhancement - *

The issue isn't a bug but a request for new functionality. If the new functionality meets our RFC criteria then the issue should be politely closed and the user directed to the RFC process. It's important to explain why the enhancement requires an RFC. Be sure to add the "turn into rfc" label as well. If the enhancement doesn't require an RFC, the correct "enhancement - *" label should be applied. 

_enhancement - needs discussion_ should be applied if an additional conversation is required. If that discussion should happen not just on the issue but during the sync call, be sure to add the "needs discussion during sync" label.

_enhancement - ready for work_ should be applied if the enhancement is already fully scoped and someone could start work on it. If you are able to, assign the proper difficulty and priority. If you aren't able to assign a difficulty and priority, add the "needs discussion during sync" label so difficulty and priority can be discussed.

### complexity - *

_complexity: beginner friendly_ should be applied if the issue is one that someone with minimal knowledge of Pony can tackle.

_complexity: requires context_ should be applied if the issue needs you to either be familiar with that part of the codebase already, or you need to spend some time getting familiar with it, but after gaining that context, it's not very complex.

_complexity: major effort_ should be applied if the issue is one where even somebody very familiar with that part of the codebase is going to spend a significant amount of time working through finding and implementing the correct solution.

### triggers release

Should be applied if the resolution of the issue triggers a Pony release. This label is generally only applied to severe bugs. 

Generally, most issues will not have triggers release set.

### duplicate

The bug is a duplicate of an existing issue. The issue number that it duplicates should be noted, the label applied and the issue closed. In general, it's a good idea to get confirmation that the issue is actually a duplicate before closing.

### wont fix

The bug is one that we can't or won't fix. It is highly unlikely this would ever be applied during triaging.
