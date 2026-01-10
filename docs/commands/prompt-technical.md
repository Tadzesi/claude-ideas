# /prompt-technical

Technical implementation analysis with intelligent agent assistance and code scaffolding.

## Overview

| Aspect | Details |
|--------|---------|
| **Speed** | 5-30 seconds |
| **Complexity** | Advanced |
| **Agent** | Explore Agent (automatic for complex tasks) |
| **Best For** | New features, refactoring, implementation planning |

## Usage

```bash
/prompt-technical [task description]

# With flags
/prompt-technical --agent Add caching layer
/prompt-technical --manual Add input validation
/prompt-technical --verbose Refactor UserService
```

### Flags

| Flag | Effect |
|------|--------|
| `--manual` | Skip agent, use manual analysis only |
| `--agent` | Force agent even for simple tasks |
| `--no-cache` | Skip cache, run fresh analysis |
| `--no-predict` | Skip predictive intelligence |
| `--verbose` | Show detailed complexity scoring |

## Examples

### New Feature

```bash
/prompt-technical Add Redis caching to user queries
```

**Output:**
```
Phase 0: Prompt Perfection

Complexity Score: 12 (Complex)
- Multi-file scope: +5
- Pattern detection: +6
- Cross-cutting concern: +4
- Risk: Performance critical

Spawning Explore Agent...

Agent Findings:
- Framework: Express.js
- Existing cache: None detected
- Similar pattern: Redis client in payment-service.js
- Files to modify: UserService.ts, app.ts

Implementation Options:

Option A: Cache-Aside Pattern (Recommended)
- Pros: Simple, explicit control, works with any cache
- Cons: More code, cache invalidation manual
- Files: UserService.ts, cache.service.ts (new)

Option B: Write-Through Cache
- Pros: Automatic sync, simpler reads
- Cons: Slower writes, more complex
- Files: UserService.ts, CacheInterceptor.ts (new)

Option C: Redis Middleware
- Pros: No code changes to services
- Cons: Less granular control
- Files: app.ts, redis.middleware.ts (new)

Recommendation: Option A
Matches existing patterns and provides fine-grained control.

Best Practices Checklist:
✓ Cache invalidation on user update/delete
✓ TTL: 5 minutes for user data
✓ Key pattern: user:{id}
✓ Error handling: fallback to database
✓ Metrics: cache hit/miss ratio

Implementation Plan:
1. Install ioredis package
2. Create cache.service.ts with Redis connection
3. Add caching to UserService.getById()
4. Add cache invalidation to update/delete methods
5. Add cache warming for frequently accessed users

Code Scaffolding:
[Generates code matching your project conventions]

Proceed with Option A? [Yes / A / B / C / Modify]
```

### Refactoring

```bash
/prompt-technical Refactor payment processing to use strategy pattern
```

**Output:**
```
Phase 0: Prompt Perfection

Complexity Score: 14 (Complex)
- Refactoring task: +5
- Architecture change: +7
- Multi-file scope: +5

Agent Analysis:
- Current: Monolithic PaymentService with switch statements
- Payment types: Credit Card, PayPal, Stripe, Bank Transfer
- Files affected: 4 (service + 3 controllers)

Implementation Options:

Option A: Full Strategy Pattern
- PaymentStrategy interface
- Concrete strategies: CreditCardStrategy, PayPalStrategy, etc.
- PaymentContext for strategy selection
- Pros: Clean, extensible, testable
- Cons: More files, migration effort

Option B: Partial Refactor
- Extract payment logic to separate methods
- Keep within PaymentService
- Pros: Less disruption, faster
- Cons: Still coupled, harder to test

Recommendation: Option A
Long-term maintainability outweighs short-term effort.

Proceed? [Yes / A / B / Modify]
```

### Architecture Decision

```bash
/prompt-technical Add real-time notifications using WebSockets vs SSE
```

