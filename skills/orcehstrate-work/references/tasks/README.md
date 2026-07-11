# Tasks Workflow

Twelve files form the complete portable workflow:

1. `README.md` — explain the layout and the purpose of every retained file.
2. `orchestrator.md` — define scheduling, context, review, and fix policy.
3. `current.md` — route the active campaign to one phase and next action.
4. `campaign.md` — hold the compact dependency graph and task index.
5. `ticket-template.md` — define the immutable contract for dispatched work.
6. `run-template.md` — combine mutable state, handoff, evidence, and findings.
7. `assumptions.md` — record local reversible choices needing later review.
8. `lessons.md` — retain evidence-backed workflow improvements.
9. `agents/implementer.md` — constrain implementation and accepted fix work.
10. `agents/white-box-reviewer.md` — verify acceptance with the handoff context.
11. `agents/black-box-reviewer.md` — provide independent critical-risk review.
12. `agents/specialists.md` — combine optional quality, docs writing, and docs
    sync roles.

Repository instructions and project principles define product policy. These
files define execution process and project-local campaign state.

Create task tickets from `ticket-template.md` and one mutable run file per task
from `run-template.md`. Create scratch, archive, or domain-contract directories
only when the project actually needs them.

Never overwrite an existing workflow file automatically; reconcile it with the
bundled version deliberately.
