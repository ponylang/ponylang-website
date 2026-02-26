# Documentation Generation

pony-doc generates API documentation for Pony packages. It produces a complete [MkDocs](https://www.mkdocs.org/) site with the [Material](https://squidfundamentals.com/mkdocs-material/) theme, including type pages, method signatures, docstrings, and source code browsing. It is part of the [ponylang/ponyc](https://github.com/ponylang/ponyc) repository, built alongside the compiler, and distributed with it. Installing ponyc from source or via ponyup will include pony-doc.

## Usage

```bash
# Generate docs for the current directory
pony-doc

# Generate docs for a specific package
pony-doc path/to/my-package

# Write output to a specific directory
pony-doc -o docs path/to/my-package

# Include private types and methods
pony-doc --include-private

# Print version
pony-doc --version
```

pony-doc compiles the package through the type-checking pass, extracts type information from the AST, and writes MkDocs-compatible markdown. The output lands in a directory named `<package>-docs/` inside the output directory (current directory by default).

## Output

The generated site includes:

- A home page listing all packages
- A page per package with its public (and optionally private) types
- A page per type with constructors, fields, methods, parameters, and return types
- Source code pages with line-numbered Pony source
- Cross-reference links between types

By default, only public types and methods are included. Use `--include-private` to include private types and methods as well.

## Viewing the Output

The generated output is a MkDocs project. To view it locally:

```bash
pip install mkdocs-material
cd <package>-docs
mkdocs serve
```

Then open `http://127.0.0.1:8000` in a browser.

## Using with Corral

For projects that use [corral](https://github.com/ponylang/corral) for dependency management, run pony-doc through `corral run` so that dependencies are on the package search path:

```bash
corral run -- pony-doc
```
