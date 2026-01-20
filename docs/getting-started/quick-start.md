# Quick Start

Get productive with Claude Commands Library in 5 minutes.

## Your First Commands

After [installation](/getting-started/installation), try these commands:

### 1. Basic Prompt Perfection

```bash
/prompt Fix the login bug that shows error on empty password
```

Claude will:
1. Detect this is a bug fix request
2. Check if you've specified the file location
3. Ask clarifying questions if needed
4. Structure the request clearly
5. Wait for your approval

### 2. Technical Implementation

```bash
/prompt-technical Add Redis caching to the user service
```

Claude will:
1. Scan your project structure
2. Detect your tech stack (Node.js, Python, etc.)
3. Find existing caching patterns
4. Present 2-3 implementation options
5. Generate code matching your conventions

### 3. Session Management

```bash
# At the start of your work
/session-start

# At the end of your work
/session-end
```

This preserves your context between sessions - decisions made, files changed, and work in progress.

## Command Reference

| Command | Use When | Speed |
|---------|----------|-------|
| `/prompt` | Quick fixes, simple questions | ~2s |
| `/prompt-hybrid` | Complex tasks needing codebase context | 2-30s |
| `/prompt-technical` | New features, refactoring | 5-30s |
| `/prompt-research` | Security audits, architecture review | 60-180s |
| `/prompt-article` | Writing blog posts, documentation | Interactive |
| `/prompt-article-readme` | Generating README files | ~30s |
| `/session-start` | Beginning your work session | ~2s |
| `/session-end` | Ending your work session | ~5s |
| `/reflect` | Improving a command from feedback | 5-15s |

## Decision Tree

**"I have a vague idea..."**
```bash
/prompt Fix the bug in authentication
```

**"I need to implement something..."**
```bash
/prompt-technical Add password reset functionality
```

**"I need deep analysis..."**
```bash
/prompt-research Analyze authentication for security vulnerabilities
```

**"I want to write content..."**
```bash
/prompt-article Write about CI/CD best practices
```

## Example: Complete Workflow

Here's a realistic workflow for adding a feature:

```bash
# 1. Start your session
/session-start

# Claude loads previous context: "You were working on the user
# authentication feature. Files modified: auth.js, user.model.js"

# 2. Perfect your prompt
/prompt-hybrid Add two-factor authentication

# Claude detects complexity: 12 (cross-cutting concern)
# Spawns Explore Agent to find existing auth patterns
# Returns structured prompt with implementation options

# 3. Get technical analysis
/prompt-technical

# Claude provides:
# - 3 implementation options (SMS, TOTP, Email)
# - Pros/cons of each
# - Best practices checklist
# - Code scaffolding matching your patterns

# 4. Implement (follow Claude's plan)
# ... your work here ...

# 5. Save your session
/session-end

# Claude captures:
# - Decisions: "Chose TOTP over SMS for security"
# - Files changed: auth.js, 2fa.service.js, user.model.js
# - Work in progress: "2FA implementation complete, needs testing"
```

## Understanding Complexity Scores

The library scores your prompts for complexity:

### Simple (0-4 points)
- Single file changes
- Clear, specific request
- No pattern matching needed

```bash
# Example: Score 2
/prompt Add a console.log to debug the API response
```

### Moderate (5-9 points)
- Multiple files involved
- Pattern detection helpful
- Claude asks if you want agent help

```bash
# Example: Score 7
/prompt Add input validation to all form fields
```

### Complex (10-19 points)
- Cross-cutting concerns
- Architecture decisions
- Agent spawns automatically

```bash
# Example: Score 14
/prompt Implement rate limiting across all API endpoints
```

### Research (20+ points)
- Multi-agent deep analysis
- Comprehensive reports
- Takes 1-3 minutes

```bash
# Example: Score 25
/prompt-research Perform OWASP security audit of payment processing
```

## Tips for Best Results

### Be Specific
```bash
# Less effective
/prompt Fix the bug

# More effective
/prompt Fix the login bug that shows "undefined" when password is empty
```

### Provide Context
```bash
# Less effective
/prompt Add caching

# More effective
/prompt Add Redis caching to UserService.getById() which is called 100+ times per second
```

### Answer Questions
When Claude asks clarifying questions, answer them. Each question prevents potential misimplementation.

### Use the Right Command
- Use `/prompt` for quick fixes
- Use `/prompt-technical` for implementation work
- Use `/prompt-research` for deep analysis

### Trust the System
If complexity detection says you need an agent, let it spawn one. The 20-second investment saves hours of rework.

## What's Next?

Ready to go deeper?

- [Your First Prompt](/getting-started/first-prompt) - Detailed walkthrough
- [Commands Reference](/commands/) - All commands explained
- [Architecture](/architecture/) - How it all works
- [Best Practices](/reference/best-practices) - Expert tips
