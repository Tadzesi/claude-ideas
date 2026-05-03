# Research Adapter - Phase 0 for /prompt-research

**Version:** 2.0
**Adapter Type:** Phase 0 research-specific adaptation
**Parent Library:** [prompt-perfection-core.md](prompt-perfection-core.md)
**Used by:** `.claude/skills/prompt-research/SKILL.md`

---

## Overview

Phase 0 add-on for `/prompt-research`. Adds a complexity score for
research depth, maps the score to a strategy (Narrow / Broad /
Comprehensive), and overrides Phase 0 Step 4 (clarifying questions) +
Step 5 (structured output) with research-specific templates. Everything
else in Phase 0 (language detection, type identification, completeness
validation, approval gate) runs as-is from `prompt-perfection-core.md`.

Subagent orchestration, iteration loop, and aggregation live in the
SKILL itself (`.claude/skills/prompt-research/SKILL.md`) — they are
runtime concerns, not Phase 0 concerns.

---

## Research Complexity Scoring

Reuse the base complexity score from `prompt-perfection-core.md`, then
add research-specific weights:

| Trigger                     | Weight |
|-----------------------------|--------|
| Security audit requested    | +10    |
| Performance investigation   | +8     |
| Architecture analysis       | +7     |
| Pattern discovery           | +6     |
| Codebase exploration        | +7     |
| Technical debt assessment   | +8     |
| Compliance review           | +10    |
| Multiple focus areas        | +5     |

Source: `.claude/config/complexity-rules.json` (entries with
`research_mode: true`).

---

## Strategy Selection

| Score band | Strategy        | Default cohort                                    | Iterations | Duration |
|------------|-----------------|---------------------------------------------------|------------|----------|
| 0-19       | not research    | use `/prompt` instead                             | n/a        | n/a      |
| 20-29      | Narrow          | explore + citation                                | 1-2        | ~60s     |
| 30-49      | Broad           | explore + citation + pattern + 1 specialist       | 2-3        | ~120s    |
| 50+        | Comprehensive   | explore + citation + security + performance + pattern | 3-4    | ~180s    |

User can override the routed strategy in the approval gate (e.g.
`switch broad`). Selection rules and per-subagent invocation patterns
live in `prompt-research/SKILL.md` ("Specialist Selection Rules" +
"Orchestration Flow").

---

## Phase 0 Step 4 Override — Clarifying Questions

For research prompts, replace the generic Step 4 questions with
these three:

**Q1 — Research scope**
> What specific aspects should I research?
>   1. Architecture & Design — components, data flow, patterns
>   2. Security & Compliance — vulnerabilities, auth, OWASP Top 10
>   3. Performance & Scalability — bottlenecks, caching, async
>   4. Code Quality & Patterns — conventions, consistency, debt
>   5. All of the above (comprehensive — slower)

**Q2 — Research depth**
> How deep should the analysis be?
>   1. Quick overview (Narrow, 1-2 iterations, ~60s)
>   2. Standard analysis (Broad, 2-3 iterations, ~120s) [recommended]
>   3. Comprehensive audit (3-4 iterations, ~180s)

**Q3 — Specific questions**
> What concrete questions need answering? (free text — examples:
> "How does authentication work?", "Are there N+1 queries on the
> dashboard?", "Which patterns govern error handling?")

Skip Q4 (focus prioritisation) unless Q1 = "All of the above".

---

## Phase 0 Step 5 Override — Structured Output

For research prompts, the perfected prompt template is:

```markdown
## Goal
<research objective from user>

## Research Scope
<components / paths / "full codebase">

## Research Depth
Narrow | Broad | Comprehensive   (← from Q2)

## Focus Areas
- Architecture | Security | Performance | Patterns
  (one or more, from Q1)

## Specific Questions
1. <Q3 item 1>
2. <Q3 item 2>
...

## Constraints
- Time budget: <from depth>
- Files to exclude: <patterns if any>

## Expected Deliverables
- Research report with prioritised findings (Critical / Important /
  Informational)
- file:line citations for every claim
- Updates to .claude/memory/{project-knowledge,architectural-context,
  citation-index}.md
```

---

## Performance Expectations

| Strategy       | Subagents | Iterations | First-run | Cached re-run |
|----------------|-----------|------------|-----------|---------------|
| Narrow         | 2         | 1-2        | ~60s      | ~10s          |
| Broad          | 3-4       | 2-3        | ~120s     | ~10s          |
| Comprehensive  | 5         | 3-4        | ~180s     | ~10s          |

Cached re-run assumes same prompt + unchanged files.

---

Version history: see `.claude/CHANGELOG-skills.md`.
