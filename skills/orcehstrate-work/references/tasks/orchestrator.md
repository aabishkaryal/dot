# Orchestrator

Project-agnostic workflow for substantial autonomous work. Execute the campaign
in `tasks/current.md`, dispatch narrow workers, verify exact revisions, route
fixes, and stop only for true blockers or owner decisions. Repository
instructions, project principles, and task tickets define product policy; this
file defines process.

## Context

Keep these layers separate:

- repository instructions and project principles: durable policy;
- `tasks/current.md`: active campaign and next action;
- campaign index: dependencies and compact task state;
- frozen ticket: implementation contract;
- `tasks/runs/<task-id>.md`: mutable state, handoff, evidence, and findings;
- `tasks/tmp/`: scratch; archives: cold history.

Read this file, `tasks/current.md`, the campaign index, the selected ticket, and
only the contracts or source sections that ticket names. Fold accepted decisions
into a ticket or domain contract; review history is provenance, not another
active specification.

Give workers a fresh scoped packet: repository instructions, one role, one
ticket, exact context paths/headings, owned paths, revisions, and commands.
Prefer references over pasted files, diffs, logs, or prior messages. Never send
the whole task tree or an archive by default.

When supported, disable inherited conversation context; in Codex, use
`fork_turns: "none"`. A black-box reviewer must not receive or read implementer
summaries, todos, prior findings, or mutable run notes.

## Tickets And Scheduling

Create tickets from `tasks/ticket-template.md` and run files from
`tasks/run-template.md`. Freeze a ticket when implementation starts and keep
all progress outside it. Use these run states: `draft`, `blocked`, `ready`,
`implementing`, `review`, `fix`, and `accepted`.

A ready ticket names accepted dependency revisions, scoped context, ownership,
acceptance criteria, verification, docs impact, risk, and gates. The main agent
owns readiness, sequencing, risk, revision pinning, review routing, owner
decisions, and final acceptance; delegate substantive implementation, docs,
review, and fixes when workers are available.

Prefer ready work that unblocks the critical path; use task number only as a
tiebreaker. Parallel implementation requires disjoint dependencies and writes
plus separate worktrees or equivalent isolation. Keep high-conflict shared
surfaces sequential unless proven otherwise. Pipeline independent work when one
pinned revision is under read-only review, and split broad work before dispatch.

## Risk And Gates

Every ticket declares its risk and exact gates.

- `low`: narrow docs/tests/mechanical or behavior-preserving work. Use
  deterministic preflight, main-agent scope review, and a specialist only when
  useful.
- `normal`: localized behavior using established patterns with no stable
  contract, security, data, migration, or concurrency impact. Use preflight and
  one combined acceptance/code-quality review; add docs review when needed.
- `critical`: security/authorization, secrets, destructive or compatibility
  data changes, migrations, concurrency/lifecycle, public or third-party
  contracts, releases, or broad cross-layer work. Use preflight plus white-box
  and black-box review in parallel; add quality/docs specialists only when the
  ticket or diff warrants them.

Dual review is a risk control, not universal ceremony. Risk may be raised before
review; lowering declared critical risk requires a recorded reason. Never
dispatch a documenter merely to prove a no-op.

## Lifecycle

1. Select the highest-value ready task or owner decision.
2. Validate dependencies, context, ownership, risk, gates, and criteria.
3. Create an isolated branch/worktree and record the base revision.
4. Dispatch one implementer with a fresh scoped packet.
5. Check changed paths, checkpoint the candidate, and record its head revision.
6. Run deterministic preflight once for that revision and record compact
   evidence.
7. Perform the main-agent scope check and run only declared review gates.
8. Route accepted findings and re-run only invalidated gates.
9. Run final broad verification once when risk or release policy requires it.
10. Integrate the accepted revision, compact the outcome, and archive the run.

For decision-only campaigns, do not dispatch implementers. Batch independent
decisions only when their tradeoffs remain clear.

## Evidence, Reviews, And Fixes

Review a pinned `base..head`, never a moving shared worktree. Checkpoint commits
may be squashed during integration; the main branch receives only accepted work.

Evidence is valid only for its revision, command, environment, and dependency
state. Record compact successes and retain detailed logs only when useful.
Reuse valid evidence and run targeted commands for independent claims,
uncovered risks, changed environments, or explicit requirements. Isolate
mutable external test state for parallel runs; otherwise serialize it.

Passing reviews report verdict, head revision, evidence, targeted commands, and
residual risk. Failing reviews add only actionable findings with severity,
evidence, impact, required outcome, and routing. Reviewers are read-only unless
later dispatched as fix workers.

Apply fixes from `frozen ticket + accepted findings`, create a new head and
preflight, then invalidate gates by impact:

- production or public-contract change: affected acceptance gates; critical
  changes normally invalidate both white-box and black-box;
- tests only: requesting reviewer plus relevant automated checks;
- docs only: docs review;
- task intent or criteria: freeze a revised ticket and re-run all gates;
- mechanical conflict resolution: main-agent inspection and affected checks.

## Decisions, Docs, And History

Permit only local, reversible, low-blast-radius implementation assumptions. Stop
for intent, public contracts, security/privacy, data/schema/migrations,
compatibility, billing/releases, dependencies, or project-principle decisions.
Put durable assumptions in `tasks/assumptions.md`, not tickets or handoffs.

Make each ticket declare docs impact and files. Let the implementer update
adjacent docs; use a documenter for docs-heavy work or accepted docs findings.
Use docs-sync review for public/operational changes, relevant phase boundaries,
and release. Let campaign policy name release-only documents.

Use `tasks/runs/` for structured active artifacts and create scratch storage only
when needed.
Keep archives cold unless a ticket links one precise fact. At campaign
boundaries, update `tasks/lessons.md` with gate yield, no-op work, duplicate
verification, fix loops, context cost, and scheduling delays.
