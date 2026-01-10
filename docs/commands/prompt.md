# /prompt

The foundational command for basic prompt perfection. Fast, simple, and effective.

## Overview

| Aspect | Details |
|--------|---------|
| **Speed** | ~2 seconds |
| **Complexity** | Simple |
| **Agent** | None |
| **Best For** | Quick fixes, simple questions, single-file changes |

## Usage

```bash
/prompt [your prompt]
```

## Examples

### Bug Fix

```bash
/prompt Fix the null pointer error in UserService.getById()
```

**Output:**
```
Phase 0 Analysis:
- Type: Bug Fix
- Completeness: 80% (missing error context)

Question: What error message are you seeing?
```

### Simple Question

```bash
/prompt How do I add environment variables in Next.js?
```

**Output:**
```
Phase 0 Analysis:
- Type: Question
- Completeness: 100%

[Claude proceeds with answer]
```

### Code Change

```bash
/prompt Add input validation to the email field in RegisterForm.tsx
```

**Output:**
```
Phase 0 Analysis:
- Type: Code Change
- Completeness: 90%

Proceeding with email validation using existing pattern from LoginForm.tsx
```

## How It Works

### Step 1: Initial Analysis

Claude detects:
- **Language**: English, Slovak, etc.
- **Type**: Task, Question, Bug Fix, Feature, Refactoring
- **Intent**: What you're trying to achieve

### Step 2: Completeness Check

Validates against 6 criteria:

| Criterion | Question |
|-----------|----------|
| Goal | What do you want to achieve? |
| Context | What's the current state? |
| Scope | What files are involved? |
| Requirements | What specific needs exist? |
| Constraints | What limitations apply? |
| Expected Result | How will you know it's done? |

### Step 3: Clarification

If information is missing, Claude asks. Questions are prioritized:
- **Critical** (blocks understanding): Asked first
- **Important** (affects quality): Asked second
- **Nice-to-have** (optimizes): Grouped at end

### Step 4: Perfect & Proceed

Claude structures your prompt and proceeds with execution.

## When to Use /prompt

### Good For

- Single-file bug fixes
- Simple questions
- Quick code changes
- Adding comments or documentation
- Small refactoring tasks

### Not Ideal For

- Multi-file changes → Use `/prompt-hybrid`
- New features → Use `/prompt-technical`
- Pattern detection needed → Use `/prompt-hybrid`
- Deep analysis → Use `/prompt-research`

## Comparison

| Feature | /prompt | /prompt-hybrid |
|---------|---------|----------------|
| Speed | ~2s | 2-30s |
| Agent support | No | Yes |
| Caching | No | Yes |
| Complexity detection | Basic | Advanced |
| Pattern matching | No | Yes |
| Multi-file context | Limited | Full |

## Tips

### Be Specific

```bash
# Less effective
/prompt Fix the bug

# More effective
/prompt Fix the TypeError in line 42 of UserService.ts where user.email is undefined
```

### Include File Names

```bash
# Less effective
/prompt Add logging

# More effective
/prompt Add debug logging to handleSubmit in src/components/LoginForm.tsx
```

### State Expected Behavior

```bash
# Less effective
/prompt The button doesn't work

# More effective
/prompt The submit button in ContactForm should show a loading spinner but currently does nothing when clicked
```

## Output Format

```
Phase 0: Prompt Perfection

Initial Analysis:
- Language: English
- Type: Bug Fix
- Intent: Fix null pointer in UserService

Completeness Check:
✓ Goal: Fix null pointer error
✓ Context: UserService.getById() method
✓ Scope: Single file (UserService.ts)
? Requirements: What should happen when user is null?
✓ Constraints: None specified
✓ Expected Result: No more null pointer errors

Clarification:
What should happen when the user is not found?
- Option A: Return null
- Option B: Throw UserNotFoundError
- Option C: Return default user object

[Your response]

Perfected Prompt:
Fix the null pointer error in UserService.getById() by adding
null check before accessing user.email. When user is not found,
throw UserNotFoundError with descriptive message.

Proceed? [Yes / Modify / Cancel]
```

## Related Commands

- [/prompt-hybrid](/commands/prompt-hybrid) - When you need agent assistance
- [/prompt-technical](/commands/prompt-technical) - For implementation planning
- [/session-end](/commands/session-end) - Save your work