**Output:**
```
Phase 0: Prompt Perfection

Complexity Score: 11 (Complex)
- Architecture question: +7
- Pattern detection: +4

Analysis:

WebSocket:
- Bidirectional communication
- Higher resource usage
- Better for: chat, gaming, collaborative editing
- Your stack: Socket.io available

Server-Sent Events (SSE):
- Unidirectional (server → client)
- Lower resource usage
- Better for: notifications, feeds, updates
- Native browser support

Recommendation: SSE for notifications
- Notifications are server → client only
- Lower server load
- Works through firewalls
- Falls back to polling gracefully

Implementation Plan:
1. Create SSE endpoint: GET /api/events
2. Add EventEmitter for notification dispatch
3. Client-side: EventSource API
4. Fallback: Long-polling for IE11

Proceed with SSE? [Yes / WebSocket / Modify]
```

## How It Works

### Phase 0: Prompt Perfection + Complexity Detection

```
1. Detect language, type, intent
2. Calculate complexity score (0-50+)
3. Check completeness (6 criteria + technical criteria)
4. Ask clarifying questions
5. Wait for approval
```

### Complexity Triggers

| Trigger | Weight | Example |
|---------|--------|---------|
| Multi-file scope | +5 | "Update all API endpoints" |
| Architecture questions | +7 | "How should I structure..." |
| Pattern detection | +6 | "Following existing patterns" |
| Feasibility checks | +4 | "Is it possible to..." |
| Refactoring tasks | +5 | "Refactor the payment..." |
| Cross-cutting concerns | +4 | "Add logging throughout" |
| Implementation planning | +3 | "Best way to implement..." |

### Path Selection

| Score | Path | Time |
|-------|------|------|
| 0-4 | Manual scan only | ~5s |
| 5-9 | Ask user about agent | ~5s + optional |
| 10+ | Automatic agent | ~20s |
| 15+ | Multi-agent verification | ~50s |

### Agent Analysis

When the Explore Agent runs, it:

1. Scans project structure
2. Detects tech stack and frameworks
3. Finds related code patterns
4. Identifies files to modify
5. Returns structured findings

## Output Sections

### 1. Project Context
- Framework and tech stack
- Relevant files and patterns
- Architecture overview

### 2. Implementation Options
- 2-3 approaches with pros/cons
- Clear recommendation
- Trade-off analysis

### 3. Best Practices Checklist
- Security considerations
- Performance implications
- Testing requirements
- Error handling patterns

### 4. Implementation Plan
- Ordered steps
- File-by-file changes
- Dependencies and prerequisites

### 5. Code Scaffolding
- Ready-to-use templates
- Matches project conventions
- Includes necessary imports

## Tips

### Provide Context

```bash
# Less effective
/prompt-technical Add caching

# More effective
/prompt-technical Add caching to UserService.getById() which is called
100+ times per second and queries PostgreSQL
```

### Specify Constraints

```bash
/prompt-technical Add authentication. Must use existing User model,
support OAuth and JWT, and not break the mobile app.
```

### Ask for Comparisons

```bash
/prompt-technical Add state management: Redux vs Zustand vs Context
```

### Request Options

```bash
/prompt-technical Implement file uploads. Show me 3 approaches
for handling large files.
```

## Error Handling

### Agent Timeout

If the agent takes more than 30 seconds:

```
Agent analysis timed out.

Options:
1. Retry agent analysis
2. Continue with manual scan
3. Cancel

[1 / 2 / 3]
```

### No Patterns Found

```
Agent completed but found no relevant patterns.

This might mean:
- New technology in your project
- Unique implementation needed
- Different search terms needed

Proceeding with general best practices...
```

## Related Commands

- [/prompt-hybrid](/commands/prompt-hybrid) - For general prompt perfection with agents
- [/prompt-research](/commands/prompt-research) - For deep multi-agent analysis
- [/reflect](/commands/reflect) - Improve this command from feedback
