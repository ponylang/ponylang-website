# RFC Process

Significant changes to the Pony language or standard library go through a Request for Comments (RFC) process. An RFC is a written proposal that the community reviews and discusses before a decision is made.

## When You Need an RFC

RFCs are required for changes to:

- Language syntax or semantics
- Standard library public APIs (adding, changing, or removing)
- Project-wide processes or policies

RFCs are **not** needed for:

- Bug fixes
- Refactoring that doesn't change public behavior
- Internal implementation changes
- Documentation improvements
- Tooling changes (corral, ponyup, etc.)

If you're unsure, ask in the [#RFCs](https://ponylang.zulipchat.com/#narrow/stream/189939-RFCs) channel on Zulip or bring it up at the [Development Sync](sync.md).

## Process

1. **Discuss informally.** Float your idea in the [#RFCs](https://ponylang.zulipchat.com/#narrow/stream/189939-RFCs) channel on Zulip or at the weekly Development Sync. Early feedback helps shape the proposal before you invest time writing it up.
2. **Write the RFC.** Fork the [rfcs repository](https://github.com/ponylang/rfcs), copy the template, and fill it in.
3. **Submit a PR.** Open a pull request against the rfcs repository. This is where formal review happens.
4. **Iterate.** Respond to feedback and revise the RFC as needed. Discussion happens on the PR itself and often at the Development Sync.
5. **Final Comment Period.** Once the RFC is considered ready, it enters a one-week Final Comment Period (FCP). This is the last chance for the community to raise concerns.
6. **Decision.** After FCP, the RFC is either accepted or rejected.

## Template Sections

The RFC template asks for:

- **Summary** -- a brief description of the proposal
- **Motivation** -- why this change is needed
- **Detailed design** -- the technical details
- **How We Teach This** -- how documentation, tutorials, and error messages should be updated
- **How We Test This** -- how the change will be tested
- **Drawbacks** -- reasons not to do this
- **Alternatives** -- other approaches considered
- **Unresolved questions** -- open issues to resolve during the RFC process

## More Information

The [rfcs repository](https://github.com/ponylang/rfcs) has the full details, including the template and all existing RFCs.
