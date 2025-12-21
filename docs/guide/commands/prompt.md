# /prompt

Basic prompt perfection for quick clarification and refinement.

## Overview

The `/prompt` command analyzes, clarifies, and perfects any prompt into an unambiguous, executable format using the Phase 0 validation flow.

- **Time:** ~2 seconds
- **Complexity:** Simple
- **Best for:** Quick prompts, single-file tasks, well-defined requests

## What It Does

1. **Detects Language** - Slovak or English
2. **Identifies Type** - Task, Question, Bug Fix, Feature, Refactoring
3. **Checks Completeness** - Goal, Context, Scope, Requirements, Constraints, Success Criteria
4. **Asks Clarifying Questions** - If information is missing
5. **Outputs Perfected Prompt** - Structured and unambiguous

## Usage

```bash
/prompt [your prompt]
```

### Examples

```bash
# Bug fix
/prompt Fix the login bug in my app

# Feature request
/prompt Add dark mode to settings

# Question
/prompt How do I implement caching?

# Refactoring
/prompt Refactor UserService for better performance
```

## The Phase 0 Flow

### Step 0.1: Initial Analysis

Detects:
- Language (Slovak/English)
- Prompt type (Task/Question/Bug/etc.)
- Core intent

### Step 0.2: Completeness Check

Verifies presence of:
- ✅ Goal - What you want to achieve
- ✅ Context - Environment, tech stack, background
- ✅ Scope - Files, components affected
- ✅ Requirements - Specific needs
- ✅ Constraints - Limitations, compatibility
- ✅ Success Criteria - How to verify completion

### Step 0.3: Clarification

Asks questions about missing items:
- What's unclear?
- Multiple valid approaches?
- Missing context?

### Step 0.4: Correction

Fixes:
- Grammar and spelling
- Structure and clarity
- Preserves technical terms

### Step 0.5: Perfect Prompt Output

Structured format:
```
Goal: [One clear sentence]
Context: [Environment, tech stack, background]
Scope: [Files, components]
Requirements:
  1. [Requirement 1]
  2. [Requirement 2]
Constraints: [Limitations]
Expected Result: [Success criteria]
```

### Step 0.6: Approval Gate

You can:
- `y` or `yes` - Execute
- `n` or `no` - Cancel
- `modify [changes]` - Adjust
- `explain` - Get details

## Example Flow

### Input
```bash
/prompt Fix login bug
```

### Phase 0 Analysis
```
Detected Language: English
Prompt Type: Bug Fix

Completeness Check:
✅ Goal: Fix login bug
❌ Context: Which framework? ASP.NET? React?
❌ Scope: Frontend or backend?
❌ Success Criteria: How to verify?

Questions:
1. What login framework are you using?
2. What specific error occurs?
3. Which layer needs fixing (UI, API, database)?
```

### After User Answers

```
Perfected Prompt:

Goal: Fix null reference exception in ASP.NET Core login API

Context:
- ASP.NET Core 6.0
- SQL Server database
- JWT authentication

Scope:
- File: Controllers/UserController.cs
- Method: Login(), line 47

Requirements:
1. Handle null email input gracefully
2. Add proper error logging
3. Return appropriate HTTP status codes
4. Maintain security best practices

Constraints:
- Must maintain existing JWT token structure
- No breaking changes to API contract

Expected Result:
Login API handles invalid input gracefully without throwing exceptions

Changes Made:
- Clarified framework and version
- Identified specific file and method
- Added security requirement
- Defined success criteria
```

## When to Use

### Use `/prompt` when:

✅ **Quick clarification needed** - Simple tasks
✅ **Single file changes** - Clear scope
✅ **No codebase analysis needed** - You have context
✅ **Well-defined request** - Just needs structuring

### Use `/prompt-hybrid` instead when:

❌ **Complex task** - Multi-file, patterns
❌ **Need codebase analysis** - Pattern detection
❌ **Feasibility check required** - Technical validation
❌ **Uncertain scope** - Let agent explore

## Tips for Best Results

1. **Be specific** - Include what you know
2. **Answer questions** - Phase 0 asks for a reason
3. **Review carefully** - Check the perfected prompt
4. **Use modifications** - `modify [change]` to refine
5. **Chain commands** - Use `/prompt-technical` after for implementation

## Output Structure

All perfected prompts include:

```markdown
Goal: [Clear, one-sentence objective]

Context:
- Environment: [OS, platform]
- Tech Stack: [Languages, frameworks]
- Background: [Relevant history]

Scope:
- Files to modify: [List]
- Files to create: [List]
- Components affected: [List]

Requirements:
1. [Specific requirement]
2. [Another requirement]
...

Constraints:
- [Limitation 1]
- [Limitation 2]

Expected Result:
[Definition of success]
```

## Next Steps

- [Try /prompt-hybrid for complex tasks](/guide/commands/prompt-hybrid)
- [Use /prompt-technical for implementation](/guide/commands/prompt-technical)
- [Learn about Phase 0 library](/guide/architecture/library-system)
