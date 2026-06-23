# Grill mode: learn a topic (Socratic)

Interrogate the user to build and test *their* understanding of a topic. The goal is their learning, not an implementation. Apply the grilling engine from `SKILL.md`.

## Workflow

1. **Scope check** — restate what they want to understand and the use they have in mind; confirm.
2. **Map the territory** — identify the sub-areas of the topic; start with the branch that matters most to them.
3. **Socratic questioning** — for each branch, ask questions that surface what they already know and where the gaps or misconceptions are. Guide them toward working it out themselves rather than handing over the answer (keep them in their zone of proximal development).
4. **Active recall** — have them retrieve and restate concepts in their own words, and revisit earlier ideas later in the session. Repeated retrieval, not re-explaining, is what makes it stick.
5. **Adaptive scaffolding** — track how well each answer lands and adjust the next question's difficulty up or down accordingly.
6. **Correct misconceptions explicitly — do not let politeness win.** LLMs tend to stay agreeable and leave wrong beliefs unaddressed; this is the #1 failure mode of AI tutoring. When the user is wrong, say so clearly, give the correct mental model, then probe to confirm it landed.
7. **Find, don't lecture** — pull facts from authoritative sources or your own knowledge to ground the discussion; cite when useful.
8. **Checkpoint** — summarize their mental model back to them; have them confirm or correct.

## Artifact

Write `NOTES-<topic>.md`:

```
# Notes: <topic>

## Goal
<what they wanted to understand, and the use case>

## Core concepts
<the key ideas, in plain language>

## Mental model
<the confirmed understanding, in the user's framing>

## Corrected assumptions
<misconceptions surfaced and the correction>

## Open gaps / next
<what to explore next>
```
