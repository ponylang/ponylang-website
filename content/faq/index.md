+++
title = "FAQ"
+++

## About Pony

### How'd Pony come to be?

Check out ["An Early History of Pony"](https://www.ponylang.org/blog/2017/05/an-early-history-of-pony/).

### Why's it called "Pony"?

Interesting question. We here that a lot. If you read enough of ["An Early History of Pony"](https://www.ponylang.org/blog/2017/05/an-early-history-of-pony/), you'll get your answer.

### What makes Pony different?

See the ["What makes Pony different"]({{< relref "discover/index.md#what-makes-pony-different" >}}) section of ["Discover"]({{< relref "discover/index.md" >}}).

### Why would I use Pony instead of language X?

That's a hard question to answer. Language X is probably very compelling for some problems. It's probably less compelling for others. Such is computers. In the end, the best we can do is tell you what Pony is good at and you can make the decision for yourself. To learn more about Pony, we suggest checking out the ["Discover"]({{< relref "discover/index.md" >}}) section of the website. There's a portion of that section called ["Why Pony"]({{< relref "discover/index.md#why-pony" >}}) that might answer your question.

## Compiling

### I get a "requires dynamic" error when compiling, how do I solve it?

```bash
/usr/bin/ld.gold: error: ./fb.o: requires dynamic R_X86_64_32 
  reloc against 'Array_String_val_Trace' which may 
  overflow at runtime; recompile with -fPIC
```

try running `ponyc` with the `--pic` flag.

For example:

```bash
ponyc --pic examples/helloworld
```
