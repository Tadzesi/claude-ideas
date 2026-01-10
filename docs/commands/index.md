# Commands Overview

Claude Commands Library provides 10 slash commands organized into four categories.

## Quick Reference

| Command | Purpose | Speed | Complexity |
|---------|---------|-------|------------|
| [/prompt](/commands/prompt) | Basic prompt perfection | ~2s | Simple |
| [/prompt-hybrid](/commands/prompt-hybrid) | Intelligent with agents | 2-30s | Advanced |
| [/prompt-technical](/commands/prompt-technical) | Implementation analysis | 5-30s | Advanced |
| [/prompt-research](/commands/prompt-research) | Multi-agent research | 60-180s | Expert |
| [/prompt-article](/commands/prompt-article) | Article writing | Interactive | Medium |
| [/prompt-article-readme](/commands/prompt-article-readme) | README generation | ~30s | Medium |
| [/session-start](/commands/session-start) | Load session context | ~2s | Simple |
| [/session-end](/commands/session-end) | Save session context | ~5s | Simple |
| [/reflect](/commands/reflect) | Improve skills | 5-15s | Medium |

## Categories

### Prompt Engineering

Commands for transforming ideas into precise, executable prompts.

**[/prompt](/commands/prompt)** - Fast prompt perfection
```bash
/prompt Fix the login bug showing null error
```
Best for: Quick fixes, simple questions, single-file changes.

**[/prompt-hybrid](/commands/prompt-hybrid)** - Intelligent prompt perfection
```bash
/prompt-hybrid Add authentication following existing patterns
```
Best for: Complex tasks, multi-file changes, pattern detection.

**[/prompt-technical](/commands/prompt-technical)** - Technical implementation
```bash
/prompt-technical Implement Redis caching for user queries
```
Best for: New features, refactoring, architecture decisions.

**[/prompt-research](/commands/prompt-research)** - Deep analysis
```bash
/prompt-research Perform security audit of payment system
```
Best for: Security audits, performance analysis, architecture review.

### Content Creation

Commands for generating written content.

**[/prompt-article](/commands/prompt-article)** - Article wizard
```bash
/prompt-article Write about CI/CD best practices
```
Interactive wizard for blog posts, Medium articles, LinkedIn content.

**[/prompt-article-readme](/commands/prompt-article-readme)** - README generator
```bash
/prompt-article-readme
```
Analyzes project and generates comprehensive README.

### Session Management

Commands for preserving context between work sessions.

**[/session-start](/commands/session-start)** - Load context
```bash
/session-start
```
Loads previous session context including decisions, changes, and work in progress.

**[/session-end](/commands/session-end)** - Save context
```bash
/session-end
```
Saves comprehensive session context for continuity.

### Utility

Commands for system improvement.

**[/reflect](/commands/reflect)** - Skill improvement
```bash
/reflect prompt-technical
```
Analyzes session and proposes improvements based on corrections and preferences.

## How Commands Work

### Phase 0: Every Command Starts Here

All prompt commands run Phase 0 validation:

```
Step 0.1: Initial Analysis
- Detect language (English, Slovak, etc.)
- Identify prompt type (Task, Question, Bug Fix, etc.)
- Extract core intent

Step 0.2: Completeness Check
- Goal: What do you want to achieve?
- Context: What's the current state?
- Scope: What files/components are involved?
- Requirements: What specific needs exist?
- Constraints: What limitations apply?
- Expected Result: How will you know it's done?

Step 0.3: Clarification Questions
- Ask about missing information
- Present options where needed
- Prioritize by criticality

Step 0.4: Perfect the Prompt
- Structure into clear format
- Add detected context
- Include constraints

Step 0.5: Approval Gate
- Show perfected prompt
- Wait for user confirmation
- Allow modifications
```

### Complexity Detection

Commands with hybrid intelligence score your prompt:

| Score | Category | What Happens |
|-------|----------|--------------|
| 0-4 | Simple | Fast inline validation only |
| 5-9 | Moderate | Claude asks if you want agent help |
| 10-19 | Complex | Agent spawns automatically |
| 20+ | Research | Multi-agent deep analysis |

### Agent Types

When complexity warrants, specialized agents help:

- **Explore Agent** (Haiku, 30s) - Scans codebase for patterns
- **Plan Agent** (Sonnet, 60s) - Creates implementation strategies
- **Security Agent** (Sonnet, 45s) - Checks for vulnerabilities
- **Performance Agent** (Sonnet, 45s) - Identifies bottlenecks
- **Pattern Agent** (Haiku, 30s) - Ensures consistency

## Choosing the Right Command

### Decision Flow

```
┌─────────────────────────────────────────┐
│ What do you need?                       │
└─────────────────────────────────────────┘
          │
    ┌─────┴─────┐
    ▼           ▼
┌───────┐   ┌─────────┐
│ Code  │   │ Content │
└───────┘   └─────────┘
    │           │
    │      ┌────┴────┐
    │      ▼         ▼
    │  ┌───────┐ ┌────────┐
    │  │Article│ │ README │
    │  └───────┘ └────────┘
    │      │         │
    │      ▼         ▼
    │  /prompt   /prompt-
    │  -article  article-
    │            readme
    │
    ├─── Simple fix? ───────► /prompt
    │
    ├─── Need codebase ─────► /prompt-hybrid
    │    context?
    │
    ├─── Implementation ────► /prompt-technical
    │    planning?
    │
    └─── Deep analysis? ────► /prompt-research
```

### By Use Case

| Use Case | Command |
|----------|---------|
| Fix a bug | `/prompt` |
| Add a small feature | `/prompt` or `/prompt-hybrid` |
| Add a complex feature | `/prompt-technical` |
| Refactor code | `/prompt-technical` |
| Security audit | `/prompt-research` |
| Performance optimization | `/prompt-research` |
| Architecture review | `/prompt-research` |
| Write documentation | `/prompt-article` |
| Generate README | `/prompt-article-readme` |
| Start work session | `/session-start` |
| End work session | `/session-end` |
| Improve a command | `/reflect` |

## Next Steps

- [Learn /prompt](/commands/prompt) - The foundation
- [Learn /prompt-technical](/commands/prompt-technical) - For implementation
- [Understand the architecture](/architecture/) - How it all works
