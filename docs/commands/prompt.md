# /prompt

The foundational command for prompt perfection. Project-aware, fast, and effective.

::: tip What's New in v3.0 (Skills Format + Project-Aware)
- **Skills Format** - YAML frontmatter, auto-invocation by Claude when relevant
- **STARTUP Section** - Loads project-profile.md, sessions.md, prompt-patterns.md first
- **CONTEXT LOADED** - Shows what is pre-filled so you see exactly what Claude knows
- **Zero repeat questions** - Never asks about tech stack, platform, or preferences again
:::

## Overview

| Aspect | Details |
|--------|---------|
| **Speed** | ~2 seconds |
| **Version** | v3.0 (Skills Format) |
| **Format** | `.claude/skills/prompt/SKILL.md` |
| **Complexity** | Simple |
| **Agent** | None |
| **Best For** | Quick fixes, simple questions, single-file changes |

## Usage

```bash
/prompt [your prompt]
```

Claude also auto-invokes this skill when it detects you want to refine or clarify a task.

## What Happens at Startup

Before any analysis, `/prompt` loads your project context:

```
CONTEXT LOADED FROM PROJECT PROFILE

Project: Your App v2.1
Stack: Node.js, Express, PostgreSQL
Platform: macOS, bash
Preferences: TypeScript strict, 2-space indent, no auto-commit
Recent: Added JWT auth middleware (from sessions.md)
Patterns: "authentication" → auto-include security checklist

What I still need for this task: [only truly missing items]
```

This means you **never** need to explain your stack, platform, or preferences again.

## Examples

### Bug Fix (Project-Aware)

```bash
/prompt Fix the null pointer error in UserService.getById()
```

**With project context loaded, output:**
```
CONTEXT LOADED
Project: Your App | Stack: Node.js + TypeScript + PostgreSQL

Phase 0 Analysis:
- Type: Bug Fix
- Pre-filled: TypeScript, Express, your DB schema (from profile)
- Missing: What error message are you seeing?

Question: What does the error say exactly?
```

No questions about stack, framework, or project structure — Claude already knows.

### Simple Question

```bash
/prompt How do I add environment variables in Next.js?
```

**Output:**
```
CONTEXT LOADED
Project: My App | Stack: Next.js + TypeScript

Phase 0: Complete (100%)
[Claude proceeds with answer, using your specific Next.js version from profile]
```

### Code Change

```bash
/prompt Add input validation to the email field in RegisterForm.tsx
```

**Output:**
```
CONTEXT LOADED
Project: My App | Stack: React + TypeScript | Pattern: use Zod for validation

Phase 0: Complete (90%)
Note: Following existing Zod validation pattern from LoginForm.tsx (from profile)

Proceeding with email validation using Zod, consistent with your codebase.
```

## How It Works

### STARTUP: Load Project Context

**Always runs first, before any analysis:**

1. Read `.claude/memory/project-profile.md` — full project facts
2. Read last 3 sessions from `.claude/memory/sessions.md` — recent work
3. Read `.claude/memory/prompt-patterns.md` — learned patterns

Display brief "CONTEXT LOADED" summary, then proceed.

### Step 0.1: Initial Analysis

Detects:
- **Language**: English, Slovak, etc.
- **Type**: Task, Question, Bug Fix, Feature, Refactoring, Config, Docs
- **Intent**: What you're trying to achieve
- **Scope**: This project or another project?

### Step 0.2: Project-Aware Completeness Check

Uses loaded project context to pre-fill criteria. Only checks for task-specific unknowns:

**Already known from project profile (never asked again):**
- Environment, platform, OS
- Tech stack and framework versions
- Code conventions and style preferences
- Project file structure

**Checked per task (may be missing):**

| Criterion | Question |
|-----------|----------|
| Goal | What exactly do you want to achieve? |
| Scope | Which specific file or component? |
| Requirements | Specific needs beyond defaults? |
| Expected Result | How will you verify success? |

### Step 0.3: Targeted Clarification

Only asks for genuinely missing information:

```
What I already know: [from project profile]
What I need for this task:

1. [Critical] Which specific file? (detected: UserService.ts, UserController.ts)
2. [Important] What should happen when user is null? Return null or throw?
```

When multiple approaches exist, presents options with a recommendation:

```
APPROACHES:

Option 1: Return null (simple, caller handles)
  Pros: Non-throwing, flexible  Cons: Caller must always check

Option 2: Throw UserNotFoundError (explicit)  ⭐ RECOMMENDED
  Pros: Clear contract, consistent with ErrorHandler  Cons: Caller must catch

Select: 1, 2, or describe your preference
```

