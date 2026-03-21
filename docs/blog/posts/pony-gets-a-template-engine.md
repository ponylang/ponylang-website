---
date: 2026-03-22T15:00:00-04:00
title: "Pony Gets a Template Engine"
authors:
  - seantallen
categories:
  - Libraries
draft: false
---

If you've been following along, you know the story. [Lori](pony-networking-take-two.md) for networking. [Stallion](stallion-http-server.md) for HTTP. [JSON](pony-gets-a-new-json-library.md) back in the standard library. Pony's web development stack is coming together piece by piece. But a web stack that only speaks JSON is an API server with aspirations. At some point, someone is going to want an actual page.

[`ponylang/templates`](https://github.com/ponylang/templates) handles that.

<!-- more -->

## The basics

The syntax is what you'd expect if you've used Mustache or Jinja. Variables go in `{{ }}`. You get conditionals, loops, filters with pipes, includes, template inheritance, whitespace control, comments. The feature set is table stakes for a modern template engine and I'm not going to walk through each piece. The [examples](https://github.com/ponylang/templates/tree/main/examples) cover all of it. What I want to dig into is what isn't table stakes.

## Two template types, one syntax

Templates has two entry points: `Template` and `HtmlTemplate`. Same syntax. Same parser. Same features. The difference is what happens when a variable gets rendered.

`Template` renders values as-is. No escaping, no transformation. Config files, emails, code generation, anything that isn't HTML.

`HtmlTemplate` applies context-aware escaping to every variable based on where it appears in the HTML structure. That phrase "context-aware" is doing a lot of work, and it's the interesting part.

## HTML escaping that actually works

Most template engines handle XSS prevention with a single escape function. Every variable gets HTML entity encoding: `<` becomes `&lt;`, `>` becomes `&gt;`, `&` becomes `&amp;`. Call it a day.

That works when every variable lands between tags in text content. It doesn't work everywhere else.

Consider this template:

```html
<a href="{{ url }}">{{ label }}</a>
<button onclick="{{ handler }}">Click</button>
<div style="color: {{ color }}">{{ text }}</div>
```

Four variables, three different HTML contexts. `{{ label }}` and `{{ text }}` sit in text content. Entity encoding handles them fine. But `{{ url }}` is in a URL attribute. Entity encoding won't stop `javascript:alert('xss')` from executing, because that's a perfectly valid URL with no special HTML characters in it. `{{ handler }}` is in a JavaScript event handler. `{{ color }}` is in a CSS context. Each one needs different escaping rules.

Most template engines punt on this. They give you one escape function and trust you to pick the right one for each spot. Or they auto-escape for the text-content case and hope nobody puts a variable in a URL attribute.

`HtmlTemplate` doesn't punt. It figures out the context for you.

Under the hood, a state machine processes each literal segment of the template character by character, tracking whether you're in a tag, an attribute name, an attribute value (and which kind), a comment, a script block, a style block, or plain text. When the template walker reaches a variable, the state machine knows the context. The right escaping follows automatically:

- Text content and regular attributes get entity encoding
- URL attributes (`href`, `src`, `action`) get scheme filtering that blocks `javascript:`, `vbscript:`, and `data:` URIs, followed by percent-encoding
- Event handlers (`onclick`, `onmouseover`, anything starting with `on`) get JavaScript string escaping
- `style` attributes get CSS value escaping
- Script and style blocks get their respective escaping
- Comments get `--` sequences stripped
- RCDATA elements (`<title>`, `<textarea>`) get minimal escaping

The state machine also catches structural problems at parse time. A variable inside an unquoted attribute value, in a tag name position, or in an attribute name position is rejected before any data ever touches the template. Same with unknown filters, wrong filter arities, and circular include or extends chains. If something is knowably wrong, you find out when you parse the template, not when a user hits the bad code path at 2 AM.

If you need to bypass escaping for trusted content (pre-sanitized HTML fragments, for instance), `TemplateValue.unescaped` explicitly opts out. The default is safe. You have to go out of your way to be unsafe.

If this sounds familiar, you might be a Go programmer. Go's [`html/template`](https://pkg.go.dev/html/template) package in the standard library has done context-aware escaping for years. I shamelessly stole the idea. It's a great idea, it's better than what most template engines do. And if you know there's a good solution out there, you'd be a fool not to steal it.

## A rendering interface that came from a real problem

The standard way to use a template is simple: call `render()`, get a string. For most uses, that's all you need.

It wasn't enough for [`ponylang/livery`](https://github.com/ponylang/livery).

Livery is a LiveView-inspired framework for building interactive server-rendered UIs over WebSockets. The idea behind any LiveView-style system is that the server renders HTML but doesn't ship the whole page on every update. It figures out what changed and sends a minimal diff. For that to work, the rendering layer needs to separate static template content from dynamic values. The statics (the HTML structure between `{{ }}` markers) never change between renders. The dynamics (the substituted values) might. Send the statics once when the connection opens, then only send the dynamics that actually changed on each update, and you're transmitting dramatically less data over the wire.

The brute-force way to support this would have been to crack open the template's internal AST and walk it ourselves. It would have worked, but it would have coupled livery to the template library's internals and been ugly besides.

Instead, we added `TemplateSink`, a general-purpose rendering interface. A sink receives alternating `literal` and `dynamic_value` calls as the template is walked. The interleaving is strict: for N dynamic insertions, exactly N+1 literal calls, starting and ending with a literal. Control flow blocks collapse their rendered output into a single dynamic value.

Livery's `_RenderSink` implements this interface. On first render, it collects the statics and all the dynamics, sends both to the client, and caches them. On every subsequent render, it compares each new dynamic value against the cached previous value. Only the indices and values of slots that actually changed go over the WebSocket. If nothing changed, nothing goes over the wire at all. The template library doesn't know about WebSockets or diffs. Livery doesn't parse templates or walk ASTs. Each library stays in its lane.

This started as livery's need, but it made templates a better library. There's also `render_split()`, which returns statics and dynamics as two separate arrays for simpler cases. Any project that needs more than "give me a string" now has a clean way to get at the template's structure without reaching into internals. A specific problem drove a general improvement. That's how it should work.

## Where this is all going

Template engines aren't sexy. But I'm excited about the progress: Lori for networking. Stallion for HTTP. Mare for WebSockets. JSON for data. Templates for rendering pages. Livery for live, interactive UIs with server-rendered HTML and minimal wire updates.

We're building toward a Phoenix-like web framework for Pony. Server-rendered HTML with the kind of developer experience that Phoenix and LiveView pioneered, built on Pony's actor model and reference capabilities. Each library handles its own layer. Each one composes with the others. Same design philosophy running through the whole stack.

There's a lot of road ahead. But that API server with aspirations is starting to look like something real. Livery deserves its own post, and it'll get one. In the meantime, give templates a try. The [examples](https://github.com/ponylang/templates/tree/main/examples) cover everything from basic variable substitution to template inheritance to HTML auto-escaping.
