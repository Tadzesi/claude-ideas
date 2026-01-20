# Tutorial: Getting Best Results with Claude Commands

This comprehensive tutorial teaches you how to use Claude Commands Library effectively, following the AI Fluency Framework principles for optimal human-AI collaboration.

## Prerequisites

- Claude Commands Library v4.2+ installed
- Basic familiarity with Claude Code
- A project to work with

## Part 1: Understanding the Fundamentals

### The 4Ds Framework

Every interaction with Claude Commands follows Anthropic's AI Fluency Framework:

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│ DELEGATION  │ ──► │ DESCRIPTION │ ──► │ DISCERNMENT │ ──► │  DILIGENCE  │
│ What to ask │     │ How to ask  │     │ Evaluate    │     │ Responsible │
└─────────────┘     └─────────────┘     └─────────────┘     └─────────────┘
```

### The Feedback Loop

Effective AI use is iterative. Don't expect perfection on first try:

```
    DESCRIBE          EVALUATE
   (what you want) → (what you got)
         ↑               ↓
         └─── REFINE ←──┘
           (improve prompt)
```

## Part 2: Choosing the Right Command

| Situation | Command | Why |
|-----------|---------|-----|
| Quick fix, simple task | `/prompt` | Fast, 2 seconds |
| Complex task, need exploration | `/prompt-hybrid` | Agent assistance |
| New feature, architecture | `/prompt-technical` | Implementation analysis |
| Security audit, deep analysis | `/prompt-research` | Multi-agent research |
| Writing content | `/prompt-article` | Article wizard |
| Starting work session | `/session-start` | Load context |
| Ending work session | `/session-end` | Save context |
| Improve from feedback | `/reflect` | Learn from session |

## Part 3: Writing Effective Prompts

### Bad vs Good Prompts

::: danger Bad Prompt
```
/prompt Fix my code
```
**Problems:**
- No context (what code?)
- No scope (which file?)
- No expected result (what should happen?)
:::

::: tip Good Prompt
```
/prompt Fix the NullReferenceException in UserService.GetUser() method
when the user doesn't exist in the database. Should return null instead
of throwing. Using .NET 8, Entity Framework Core.
```
**Why it works:**
- Clear goal (fix exception)
- Specific scope (UserService.GetUser)
- Context (what happens, what should happen)
- Tech stack (.NET 8, EF Core)
:::

### The 6 Essential Criteria

Every prompt should include:

1. **Goal** - What do you want to achieve?
2. **Context** - Project, technology, environment
3. **Scope** - Which files, components, areas
4. **Requirements** - Specific needs
5. **Constraints** - Limitations, rules (optional)
6. **Expected Result** - How to verify success

### Examples by Task Type

#### Bug Fix
```
/prompt-technical

Fix the authentication timeout issue in our React app.
- Users report being logged out after 5 minutes
- Expected: Sessions should last 30 minutes
- Files: src/auth/AuthContext.tsx, src/api/client.ts
- Using: React 18, Axios, JWT tokens
```

#### New Feature
```
/prompt-hybrid

Add dark mode toggle to the Settings page.
- Should persist preference in localStorage
- Should respect system preference on first load
- Toggle should be a switch component
- Using: React, Tailwind CSS, shadcn/ui
```

#### Architecture Question
```
/prompt-research

Analyze our current authentication system and recommend improvements.
- Current: JWT tokens stored in localStorage
- Concerns: Security, session management, refresh tokens
- Tech stack: React frontend, .NET Core API
```

## Part 4: Understanding the Phase 0 Flow

When you run a command, it goes through Phase 0:

### Step 1: Analysis
```
Detected Language: English
Prompt Type: Bug Fix
Core Intent: Fix authentication timeout
```

### Step 2: Completeness Check
```
✓ Goal: Fix timeout issue
✓ Context: React app, JWT tokens
✓ Scope: AuthContext.tsx, client.ts
✓ Requirements: 30-minute sessions
○ Constraints: Not specified
✓ Expected Result: Sessions last 30 minutes
```

### Step 3: Clarification Questions

If anything is missing, you'll be asked:

```
🚨 Critical (must have):
- What authentication library are you using?

⚠️ Important (should have):
- Is there a refresh token mechanism?

💡 Optional:
- Should I also add "remember me" functionality?
```

### Step 4: Approval Gate

```
⏸️ Perfected Prompt Ready - Awaiting Your Approval

Summary:
- Type: Bug Fix
- Goal: Fix authentication timeout (5min → 30min)
- Scope: AuthContext.tsx, client.ts
- Confidence: High

⚖️ Diligence Reminder (AI Fluency):
You remain responsible for any output generated.

Reply with: y/yes, n/no, modify, explain, options
```

### Step 5: Execution

After approval, the task executes.

### Step 6: Post-Execution Evaluation

```
📊 Quick Evaluation (Discernment Check)

How was this output?
- `good` — Accurate, appropriate, useful ✅
- `partial` — Mostly good, needs adjustments ⚠️
- `wrong` — Significant issues, needs rework ❌
- `explain` — Show me your reasoning 🔍
```

## Part 5: Iterating for Better Results

### When Output is "Partial"

```
User: partial

Claude: What needs adjustment?

User: The session duration is correct, but I also need to handle
      the refresh token expiration.

Claude: [Makes adjustments]
```

### When Output is "Wrong"

```
User: wrong

Claude: What specifically was wrong?

User: You modified the wrong file. The auth logic is in
      src/services/auth.ts, not src/auth/AuthContext.tsx

