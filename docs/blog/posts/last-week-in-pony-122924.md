---
draft: false
authors:
  - seantallen
categories:
  - "Last Week in Pony"
title: "Last Week in Pony - December 29, 2024"
date: 2024-12-29T07:00:06-04:00
---

A new version of Pony is out. 0.58.8 has an exciting new feature for folks who want to use C based graphics libraries with Pony. We even had to do a quick follow-up release that is of interest to practically no one and only exists to clean up an issue with some standard library documentation not building.

Enjoy! See you next year.

<!-- more -->

## Items of Note

### Actor Pinning

Experimental support for pinning Pony actors to a dedicated scheduler thread has landed in the latest Pony release. The feature comes with a number of caveats. It is intended to be used with C-code that uses thread local variables and otherwise can't be called from multiple different threads of execution. See the [actor pinning documentation](https://stdlib.ponylang.io/actor_pinning--index/) for more information.

### Supported Fedora Changed

With the release of Pony 0.58.8, we switched from supporting Fedora 39 to supporting Fedora 41.

### New Pony Pattern

We've added a new pattern ["FFI Global Initializer"](https://patterns.ponylang.io/creation/ffi-global-initializer) to the [Pony Patterns book](https://patterns.ponylang.io/).

### Office Hours

I wasn't at Office Hours this past week but Red was. He provided the following summary:

A couple of people showed up, and I did a walk-through of the work that I've done thus far with Gtk et al. Now that the excellent work that Dipin did with ```actor_pinning``` support is in the runtime, a fully functional Gtk package that doesn't leak memory is well within reach.

What started as a brief walk-through of the package's design, the approach, and the trade=offs that I've made thus far turned into a discussion on API design.

When you have two languages that have such a severe impedance mismatch, is the principle of "least surprise" when it diverges from the original API, or when it diverges from how pony programmers model the how the runtime operates?

For example, when you define a UI in XML and use GtkBuilder to build that UI, all of the C GObjects are created without any pony objects existing. If you need to perform some operation on one, say bind a pony bare function to a button-click - this is how it's currently done:

```pony
    let button_increment: GtkButton = GtkButton.new_from_builder(builder, "button_increment")?
    button_increment.signal_connect_data[AppState]("clicked", this~raw_increment_clicked(), this)
```

The "rub" is that we're creating a new pony object to wrap an existing C GObject. We're not creating a new (C) GtkButton. So, should the function be ```new_from_builder()``` or ```get_from_builder```?

Does ```new_from_builder()``` create a model in the end-user's head that when button_increment falls out of scope, that the C GtkButton would likewise be garbage collected and freed?

In reality, no - as Gtk/GObject has its own reference counting / garbage collection, so when we create a pony object to wrap it, we increment the reference count on creation, and decrement it in _final().

Which means of course that in this case:

```pony
  let a: GtkLabel = GtkLabel.new_from_builder(builder, "mylabel")?
  let b: GtkLabel = GtkLabel.new_from_builder(builder, "mylabel")?
```

a and b have different identities in pony, but the same identity in C/GObject.

We also talked about a potential peer-to-peer pony program and a pure implementation of QUIC for "reasons".

## Releases

- [ponylang/ponyc 0.58.8](https://github.com/ponylang/ponyc/releases/tag/0.58.8)
- [ponylang/ponyc 0.58.9](https://github.com/ponylang/ponyc/releases/tag/0.58.9)
- [ponylang/ponyup 0.8.5](https://github.com/ponylang/ponyup/releases/tag/0.8.5)

---

_Last Week In Pony_ is a weekly blog post to catch you up on the latest news for the Pony programming language. To learn more about Pony, check out [our website](https://ponylang.io) or our [Zulip community](https://ponylang.zulipchat.com).

Got something you think should be featured? There's a GitHub issue for that! Add a comment to the [open "Last Week in Pony" issue](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).
