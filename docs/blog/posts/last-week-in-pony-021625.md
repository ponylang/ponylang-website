---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - February 16, 2025"
date: 2025-02-16T07:00:06-04:00
---

Ponyc nightly builds are working again. Feel free to fire up that `ponyup` and install away!

<!-- more -->

## Items of Note

### No Longer Broken Nightly Builds

Last week, [we reported that nightly builds were broken](https://www.ponylang.io/blog/2025/02/last-week-in-pony---february-9-2025/#broken-nightly-builds). We are happy to report all is good again. Install away!

### Pony Development Sync

The recording from this week's Development Sync is now [available on Vimeo](https://vimeo.com/1055705619).

### Office Hours

Office Hours was a fun one this week. Well, it was for me. I got to talk about lots of stuff I love.

Attendees were: Adrian, Red, Nathan, Alex, and me.

We discussed the [Rego policy language](https://www.openpolicyagent.org/docs/latest/policy-language/) as I am working on Pony bindings for [microsoft/rego-cpp](https://github.com/microsoft/rego-cpp). We discussed [Datalog languages](https://en.wikipedia.org/wiki/Datalog) including some discussion of [Prolog](https://en.wikipedia.org/wiki/Prolog).

We ended up pivoting to discussing [WASM](https://en.wikipedia.org/wiki/WebAssembly). Red wasn't really familiar with it so I took him through some basics. I discussed it through the lens of 1990's browsers and "javascript vs applets" and virtual machines.

We ended up pivoting back to policy language and why you would want one and what it would be used for. I discussed it in the context of the work I did on [Confidential Containers](https://www.seantallen.com/papers/confidential-container-groups/) while I was at Microsoft Research. We ended up discussing some stuff near and dear to my heart: [hardware root of trust](https://www.rambus.com/blogs/hardware-root-of-trust/). We discussed the [TPM](https://en.wikipedia.org/wiki/Trusted_Platform_Module) and [SGX](https://en.wikipedia.org/wiki/Software_Guard_Extensions).

Finally, we ended up wrapping it all up by discussing how I am incorporating all of this into a new project I am working on. There, I'm not using Rego as a policy language but as a configuration language with all the goodness of Datalog.

Tomorrow is a vacation in the US and Canada so we will see how many attendees we have. I will probably be there, but, that isn't guaranteed.

## Releases

- [ponylang/lori 0.5.1](https://github.com/ponylang/lori/releases/tag/0.5.1)
- [ponylang/postgres 0.1.1](https://github.com/ponylang/postgres/releases/tag/0.1.1)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
