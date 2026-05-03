# Multi-Agent Research

Deep analysis through real Anthropic subagents working in parallel with
iterative refinement. As of v5.2, every specialist is a real subagent
file in `.claude/agents/` — no prose simulation.

## Architecture (v5.2+)

```
┌──────────────────────────────────────────────────────────────────┐
│  Main thread — .claude/skills/prompt-research/SKILL.md           │
│  (orchestrator: planning, iteration loop, gap analysis,          │
│   citation index persistence, aggregation)                        │
└────────────────────────┬─────────────────────────────────────────┘
                         │ Task tool (parallel spawn,
                         │ single message multiple invocations)
        ┌────────────────┼────────────────┐
        ▼                ▼                ▼
   ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ...
   │@research-   │  │@research-   │  │@research-   │
   │ explore     │  │ citation    │  │ security    │
   │ (haiku)     │  │ (haiku)     │  │ (sonnet)    │
   └──────┬──────┘  └──────┬──────┘  └──────┬──────┘
          │ summary         │ citations       │ findings
          └─────────────────┼─────────────────┘
                            ▼
                  Subagent results return to main
                  thread (isolated context per agent)
                            │
                            ▼
                  Aggregation + gap analysis
                  (main thread)
                            │
                            ▼
                  Converged? → Report
                  Not yet?   → Iteration N+1
```

