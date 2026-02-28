# Linting

pony-lint checks Pony source files for style violations and reports diagnostics with file, line, and column information. It is part of the ponyc repository, built alongside the compiler, and distributed with it. Installing ponyc from source or via ponyup will include pony-lint.

## Usage

```bash
# Lint the current directory
pony-lint

# Lint specific paths
pony-lint src/ test/

# Disable a rule
pony-lint --disable style/hard-tabs

# Disable a category
pony-lint --disable style

# Use a config file
pony-lint --config .pony-lint.json

# Print version
pony-lint --version
```

## Rules

| Rule ID | Default | Description |
|---------|---------|-------------|
| `style/acronym-casing` | on | Acronyms in type names should be fully uppercased |
| `style/assignment-indent` | on | Multiline assignment RHS must start on the line after `=` |
| `style/blank-lines` | on | Blank line conventions within and between entities |
| `style/comment-spacing` | on | `//` not followed by exactly one space |
| `style/control-structure-alignment` | on | Control structure keywords must be vertically aligned |
| `style/docstring-format` | on | Docstring `"""` tokens should be on their own lines |
| `style/dot-spacing` | on | No spaces around `.`; `.>` spaced as infix operator |
| `style/file-naming` | on | File name should match principal type |
| `style/hard-tabs` | on | Tab characters anywhere in source |
| `style/indentation-size` | on | Indentation should be a multiple of 2 spaces |
| `style/lambda-spacing` | on | No space after `{` in lambdas; space before `}` only on single-line |
| `style/line-length` | on | Lines exceeding 80 codepoints |
| `style/match-case-indent` | on | Match case `\|` must align with `match` keyword |
| `style/match-no-single-line` | on | Match expressions must span multiple lines |
| `style/member-naming` | on | Member names should be snake_case |
| `style/operator-spacing` | on | Binary operators need surrounding spaces; no space after unary `-` |
| `style/package-docstring` | on | Package should have a `<package>.pony` file with a docstring |
| `style/package-naming` | off | Package directory name should be snake_case |
| `style/partial-call-spacing` | on | `?` at call site must immediately follow `)` |
| `style/partial-spacing` | on | `?` in method declaration needs surrounding spaces |
| `style/prefer-chaining` | on | Local variable can be replaced with `.>` chaining |
| `style/public-docstring` | on | Public types and methods should have a docstring |
| `style/trailing-whitespace` | on | Trailing spaces or tabs |
| `style/type-naming` | on | Type names should be CamelCase |

See the [Rule Reference](linting/rule-reference.md) for detailed explanations and code examples for each rule.

## Configuration

Create a `.pony-lint.json` file in your project root (next to `corral.json`) to configure rule status. Each entry maps a rule ID or category name to `"on"` or `"off"`:

```json
{
  "rules": {
    "style/line-length": "off",
    "style": "on"
  }
}
```

Rule-specific entries take precedence over category entries. CLI `--disable` flags take precedence over file configuration.

Config file discovery order:

1. `.pony-lint.json` in the current working directory
2. Walk up to find `corral.json`, then `.pony-lint.json` in that directory
3. Not found -- all rules use their defaults

## Suppression Comments

Inline comments suppress diagnostics for specific lines or regions:

```pony
// pony-lint: off style/line-length
let long = "this line won't be flagged for length"
// pony-lint: on style/line-length

// pony-lint: allow style/trailing-whitespace
let x = 1
```

Directives:

- `// pony-lint: off <rule-or-category>` -- suppress from this line onward
- `// pony-lint: on <rule-or-category>` -- resume checking
- `// pony-lint: allow <rule-or-category>` -- suppress next line only
- Omit the rule/category to suppress all rules

A rule-specific `on` overrides a category-level `off`. Unclosed `off` regions produce `lint/unclosed-suppression` diagnostics. Malformed directives (missing space, unknown directive, empty directive, duplicate `off`) produce `lint/malformed-suppression` diagnostics.

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | No violations found |
| 1 | One or more violations found |
| 2 | Operational error (unreadable file, malformed suppression) |
