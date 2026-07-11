---
name: orchestrate-work
description: Orchestrate substantial multi-step project campaigns using scoped implementation agents, independent risk-based review agents, immutable task tickets, pinned revisions, reusable verification evidence, and compact run state. Use when Codex is asked to run or continue an autonomous implementation campaign, coordinate implementer/reviewer/documenter agents, execute a dependency graph from tasks/current.md or an equivalent plan, establish this orchestration workflow in a repository, or reduce context/token waste in multi-agent project work. Do not use for a single small change, quick code review, pure planning discussion, or one-off question.
---

# Orchestrate Work

Act as the campaign orchestrator, not the default implementer. Keep product
policy in the repository and execution process in this skill's bundled
`references/tasks/` workflow.

## Select The Operation

- **Run or continue:** use project-local campaign state to select, implement,
  review, and accept work.
- **Bootstrap:** install missing workflow files, tailor the current campaign,
  and stop unless implementation was also requested.
- **Recover:** reconstruct compact state from tickets, version control, and
  evidence instead of replaying historical transcripts.

Preserve an established equivalent workflow. Add only missing controls and
files; do not replace project conventions wholesale.

## Ensure The Workflow Exists

Treat `references/tasks/` as the canonical complete workflow scaffold. Before
campaign work, check for its 12 files:

- `tasks/README.md`, `tasks/orchestrator.md`, `tasks/current.md`, and
  `tasks/campaign.md`
- `tasks/ticket-template.md`, `tasks/run-template.md`, `tasks/assumptions.md`,
  and `tasks/lessons.md`
- implementer, white-box, black-box, and specialist contracts under
  `tasks/agents/`

If `tasks/` or relevant files are missing:

1. Compare the bundled `references/tasks/` tree with the repository's task
   structure using the filesystem capabilities available in the environment.
2. Identify which workflow files are absent and which local files are
   equivalent despite different names or locations.
3. Create only missing files and directories from the bundled references. Use
   the environment's native file tools; require no Python, Node, shell, or other
   specific runtime.
4. Preserve every existing file. Stop and reconcile when a bundled path would
   collide with a file, symlink, or incompatible local convention.
5. Tailor `tasks/current.md` and `tasks/campaign.md` to the requested
   campaign; do not leave placeholders when execution is requested.

Never overwrite existing files automatically. If local workflow files differ,
preserve them and reconcile deliberately. Do not copy a new workflow merely
because a repository uses equivalent names or structure elsewhere.

## Load Only Required Process Context

Read repository instructions and project principles first. Then read the local
`tasks/orchestrator.md` completely. If it is unavailable and setup is not
authorized, read `references/tasks/orchestrator.md` instead.

Read `tasks/current.md`, the campaign index, the selected ticket, and only its
named contracts/headings. Keep archives cold.

Before dispatching a role, read only its matching local file completely, falling
back to the same path under `references/tasks/agents/`:

- `tasks/agents/implementer.md`: implementation and accepted fixes
- `tasks/agents/white-box-reviewer.md`: acceptance review with handoff
- `tasks/agents/black-box-reviewer.md`: independent critical-risk review
- `tasks/agents/specialists.md`: optional code-quality review, docs-heavy
  writing, and docs/code consistency; use only the relevant section

## Execute The Campaign

Follow `tasks/orchestrator.md` as the process contract:

1. Validate repository authority, owner decisions, dependencies, context,
   ownership, acceptance criteria, commands, docs impact, risk, and gates.
2. Prefer ready work that unblocks the critical path; split broad tasks.
3. Isolate implementation in a branch/worktree and record its base revision.
4. Dispatch one scoped implementer, then checkpoint and pin the candidate head.
5. Run deterministic preflight once and retain compact reusable evidence.
6. Run only risk-declared reviews; keep critical white-box and black-box passes
   independent.
7. Apply accepted fixes from `frozen ticket + accepted findings` and invalidate
   only affected gates.
8. Integrate the exact accepted revision, compact state, archive the run, and
   select the next action.

Respect environment authorization and concurrency limits. When supported,
start workers without inherited conversation context; in Codex, use
`fork_turns: "none"`. If independent subagents are unavailable, perform distinct
sequential passes and disclose that black-box review lacked contextual
independence.

Pass agents paths and revisions instead of pasted files, diffs, logs, or prior
messages. Never expose a black-box reviewer to implementer summaries, todos,
documenter notes, prior findings, or mutable run history.

## Preserve Decision And Evidence Integrity

Stop for the owner when a choice affects intent, public or third-party
contracts, security/privacy, data/schema/migrations, compatibility,
billing/releases, hard dependencies, or project principles. Permit only local,
reversible, low-blast-radius implementation assumptions and record them in
`tasks/assumptions.md`.

Review a pinned `base..head`, never a moving shared worktree. Reuse evidence
only for its exact revision, command, environment, and dependency state.
Isolate mutable external test state for parallel runs; otherwise serialize it.

Require pass reports to contain only verdict, head, evidence, targeted commands,
and residual risk. Require failures to contain actionable findings with
severity, evidence, impact, required outcome, and routing.

## Finish Cleanly

Integrate only accepted work using repository conventions. Keep unrelated dirty
changes out of the task diff. Move durable outcomes into contracts, assumptions,
public docs, or compact campaign state; keep scratch disposable and archives
cold.

At campaign boundaries, record evidence-backed lessons such as gate yield,
no-op work, duplicate verification, fix-loop causes, context cost, and
scheduling delays.
