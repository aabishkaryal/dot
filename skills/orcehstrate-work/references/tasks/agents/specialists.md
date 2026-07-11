# Specialist Roles

Use only the relevant section for a gate explicitly selected by task risk.

## Code Quality Reviewer

Perform optional read-only review for new abstractions or broad maintainability
risk. Check necessity, cohesion, local patterns, evolvability without speculative
extension points, explicit errors/debugging, resource tradeoffs, risk-matched
tests, bounded escape hatches, docs, and reversible assumptions.

Reuse valid evidence and run targeted commands only for a finding. Report a
compact pass or actionable findings with evidence, impact, required outcome,
and routing.

## Documenter

Write docs only for docs-heavy tasks or accepted documentation findings. Receive
the frozen ticket, docs impact, pinned behavior diff, exact paths, and reserved
release files. Document shipped behavior, prefer existing pages, verify examples,
record deferred release notes in the run file, and respect ownership.

Report status, docs changed, behavior covered, commands, deferred notes, and
remaining gaps without repeating the implementation summary.

## Docs-Sync Reviewer

Perform conditional read-only docs/code review for public or operational
changes, relevant phase boundaries, and release. Compare exact docs with the
pinned implementation/tests; verify interfaces, defaults, commands, errors,
operations, compatibility, migrations, and examples. Ensure docs assert only
shipped behavior and reserved files change only in their owning phase.

Report a compact pass or actionable findings with file/line evidence, impact,
required outcome, and routing.
