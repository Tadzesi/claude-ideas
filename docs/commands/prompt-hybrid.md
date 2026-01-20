# /prompt-hybrid

Intelligent prompt perfection with automatic complexity detection and agent assistance.

## Overview

| Aspect | Details |
|--------|---------|
| **Speed** | 2-30 seconds |
| **Complexity** | Advanced |
| **Agent** | Automatic based on complexity |
| **Best For** | Complex tasks, multi-file changes, pattern detection |

## Usage

```bash
/prompt-hybrid [your prompt]
```

## Examples

### Complex Feature

```bash
/prompt-hybrid Add user authentication following existing patterns
```

**Output:**
```
Phase 0: Prompt Perfection

Complexity Analysis:
- Pattern detection: +6
- Multi-file scope: +5
- Cross-cutting concern: +4
Total Score: 15 (Complex)

Spawning Explore Agent...

Agent Findings:
- Existing auth pattern: JWT in api/middleware/auth.js
- User model: models/User.js with password field
- Similar implementation: payment auth in checkout.js

Phase 0.15: Predictive Intelligence

Journey Stage: Implementing
You're adding a new feature to existing codebase.

Proactive Warnings:
⚠️ Authentication is security-critical
   - Ensure password hashing (bcrypt recommended)
   - Add rate limiting to prevent brute force
   - Validate JWT properly

Pattern Match:
Your existing JWT middleware uses RS256 algorithm.
New auth should match this pattern.

Clarification Questions:
1. Which auth flows needed?
   - Login only
   - Login + Registration
   - Login + Registration + Password Reset

2. Token storage?
   - HttpOnly cookie (more secure)
   - LocalStorage (easier CORS)

[Your answers]

Perfected Prompt:
[Structured, unambiguous prompt]

Proceed? [Yes / Modify]
```

### Multi-File Change

```bash
/prompt-hybrid Add input validation to all form components
```

**Output:**
```
Complexity Score: 11 (Complex)
- Multi-file scope: +5 (12 form components detected)
- Pattern detection: +6

Agent findings:
- Forms: LoginForm, RegisterForm, ContactForm, etc.
- Existing validation: Zod schema in LoginForm only
- Recommended: Extend Zod pattern to all forms

Proceed with Zod validation for all 12 forms? [Yes / Modify]
```

### Pattern Detection

```bash
/prompt-hybrid Implement caching like we did for products
```

**Output:**
```
Complexity Score: 12 (Complex)
- Pattern detection: +6
- Implementation planning: +3
- Feasibility check: +4

Agent found pattern:
ProductService uses Redis cache-aside pattern:
- TTL: 5 minutes
- Key format: product:{id}
- Invalidation on update/delete

Applying same pattern to: [target service]
```

## How It Works

### Complexity Detection

The system scores your prompt against triggers:

| Trigger | Weight | Detection |
|---------|--------|-----------|
| Multi-file scope | +5 | "all", "every", "across" |
| Architecture questions | +7 | "how should", "best approach" |
| Pattern detection | +6 | "like", "similar to", "existing" |
| Feasibility checks | +4 | "possible", "can we" |
| Refactoring tasks | +5 | "refactor", "restructure" |
| Cross-cutting concerns | +4 | "logging", "auth", "validation" |
| Implementation planning | +3 | "implement", "add feature" |

### Path Selection

| Score | Path | Description |
|-------|------|-------------|
| 0-4 | Simple | Fast inline validation (~2s) |
| 5-9 | Moderate | Asks if you want agent help |
| 10-19 | Complex | Spawns agent automatically (~20s) |
| 20+ | Research | Consider `/prompt-research` |

### Predictive Intelligence (Phase 0.15)

When enabled, provides:

1. **Journey Stage Detection**
   - Exploring → Planning → Implementing → Debugging → Refactoring → Reviewing

2. **Domain Risk Analysis**
   - Security risks for auth, payment, etc.
   - Performance concerns for database, API

3. **Pattern Recognition**
   - Naming conventions in your codebase
   - Architectural patterns used

4. **Proactive Warnings**
   - Security issues before implementation
   - Performance bottlenecks to avoid

5. **Next-Steps Prediction**
   - What you'll likely need next
   - Related tasks to consider

### Caching

Results are cached for 10-20x speedup:

- **Cache key**: prompt + files + branch + template
- **TTL**: 24 hours
- **Invalidation**: On file changes, branch switch
- **Storage**: `.claude/cache/agent-results/`

## Comparison

| Feature | /prompt | /prompt-hybrid | /prompt-technical |
|---------|---------|----------------|-------------------|
| Speed | ~2s | 2-30s | 5-30s |
| Complexity detection | Basic | Advanced | Advanced |
| Agent support | No | Yes | Yes |
| Caching | No | Yes | Yes |
| Code scaffolding | No | No | Yes |
| Implementation options | No | No | Yes |
| Predictive intelligence | No | Yes | Yes |

## When to Use

### Good For

- Complex tasks needing codebase context
- Multi-file changes
- Pattern-following implementations
- Cross-cutting concerns (auth, logging, validation)
- Tasks where you want intelligent assistance

### Not Ideal For

- Simple single-file fixes → Use `/prompt`
- Detailed implementation planning → Use `/prompt-technical`
- Security audits or deep analysis → Use `/prompt-research`

## Tips

### Trust the System

Let complexity detection decide if an agent is needed. Fighting it wastes time:

```bash
# If score is 12 (complex), let the agent run
# The 20 seconds saves hours of rework
```

### Reference Existing Patterns

```bash
/prompt-hybrid Add logging like we have in AuthService
```

The agent will find and apply the existing pattern.

### Be Explicit About Scope

```bash
# Vague
/prompt-hybrid Add validation

# Explicit
/prompt-hybrid Add Zod validation to all forms in src/components/forms/
```

### Use for Exploration

Not sure how to implement something?

```bash
/prompt-hybrid How should I implement real-time notifications?
```

The agent will explore your codebase and suggest approaches.

## Related Commands

- [/prompt](/commands/prompt) - For simple tasks without agent
- [/prompt-technical](/commands/prompt-technical) - For implementation planning
- [/prompt-research](/commands/prompt-research) - For deep analysis
