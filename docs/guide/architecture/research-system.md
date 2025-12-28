# Multi-Agent Research System (v3.0)

The v3.0 Multi-Agent Research System provides enterprise-grade codebase analysis using orchestrated agents with iterative refinement.

## Overview

Unlike single-pass analysis (`/prompt-hybrid`), the research system uses an **orchestrator-worker architecture** where a lead agent coordinates 2-5 specialized workers through multiple iteration cycles to achieve comprehensive understanding.

## Architecture Pattern

```
User Request
     ↓
Phase 0: Research Specification
     ↓
Lead Agent (Orchestrator)
     ↓
┌────────┴────────┐
↓                 ↓
Iteration 1    Iteration 2-4
(Initial)      (Refinement)
     ↓                 ↓
Worker Agents (Parallel):
- ExploreAgent (always)
- CitationAgent (always)
- SecurityAgent (conditional)
- PerformanceAgent (conditional)
- PatternAgent (conditional)
     ↓
Convergence Check
(Coverage >= 70%, Confidence >= 0.80)
     ↓
Result Aggregator
     ↓
Research Report + Memory Updates
```

## Core Components

### 1. Lead Agent (Orchestrator)

**Location:** `.claude/library/orchestration/lead-agent-core.md`

**Responsibilities:**
- Analyzes user's research request
- Develops research strategy (Narrow/Broad/Comprehensive)
- Spawns 2-5 specialized workers in parallel
- Monitors research progress across iterations
- Decides when to refine vs. when to converge
- Coordinates worker efforts

### 2. Specialized Worker Agents

#### ExploreAgent (Always Active)
**Location:** `.claude/library/agents/explore-agent.md`
- Codebase discovery and file mapping
- Architecture understanding
- Component relationship analysis
- **Model:** Haiku (fast, cost-effective)
- **Timeout:** 30 seconds

#### CitationAgent (Always Active)
**Location:** `.claude/library/agents/citation-agent.md`
- Source attribution with file:line precision
- Code snippet extraction with context
- Confidence scoring per citation
- Evidence tracking and validation
- **Model:** Haiku
- **Timeout:** 20 seconds

#### SecurityAgent (Conditional)
**Location:** `.claude/library/agents/security-agent.md`
- OWASP Top 10 compliance checks
- Vulnerability detection
- Authentication/authorization analysis
- Security pattern validation
- **Model:** Sonnet (deeper analysis)
- **Timeout:** 45 seconds
- **Triggers:** Security scope, auth keywords

#### PerformanceAgent (Conditional)
**Location:** `.claude/library/agents/performance-agent.md`
- Bottleneck detection
- N+1 query identification
- Caching analysis
- Performance optimization opportunities
- **Model:** Sonnet
- **Timeout:** 45 seconds
- **Triggers:** Performance scope, slow keywords

#### PatternAgent (Conditional)
**Location:** `.claude/library/agents/pattern-agent.md`
- Convention detection (naming, organization)
- Consistency analysis
- Pattern recognition across codebase
- **Model:** Haiku
- **Timeout:** 30 seconds
- **Triggers:** Pattern scope, consistency keywords

### 3. Iteration Engine

**Location:** `.claude/library/orchestration/iteration-engine.md`

**Responsibilities:**
- Executes multi-step refinement loop (max 4 iterations)
- Detects 8 types of gaps:
  - Coverage gaps (incomplete file analysis)
  - Confidence gaps (low-confidence findings)
  - Unresolved questions
  - Missing context
  - Conflicting findings
  - Insufficient citations
  - Incomplete patterns
  - Security/performance coverage
- Adaptive agent selection for gap-filling
- Convergence evaluation

**Convergence Criteria:**
- Coverage >= 70% (configurable)
- Confidence >= 0.80 (average across findings)
- Unresolved conflicts: 0
- All critical questions answered

### 4. Result Aggregator

**Location:** `.claude/library/orchestration/result-aggregator.md`

**Responsibilities:**
- Deduplication of findings across iterations
- Conflict resolution using 6 rules:
  1. Higher confidence wins
  2. More citations preferred
  3. Later iterations override earlier (refinement)
  4. Specific > General
  5. Security findings prioritized
  6. User manual resolution for ties
- Confidence scoring with bonuses:
  - Multiple agent agreement: +0.1
  - Multiple citations: +0.05 per citation
  - Later iterations: +0.05
- Priority classification (Critical/Important/Informational)

## External Memory System

### Persistent Knowledge Graph

Three interconnected files maintain long-term project understanding:

#### 1. project-knowledge.md
**Purpose:** Facts, patterns, and findings
```markdown
## Core Components
### Component: AuthService
- Location: src/services/AuthService.cs
- Responsibility: JWT generation, password validation
- Dependencies: IUserRepository, IConfiguration
- Patterns: Service layer, dependency injection
```

#### 2. architectural-context.md
**Purpose:** Understanding and design rationale
```markdown
## Security Architecture
### Authentication Flow
- Why JWT: Stateless authentication, scalability
- Why BCrypt: Industry standard, configurable rounds
- Design Decision: 24-hour expiration for UX
- Trade-off: Security vs. convenience
```

