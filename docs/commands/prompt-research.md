# /prompt-research

Deep multi-agent research for comprehensive codebase analysis.

## Overview

| Aspect | Details |
|--------|---------|
| **Speed** | 60-180 seconds |
| **Complexity** | Expert |
| **Agents** | 2-5 specialized agents in parallel |
| **Best For** | Security audits, architecture review, performance analysis |

## Usage

```bash
/prompt-research [research question]
```

## Examples

### Security Audit

```bash
/prompt-research Perform security audit of the payment processing system
```

**Output:**
```
Research Mode Activated

Complexity Score: 35 (Research - Broad)
Spawning 4 agents:
- Security Agent: OWASP vulnerability scan
- Explore Agent: Payment flow analysis
- Pattern Agent: Auth pattern consistency
- Citation Agent: Source attribution

Iteration 1/3...

Security Agent Findings:
- SQL injection risk in PaymentService.processCard() line 142
- Missing input sanitization in amount parameter
- Credit card data logged in debug mode

Explore Agent Findings:
- Payment flow: Cart → Checkout → PaymentService → Stripe API
- No rate limiting on payment endpoints
- Transaction logs stored in plaintext

Pattern Agent Findings:
- Auth middleware inconsistent: /api/payment uses old pattern
- CORS too permissive for payment endpoints

Gap Analysis: Missing encryption-at-rest review

Iteration 2/3...

[Additional findings with file:line citations]

Final Report:

CRITICAL (Fix Immediately):
1. SQL injection in PaymentService.ts:142
   - Code: `WHERE order_id = ${orderId}`
   - Fix: Use parameterized query

2. Credit card logging in debug mode
   - File: logger.config.ts:28
   - Fix: Add PCI-DSS compliant filtering

HIGH (Fix Soon):
3. No rate limiting on payment endpoints
   - Affected: /api/payments/*
   - Risk: Financial fraud via automation

[Continues with MEDIUM, LOW findings...]

Sources:
- src/services/PaymentService.ts:142
- src/config/logger.config.ts:28
- src/routes/payments.ts:15-45
```

### Architecture Review

```bash
/prompt-research Analyze our microservices architecture for scalability issues
```

### Performance Analysis

```bash
/prompt-research Identify performance bottlenecks in the user dashboard
```

## How It Works

### Agent Orchestration

```
┌─────────────────────────────────────────────┐
│              Lead Agent (Orchestrator)       │
└─────────────────────────────────────────────┘
                    │
        ┌───────────┼───────────┐
        ▼           ▼           ▼
   ┌─────────┐ ┌─────────┐ ┌─────────┐
   │ Explore │ │Security │ │ Pattern │
   │  Agent  │ │  Agent  │ │  Agent  │
   └─────────┘ └─────────┘ └─────────┘
        │           │           │
        └───────────┼───────────┘
                    ▼
              Gap Analysis
                    │
              Next Iteration
```

### Research Levels

| Score | Level | Agents | Iterations |
|-------|-------|--------|------------|
| 20-29 | Narrow | 2 | 1-2 |
| 30-49 | Broad | 3-4 | 2-3 |
| 50+ | Comprehensive | 5 | 3-4 |

### Iteration Cycle

1. **Initial Analysis** - All agents scan in parallel
2. **Gap Detection** - What's missing?
3. **Focused Research** - Fill gaps
4. **Synthesis** - Combine findings
5. **Repeat** if gaps remain

### Agent Types

| Agent | Purpose | Model |
|-------|---------|-------|
| Explore | Codebase navigation, patterns | Haiku |
| Security | OWASP Top 10, vulnerabilities | Sonnet |
| Performance | Bottlenecks, N+1 queries | Sonnet |
| Pattern | Convention consistency | Haiku |
| Citation | Source attribution | Haiku |

## Output Format

### Structured Report

```markdown
# Research Report: [Topic]

## Executive Summary
[1-2 paragraph overview]

## Findings

### CRITICAL
[Immediate action required]

### HIGH
[Fix within this sprint]

### MEDIUM
[Planned backlog]

### LOW
[Nice to have]

## Recommendations
[Ordered by priority]

## Sources
[File:line citations]
```

### Citation Format

Every finding includes:

```
Finding: SQL injection vulnerability
File: src/services/PaymentService.ts
Line: 142
Code: WHERE order_id = ${orderId}
Context: User-controlled input passed directly to query
```

## When to Use

### Good For

- Security audits
- Architecture reviews
- Performance analysis
- Technical debt assessment
- Compliance checks
- Onboarding to large codebase

### Not Ideal For

- Simple questions → Use `/prompt`
- Single feature implementation → Use `/prompt-technical`
- Quick fixes → Use `/prompt`

## Tips

### Be Specific About Scope

```bash
# Too broad
/prompt-research Analyze everything

# Better
/prompt-research Analyze authentication system for security vulnerabilities
```

### Specify What You Care About

```bash
/prompt-research Analyze payment processing focusing on:
- PCI-DSS compliance
- SQL injection risks
- Rate limiting
```

### Allow Time

Research takes 1-3 minutes. This is intentional:
- Multiple agents working in parallel
- Iterative refinement
- Comprehensive coverage

## Configuration

In `.claude/config/orchestration-config.json`:

```json
{
  "research_levels": {
    "narrow": { "agents": 2, "iterations": 2 },
    "broad": { "agents": 4, "iterations": 3 },
    "comprehensive": { "agents": 5, "iterations": 4 }
  },
  "convergence": {
    "gap_threshold": 0.2,
    "max_iterations": 4
  }
}
```

## Related Commands

- [/prompt-technical](/commands/prompt-technical) - For implementation planning
- [/prompt-hybrid](/commands/prompt-hybrid) - For general complex tasks
