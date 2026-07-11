---
id: TASK-ID
parent: null
risk: normal
run_file: tasks/runs/TASK-ID.md
dependencies: []
context:
  - path: AGENTS.md
    headings: []
ownership:
  owned: []
  allowed_shared: []
docs:
  impact: none
  owned: []
  reserved: []
gates:
  preflight: []
  reviewers: []
  final: []
---

# TASK-ID - Short Title

Treat the frontmatter as the canonical routing manifest. Do not repeat
dependencies, context, ownership, docs, or gates in the body. Freeze this file
when implementation starts; put mutable output in its run file.

## Goal

State the observable outcome and why it matters.

## Required Behavior

- Describe the target behavior or artifact precisely.
- Name important edge, failure, compatibility, and performance constraints.

## Out Of Scope

- Name adjacent work this ticket must not absorb.

## Acceptance Criteria

- [ ] Behavior or artifact can be verified from the exact candidate revision.
- [ ] Tests cover important success, edge, and failure paths.
- [ ] Documentation and assumption duties in the routing manifest are complete.

## Verification

- Focused development commands:
- Deterministic preflight:
- Final verification, if required:
- Environment or isolation requirements:

## Open Decisions

None. A ticket with unresolved owner decisions is `blocked`, not ready.

## Dispatch Freeze

- [ ] Owner decisions are resolved.
- [ ] Hard dependencies name accepted revisions.
- [ ] Context and ownership are narrow and complete.
- [ ] Acceptance criteria and commands are executable.
- [ ] Risk and gates are explicit.
- [ ] Run file and base revision are ready.
