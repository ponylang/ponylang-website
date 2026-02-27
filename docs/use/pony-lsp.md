# Pony Language Server

pony-lsp is the Pony Language Server. It communicates with editors via stdout/stdin using the [Language Server Protocol](https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/). It is part of the [ponylang/ponyc](https://github.com/ponylang/ponyc) repository, built alongside the compiler, and distributed with it. Installing ponyc from source or via [ponyup](https://github.com/ponylang/ponyup) will include pony-lsp.

Your editor launches the `pony-lsp` binary as a subprocess. See the [editor configuration](#editor-configuration) section for setup instructions.

## Feature Support

| Feature | Description |
|---------|-------------|
| Diagnostics | Compiler errors and warnings published on file open and save |
| Hover | Type information and documentation on hover |
| Go To Definition | Jump to the definition of a symbol |
| Document Symbols | List of symbols in the current file |

## Settings

pony-lsp supports settings via [`workspace/configuration`](https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#workspace_configuration) request and [`workspace/didChangeConfiguration`](https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#workspace_didChangeConfiguration) notification.

| Setting | Type | Example | Description |
|---------|------|---------|-------------|
| `defines` | `Array[String]` | `["FOO", "BAR"]` | Defines active during compilation, equivalent to the `-D` flag in `ponyc` |
| `ponypath` | `Array[String]` | `["/path/to/pony/package"]` | Additional package search paths for pony-lsp |

The standard library is discovered automatically from the pony-lsp installation path. You only need `ponypath` if your project depends on packages outside the standard search locations.

Example settings:

```json
{
  "defines": ["FOO", "BAR"],
  "ponypath": ["/path/to/pony/package", "/another/path"]
}
```

How to pass these settings depends on your editor. See the editor configuration sections below.

## Editor Configuration

### Helix

Getting Helix set up with pony-lsp is very easy. Add the following to your [`languages.toml`](https://docs.helix-editor.com/languages.html).

```toml
[[language]]
name = "ponylang"
language-servers = [ "pony-lsp" ]
indent = { tab-width = 2, unit = "  " }

[language-server.pony-lsp]
command = "pony-lsp"
args = [""]
```

#### Project-Specific Defines

Defines are almost always project-specific. Rather than adding them to your global `languages.toml`, create a `.helix/languages.toml` in the project root:

```toml
[language-server.pony-lsp.config]
defines = [
  "MY_DEFINE_ONE",
  "MY_DEFINE_TWO",
]
```

Replace the example values with the actual defines your project needs.

### Neovim

Configuration details are coming. If you use Neovim with pony-lsp, consider contributing to this section.

### Visual Studio Code

Configuration details are coming. If you use Visual Studio Code with pony-lsp, consider contributing to this section.

### Zed

Configuration details are coming. If you use Zed with pony-lsp, consider contributing to this section.
