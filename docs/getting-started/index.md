# Introduction

Claude Commands Library is a collection of slash commands for Claude Code that transform how you write prompts. Instead of hoping Claude understands your intent, every prompt goes through a validation process that ensures clarity before execution.

## Why Use This Library?

### The Traditional Approach

```
You: "Add authentication to my app"
Claude: *implements basic username/password*
You: "No, I meant OAuth with Google"
Claude: *refactors to OAuth*
You: "And I need JWT tokens for the API"
Claude: *adds JWT layer*
```

**Result:** 3 rounds of back-and-forth, wasted tokens, fragmented implementation.

### The Claude Commands Approach

```
You: /prompt-technical Add authentication to my app

Claude: Before I implement, let me clarify:

1. Which authentication method?
   - Option A: OAuth (Google, GitHub, Microsoft)
   - Option B: JWT with username/password
   - Option C: Session-based with cookies
   Recommended: Option A for user convenience

2. Which providers should I support?
   - Google (most common)
   - GitHub (developer audience)
   - Microsoft (enterprise)

3. Where should I store user data?
   - Your existing Users table
   - New OAuth-specific tables

You: A, Google only, existing Users table

Claude: *implements exactly what you need, first time*
```

**Result:** One clear conversation, precise implementation.

## Core Concepts

### Phase 0: Prompt Perfection

Every command begins with **Phase 0** - a validation process that:

1. **Detects** what you're asking (task, question, bug fix, etc.)
2. **Checks** for missing information using 6 criteria
3. **Asks** clarifying questions before proceeding
4. **Structures** your request into an unambiguous format
5. **Waits** for your approval

[Learn more about Phase 0 →](/architecture/phase-0)

### Complexity Detection

Not every task needs deep analysis. The library automatically scores complexity:

| Score | Category | Action |
|-------|----------|--------|
| 0-4 | Simple | Fast inline validation |
| 5-9 | Moderate | Asks if you want agent help |
| 10-19 | Complex | Spawns Explore Agent automatically |
| 20+ | Research | Multi-agent deep analysis |

### Agent Types

When complexity warrants it, specialized agents help:

- **Explore Agent** - Scans your codebase for patterns and conventions
- **Plan Agent** - Creates implementation strategies
- **Security Agent** - Checks for OWASP vulnerabilities
- **Performance Agent** - Identifies bottlenecks
- **Pattern Agent** - Ensures consistency with existing code

## What You'll Learn

This documentation covers:

1. **[Installation](/getting-started/installation)** - Get set up in 2 minutes
2. **[Quick Start](/getting-started/quick-start)** - Your first commands
3. **[Your First Prompt](/getting-started/first-prompt)** - Detailed walkthrough
4. **[Commands](/commands/)** - Complete command reference
5. **[Architecture](/architecture/)** - How everything works
6. **[Best Practices](/reference/best-practices)** - Get the most from the library

## Requirements

- [Claude Code CLI](https://claude.ai/code) installed
- Windows 10/11 or compatible PowerShell environment
- Git (for installation)

## Next Steps

Ready to get started?

::: tip Recommended Path
1. [Install the library](/getting-started/installation) (2 minutes)
2. [Try the quick start](/getting-started/quick-start) (5 minutes)
3. [Build your first perfect prompt](/getting-started/first-prompt) (10 minutes)
:::

[Begin Installation →](/getting-started/installation)
