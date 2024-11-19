---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - November 24, 2024"
date: 2024-11-24T07:00:06-04:00
---

...

<!-- more -->

## Items of Note

### Another "interview" might be on the way

A couple weeks back, we became aware of a video ["Pony Language - First Impression [Programming Languages Episode 34]"](last-week-in-pony-111024.md#first-impressions-video) by Mike Shah. Sylvan and I both loved it. I reached out to Mike and the 3 of us are planning on having a chat next week. It might be recorded, in which case, you can expect to see it on YouTube and announced here at some point.

### Office Hours

Office Hours this past week was myself, Adrian, and Red. This conversation was driven by Adrian and started from [a Zulip thread](https://ponylang.zulipchat.com/#narrow/channel/189934-general/topic/Office.20Hours.2011.2F18.2F2024).

Adrian wanted to discuss the graphics libraries [Nuklear](https://github.com/Immediate-Mode-UI/Nuklear) and [Glfw](https://www.glfw.org/). In particular, are they suitable for use with Pony.

I'm not a computer graphics person so I chimed in when the subject would turn to "can that work with the Pony runtime", but otherwise, mostly kept quiet.

While discussing integration options, Red's POC project [pony_libei](https://github.com/redvers/pony_libei) came up.

Adrian summarized our discussion on Zulip with:

> Follow-up info related to our Office Hours discussion. The library doesn't seem to be limited in terms of which threads do what. Rather, such limitations are actually a consequence of the particular OSes you hope to target. If you want to create a maximally cross-platform application you need to live with MacOS's rules, since it's the most restrictive supported OS. Sean mentioned these restrictions during the call without knowing if it's still relevant in the current GUI frameworks for popular OSes.
>
> The GLFW project assumes that users desire to creating maximally cross-platform applications but then there's mention of "pure GLFW" in the quote below. This might mean that the GLFW code doesn't actually enforce the rules, depending instead on people to do what the GLFW documentation tells them to. But even there is no enforcement of the rules, there could be GLFW code that does depend on users obeying the documented rules.

As an aside, early in the conversation, Red said the most Red of all things: "I was in my 'Woo-hoo! i can bind to anything' phase."

See ya next week!

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
