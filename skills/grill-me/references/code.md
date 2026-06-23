# Grill mode: existing code change / diff review

Grill the user about an **already-written** change, then review the actual code against their stated intent. Apply the grilling engine from `SKILL.md`.

## Step A — Establish scope & intent

- Determine the diff: files/diffs the user points to; else `git diff main...HEAD` on a feature branch; else the working/staged changes (`git diff`, `git diff --staged`).
- Before grilling, read the actual changed code so every question is grounded in what is really there.
- Grill the user to pin down **intent**: What is this change supposed to do? What is the success criterion? What is explicitly out of scope?

## Step B — Grill against the code (branches of the tree)

Review in **independent passes** rather than one blurred sweep — research shows separating concerns catches more than a single general pass:

- **Intent vs implementation** — does the code actually do what they said? Where does it diverge?
- **Correctness** — edge cases, error handling, off-by-one, null/empty, concurrency.
- **Completeness** — does it fully address the stated task, or only the happy path?
- **Blast radius** — callers/consumers affected, backward compatibility, migrations.
- **Tests** — what is covered, what regression is likely, what is untested.
- **Simpler alternative** — is there a smaller, cleaner way to achieve the same intent?
- For each, find the answer in the code first; only ask the user when the intent or tradeoff is genuinely theirs to decide.

## Counter the leniency bias (important)

LLM reviewers systematically *over-approve* — a reviewer tends to share the author's blind spots and wave code through. Defend against it:

- **Adopt an explicitly adversarial stance.** Default assumption: there is a flaw here and your job is to find it. "Looks fine" is not an acceptable result until you have actively tried to break it.
- **Demand evidence, not vibes.** Every "this is correct" must cite the specific code path that makes it correct; every finding must cite `file:line`.
- **Second opinion when available.** If a second model or agent is reachable in this environment (any vendor), hand it the same diff and intent for an independent read — cross-model disagreement is high-value signal. This is optional and harness-dependent; never block on it.

## Artifact

Write `REVIEW-<branch-or-topic>.md`:

```
# Review: <change>

## Intent
<what the change is meant to do, as confirmed in the grill>

## Scope reviewed
<files / diff range>

## Findings
<each: severity · location (file:line) · issue · suggested fix>

## Verified
<what was checked and is sound>

## Risks / open questions
<for the user to decide>
```

Do not modify the code during the grill — produce the review. Fixes are a separate, user-approved step.
