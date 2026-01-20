# /session-end

Save comprehensive session context for future continuity.

## Overview

| Aspect | Details |
|--------|---------|
| **Speed** | ~5 seconds |
| **Complexity** | Simple |
| **Purpose** | Capture work for future sessions |

## Usage

```bash
/session-end
```

## What It Captures

### 1. Decisions Made

Architectural and technical choices:

```markdown
Decisions:
- Chose JWT over sessions for API auth
  Rationale: Stateless, better for mobile app

- Using repository pattern for data access
  Rationale: Easier testing, consistent interface
```

### 2. Code Changes

Files modified with purpose:

```markdown
Files Changed:
- src/auth/jwt.service.ts (created)
  Purpose: JWT generation and verification

- src/middleware/auth.ts (modified)
  Purpose: Added JWT verification middleware
```

### 3. Features Status

Progress tracking:

```markdown
Features:
✓ Login endpoint - Complete
◐ Registration - 70% (needs email verification)
○ Password reset - Not started
```

### 4. Problems Solved

Root causes and solutions:

```markdown
Problems Solved:
- Token expiration causing logout loops
  Root cause: Clock skew between servers
  Solution: Added 5-minute tolerance window
```

### 5. Technical Stack

Context for next session:

```markdown
Tech Stack:
- Express.js 4.18 + TypeScript 5.0
- PostgreSQL 14 with Prisma 5.0
- Redis 7.0 for caching
- Jest for testing
```

### 6. Key Insights

Important discoveries:

```markdown
Insights:
- Prisma doesn't support transactions across databases
- Redis connection pool should be max 10 for this workload
- User model has soft delete, not hard delete
```

### 7. User Preferences

Captured patterns:

```markdown
Preferences:
- Uses async/await consistently
- Prefers explicit error types over generic Error
- Likes inline comments for complex logic
```

### 8. Active Work

Current state:

```markdown
Active Work:
Currently implementing email verification for registration.
- Verification token generation: Done
- Email sending: Done
- Verification endpoint: In progress
- Stuck on: Email template loading
```

### 9. Project Notes

Structure information:

```markdown
Project Notes:
- Tests go in __tests__ folder, not .spec.ts
- Migrations use timestamp prefix
- Env vars in .env.local for development
```

### 10. Next Steps

Clear actionables:

```markdown
Next Steps:
1. Fix email template loading issue
2. Add rate limiting to verification endpoint
3. Write integration tests for auth flow
4. Update API documentation
```

## Example Output

```
Session Summary Captured

Duration: 2 hours 34 minutes
Files Changed: 7
Decisions: 3
Problems Solved: 2

Key Accomplishments:
✓ Implemented JWT authentication
✓ Created auth middleware
✓ Added login endpoint

Work in Progress:
◐ Registration endpoint (70%)

Blockers:
⚠ Email template loading failing

Next Session Priority:
1. Debug email template issue
2. Complete registration
3. Add password reset

Context saved to: .claude/memory/sessions.md

Run /session-start next time to resume.
```

## When to Use

### End of Work Day

```bash
# Before closing Claude Code
/session-end
```

### Before Long Break

```bash
# Lunch, meeting, etc.
/session-end
```

### Switching Projects

```bash
# Capture before moving to different codebase
/session-end
```

### After Major Milestone

```bash
# Feature complete, good checkpoint
/session-end
```

## Best Practices

### Be Honest About State

If something isn't working, say so:

```bash
"The email verification is broken, I don't know why yet"
```

This helps future-you understand the actual state.

### Note Blockers Explicitly

```bash
"I'm stuck on email template loading"
```

This becomes a priority for next session.

### Include Why, Not Just What

```bash
"Chose JWT because mobile app needs stateless auth"
```

Decisions without rationale aren't useful later.

### Run Before /reflect

If you want to improve skills from this session:

```bash
/reflect prompt-technical
/session-end
```

## Data Storage

Saves to `.claude/memory/sessions.md`:

```markdown
## Session: 2026-01-09 16:45

**Duration:** 2h 34m
**Branch:** feature/auth

### Decisions Made
...

### Code Changes
...

[continues with all sections]
```

## Related Commands

- [/session-start](/commands/session-start) - Load this context later
- [/reflect](/commands/reflect) - Improve skills before saving
