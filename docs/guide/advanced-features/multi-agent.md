# Multi-Agent Systems

The library provides two multi-agent capabilities: **v2.0 Verification** (2-3 agents, single-pass) and **v3.0 Research System** (2-5 agents, iterative).

## v2.0 Multi-Agent Verification

Cross-validate critical operations with 2-3 agents running in parallel.

### When It Triggers

Automatic triggers:
- Complexity score >= 15
- Critical keywords detected: `payment`, `security`, `auth`, `migration`
- Financial or security-sensitive operations

Manual trigger:
- User includes `--verify` flag in prompt

### How It Works

1. **Parallel Execution** - Spawns 2-3 agents simultaneously
2. **Different Strategies** - Each agent uses a different approach:
   - Agent 1: Comprehensive analysis
   - Agent 2: Security-focused
   - Agent 3: Performance-focused
3. **Consensus Analysis** - Compares findings across agents:
   - **Agreement** - High confidence, proceed
   - **Partial Agreement** - Medium confidence, highlight differences
   - **Disagreement** - Present options to user for decision
4. **User Choice** - If agents disagree, user selects preferred approach

### Example Output

```
Multi-Agent Verification Results (3 agents):

Agent 1 (Comprehensive):
- Recommends: JWT with refresh tokens
- Confidence: 0.85
- Reasoning: Industry standard, scalable

Agent 2 (Security-focused):
- Recommends: JWT with short expiration + refresh
- Confidence: 0.90
- Reasoning: Better security, limits exposure

Agent 3 (Performance-focused):
- Recommends: Session-based with Redis
- Confidence: 0.80
- Reasoning: Faster validation, no crypto overhead

Consensus: Partial agreement on JWT
Recommendation: Agent 2's approach (security-optimized JWT)

Do you want to proceed with Agent 2's approach? (y/n)
```

### Configuration

`.claude/config/verification-config.json`:
```json
{
  "triggers": {
    "complexity_threshold": 15,
    "keywords": ["payment", "security", "auth", "migration"]
  },
  "agents": {
    "count": 3,
    "strategies": ["comprehensive", "security", "performance"]
  }
}
```

### Performance

- **Duration:** ~50 seconds (3 agents in parallel)
- **Cost:** 3x single agent (Sonnet model for critical tasks)
- **When to Use:** Critical operations where accuracy > speed

---

## v3.0 Multi-Agent Research System 🔬

Enterprise-grade codebase research with 2-5 specialized agents and iterative refinement.

### Overview

The v3.0 research system uses an **orchestrator-worker architecture** where a lead agent coordinates specialized workers through 2-4 iteration cycles to achieve comprehensive understanding.

**Key Command:** `/prompt-research`

### Architecture

```
Lead Agent (Orchestrator)
     ↓
Iteration 1 → Iteration 2 → ... → Convergence
     ↓              ↓                   ↓
Worker Agents (Parallel)         Result Aggregation
- ExploreAgent                         ↓
- CitationAgent               Research Report (15-20 pages)
- SecurityAgent (conditional)          ↓
- PerformanceAgent (conditional)  Memory Updates
- PatternAgent (conditional)
```

### Specialized Research Agents

#### Always Active

1. **ExploreAgent**
   - Codebase discovery and file mapping
   - Architecture understanding
   - Component relationships
   - **Model:** Haiku (fast, cost-effective)

2. **CitationAgent**
   - Source attribution (file:line)
   - Code snippet extraction
   - Evidence tracking
   - **Model:** Haiku

#### Conditionally Active

3. **SecurityAgent**
   - OWASP Top 10 compliance
   - Vulnerability detection
   - Auth/authz analysis
   - **Model:** Sonnet (deeper analysis)
   - **Triggers:** Security scope, auth keywords

4. **PerformanceAgent**
   - Bottleneck detection
   - N+1 query identification
   - Caching analysis
   - **Model:** Sonnet
   - **Triggers:** Performance scope, slow keywords

5. **PatternAgent**
   - Convention detection
   - Consistency analysis
   - Pattern recognition
   - **Model:** Haiku
   - **Triggers:** Pattern scope

### Iterative Refinement

Unlike v2.0 verification (single-pass), v3.0 research uses **2-4 iteration cycles**:

**Iteration 1 (Initial):**
- Broad exploration
- Initial findings
- Coverage: ~55%

**Iteration 2 (Refinement):**
- Fill gaps from Iteration 1
- Deeper analysis on unclear areas
- Coverage: ~75%

**Iteration 3-4 (Optional):**
- Continue if convergence not met
- Resolve conflicts
- Validate findings
- Coverage: ~85%

**Convergence Criteria:**
- Coverage >= 70%
- Confidence >= 0.80
- Unresolved conflicts: 0

### Research Strategies

| Strategy | Duration | Agents | Iterations | Use Case |
|----------|----------|--------|------------|----------|
| Narrow | 60s | 2 | 1-2 | Quick overview |
| Broad | 120s | 3-4 | 2-3 | Standard research ⭐ |
| Comprehensive | 180s | 5 | 3-4 | Critical audits |

### External Memory System

Research builds a **persistent knowledge graph**:

- **project-knowledge.md** - Facts, patterns, findings
- **architectural-context.md** - Understanding, rationale
- **citation-index.md** - Evidence with file:line refs

This memory improves over time, making subsequent research faster.

### Example Research Report

```markdown
# Research Report: Authentication System

## Executive Summary
- Secure JWT implementation (BCrypt + HMAC-SHA256)
- 2 areas need attention: token expiration, rate limiting
- Overall security score: 8.5/10

## Critical Findings
(None - good news!)

## Important Findings
Finding 1: Token expiration hardcoded ⚠️
- File: src/services/AuthService.cs:26
- Recommendation: Move to configuration
- Priority: P1

Finding 2: Missing rate limiting ⚠️
- File: src/controllers/AuthController.cs:42
- Recommendation: Add AspNetCoreRateLimit
- Priority: P1

## Informational Findings
[15 architecture and pattern findings...]

## Recommendations
1. Configure token expiration (P1, 1 hour effort)
2. Implement rate limiting (P1, 4 hours effort)

## Citations
[13 file:line references with code snippets...]
```

### Performance

**First Run:**
- Narrow: ~60s
- Broad: ~120s
- Comprehensive: ~180s

**Cached Run:** ~10s (10-20x faster)

### Configuration

`.claude/config/orchestration-config.json` - Research strategies
`.claude/config/agent-roles.json` - Agent definitions
`.claude/config/iteration-rules.json` - Convergence criteria

---

## Comparison: Verification vs. Research

| Feature | v2.0 Verification | v3.0 Research |
|---------|-------------------|---------------|
| **Purpose** | Task validation | Codebase understanding |
| **Agents** | 2-3 general | 2-5 specialized |
| **Iterations** | 1 (single-pass) | 2-4 (iterative) |
| **Duration** | ~50s | 60-180s |
| **Output** | Consensus + options | 15-20 page report |
| **Memory** | None | Persistent graph |
| **Citations** | Basic | file:line + snippets |
| **Use Case** | Critical decisions | Research & audits |

## When to Use Which

**Use v2.0 Verification when:**
- Validating a specific implementation approach
- Need consensus on critical decisions
- Quick validation needed (~50s)
- Task-focused, not research

**Use v3.0 Research when:**
- Security audit required
- Performance investigation needed
- Architecture understanding critical
- Deep comprehensive analysis needed
- Building long-term project knowledge

---

## Learn More

- [v3.0 Research System Architecture](/guide/architecture/research-system)
- [/prompt-research Command](/guide/commands/prompt-research)
- [Configuration Reference](/reference/configuration)

