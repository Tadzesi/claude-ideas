# /prompt-research

**Deep Multi-Agent Research Command** (New in v3.0)

Comprehensive codebase research using orchestrated agents with iterative refinement for deep understanding, security audits, and performance analysis.

## Overview

The `/prompt-research` command provides **enterprise-grade multi-agent research** capabilities aligned with Anthropic's research architecture. Unlike `/prompt-hybrid` (single-pass, fast), this command uses **2-4 iteration cycles** with **2-5 specialized agents** working in parallel to achieve comprehensive understanding.

**Duration:** 60-180 seconds (depending on strategy)
**Complexity:** Expert level
**Best for:** Security audits, performance analysis, architecture understanding

## When to Use

### ✅ Use `/prompt-research` for:

- **Security audits** - OWASP Top 10 compliance, vulnerability detection
- **Performance investigations** - Bottleneck detection, N+1 queries, optimization
- **Architecture analysis** - System structure, component relationships, design patterns
- **Pattern discovery** - Naming conventions, code organization, consistency
- **Comprehensive understanding** - When you need multiple perspectives and deep insights
- **Critical decisions** - When accuracy and completeness matter more than speed

### ⚡ Use `/prompt-hybrid` instead for:

- Quick tasks (single-file changes, simple questions)
- Fast iterations (need answers in 2-30 seconds)
- Single perspective (one agent is sufficient)
- Known patterns (following established codebase patterns)

## Key Features

### 🤖 Multi-Agent Orchestration

Coordinates **2-5 specialized agents** working in parallel:

- **ExploreAgent** - Codebase discovery and architecture mapping
- **CitationAgent** - Source attribution with file:line precision
- **SecurityAgent** - OWASP Top 10 compliance checks (conditional)
- **PerformanceAgent** - Bottleneck detection and optimization (conditional)
- **PatternAgent** - Convention and consistency analysis (conditional)

### 🔄 Iterative Refinement

- **2-4 iteration cycles** with intelligent gap detection
- Each iteration refines understanding based on previous findings
- **Smart convergence** - Automatically stops when research is complete (>70% coverage, >0.80 confidence)
- Gap-driven analysis - Focuses on unresolved questions and missing context

### 📍 Source Attribution

- Every finding includes **file:line citations** with code snippets
- Multiple evidence sources per finding
- Confidence scoring (0.0-1.0) for each citation
- Traceability from findings back to source code

### 🧠 External Memory

Builds a **persistent knowledge graph** across sessions:

- `project-knowledge.md` - Facts, patterns, findings
- `architectural-context.md` - System understanding and design rationale
- `citation-index.md` - Evidence mapping with file locations

### 📊 Comprehensive Reporting

Generates **15-20 page research reports** with:

- Executive summary with key takeaways
- Findings organized by priority (Critical/Important/Informational)
- Architectural insights and component maps
- Security analysis (OWASP Top 10)
- Performance analysis (bottlenecks, opportunities)
- Patterns & conventions (consistency scores)
- Prioritized recommendations with citations
- Full citation index with code snippets

## Usage

### Basic Usage

```bash
/prompt-research Analyze the authentication system
```

### With Specific Focus

```bash
/prompt-research Perform security audit of payment processing
```

### With Questions

```bash
/prompt-research How does caching work? Are there N+1 query problems?
```

## Interactive Flow

When you run `/prompt-research`, you'll be asked:

### 1. Research Scope

```
What aspects should I research?

1. Architecture & Design (Recommended)
2. Security & Compliance
3. Performance & Scalability
4. Code Quality & Patterns
5. All of the Above (Comprehensive)
```

### 2. Research Depth

```
How deep should the analysis be?

1. Quick Overview (Narrow - 60s)
2. Standard Analysis (Broad - 120s) ⭐ Recommended
3. Comprehensive Audit (Comprehensive - 180s)
```

### 3. Specific Questions

```
What specific questions do you need answered?

Examples:
- "How does authentication work?"
- "Are there SQL injection vulnerabilities?"
- "What causes slow performance?"
```

## Research Strategies

### Narrow (60s, 1-2 iterations)

- **Agents:** 2 (ExploreAgent + CitationAgent)
- **Iterations:** 1-2
- **Best for:** Focused questions, quick overview
- **Coverage target:** 50%

### Broad (120s, 2-3 iterations) ⭐ Recommended

- **Agents:** 3-4 (Explore + Citation + 1-2 specialized)
- **Iterations:** 2-3
- **Best for:** Most research tasks, balanced depth
- **Coverage target:** 70%

### Comprehensive (180s, 3-4 iterations)

- **Agents:** 5 (all agents)
- **Iterations:** 3-4
- **Best for:** Critical audits, complete understanding
- **Coverage target:** 85%

## Report Structure

The research report includes:

### Executive Summary
- Key takeaways (3-5 bullets)
- High-level findings and recommendations

### Research Metadata
- Agents deployed, iterations completed
- Duration, files analyzed
- Coverage and confidence metrics

### Findings by Priority

**🚨 Critical Findings** (P0 - immediate action required)
- Security vulnerabilities, critical bugs
- File:line citations with code snippets

**⚠️ Important Findings** (P1 - address soon)
- Security concerns, performance issues
- Maintainability problems

**💡 Informational Findings** (P2 - nice to know)
- Architecture documentation
- Pattern analysis, conventions

