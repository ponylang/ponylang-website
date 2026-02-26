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
| `style/comment-spacing` | on | `//` not followed by exactly one space |
| `style/file-naming` | on | File name should match principal type |
| `style/hard-tabs` | on | Tab characters anywhere in source |
| `style/line-length` | on | Lines exceeding 80 columns |
| `style/member-naming` | on | Member names should be snake_case |
| `style/package-naming` | off | Package directory name should be snake_case |
| `style/public-docstring` | on | Public types and methods should have a docstring |
| `style/trailing-whitespace` | on | Trailing spaces or tabs |
| `style/type-naming` | on | Type names should be CamelCase |

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
