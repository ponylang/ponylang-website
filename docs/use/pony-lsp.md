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

pony-lsp accepts settings via the LSP `initializationOptions` field. Editors pass these during the server initialization handshake.

| Setting | Type | Description |
|---------|------|-------------|
| `PONYPATH` | string | Colon-separated list of additional package search paths |

`PONYPATH` works the same as the `ponyc` environment variable — it tells the server where to find packages beyond the standard library. The standard library is discovered automatically from the pony-lsp installation path, so you only need `PONYPATH` if your project depends on packages outside the standard search locations.

Example `initializationOptions`:

```json
{
  "PONYPATH": "/home/user/pony-libs/lib1:/home/user/pony-libs/lib2"
}
```

How to pass initialization options depends on your editor. See the editor configuration sections below.

## Editor Configuration

### Helix

Getting Helix set up with pony-lsp is very easy. Add the following to your [`languages.toml`](https://docs.helix-editor.com/languages.html).

```toml
[[language]]
name = "ponylang"
language-servers = [ "pony-lsp" ]  
```

### Neovim

Configuration details are coming. If you use Neovim with pony-lsp, consider contributing to this section.

### Visual Studio Code

Configuration details are coming. If you use Visual Studio Code with pony-lsp, consider contributing to this section.

### Zed

Configuration details are coming. If you use Zed with pony-lsp, consider contributing to this section.