### Analysis Sections

- **Architectural Insights** - Component relationships, data flow
- **Security Analysis** - OWASP Top 10 compliance
- **Performance Analysis** - Bottlenecks, optimization opportunities
- **Patterns & Conventions** - Naming, organization, consistency

### Recommendations

Prioritized recommendations with:
- Rationale (why this matters)
- Impact (what changes)
- Effort estimate
- File:line citations

### Citations & References

Complete index of all sources with:
- File paths and line numbers
- Code snippets with context
- Confidence scores

## Examples

### Example 1: Security Audit

```bash
/prompt-research Perform comprehensive security audit
```

**Interactive selections:**
- Scope: Security & Compliance
- Depth: Comprehensive
- Questions: "Are there any vulnerabilities? Is auth secure?"

**Output:**
- 15-page report with OWASP Top 10 analysis
- 2 critical findings (SQL injection risk, weak password policy)
- 5 important findings (rate limiting, session management)
- 8 security best practices validated
- Full remediation recommendations

**Duration:** ~165 seconds

---

### Example 2: Performance Investigation

```bash
/prompt-research Why is the dashboard slow?
```

**Interactive selections:**
- Scope: Performance & Scalability
- Depth: Standard
- Questions: "What's causing slowness? Any N+1 queries?"

**Output:**
- 12-page report with bottleneck analysis
- 1 critical finding (N+1 query in user list)
- 3 optimization opportunities
- Performance metrics and baselines
- Caching recommendations

**Duration:** ~95 seconds

---

### Example 3: Architecture Understanding

```bash
/prompt-research Help me understand the authentication system
```

**Interactive selections:**
- Scope: Architecture & Design
- Depth: Standard
- Questions: "How does login work? What's the token flow?"

**Output:**
- 18-page report with component diagrams
- Authentication flow documentation
- Token lifecycle explanation
- Security model overview
- 6 architectural patterns identified

**Duration:** ~110 seconds

## Performance

### First Run (No Cache)
- **Narrow:** ~60s (2 agents, 1-2 iterations)
- **Broad:** ~120s (4 agents, 2-3 iterations)
- **Comprehensive:** ~180s (5 agents, 3-4 iterations)

### Cached Run (Same Research)
- **All strategies:** ~10s (10-20x faster)
- Cache valid for 24 hours or until files change

### Memory Benefits
- **Second research on same topic:** Faster (skips known areas)
- **Related research:** Builds on existing knowledge
- **After multiple sessions:** Significantly faster (comprehensive knowledge)

## Comparison with Other Commands

| Feature | /prompt-research | /prompt-hybrid | /prompt-technical |
|---------|------------------|----------------|-------------------|
| Duration | 60-180s | 2-30s | 20-60s |
| Agents | 2-5 specialized | 0-1 general | 0-1 general |
| Iterations | 2-4 cycles | Single-pass | Single-pass |
| Depth | Comprehensive | Balanced | Technical |
| Citations | Always (file:line) | Optional | Optional |
| Memory | Persistent graph | Learning only | Learning only |
| Report | 15-20 pages | Structured prompt | Implementation plan |
| Use Case | Research & audit | General tasks | Implementation |

## Best Practices

### 1. Be Specific

❌ Bad: "Analyze the code"
✅ Good: "Analyze authentication system for security vulnerabilities"

### 2. Use for Complex Tasks

❌ Bad: "Fix typo in line 42" (use `/prompt` instead)
✅ Good: "Perform comprehensive security audit"

### 3. Provide Context in Questions

❌ Bad: "Is it fast?"
✅ Good: "Are there performance bottlenecks in the API layer?"

### 4. Leverage Multiple Sessions

- **First session:** Broad understanding
- **Second session:** Deep dive into specific area
- **Memory builds understanding over time**

### 5. Review Knowledge Graph

Check `.claude/memory/project-knowledge.md` periodically to:
- See what the system knows
- Avoid redundant research
- Build on existing insights

## Configuration

Research behavior is controlled by:

- `.claude/config/orchestration-config.json` - Strategies, iterations
- `.claude/config/agent-roles.json` - Agent definitions, triggers
- `.claude/config/iteration-rules.json` - Convergence criteria
- `.claude/config/citation-config.json` - Citation formatting
- `.claude/config/external-memory-config.json` - Memory persistence

See [Configuration Reference](/reference/configuration) for customization options.

## Troubleshooting

### Research Takes Too Long

**Issue:** Research exceeds expected duration
**Cause:** Comprehensive strategy on large codebase
**Solution:** Use Narrow or Broad strategy instead

### Low Coverage (< 70%)

**Issue:** Convergence not met, research incomplete
**Cause:** Scope too broad, too many files
**Solution:** Narrow scope to specific components

### Too Many Findings

**Issue:** Report has 50+ findings (overwhelming)
**Cause:** Comprehensive strategy on complex codebase
**Solution:** Focus on Critical/Important findings first

### Cache Not Working

**Issue:** Research not using cached results
**Cause:** Files changed or branch switched
**Solution:** Expected behavior - cache invalidates on changes

## Next Steps

- [Learn about hybrid intelligence](/guide/architecture/hybrid-architecture)
- [Configure research strategies](/reference/configuration)
- [Explore specialized agents](/guide/advanced-features/multi-agent)
- [Try /prompt-research on your codebase](#usage)