### Step 0.4-0.5: Perfect Prompt Output

```
PERFECTED PROMPT

Goal: Fix null pointer in UserService.getById() with proper error handling

Context (from project profile):
- Stack: Node.js + TypeScript + PostgreSQL/Prisma
- Pattern: Throws typed errors (ErrorHandler.ts)
- Conventions: async/await, strict null checks

Scope:
- File: src/services/UserService.ts (line 42)
- Pattern to follow: ProductService.getById() (already throws NotFoundError)

Requirements:
1. Add null check after database query
2. Throw UserNotFoundError with descriptive message
3. Follow existing pattern in ProductService

Expected Result: No more null pointer. Callers receive typed error.
Verify: Run existing tests in __tests__/UserService.test.ts

Changes Made:
- Project context auto-filled from project-profile.md
- Pattern reference added from profile
```

### Step 0.6: Approval Gate

```
PERFECTED PROMPT READY

Type: Bug Fix | Scope: UserService.ts | Confidence: High
Project context: Auto-loaded from profile

Approve?
- y / yes  - Execute
- n / no   - Cancel
- modify [description] - Adjust
- explain [part]       - Explain a decision
- options              - Show alternatives
```

## Skills Format (v4.3)

The `/prompt` skill uses native Claude Code Skills format:

**Location**: `.claude/skills/prompt/SKILL.md`

**Frontmatter:**
```yaml
---
name: prompt
description: Transform any prompt into an unambiguous, executable format.
             Use when the user wants to refine or perfect a prompt...
argument-hint: "[your prompt or task description]"
---
```

The `description` field allows Claude to suggest this skill automatically when relevant. You can still invoke it directly with `/prompt`.

Old `.claude/commands/prompt.md` continues to work unchanged.

## When to Use /prompt

### Good For

- Single-file bug fixes
- Simple questions
- Quick code changes (1-2 files)
- Adding comments or documentation
- Small refactoring tasks
- Any task where you have clear scope

### Not Ideal For

| Need | Better Command |
|------|---------------|
| Multi-file changes | `/prompt-hybrid` |
| Pattern detection across codebase | `/prompt-hybrid` |
| Architecture decisions | `/prompt-technical` |
| Deep analysis or research | `/prompt-research` |
| Writing articles or documentation | `/prompt-article` |

## Comparison

| Feature | /prompt | /prompt-hybrid |
|---------|---------|----------------|
| Speed | ~2s | 2-30s |
| Project context | ✅ Full | ✅ Full |
| Agent support | No | Yes |
| Caching | No | Yes |
| Complexity detection | Basic | Advanced |
| Pattern matching | From profile | Active agent scan |
| Multi-file context | From profile | Full exploration |

## AI Fluency Features

### Quick Delegation Check (Step 0.11)

Before processing, validates task appropriateness:

```
Delegation Check:
- Task: Suitable for AI ✓
- Capability match: Code analysis (excellent) ✓
- Responsibility: User remains responsible ✓
```

### Post-Execution Evaluation (Step 0.7)

After completion, prompts for feedback:

```
Quick Evaluation

How was this output?
- good    — Accurate, appropriate ✅
- partial — Mostly good, minor adjustments ⚠️
- wrong   — Significant issues ❌
- explain — Show me your reasoning 🔍
```

### Diligence Reminder

In approval gate: you remain responsible for verifying AI output before use.

## Tips

### Be Specific About Scope

```bash
# Less effective
/prompt Fix the bug

# More effective
/prompt Fix the TypeError on line 42 of UserService.ts where user.email is undefined
```

### Reference Existing Patterns

```bash
/prompt Add validation to handleSubmit in ContactForm.tsx, similar to LoginForm.tsx
```

Claude will find the pattern in your profile or from the mentioned file.

### State Expected Behavior

```bash
/prompt The submit button in ContactForm should show a loading spinner
        but currently does nothing when clicked. Fix it.
```

## Version History

| Version | Date | Changes |
|---------|------|---------|
| v3.0 | Mar 2026 | Skills format, STARTUP section, project-aware, zero repeat questions |
| v2.1 | Jan 2026 | AI Fluency: Delegation Check, Post-Execution Evaluation, Diligence |
| v2.0 | Dec 2024 | Migrated to unified library system |
| v1.0 | Oct 2024 | Initial standalone implementation |

## Related

- [/prompt-hybrid](/commands/prompt-hybrid) - When you need agent assistance
- [/prompt-technical](/commands/prompt-technical) - For implementation planning
- [/session-end](/commands/session-end) - Save your work
- [Skills Format](/architecture/skills-format) - How the new format works
- [Phase 0](/architecture/phase-0) - The validation flow