#### 3. citation-index.md
**Purpose:** Evidence mapping with file locations
```markdown
**Finding ID:** RS001-SEC-001
**Description:** JWT authentication with BCrypt
**Confidence:** 0.95
**Citations:**
- [1] src/services/AuthService.cs:15-30 (JWT generation)
- [2] src/services/AuthService.cs:80-85 (BCrypt hashing)
```

### Memory Update Strategy
- Append new knowledge after each research session
- Merge non-conflicting information automatically
- Flag conflicts for manual resolution
- Auto-summarize when files exceed 10 MB

## Research Strategies

### Narrow (60s, 1-2 iterations)
- **Agents:** 2 (ExploreAgent + CitationAgent)
- **Coverage Target:** 50%
- **Best For:** Focused questions, quick overview
- **Example:** "How does login work?"

### Broad (120s, 2-3 iterations)
- **Agents:** 3-4 (Explore + Citation + 1-2 specialized)
- **Coverage Target:** 70%
- **Best For:** Most research tasks, balanced depth
- **Example:** "Analyze authentication system"
- **Recommended for general use**

### Comprehensive (180s, 3-4 iterations)
- **Agents:** 5 (all agents)
- **Coverage Target:** 85%
- **Best For:** Critical audits, complete understanding
- **Example:** "Comprehensive security audit"

## Configuration Files

### orchestration-config.json
Defines research strategies and coordination:
```json
{
  "strategy_templates": {
    "narrow_research": {
      "initial_agents": 2,
      "max_iterations": 2,
      "estimated_duration_seconds": 60
    },
    "broad_research": {
      "initial_agents": 4,
      "max_iterations": 3,
      "estimated_duration_seconds": 120
    }
  }
}
```

### agent-roles.json
Agent definitions and triggers:
```json
{
  "agents": {
    "SecurityAgent": {
      "model": "sonnet",
      "timeout": 45,
      "triggers": ["security", "auth", "owasp"]
    }
  }
}
```

### iteration-rules.json
Convergence criteria and gap detection:
```json
{
  "convergence": {
    "min_coverage": 0.70,
    "min_confidence": 0.80,
    "max_iterations": 4
  }
}
```

### citation-config.json
Citation formatting and snippet extraction

### external-memory-config.json
Memory persistence and cleanup rules

## Research Report Structure

Generated reports include:

1. **Executive Summary** - Key takeaways (3-5 bullets)
2. **Research Metadata** - Agents, iterations, duration, files analyzed
3. **Critical Findings** 🚨 (P0 - immediate action)
4. **Important Findings** ⚠️ (P1 - address soon)
5. **Informational Findings** 💡 (P2 - nice to know)
6. **Architectural Insights** - Component maps, relationships
7. **Security Analysis** - OWASP Top 10 compliance
8. **Performance Analysis** - Bottlenecks, opportunities
9. **Patterns & Conventions** - Consistency scores
10. **Recommendations** - Prioritized with citations
11. **Knowledge Graph Updates** - Memory changes
12. **Gaps & Future Research** - Unresolved areas
13. **Citations & References** - file:line with code
14. **Research Statistics** - Metrics and coverage
15. **Next Steps** - Actionable items

## Performance Characteristics

### First Run (No Cache)
- **Narrow:** ~60s
- **Broad:** ~120s
- **Comprehensive:** ~180s

### Cached Run (Same Research)
- **All strategies:** ~10s (10-20x faster)
- Cache valid for 24 hours or until files change

### Memory Benefits
- **Second research on same topic:** Faster (skips known areas)
- **Related research:** Builds on existing knowledge
- **After multiple sessions:** Significantly faster

## Use Cases

### Security Audits
- OWASP Top 10 compliance
- Vulnerability detection
- Authentication/authorization review
- **Example Duration:** 120-165s

### Performance Investigations
- Bottleneck identification
- N+1 query detection
- Caching analysis
- **Example Duration:** 95-140s

### Architecture Analysis
- System structure understanding
- Component relationships
- Design pattern recognition
- **Example Duration:** 110-150s

### Pattern Discovery
- Naming conventions
- Code organization
- Consistency checks
- **Example Duration:** 60-90s

## Comparison with v2.0 Hybrid System

| Feature | v3.0 Research | v2.0 Hybrid |
|---------|---------------|-------------|
| **Architecture** | Orchestrator-worker | Single agent or none |
| **Iterations** | 2-4 cycles | Single-pass |
| **Agents** | 2-5 specialized | 0-1 general |
| **Duration** | 60-180s | 2-30s |
| **Depth** | Comprehensive | Balanced |
| **Citations** | Always (file:line) | Optional |
| **Memory** | Persistent graph | Learning only |
| **Convergence** | Intelligent (auto-stop) | N/A |
| **Report** | 15-20 pages | Structured prompt |
| **Use Case** | Research & audit | Task execution |

## When to Use Research vs. Hybrid

**Use v3.0 Research (`/prompt-research`) when:**
- Security audits needed
- Performance deep-dives required
- Architecture understanding critical
- Multiple perspectives valuable
- Accuracy > Speed

**Use v2.0 Hybrid (`/prompt-hybrid`) when:**
- Fast task completion needed
- Single perspective sufficient
- Simple to moderate complexity
- Speed > Depth

## Next Steps

- [Try /prompt-research](/guide/commands/prompt-research)
- [Configure research strategies](/reference/configuration)
- [Learn about specialized agents](/guide/advanced-features/multi-agent)
