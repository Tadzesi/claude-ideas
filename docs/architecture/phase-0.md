# Phase 0: Prompt Perfection

Phase 0 is the foundation of every command. It transforms vague ideas into precise, executable prompts through systematic validation.

## Why Phase 0?

Without Phase 0:
```
User: "Add login"
Claude: *guesses implementation details*
User: "No, I meant OAuth"
Claude: *refactors*
User: "With JWT"
Claude: *refactors again*
```

With Phase 0:
```
User: "Add login"
Claude: "Before I implement, which auth method: OAuth, JWT, or Sessions?"
User: "OAuth with JWT tokens"
Claude: *implements correctly the first time*
```

## The 6 Steps

### Step 0.1: Initial Analysis

Claude detects:

| Aspect | Examples |
|--------|----------|
| **Language** | English, Slovak, Mixed |
| **Type** | Task, Question, Bug Fix, Feature, Refactoring |
| **Intent** | What you're trying to achieve |

```
Initial Analysis:
- Language: English
- Type: Feature Implementation
- Intent: Add user authentication to web application
```

### Step 0.12: Interaction Mode Detection (NEW v4.1)

Based on **Anthropic's AI Fluency Framework**, Claude detects the optimal collaboration mode:

| Mode | Description | Best For |
|------|-------------|----------|
| **Automation** | AI executes specific instructions | Simple tasks, clear commands |
| **Augmentation** | Human and AI collaborate iteratively | Complex analysis, decision-making |
| **Agency** | AI works independently | Research, exploration, multi-agent |

```
Interaction Mode: Augmentation
Rationale: Task requires decision-making collaboration
Implications: Will engage in dialogue, offer options, iterate
```

### Step 0.2: Completeness Check

Every prompt is validated against 9 criteria (expanded from 6 in v4.1):

**Product Description (WHAT):**
| Criterion | Question | Example |
|-----------|----------|---------|
| **Goal** | What do you want to achieve? | "Add user login" |
| **Context** | What's the current state? | "Express.js app with no auth" |
| **Scope** | What files/components? | "API routes and User model" |
| **Requirements** | Specific needs? | "Support email + password" |
| **Constraints** | Limitations? | "Must work with mobile app" |
| **Expected Result** | How will you know it's done? | "Users can log in and receive token" |

**Process Description (HOW) - NEW v4.1:**
| Criterion | Question | Example |
|-----------|----------|---------|
| **Approach** | How should AI work? | "Step-by-step, test each change" |

**Performance Description (AI BEHAVIOR) - NEW v4.1:**
| Criterion | Question | Example |
|-----------|----------|---------|
| **Interaction Style** | Concise or detailed? | "Detailed explanations" |
| **Communication Tone** | Formal or casual? | "Technical, professional" |

```
Completeness Check:
✓ Goal: Add user authentication
✓ Context: Express.js application
? Scope: Which files need changes?
? Requirements: Which auth method?
✓ Constraints: None specified
? Expected Result: What should happen after login?
```

### Step 0.3: Clarification Questions

Missing information triggers questions. Questions are prioritized:

1. **Critical** - Blocks understanding (asked first)
2. **Important** - Affects implementation quality
3. **Nice-to-have** - Optimizes but not essential

```
Clarification Questions:

1. [Critical] Which authentication method?
   - Option A: JWT tokens (Recommended for API)
   - Option B: Session cookies
   - Option C: OAuth providers

2. [Important] Which files should I modify?
   - Detected: routes/api.js, models/User.js
   - Create new: middleware/auth.js

3. [Nice-to-have] Include password reset?
   - Yes (adds 2 more endpoints)
   - No (just login/logout)
```

### Step 0.4: Correction & Structuring

Claude corrects issues and structures the prompt:

- Grammar and clarity improvements
- Technical terminology standardization
- Logical ordering of requirements

### Step 0.5: Perfected Prompt Output

The structured, unambiguous prompt:

