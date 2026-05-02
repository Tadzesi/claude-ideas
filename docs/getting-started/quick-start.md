# Quick Start

Get productive with Claude Commands Library in 5 minutes.

## Your First Commands

After [installation](/getting-started/installation), try these three commands:

### 1. Rewrite a vague prompt

```bash
/prompt Fix the login bug that shows error on empty password
```

Claude will:
1. Detect this is a bug fix request
2. Check what information is missing (file location, error message, expected behaviour)
3. Ask only the questions it cannot answer from memory
4. Structure the request into Goal / Context / Scope / Requirements / Expected Result
5. Wait for your approval before proceeding

### 2. Generate a README

```bash
/prompt-article-readme
```

Claude will:
1. Scan your project structure, `package.json` / `.csproj` / `Dockerfile`
2. Detect your stack and conventions
3. Generate a `README.md` matching what it found — no guessing

### 3. Research an unfamiliar codebase

```bash
/prompt-research Understand how authentication works and identify security risks
```

Claude will:
1. Spawn 2–5 specialist agents in parallel (Explore, Pattern, Security, Performance, Citation)
2. Run 2–4 iteration cycles, resolving gaps between rounds
3. Produce a consolidated report with `file:line` citations

## Command Reference

| Command | Use When |
|---------|----------|
| `/prompt` | Any vague or incomplete task description |
| `/prompt-article-readme` | Generating or updating a README |
| `/prompt-research` | Deep analysis of a codebase you don't know |

## Decision Guide

**"I want to write a clearer prompt before I ask Claude to do something..."**
```bash
/prompt Refactor the UserService to use repository pattern
```

**"My README is outdated or missing..."**
```bash
/prompt-article-readme
```

**"I'm joining a new project and need to understand how it works..."**
```bash
/prompt-research Map the architecture and identify the main data flows
```

**"I need a security audit before shipping..."**
```bash
/prompt-research Perform OWASP review of the payment processing module
```

## Tips for Best Results

**Be specific:**
```bash
# Less effective
/prompt Fix the bug

# More effective
/prompt Fix the login bug that returns "undefined" when password is empty in LoginController.cs
```

**Answer clarifying questions fully** — each question prevents misimplementation. If Claude asks which auth method, saying "JWT" saves a refactor.

**For /prompt-research — give a focused goal.** "Understand everything" produces shallow results. "Understand the payment flow and identify race conditions" produces deep ones.

## What's Next?

- [Your First Prompt](/getting-started/first-prompt) — detailed walkthrough
- [Commands Reference](/commands/) — all three commands explained
- [Architecture](/architecture/) — how Phase 0 and multi-agent research work
- [Best Practices](/reference/best-practices) — tips from real use
