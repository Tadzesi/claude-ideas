# Introduction

Claude Commands Library is a collection of three slash commands for Claude Code that improve how you write prompts and research codebases.

## Why Use This Library?

### Without it

```
You: "Add authentication to my app"
Claude: *implements basic username/password*
You: "No, I meant OAuth with Google"
Claude: *refactors to OAuth*
You: "And I need JWT tokens for the API"
Claude: *adds JWT layer*
```

**Result:** 3 rounds of back-and-forth, wasted tokens, fragmented implementation.

### With /prompt

```
You: /prompt Add authentication to my app

Claude: Before you proceed, let me clarify:

1. Which authentication method?
   - Option A: OAuth (Google, GitHub, Microsoft)
   - Option B: JWT with username/password
   - Option C: Session-based with cookies

2. Which providers should you support?

3. Where should user data be stored?
   - Your existing Users table
   - New OAuth-specific tables

You: OAuth, Google only, existing Users table

→ Structured prompt ready. Hand it to Claude for precise implementation.
```

**Result:** One clear conversation. Correct implementation on the first attempt.

## The Three Commands

**[/prompt](/commands/prompt)** — Analyses any prompt, asks targeted questions, and rewrites it into a structured executable form.

**[/prompt-article-readme](/commands/prompt-article-readme)** — Scans your project and generates or updates `README.md` matched to the detected stack.

**[/prompt-research](/commands/prompt-research)** — Multi-step research for unfamiliar codebases. Spawns parallel agents, iterates on findings, produces a cited report.

## Core Concept: Phase 0

Every command begins with **Phase 0** — a shared validation layer that:

1. **Detects** what you're asking (task, question, bug fix, etc.)
2. **Recalls** known facts from project memory
3. **Checks** for missing information
4. **Asks** only genuinely unknown questions
5. **Structures** the result into a clear format
6. **Waits** for your approval

[Learn more about Phase 0 →](/architecture/phase-0)

## What You'll Learn

1. **[Installation](/getting-started/installation)** — get set up in 2 minutes
2. **[Quick Start](/getting-started/quick-start)** — your first commands
3. **[Your First Prompt](/getting-started/first-prompt)** — detailed walkthrough
4. **[Commands](/commands/)** — complete command reference
5. **[Architecture](/architecture/)** — how everything works

## Requirements

- [Claude Code CLI](https://claude.ai/code) installed
- Windows 10/11 (PowerShell installer); `.claude/` directory is OS-agnostic
- Git

::: tip Recommended Path
1. [Install the library](/getting-started/installation) (2 minutes)
2. [Try the quick start](/getting-started/quick-start) (5 minutes)
3. [Build your first perfect prompt](/getting-started/first-prompt) (10 minutes)
:::

[Begin Installation →](/getting-started/installation)
