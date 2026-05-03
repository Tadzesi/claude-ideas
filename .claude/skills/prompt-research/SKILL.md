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

`/prompt-research` runs orchestration **in the main thread** that spawns
up to 5 real Anthropic subagents in parallel via the Task tool
(`@research-explore`, `@research-pattern`, `@research-security`,
`@research-performance`, `@research-citation` — all defined in
`.claude/agents/`), coordinates 2-4 iteration cycles with gap-driven
refinement, and aggregates findings into a comprehensive report.

**Key capabilities:**
- Real subagent orchestration (isolated context per specialist) via Task tool
- Iterative refinement with smart convergence (coverage + confidence targets)
- File:line citations and code snippets for every finding
- Persistent knowledge graph across sessions
- Comprehensive prioritised reports (Critical / Important / Informational)

**Why orchestration runs in main thread:** Anthropic subagents cannot spawn
other subagents (https://code.claude.com/docs/en/sub-agents#limitations).
The iteration loop, gap analysis, citation index persistence, and final
aggregation all live in this skill (main context).

**Phase 0 Import:** `@.claude/library/prompt-perfection-core.md` (canonical
flow with research-adapter Phase 0 add-ons; default MODEL HINT for
research is `opus`).

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

## Specialist Selection Rules

Always spawn (every iteration of every research session):
- `@research-explore`   — file discovery, architecture mapping
- `@research-citation`  — file:line evidence for every finding

Conditionally spawn based on detected keywords + complexity score:

| Subagent                | Spawn when (any condition true)                                    |
|-------------------------|--------------------------------------------------------------------|
| `@research-security`    | keywords: security, authentication, authorization, encryption,     |
|                         | vulnerability, payment, credential, password, token                |
|                         | OR complexity >= 15                                                |
| `@research-performance` | keywords: performance, slow, optimization, bottleneck,             |
|                         | scalability, latency, throughput, caching                          |
|                         | OR complexity >= 12                                                |
| `@research-pattern`     | keywords: pattern, convention, like other, match existing,         |
|                         | consistent, standard                                               |
|                         | OR strategy in {broad, comprehensive}                              |

Strategy → default cohort size:
- Narrow:        explore + citation                              (2)
- Broad:         explore + citation + pattern + 1 specialist     (3-4)
- Comprehensive: explore + citation + security + performance + pattern (5)

Source: `.claude/config/orchestration-config.json#agent_cohort_rules` plus
the per-subagent `description` frontmatter (which is also pushy enough for
auto-delegation outside `/prompt-research`).

---

## Orchestration Flow

**Iteration 1** (parallel spawn — single message with multiple Task
tool invocations, one per subagent):

```
Task(subagent_type: "research-explore",   prompt: <scope-specific>)
Task(subagent_type: "research-citation",  prompt: <findings-to-cite>)
Task(subagent_type: "research-{conditional}", prompt: ...)
```

Wait for all SubagentStop events (Anthropic auto-handles this when Task
calls are batched in one message).

**Gap analysis** (main context):
- Compare aggregated subagent summaries against
  `orchestration-config.json#convergence_settings`:
  `min_coverage: 0.70`, `min_confidence: 0.80`,
  `max_unresolved_conflicts: 2`.
- If converged → proceed to Aggregation.
- If gaps → Iteration 2 with refinement spawns targeted at the gap.

**Iterations 2-4:** spawn refinement subagents per detected gap. Stop when:
- convergence reached, OR
- max iterations (4) hit, OR
- no new findings between two consecutive iterations.

**Aggregation** (main context):
- Dedupe similar findings (similarity >= 0.85).
- Resolve conflicts (prefer higher-confidence source).
- Prioritise by severity (Critical / Important / Informational).
- **Append citation index entries** returned by `@research-citation` to
  `.claude/memory/citation-index.md` (subagents are read-only; this
  write happens in main thread).
- Update `.claude/memory/project-knowledge.md` and
  `.claude/memory/architectural-context.md` with new insights.
- Render final report.

---

## Performance Expectations

First-run (no cache) duration estimates:

  Narrow strategy        ~60s   (2-3 subagents, 1-2 iterations)
  Broad strategy         ~120s  (3-4 subagents, 2-3 iterations)
  Comprehensive strategy ~180s  (5 subagents, 3-4 iterations)

Cached re-run (same prompt, files unchanged): ~10s (10-20× faster).
Subagents have isolated context windows — their cache lifecycle is
separate from the main session cache.

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

Each subagent owns its own "Output format" section in
`.claude/agents/research-*.md`; the report concatenates per-subagent
sections under the appropriate severity heading.

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
- Per-agent model and tools live in subagent frontmatter
  (`.claude/agents/research-*.md`); inspect via `/agents` UI or read
  the files directly.

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