```
Perfected Prompt:

GOAL
Implement JWT-based authentication for Express.js API

CONTEXT
- Express.js 4.18 web application
- PostgreSQL database with Prisma ORM
- Existing User model with email field
- No current authentication

SCOPE
Files to create:
- src/middleware/auth.js (JWT verification)
- src/routes/auth.js (login, register, logout)
- src/services/auth.service.js (business logic)

Files to modify:
- src/routes/api.js (mount auth routes)
- prisma/schema.prisma (add password field)

REQUIREMENTS
1. Login: POST /api/auth/login
   - Accept email + password
   - Return JWT in HttpOnly cookie
   - Rate limit: 5 attempts/minute

2. Register: POST /api/auth/register
   - Validate email format
   - Hash password with bcrypt
   - Return JWT in HttpOnly cookie

3. Logout: POST /api/auth/logout
   - Clear auth cookie

4. Auth middleware
   - Verify JWT from cookie
   - Attach user to req.user
   - Return 401 for invalid tokens

CONSTRAINTS
- JWT expiration: 24 hours
- Use bcrypt with cost factor 12
- No breaking changes to existing endpoints

EXPECTED RESULT
- Users can register, login, and logout
- Protected routes require valid JWT
- Proper error messages for auth failures
```

### Step 0.6: Approval Gate

Claude waits for explicit approval:

```
Proceed with this implementation?

[Yes] - Execute as specified
[Modify] - Adjust something
[Cancel] - Start over
```

## Optional: Phase 0.15 - Predictive Intelligence

For advanced commands, Phase 0.15 adds proactive guidance:

```
Phase 0.15: Predictive Intelligence

Journey Stage: Implementing
You're adding a new feature to existing codebase.

Proactive Warnings:
⚠️ Security Domain Detected
   - Ensure password hashing (bcrypt)
   - Add rate limiting to prevent brute force
   - Use HttpOnly cookies for tokens
   - Validate all inputs

Pattern Recognition:
- Your codebase uses async/await consistently
- Error handling follows ErrorResponse pattern
- Tests in __tests__ folder

Next Steps Prediction:
After auth, you'll likely need:
1. Protected route middleware
2. Role-based access control
3. Password reset flow
```

## Configuration

Phase 0 is configured in the core library:

**Location**: `.claude/library/prompt-perfection-core.md`

### Completeness Criteria

The 6 criteria are universal. Domain-specific commands add more through adapters:

**Technical Adapter** adds:
- Technical Stack
- Architecture
- Code Location
- Testing Strategy

### Question Priority

Questions are ordered by impact:
- Critical: Blocks all progress
- Important: Affects quality
- Nice-to-have: Optimization only

## Best Practices

### For Users

1. **Answer questions honestly** - Each question prevents a mistake
2. **Provide context** - More context = better prompt
3. **Modify if needed** - The approval gate is your chance to refine
4. **Trust the process** - Phase 0 seems slow but saves time overall

### For Developers

1. **Don't skip Phase 0** - It's the quality foundation
2. **Use adapters** - Don't modify core for domain-specific needs
3. **Test completeness** - Ensure all 6 criteria are checked
4. **Preserve approval gate** - Never auto-proceed

## AI Fluency Framework (NEW v4.1)

Phase 0 is now aligned with **Anthropic's AI Fluency Framework** - the 4Ds:

| D | Purpose | Implementation |
|---|---------|----------------|
| **Delegation** | Decide human vs AI tasks | Step 0.13 in `/prompt-hybrid` |
| **Description** | Define outputs, process, behavior | Expanded to 9 criteria |
| **Discernment** | Evaluate AI outputs | Discernment Hints in output |
| **Diligence** | Verify and take responsibility | Diligence Summary in `/session-end` |

### Discernment Hints (NEW v4.1)

The perfected prompt now includes evaluation criteria:

```
Discernment Hints:
- Product Evaluation: Check accuracy of implementation
- Process Evaluation: Verify logical reasoning steps
- Performance Evaluation: Was the communication style helpful?
```

### Configuration

AI Fluency settings are in `.claude/config/ai-fluency.json`:

```json
{
  "delegation": { "enabled": true },
  "description": { "enabled": true },
  "discernment": { "include_hints_in_output": true },
  "diligence": { "track_in_session_end": true }
}
```

## Related

- [Library System](/architecture/library-system) - How Phase 0 is shared
- [Hybrid Intelligence](/architecture/hybrid-intelligence) - Complexity detection
- [Predictive Intelligence](/architecture/predictive-intelligence) - Phase 0.15
- [AI Fluency Framework](/architecture/ai-fluency) - The 4Ds model
