---
name: grill-me
description: Use when the user wants to be grilled/interrogated with relentless questions to pressure-test something before producing an artifact — a design/plan/architecture (before coding), an existing code change/diff (review), or a topic they want to learn/understand. Triggers on "grill me", "stress-test this", "challenge my design/plan", "review my change/diff", "interrogate me about X", "teach me / help me understand X". Routes to one of three modes and writes a documentation artifact at the end. NOT for quick one-off clarifications (just ask directly) or trivial changes.
---

# Grill Me

Relentlessly interview the user, one branch of the decision tree at a time, until you reach a shared, testable understanding — then write the artifact. Derived from Matt Pocock's `grill-me` (MIT).

## Step 1 — Pick the mode (route)

Detect which kind of grilling this is, then **read the one matching reference file and follow it**. Read ONLY the file you need — never load more than one mode.

| Signal | Mode | Read |
|--------|------|------|
| A plan, RFC, design, architecture, "should I build X this way" — anything *before* code exists | **design** | `references/design.md` |
| An existing change/diff/branch/committed code, "review my change", "is this code right" | **code** | `references/code.md` |
| Wanting to understand or learn a topic, "teach me X", "help me understand Y" | **learn** | `references/learning.md` |

If it's genuinely ambiguous, ask ONE picker question to choose the mode, then route.

## The grilling engine (applies to every mode)

- **Walk the decision tree.** Resolve one branch and its dependencies before opening the next.
- **Short, focused questions tied to concrete facts** — one idea per question, building on the last answer, not broad multi-part prompts. (Socratic-questioning research: focused, fact-anchored questions outperform open essays.)
- **Adaptive question format.** For a simple either/or decision, offer a small set of explicit numbered options so the user can pick fast. For deep or open-ended branches, ask one conversational question at a time. If your harness/agent provides a structured multiple-choice prompt UI, use it for the pick-one cases; otherwise present the options inline as a numbered list — the behavior is the same either way.
- **Always recommend an answer** with each question, plus a one-line why.
- **Find, don't ask.** If the answer lives in the codebase, the docs, or your own knowledge, go get it and state what you found instead of asking.
- **Surface assumptions.** Whenever you infer something, say it out loud and have the user confirm or correct it.
- **Stay skeptical, not agreeable.** Your job is to find what breaks, not to validate. Don't let politeness suppress a real objection; name the weakness plainly.
- **Stop at "good enough."** Aim for clarity a downstream step could act on — don't chase perfection.

## Portability

This skill is harness- and model-agnostic. It names no specific CLI, model, or vendor tool. Use whatever your environment provides for the generic actions it calls for: reading files, inspecting a diff, searching the codebase, asking the user, and writing a markdown file. Any capable agent (Claude, Codex, Gemini, or another) can run it.

## Step 2 — Write the artifact

Every session ends with a written doc; the mode's reference file says which file and what structure. Confirm the converged understanding with the user first, then write it. No code or implementation happens during a grill — that is a separate step after the user signs off.

## Step 3 — Self-improvement

This skill improves by editing its own files (`SKILL.md` and `references/*.md`). After a session, run a quick retro — but only act when there's a *durable, generalizable* lesson, never on a one-off:

- **What to look for:** a question pattern that reliably exposed real problems (worth adding); a line of questioning that wasted the user's time (worth cutting or tightening); a blind spot the grill missed that the user had to point out (worth adding as a checklist item); explicit user feedback on how they want to be grilled.
- **Generalize, don't log.** Encode only lessons that will apply to *future* sessions of this mode. Project- or session-specific details do not belong in the skill — leave those in the session's artifact doc.
- **Propose before writing.** State the exact edit (which file, what changes, and why) and apply it only after the user confirms — editing the skill is a real change to their environment.
- **Stay lean.** The skill's value is its brevity. When you add something, look for something stale to prune; net growth should be slow. If the same lesson recurs across modes, put it here in `SKILL.md`, not in each reference.

Trigger this only when a lesson actually emerged, or when the user asks to refine the skill. A routine session with nothing notable needs no change.
