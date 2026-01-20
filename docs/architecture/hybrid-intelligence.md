# Hybrid Intelligence

Automatic complexity detection that determines when to use specialized agents.

## The Concept

Not every task needs deep analysis. Hybrid Intelligence scores your prompt and chooses the appropriate path:

| Score | Path | Time | Agent |
|-------|------|------|-------|
| 0-4 | Simple | ~2s | None |
| 5-9 | Moderate | ~5s + optional | User choice |
| 10-19 | Complex | ~20s | Automatic |
| 20+ | Research | ~60s+ | Multi-agent |

## How It Works

### Step 1: Trigger Detection

Your prompt is analyzed for complexity triggers:

```
Input: "Add authentication following existing patterns"

Triggers matched:
- "authentication" → Cross-cutting concern (+4)
- "existing patterns" → Pattern detection (+6)

Total Score: 10 (Complex)
```

### Step 2: Path Selection

Based on score:

```
Score: 10 → Complex path
Action: Spawn Explore Agent automatically
```

### Step 3: Agent Execution

The appropriate agent analyzes your codebase:

```
Explore Agent running...

Findings:
- Framework: Express.js 4.18
- Existing auth: JWT pattern in payment-service.js
- User model: Has password field already
- Middleware folder: Empty, ready for auth.js
```

### Step 4: Enhanced Response

Agent findings inform the response:

```
Based on codebase analysis:
- I'll follow the JWT pattern from payment-service.js
- Using existing User model with password field
- Creating auth middleware in middleware/auth.js
```

## Complexity Triggers

### Defined in `complexity-rules.json`

| Trigger | Weight | Detection Keywords |
|---------|--------|-------------------|
| Multi-file scope | +5 | "all", "every", "across", "throughout" |
| Architecture questions | +7 | "how should", "best approach", "architecture" |
| Pattern detection | +6 | "like", "similar to", "existing pattern" |
| Feasibility checks | +4 | "possible", "can we", "is it feasible" |
| Refactoring tasks | +5 | "refactor", "restructure", "reorganize" |
| Cross-cutting concerns | +4 | "logging", "auth", "validation", "caching" |
| Implementation planning | +3 | "implement", "add feature", "build" |

### Risk Multipliers

User factors can increase scores:

| Factor | Multiplier |
|--------|------------|
| Security-critical | 1.5x |
| High-impact | 1.3x |
| Multi-team | 1.2x |
| External dependency | 1.1x |

## Agent Types

### Explore Agent

| Aspect | Details |
|--------|---------|
| **Model** | Haiku |
| **Time** | ~30 seconds |
| **Purpose** | Codebase exploration, pattern detection |

Capabilities:
- Scan project structure
- Find related implementations
- Detect naming conventions
- Identify frameworks and tools

### Plan Agent

| Aspect | Details |
|--------|---------|
| **Model** | Sonnet |
| **Time** | ~60 seconds |
| **Purpose** | Implementation planning |

Capabilities:
- Design implementation strategies
- Consider trade-offs
- Plan step-by-step approach
- Identify dependencies

### Security Agent

| Aspect | Details |
|--------|---------|
| **Model** | Sonnet |
| **Time** | ~45 seconds |
| **Purpose** | Vulnerability detection |

Capabilities:
- OWASP Top 10 analysis
- Input validation review
- Authentication checks
- Authorization analysis

### Performance Agent

| Aspect | Details |
|--------|---------|
| **Model** | Sonnet |
| **Time** | ~45 seconds |
| **Purpose** | Bottleneck detection |

Capabilities:
- N+1 query detection
- Memory usage analysis
- Algorithm complexity review
- Caching opportunities

### Pattern Agent

| Aspect | Details |
|--------|---------|
| **Model** | Haiku |
| **Time** | ~30 seconds |
| **Purpose** | Convention consistency |

Capabilities:
- Naming convention analysis
- Code style consistency
- Architectural pattern detection
- Best practice verification

## Caching

Agent results are cached for 10-20x speedup:

### Cache Key Components

```
hash(
  prompt_text +
  relevant_file_hashes +
  git_branch +
  agent_template
)
```

### Cache Settings

| Setting | Value |
|---------|-------|
| TTL | 24 hours |
| Max size | 50 MB |
| Storage | `.claude/cache/agent-results/` |
| Strategy | Content hash |

### Cache Invalidation

Automatically invalidates when:
- Referenced files change
- Git branch switches
- Manual cache clear

## Multi-Agent Verification

For high complexity (15+) or critical operations:

```
Complexity: 18 (Very High)
Triggering multi-agent verification...

Agent 1 (Explore): Breadth-first analysis
Agent 2 (Pattern): Convention checking
Agent 3 (Security): Vulnerability scan

Consensus Analysis:
- All agree: Use repository pattern
- Disagreement: Error handling approach
  - Explore: Custom error classes
  - Security: Built-in error types
  Recommendation: Custom classes for better audit trail
```

## Configuration

### complexity-rules.json

```json
{
  "rules": [
    {
      "name": "multi_file_scope",
      "weight": 5,
      "triggers": ["all", "every", "across"],
      "description": "Task spans multiple files"
    }
  ],
  "thresholds": {
    "simple": { "max": 4 },
    "moderate": { "min": 5, "max": 9 },
    "complex": { "min": 10, "max": 19 },
    "research": { "min": 20 }
  },
  "user_factors": {
    "security_critical": 1.5,
    "high_impact": 1.3
  }
}
```

### agent-templates.json

```json
{
  "templates": {
    "explore_codebase_context": {
      "type": "Explore",
      "model": "haiku",
      "prompt": "Analyze the codebase for..."
    }
  },
  "trigger_mappings": {
    "pattern_detection": "explore_codebase_context",
    "security_concerns": "security_audit_specialist"
  }
}
```

## Best Practices

### Trust the System

If complexity detection says you need an agent, let it run. The 20-second investment saves hours of rework.

### Don't Fight Moderate

At score 5-9, you're asked if you want agent help. Say yes if:
- You're unsure about existing patterns
- The codebase is unfamiliar
- Implementation quality matters

### Override When Needed

Use flags to control behavior:

```bash
/prompt-technical --manual Add simple logging
/prompt-technical --agent Add minor validation
```

## Related

- [Phase 0](/architecture/phase-0) - Prompt perfection before agents
- [Predictive Intelligence](/architecture/predictive-intelligence) - Phase 0.15
- [Multi-Agent Research](/architecture/multi-agent) - Deep analysis
- [Caching](/architecture/caching) - Result persistence
