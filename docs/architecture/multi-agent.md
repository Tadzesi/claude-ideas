# Multi-Agent Research

Deep analysis through coordinated specialized agents working in parallel with iterative refinement.

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

```
┌─────────────────────────────────────────────────────────────┐
│                    Multi-Agent Research                      │
│                                                              │
│  ┌─────────────────────────────────────────────────────┐    │
│  │              Lead Agent (Orchestrator)               │    │
│  │    Manages workflow, synthesizes results             │    │
│  └───────────────────────┬─────────────────────────────┘    │
│                          │                                   │
│         ┌────────────────┼────────────────┐                 │
│         ▼                ▼                ▼                 │
│    ┌─────────┐     ┌─────────┐     ┌─────────┐             │
│    │ Agent 1 │     │ Agent 2 │     │ Agent 3 │             │
│    │ Explore │     │ Pattern │     │Security │             │
│    └────┬────┘     └────┬────┘     └────┬────┘             │
│         │               │               │                   │
│         └───────────────┼───────────────┘                   │
│                         ▼                                    │
│    ┌─────────────────────────────────────────────────────┐  │
│    │              Result Aggregation                      │  │
│    │    Combines findings, resolves conflicts             │  │
│    └─────────────────────────────────────────────────────┘  │
│                         │                                    │
│                         ▼                                    │
│    ┌─────────────────────────────────────────────────────┐  │
│    │              Gap Analysis                            │  │
│    │    Identifies missing coverage                       │  │
│    └─────────────────────────────────────────────────────┘  │
│                         │                                    │
│              ┌──────────┴──────────┐                        │
│              ▼                     ▼                        │
│         Gaps Found?           Complete                      │
│              │                     │                        │
│              ▼                     ▼                        │
│         Next Iteration       Final Report                   │
└─────────────────────────────────────────────────────────────┘
```

## Agent Types

### Explore Agent

| Property | Value |
|----------|-------|
| **Model** | Haiku |
| **Time** | ~30s |
| **Focus** | Codebase structure and patterns |

Discovers:
- Project structure
- File relationships
- Framework detection
- Naming conventions

### Citation Agent

| Property | Value |
|----------|-------|
| **Model** | Sonnet |
| **Time** | ~45s |
| **Focus** | Precise source references |

Provides:
- `file:line` citations
- Code snippet extraction
- Cross-reference mapping
- Evidence documentation

### Security Agent

| Property | Value |
|----------|-------|
| **Model** | Sonnet |
| **Time** | ~45s |
| **Focus** | Vulnerability detection |

Analyzes:
- OWASP Top 10
- Input validation
- Authentication flows
- Authorization checks
- Data exposure risks

### Performance Agent

| Property | Value |
|----------|-------|
| **Model** | Sonnet |
| **Time** | ~45s |
| **Focus** | Bottleneck identification |

Detects:
- N+1 query patterns
- Memory leaks
- Inefficient algorithms
- Missing caching
- Blocking operations

### Pattern Agent

| Property | Value |
|----------|-------|
| **Model** | Haiku |
| **Time** | ~30s |
| **Focus** | Convention consistency |

Validates:
- Code style adherence
- Architectural patterns
- Naming conventions
- Best practice compliance

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

### orchestration-config.json

```json
{
  "research_mode": {
    "default_strategy": "parallel",
    "max_agents": 5,
    "max_iterations": 4,
    "convergence_threshold": 0.85
  },
  "lead_agent": {
    "model": "sonnet",
    "synthesis_style": "comprehensive"
  },
  "agent_selection": {
    "auto_detect": true,
    "minimum_agents": 2
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

- [Hybrid Intelligence](/architecture/hybrid-intelligence) - Agent spawning
- [Caching](/architecture/caching) - Result persistence
- [/prompt-research](/commands/prompt-research) - Command reference

