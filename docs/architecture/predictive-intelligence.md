# Predictive Intelligence

Phase 0.15: Proactive guidance that prevents problems before they occur.

## The Concept

Predictive Intelligence adds a layer between prompt perfection (Phase 0) and execution. It analyzes your task to:

- Detect your current **journey stage**
- Identify **domain-specific risks**
- Recognize **project patterns**
- Map **relationships** to previous work
- Predict **logical next steps**

## How It Works

```
Phase 0 Complete
      │
      ▼
┌─────────────────────────────────────────────┐
│           Phase 0.15: Predictive            │
│                                             │
│  1. Journey Stage Detection                 │
│     └─ Where are you in the workflow?       │
│                                             │
│  2. Domain Risk Analysis                    │
│     └─ What could go wrong?                 │
│                                             │
│  3. Pattern Recognition                     │
│     └─ What conventions exist?              │
│                                             │
│  4. Relationship Mapping                    │
│     └─ What connects to this work?          │
│                                             │
│  5. Next Steps Prediction                   │
│     └─ What will you need next?             │
└─────────────────────────────────────────────┘
      │
      ▼
Execution Phase
```

## Journey Stages

The system detects which stage you're in:

| Stage | Description | Indicators |
|-------|-------------|------------|
| **Exploring** | Understanding the codebase | "how does", "where is", "what does" |
| **Planning** | Designing the approach | "should we", "best way to", "architecture" |
| **Implementing** | Writing new code | "add", "create", "implement" |
| **Debugging** | Fixing issues | "fix", "error", "not working", "broken" |
| **Refactoring** | Improving existing code | "refactor", "clean up", "restructure" |
| **Reviewing** | Evaluating changes | "review", "check", "verify", "test" |

### Stage-Specific Guidance

```
Journey Stage: Implementing
You're adding a new feature to an existing codebase.

Context:
- 3 related files found in previous session
- Similar feature implemented last week (auth)
- Testing pattern: Jest with fixtures
```

## Domain Risk Analysis

Automatic warnings for sensitive domains:

### Security Domain

Triggered by: authentication, authorization, passwords, tokens, encryption

```
⚠️ Security Domain Detected

- Ensure password hashing (bcrypt, cost 12+)
- Add rate limiting to prevent brute force
- Use HttpOnly cookies for tokens
- Validate and sanitize all inputs
- Implement proper session management
- Log authentication events for audit
```

### Payment Domain

Triggered by: payment, checkout, billing, subscription, credit card

```
⚠️ Payment Domain Detected

- Never store raw credit card numbers
- Use PCI-compliant payment processor
- Implement idempotency for transactions
- Add proper error handling for failures
- Test thoroughly in sandbox environment
- Log all transaction events
```

### Database Domain

Triggered by: migration, schema, delete, truncate, production

```
⚠️ Database Domain Detected

- Always backup before migrations
- Test migrations on staging first
- Use transactions for multi-step operations
- Have rollback strategy ready
- Verify constraints and indexes
```

### API Domain

Triggered by: api, endpoint, public, external, webhook

```
⚠️ API Domain Detected

- Implement authentication/authorization
- Add rate limiting
- Validate all input parameters
- Use proper HTTP status codes
- Document the API
- Version your endpoints
```

## Pattern Recognition

Automatically detects and adapts to your codebase conventions:

### Detected Patterns

```
Pattern Recognition:

Code Style:
- Your codebase uses async/await consistently
- Error handling follows ErrorResponse pattern
- Naming: camelCase for functions, PascalCase for classes

File Organization:
- Components in src/components/
- Services in src/services/
- Tests in __tests__/ folders

Dependencies:
- Express.js 4.18 for API
- Jest for testing
- Prisma for ORM
```

### Pattern Application

The system uses detected patterns to:

1. **Match code style** - Generated code follows existing conventions
2. **Place files correctly** - New files go in appropriate directories
3. **Use existing utilities** - Leverage what's already there
4. **Follow testing patterns** - Tests match existing structure

## Relationship Mapping

Connects current work to previous context:

```
Relationship Mapping:

Related Previous Work:
- Session 2026-01-08: Implemented user model
- Session 2026-01-09: Added authentication helpers
- Pending: Password reset feature

Dependent Components:
- UserService depends on this
- AuthMiddleware will use this
- ProfileController relates to this

Suggested Review:
- src/services/user.service.js (modified recently)
- src/middleware/auth.js (created by you)
```

## Next Steps Prediction

Forecasts what you'll likely need next:

```
Next Steps Prediction:

After implementing authentication, you'll likely need:

1. Protected Route Middleware
   ├─ Verify JWT on protected endpoints
   ├─ Attach user to request
   └─ Handle unauthorized access

2. Role-Based Access Control
   ├─ Define user roles
   ├─ Create permission checks
   └─ Restrict admin routes

3. Password Reset Flow
   ├─ Email verification
   ├─ Reset token generation
   └─ Secure token validation
```

### Scope Options

Choose how much to tackle:

| Scope | Description | Includes |
|-------|-------------|----------|
| **Focused** | Just the core task | Main feature only |
| **Balanced** | Core + essential adjacent | Feature + critical dependencies |
| **Comprehensive** | Full implementation | Feature + all related items |

## Configuration

### predictive-intelligence.json

```json
{
  "enabled": true,
  "journey_detection": {
    "enabled": true,
    "stages": ["exploring", "planning", "implementing", "debugging", "refactoring", "reviewing"]
  },
  "domain_warnings": {
    "enabled": true,
    "domains": {
      "security": {
        "triggers": ["auth", "password", "token", "encryption"],
        "severity": "high"
      },
      "payment": {
        "triggers": ["payment", "billing", "checkout"],
        "severity": "critical"
      }
    }
  },
  "pattern_recognition": {
    "enabled": true,
    "scan_depth": 3,
    "cache_duration": "24h"
  },
  "relationship_mapping": {
    "enabled": true,
    "max_related": 5
  },
  "next_steps": {
    "enabled": true,
    "scope_options": true
  }
}
```

## Integration

### With Hybrid Intelligence

Predictive Intelligence works alongside complexity detection:

```
Prompt Received
      │
      ▼
┌─────────────┐     ┌─────────────┐
│ Complexity  │────▶│  Agent      │
│ Detection   │     │  Spawning   │
└─────────────┘     └─────────────┘
      │                   │
      ▼                   ▼
┌─────────────────────────────────┐
│    Predictive Intelligence      │
│    (uses agent context)         │
└─────────────────────────────────┘
```

### With Learning System

Predictions improve over time:

- Tracks prediction accuracy
- Adjusts weights based on outcomes
- Learns user-specific patterns

## Best Practices

### Trust the Warnings

Domain-specific warnings exist for a reason. Even experienced developers benefit from security reminders.

### Use Relationship Context

When the system identifies related work, review it. The connections often reveal important context.

### Choose Appropriate Scope

- **Focused** for quick fixes
- **Balanced** for most features
- **Comprehensive** for new systems

### Provide Feedback

Mark predictions as helpful or not. This trains the system for better future predictions.

## Related

- [Hybrid Intelligence](/architecture/hybrid-intelligence) - Complexity detection
- [Learning System](/architecture/learning) - Pattern tracking
- [Phase 0](/architecture/phase-0) - Prompt perfection