**Why orchestration runs in main thread:** subagents cannot spawn other
subagents ([Anthropic limit](https://code.claude.com/docs/en/sub-agents#limitations)).
The iteration loop, gap analysis, citation index writes, and final
aggregation all live in the orchestrator skill.

## When to Use

Multi-agent research is designed for complex problems requiring multiple perspectives:

| Use Case | Description |
|----------|-------------|
| **Security Audits** | Comprehensive vulnerability analysis |
| **Architecture Review** | Design decisions across the system |
| **Performance Analysis** | Bottleneck identification |
| **Codebase Understanding** | Learning a new or complex codebase |
| **Migration Planning** | Large-scale refactoring strategies |

## How It Works

See the architecture diagram above. The orchestrator (main thread)
spawns 2-5 specialist subagents in parallel via the Task tool, waits
for all to complete, runs gap analysis, and either spawns refinement
subagents in iteration N+1 or proceeds to aggregation.

## Aggregation Pipeline

The "Result Aggregation" stage in the diagram above runs an 8-phase
synthesis: (1) **Collection** of per-agent outputs, (2) **Deduplication**
of overlapping findings, (3) **Conflict resolution** when agents disagree
on the same artefact, (4) **Confidence scoring** per finding,
(5) **Organisation** into Critical / Important / Informational tiers,
(6) **Citation enrichment** with `file:line` evidence, (7) **Knowledge
graph update** so subsequent runs build on prior context, and (8) **Metrics**
(coverage %, agent agreement, iteration cost). Convergence is declared
when coverage ≥ 70 % and confidence ≥ 80 % across all open questions, or
when the iteration cap (default 4) is reached.

## Subagents

All five live in `.claude/agents/` as real Anthropic subagents with valid
YAML frontmatter ([spec](https://code.claude.com/docs/en/sub-agents#supported-frontmatter-fields)).
The model and tool allowlist are declared in frontmatter, not in any
JSON config — single source of truth.

| File                       | Model  | Color  | Tools             | Focus                        |
|----------------------------|--------|--------|-------------------|------------------------------|
| `research-explore.md`      | haiku  | blue   | Read, Grep, Glob  | Codebase discovery, deps     |
| `research-citation.md`     | haiku  | purple | Read, Grep        | file:line evidence           |
| `research-pattern.md`      | haiku  | green  | Read, Grep, Glob  | Convention consistency       |
| `research-security.md`     | sonnet | red    | Read, Grep, Glob  | OWASP Top 10, secrets, crypto|
| `research-performance.md`  | sonnet | orange | Read, Grep, Glob  | N+1, async, caching, leaks   |

Bash is intentionally absent — read-only research is fully served by
Read + Grep + Glob, narrowing attack surface. Write/Edit are absent
because subagents do not modify files; the orchestrator (main thread)
owns all writes (citation index, project knowledge, architectural
context).

## Iteration Process

### Cycle 1: Initial Analysis

Each agent examines the codebase independently:

```
Iteration 1 Results:

Explore Agent:
- Found 156 files, 12 services
- Express.js + Prisma stack
- RESTful API pattern

Security Agent:
- 3 potential SQL injection points
- Missing rate limiting on auth endpoints
- JWT stored in localStorage (risk)

Performance Agent:
- 2 N+1 query patterns detected
- Large unbounded queries in listings
- No pagination on user endpoint
```

### Cycle 2: Gap Analysis

Lead agent identifies missing coverage:

```
Gap Analysis:

Covered:
✓ Authentication security
✓ Query performance
✓ API structure

Gaps Identified:
- Authorization (role checks)
- Error handling consistency
- Database connection pooling

Next Iteration Focus:
- Security: Dive into authorization
- Performance: Check connection handling
```

### Cycle 3: Deep Dive

Agents focus on identified gaps:

```
Iteration 2 Results:

Security Agent (Authorization focus):
- Role checks missing on 5 admin endpoints
- No middleware pattern for permissions
- User can access other users' data

Performance Agent (Connection focus):
- Connection pool size: 10 (may be low)
- No connection timeout configured
- Missing connection error handling
```

### Convergence

Research continues until:
- All identified gaps are addressed
- Maximum iterations reached (default: 4)
- Confidence threshold met

## Output Format

### Comprehensive Report

Multi-agent research produces detailed reports:

```markdown
# Research Report: Authentication System

## Executive Summary
3-agent analysis over 4 iterations identified 8 security
issues and 5 performance concerns requiring attention.

## Methodology
- Agents: Explore, Security, Performance
- Iterations: 4
- Files Analyzed: 23
- Time: 142 seconds

## Findings

### Critical (Immediate Action)

1. **SQL Injection Risk** [Security]
   Location: src/services/user.service.js:45
   Issue: Unparameterized query construction
   Recommendation: Use Prisma parameterized queries

2. **JWT in localStorage** [Security]
   Location: src/auth/token.js:12
   Issue: XSS vulnerability exposure
   Recommendation: HttpOnly cookie storage

### High Priority

3. **Missing Rate Limiting** [Security]
   Location: src/routes/auth.js:1-50
   Issue: Brute force attack vector
   Recommendation: Implement express-rate-limit

### Medium Priority

4. **N+1 Query Pattern** [Performance]
   Location: src/services/order.service.js:78
   Issue: Fetches user per order in loop
   Recommendation: Use Prisma include

## Recommendations

### Security Hardening
1. Migrate tokens to HttpOnly cookies
2. Add rate limiting middleware
3. Implement parameterized queries

### Performance Improvements
1. Refactor N+1 patterns
2. Increase connection pool
3. Add query result caching

## Appendix: File Citations

| File | Lines | Issues |
|------|-------|--------|
| src/services/user.service.js | 45, 89 | SQL injection |
| src/auth/token.js | 12-34 | Token storage |
| src/routes/auth.js | 1-50 | Rate limiting |
```

## Configuration

### .claude/agents/research-*.md (per-agent, v5.2+)

Per-agent metadata (model, tools, color, description) lives in the
subagent frontmatter — not in any separate JSON. To inspect or edit
a specialist, open `.claude/agents/research-<name>.md` directly or
use Claude Code's `/agents` UI.

### orchestration-config.json (cohort + convergence)

```json
{
  "strategy_templates": {
    "narrow_research": { "initial_agents": ["ExploreAgent","CitationAgent"], "max_iterations": 2 },
    "broad_research": { "initial_agents": ["ExploreAgent","CitationAgent","PatternAgent"], "max_iterations": 3 },
    "comprehensive_research": { "initial_agents": [...], "max_iterations": 4 }
  },
  "agent_cohort_rules": {
    "always_include": ["ExploreAgent","CitationAgent"],
    "conditional_agents": { ... }
  },
  "convergence_settings": {
    "criteria": { "min_coverage": { "threshold": 0.70 }, "min_confidence": { "threshold": 0.80 } }
  }
}
```

### iteration-rules.json

```json
{
  "gap_detection": {
    "enabled": true,
    "min_coverage": 0.80
  },
  "convergence": {
    "method": "confidence_threshold",
    "threshold": 0.85,
    "max_iterations": 4
  },
  "early_termination": {
    "enabled": true,
    "conditions": ["no_new_findings", "critical_found"]
  }
}
```

## External Memory

Research results persist across sessions:

### Knowledge Graph

```
.claude/memory/knowledge-graph.md

Nodes:
- Entities: Files, functions, components
- Relationships: Depends on, calls, extends

Edges:
- user.service.js → prisma.client
- auth.middleware → token.utils
```

### Research History

```
.claude/memory/research-history.md

## 2026-01-09 - Authentication Audit

Agents: Security, Performance, Pattern
Iterations: 3
Key Findings:
- JWT storage vulnerability
- Missing rate limiting
- 2 N+1 patterns

Resolution Status:
- JWT storage: Fixed (PR #45)
- Rate limiting: Pending
- N+1 patterns: In progress
```

## Best Practices

### Choose Appropriate Research Scope

| Scope | Agents | Time | Use When |
|-------|--------|------|----------|
| Minimal | 2 | ~60s | Quick security check |
| Standard | 3 | ~120s | Feature implementation |
| Comprehensive | 5 | ~180s | Major refactoring |

### Review Intermediate Results

Don't wait for final report. Each iteration's results are available and often actionable.

### Act on Critical Findings

If a critical security issue is found, consider stopping research to address it immediately.

### Use Citations

The `file:line` citations make findings actionable. Navigate directly to issues.

## Triggering Research Mode

### Via /prompt-research

```bash
/prompt-research Analyze authentication system for security vulnerabilities
```

### Via Complexity Score

Prompts scoring 20+ automatically trigger research mode:

```
Complexity Score: 23

Triggers:
- "security audit" (+7)
- "across all files" (+5)
- "authentication" (+4)
- "comprehensive" (+7)

→ Activating multi-agent research
```

### Manual Override

Force research mode with flag:

```bash
/prompt-hybrid --research Analyze error handling patterns
```

## Related

- [Caching](/architecture/caching) - Result persistence
- [/prompt-research](/commands/prompt-research) - Command reference

