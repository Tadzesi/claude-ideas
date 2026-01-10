# /session-start

Load previous session context for seamless continuity.

## Overview

| Aspect | Details |
|--------|---------|
| **Speed** | ~2 seconds |
| **Complexity** | Simple |
| **Purpose** | Load previous work context |

## Usage

```bash
/session-start
```

## What It Does

Loads and presents context from your previous sessions:

1. **Active Work in Progress**
   - What you were working on
   - Current state of implementation
   - Blockers or pending items

2. **Recent Decisions**
   - Architectural choices made
   - Trade-offs considered
   - Reasons for decisions

3. **Files Modified**
   - Recently changed files
   - What changes were made
   - Why they were changed

4. **Tech Stack Context**
   - Frameworks detected
   - Patterns in use
   - Conventions established

5. **User Preferences**
   - Coding style preferences
   - Communication patterns
   - Tool preferences

6. **Next Steps**
   - Pending tasks
   - Suggested follow-ups
   - Blockers to address

## Example Output

```
Session Context Loaded

Last Session: 2026-01-09 16:45

Active Work:
You were implementing two-factor authentication.
- Login flow: Complete
- Registration flow: In progress (70%)
- Password reset: Not started

Recent Decisions:
1. Chose TOTP over SMS for 2FA
   Reason: Better security, no phone dependency

2. Using existing User model with new fields
   Reason: Less migration complexity

Files Modified:
- src/auth/2fa.service.ts (created)
- src/models/User.ts (added 2FA fields)
- src/auth/auth.controller.ts (added 2FA endpoints)

Tech Stack:
- Express.js + TypeScript
- PostgreSQL with Prisma
- JWT for session management

Preferences:
- Prefers async/await over callbacks
- Uses Zod for validation
- Likes detailed error messages

Next Steps:
1. Complete registration 2FA enrollment
2. Add backup codes generation
3. Write tests for 2FA flow

Ready to continue?
```

## When to Use

### Beginning of Every Session

```bash
# First command when starting work
/session-start
```

### Returning After a Break

```bash
# Coming back after lunch, next day, etc.
/session-start
```

### Context Lost

If Claude seems to have forgotten context:

```bash
/session-start
```

## Data Sources

Session context is loaded from:

| File | Content |
|------|---------|
| `.claude/memory/sessions.md` | Session history |
| `.claude/memory/prompt-patterns.md` | Learning data |
| `.claude/memory/project-knowledge.md` | Project context |
| `.claude/memory/observations.md` | Skill observations |

## Best Practices

### Pair with /session-end

Always save before ending:

```bash
# End of work
/session-end

# Next day
/session-start
```

### Review the Context

Don't just run `/session-start` and ignore the output. Review:
- Is the "Active Work" accurate?
- Are there blockers to address?
- Do the "Next Steps" make sense?

### Correct If Needed

If something is wrong:

```bash
"Actually, I finished the registration flow yesterday"
```

Claude will update its understanding.

## Related Commands

- [/session-end](/commands/session-end) - Save context before ending
- [/reflect](/commands/reflect) - Improve skills from session
