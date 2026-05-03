---
name: prompt-research
description: Deep multi-agent research command for comprehensive codebase analysis using orchestrator-worker architecture with iterative refinement. Use for architecture analysis, security audits, performance investigations when you need thorough understanding with source citations across 2-4 iteration cycles.
argument-hint: "[research goal or question]"
---

# /prompt-research - Deep Multi-Agent Research

**Purpose:** Comprehensive codebase research using an orchestrator-worker
architecture with 2-4 iteration cycles, specialist agents in parallel, and
file:line citations on every finding.

---

## STARTUP: Load Project Context (ALWAYS FIRST)

Before any analysis, load known facts so the orchestrator skips re-researching:

1. Read `.claude/memory/project-knowledge.md`
2. Read `.claude/memory/architectural-context.md`
3. Read the last 3 sessions from `.claude/memory/sessions.md`

**Caching:** Stable library files (this SKILL, `prompt-perfection-core.md`,
`research-adapter.md`) are good `cache_control: ephemeral` candidates when
invoked via the Anthropic SDK. See `.claude/library/caching-strategy.md`.

---

## Overview

`/prompt-research` runs a **lead orchestrator** that spawns **5 specialist
agents in parallel** (Explore, Pattern, Security, Performance, Citation),
coordinates **2-4 iteration cycles** with gap-driven refinement, and
aggregates findings into a comprehensive report. Specialist roles are
described in `.claude/library/research-adapter.md`.

**Key capabilities:**
- Multi-agent orchestration with parallel specialist agents
- Iterative refinement with smart convergence (coverage + confidence targets)
- File:line citations and code snippets for every finding
- Persistent knowledge graph across sessions
- Comprehensive prioritised reports (Critical / Important / Informational)

**Phase 0 Import:** `@.claude/library/prompt-perfection-core.md` (canonical
flow with research-adapter Steps 0.25 / 0.35 / 0.55 add-ons; default MODEL
HINT for research is `opus`).

---

## When to Use

Use `/prompt-research` for:
- **Architecture analysis** - system structure, component relationships
- **Security audits** - OWASP Top 10, auth/authz, vulnerability detection
- **Performance investigations** - bottlenecks, N+1 queries, caching review
- **Pattern discovery** - naming, organisation, consistency checks
- **Critical decisions** where accuracy matters more than speed

## When NOT to Use

Use `/prompt` instead for:
- Quick questions or single-file changes
- Tasks where one agent and a single pass is sufficient
- Trivial fixes (typo, rename, one-line change)

---

## Phase 0: Prompt Perfection

Phase 0 runs as canonical — see `.claude/library/prompt-perfection-core.md`
and the research-specific adaptation in `.claude/library/research-adapter.md`.

**v2.1 add-ons (mandatory):** Step 0.25 Curiosity Gate, Step 0.35 Options-First
(present narrow / broad / comprehensive strategies with cost + duration before
spawning agents), Step 0.55 Execution Plan + MODEL HINT (default `opus` for
research; complexity >= 20). The approval gate accepts the response
`switch [haiku|sonnet|opus]` to override the routed tier. See
`.claude/library/execution-plan-template.md` and
`.claude/library/model-router.md` when constructing the plan.

**Delegation note (AI Fluency):** research operates in **Agency Mode** — the
orchestrator works independently and reports back. Humans decide on business
priority, severity sign-off, and architectural direction. The 4Ds framework
(detect / decide / direct / debrief) applies but does not need restating
inside the report.

---

## Usage

```
/prompt-research Analyze the authentication system for architecture and security
```

The command will ask up to three clarifying questions (scope, depth, specific
questions), present a strategy with cost/duration, wait for approval, then
execute.

---

## Orchestration Flow (Phase 1)

1. **Lead planning** (5-10s) — load memory, choose strategy, plan agent cohort
2. **Iteration 1** (30-40s) — Explore + Citation + scope-specific agents in parallel
3. **Iteration engine** (5s) — gap analysis against coverage + confidence targets
4. **Iteration 2-4** (30-40s each) — refine on detected gaps; stop when converged
5. **Aggregation** (20-30s) — dedupe, conflict resolution, prioritisation, report

**Convergence targets** (from `.claude/config/orchestration-config.json`):
coverage and confidence per strategy template. The engine stops when both
targets are met and there are zero unresolved questions or conflicts.

**Expected duration:** Narrow ~60s, Broad ~120s, Comprehensive ~180s
(first run, no cache; cached re-runs are 10-20x faster).

---

## Output: Research Report

A 15-20 page markdown report with these sections:
- Executive Summary + Key Takeaways
- Research Metadata (agents deployed, iterations, coverage, confidence)
- Critical / Important / Informational Findings (each with description,
  evidence, recommendation, priority, file:line citations with code snippets)
- Architectural Insights (component map, patterns)
- Security Analysis (OWASP Top 10 compliance table)
- Performance Analysis (bottlenecks, caching strategy)
- Patterns & Conventions
- Prioritised Recommendations
- Research Statistics + Next Steps

See `.claude/library/research-adapter.md` for the full report template.

---

## Persistent Memory

After research completes, the orchestrator updates
`.claude/memory/project-knowledge.md`,
`.claude/memory/architectural-context.md`, and
`.claude/memory/citation-index.md` so the next research session can build on
existing knowledge rather than re-discovering it.

---

## Configuration (read on demand)

- Read `.claude/config/complexity-rules.json` when you need
  `thresholds.research_mode` to decide automatic research routing.
- Read `.claude/config/orchestration-config.json` when you need
  `strategy_templates` (initial agents, max iterations, estimated duration)
  for narrow / broad / comprehensive.
- Read `.claude/config/agent-roles.json` when you need per-agent model tier,
  `timeout_seconds`, and `conditional` flags.

---

## Best Practices

- **Be specific.** "Analyze authentication system for security vulnerabilities"
  beats "analyze the code."
- **Match the tool to the task.** Use `/prompt` for quick fixes; reserve
  `/prompt-research` for genuinely complex multi-perspective work.
- **Frame questions with context.** "Are there bottlenecks in the API layer?"
  beats "is it fast?"
- **Leverage memory across sessions.** First session for breadth, second for
  depth on a specific area. Review `.claude/memory/project-knowledge.md`
  periodically to avoid redundant research.

---

## Troubleshooting

- **Research takes too long** — switch from Comprehensive to Broad/Narrow.
- **Low coverage (<70%)** — scope is too broad; narrow to specific components.
- **Too many findings** — focus on Critical/Important first; Informational is
  reference material.
- **Cache not working** — expected after file changes or branch switches.

---

## Related

- `.claude/library/prompt-perfection-core.md` — canonical Phase 0 + Fast Path
- `.claude/library/research-adapter.md` — research-specific adaptation,
  specialist agent roles, report template
- `.claude/library/caching-strategy.md` — `cache_control: ephemeral` guidance

Version history: see `.claude/CHANGELOG-skills.md`.
