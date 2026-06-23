# Grill mode: design / plan / architecture

Pressure-test a plan or design **before** any code is written. Apply the grilling engine from `SKILL.md`.

## What to cover (branches of the tree)

- **Why this approach?** What alternatives were considered and rejected, and why?
- **What breaks first?** Edge cases, failure modes, error states.
- **Dependencies** — what must be true for this to work? What does it depend on, and what depends on it?
- **Load-bearing decisions** — which choices are hard to reverse later? Which are cheap to change?
- **Blast radius** — callers, consumers, downstream systems, data/migrations.
- **Unknown-unknowns pass** — "What are we most unsure about? Where are we most likely to be surprised? What did we assume but never write down?"

Run this as a debate, not a checklist: for each load-bearing decision, argue the strongest case *against* it before accepting it. External adversarial pressure plus the user's self-correction is what surfaces the weak joints — agreement reached without a challenge is not yet tested. If a second model or agent is available in this environment, an independent critique of the locked design is high-value (optional, harness-dependent — never block on it).

## Artifact

Update the existing design doc if one is referenced; otherwise write `DESIGN-<topic>.md`:

```
# Design: <topic>

## Goal
<one paragraph — what the grill actually settled>

## Approach
<numbered, concrete steps>

## Key decisions & tradeoffs
<the contestable choices the grill resolved — name them>

## Risks / open questions
<anything still genuinely open>

## Out of scope
<bounds the grill established>
```