Claude: [Starts over with correct file]
```

### Useful Refinement Phrases

| Situation | Say This |
|-----------|----------|
| Too long | "Make it more concise, focus on [key points]" |
| Too vague | "Be more specific about [aspect]" |
| Wrong tone | "Use a more [formal/casual/technical] tone" |
| Missing context | "Also consider [additional context]" |
| Incorrect facts | "Check [claim], it should be [correction]" |
| Wrong approach | "Instead of X, try Y because [reason]" |

## Part 6: Command-Specific Tips

### /prompt - Quick Perfection

Best for:
- Simple bug fixes
- Small code changes
- Quick questions

```bash
/prompt Add null check to handleSubmit function in ContactForm.tsx
```

### /prompt-hybrid - Intelligent Assistance

Best for:
- Complex tasks
- When you need codebase exploration
- Multi-file changes

```bash
/prompt-hybrid Refactor our API client to use React Query for caching
```

The system will:
1. Detect complexity (score 0-50+)
2. Spawn agents if needed
3. Explore codebase
4. Provide informed recommendations

### /prompt-technical - Implementation Analysis

Best for:
- New features
- Architecture decisions
- Refactoring

```bash
/prompt-technical Implement WebSocket support for real-time notifications
```

You'll get:
- Multiple implementation options
- Pros/cons analysis
- Code scaffolding
- Best practices

### /prompt-research - Deep Analysis

Best for:
- Security audits
- Performance investigations
- Architecture reviews

```bash
/prompt-research Perform security audit of our payment processing system
```

Features:
- 2-5 specialized agents
- Iterative refinement
- Citations with file:line
- Comprehensive reports

### /session-start and /session-end

**Start of day:**
```bash
/session-start
```
Loads previous context, decisions, and work in progress.

**End of day:**
```bash
/session-end
```
Saves context for seamless resumption.

### /reflect - Learn and Improve

After using any command:
```bash
/reflect prompt-hybrid
```

Analyzes the session for:
- Corrections (what went wrong)
- Successes (what worked)
- Edge cases (missing features)
- Preferences (your patterns)

## Part 7: Common Mistakes to Avoid

### 1. Being Too Vague

::: danger Don't
```
/prompt Fix my app
```
:::

::: tip Do
```
/prompt Fix the login button not responding on mobile Safari.
Using React 18, Tailwind CSS.
```
:::

### 2. Accepting First Output

Don't settle! If output is 80% good, use `partial` and refine.

### 3. Not Providing Context

AI doesn't know your:
- Tech stack
- Project structure
- Coding conventions
- Team preferences

Always include relevant context.

### 4. Over-Trusting AI

Always:
- Review generated code
- Test before deploying
- Verify facts and claims
- Check for security issues

### 5. Under-Using AI

Don't spend hours on:
- Boilerplate code
- Documentation
- Test cases
- Code refactoring

Let AI draft, you refine.

## Part 8: Pro Tips

### Tip 1: Meta-Prompting

If unsure how to phrase something:

```
/prompt Help me craft a prompt for implementing
user authentication with OAuth2
```

AI can help you write better prompts!

### Tip 2: Use Examples

```
/prompt-technical Create a validation function like this:

// Input: { name: "", age: -1 }
// Output: { valid: false, errors: ["name required", "age must be positive"] }
```

### Tip 3: Specify Output Format

```
/prompt Explain the Observer pattern.

Output as:
1. One-sentence summary
2. When to use (3 bullet points)
3. Code example (TypeScript)
4. Common pitfalls
```

### Tip 4: Use Constraints

```
/prompt-technical Add logging to the API service.
Constraints:
- Must not affect performance (async only)
- Must not log sensitive data (PII)
- Must follow existing patterns in codebase
```

### Tip 5: Save Good Sessions

After a productive session:
```bash
/session-end
```

Then:
```bash
/reflect [command-name]
```

This captures learnings for future improvements.

## Part 9: Troubleshooting

### "Claude keeps asking too many questions"

Your prompt is missing critical information. Include:
- Goal, Context, Scope at minimum
- Tech stack if relevant

### "Output doesn't match expectations"

1. Check if you approved the perfected prompt
2. Review the scope - was it clear?
3. Use `partial` or `wrong` to refine

### "Agent spawning takes too long"

For simpler tasks, use `/prompt` instead of `/prompt-hybrid`.

### "Can't find relevant files"

Provide file paths explicitly:
```
/prompt Fix bug in src/components/UserProfile.tsx
```

## Part 10: Complete Workflow Example

### Scenario: Add User Profile Feature

**1. Start Session**
```bash
/session-start
```

**2. Plan the Feature**
```bash
/prompt-technical Add user profile page with avatar upload

Requirements:
- Display name, email, avatar
- Edit functionality
- Avatar upload to S3
- Form validation
- Using: Next.js 14, TypeScript, Tailwind, AWS S3
```

**3. Review Options**
- Option A: Server-side upload
- Option B: Client-side with presigned URLs (recommended)

Select: "Option B"

**4. Implement**
Claude provides:
- API routes
- Component code
- S3 integration
- Type definitions

**5. Evaluate**
```
partial - The form validation is good but I need server-side
validation too for the API routes.
```

**6. Refine**
Claude adds server-side validation.

**7. End Session**
```bash
/session-end
```

Saves:
- Decisions made
- Files created
- Work in progress

**8. Reflect**
```bash
/reflect prompt-technical
```

Captures learnings for future features.

## Summary

1. **Choose the right command** for your task complexity
2. **Provide complete context** (Goal, Context, Scope, Requirements)
3. **Review and approve** the perfected prompt
4. **Iterate using feedback** (good/partial/wrong)
5. **Remember your responsibility** for AI-generated output
6. **Save your work** with /session-end
7. **Learn from sessions** with /reflect

---

## Related

- [AI Fluency Framework](/architecture/ai-fluency) - The 4Ds explained
- [Phase 0 Flow](/architecture/phase-0) - Prompt perfection details
- [Commands Reference](/commands/) - All commands documentation
