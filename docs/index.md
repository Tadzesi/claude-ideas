---
layout: home

hero:
  name: Claude Commands Library
  text: Three Commands for Better Prompts
  tagline: Prompt analysis, README generation, and deep codebase research — for Claude Code.
  image:
    src: /logo.svg
    alt: Claude Commands Library
  actions:
    - theme: brand
      text: Get Started
      link: /getting-started/
    - theme: alt
      text: View Commands
      link: /commands/
    - theme: alt
      text: GitHub
      link: https://github.com/Tadzesi/claude-ideas

features:
  - icon: 🎯
    title: /prompt
    details: Analyses any prompt, asks targeted clarifying questions, and rewrites it into a structured executable form — Goal, Context, Scope, Requirements, Constraints, Expected Result.
    link: /commands/prompt
    linkText: Learn about /prompt

  - icon: 📄
    title: /prompt-article-readme
    details: Scans your project's structure and config files, then generates or updates a README.md matched to the detected stack and conventions.
    link: /commands/prompt-article-readme
    linkText: Learn about /prompt-article-readme

  - icon: 🔬
    title: /prompt-research
    details: Multi-step research workflow for unfamiliar codebases. Spawns parallel exploration agents, iterates on findings, and produces a single consolidated report with file-line citations.
    link: /commands/prompt-research
    linkText: Learn about /prompt-research

  - icon: 🧠
    title: Phase 0 — Prompt Perfection
    details: Every command begins with Phase 0 — a shared validation layer that detects intent, checks completeness, asks only the questions it cannot answer from memory, and structures the result.
    link: /architecture/phase-0
    linkText: How Phase 0 Works

  - icon: 🗣️
    title: Interaction Protocol
    details: Plan-first execution, SK/EN language rules, proactive option-finding, and never-auto-execute — enforced globally in every session via CLAUDE.md.
    link: /guide/interaction-protocol
    linkText: Read the Protocol

  - icon: 🎓
    title: Skills Format
    details: Commands use native Claude Code Skills format with YAML frontmatter. Claude auto-suggests the right skill based on your request description.
    link: /architecture/skills-format
    linkText: Skills Format Guide
---

## The Problem

You write a prompt. Claude guesses what you meant. You get something close but not quite right. You clarify. Claude tries again. Repeat.

**This wastes time and tokens.**

## The Solution

Three commands that enforce clarity before execution:

```bash
# Before: vague prompt leads to wrong implementation
"Add login to my app"

# After: /prompt asks what you actually need
/prompt Add login to my app

# Claude asks:
# - Which authentication method? (JWT / OAuth / Session)
# - Which database stores users?
# - Should I add password reset?

# Result: structured prompt you can hand to Claude for precise implementation
```

## Quick Start

### 1. Install

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-commands.ps1" -OutFile "install.ps1"
.\install.ps1
```

### 2. Use Commands

```bash
# Rewrite a vague prompt into a structured one
/prompt Fix the authentication bug in my API

# Generate or update README from your project structure
/prompt-article-readme

# Deep multi-agent research of an unfamiliar codebase
/prompt-research Understand the payment processing flow
```

## Command Overview

| Command | Purpose | When to Use |
|---------|---------|-------------|
| `/prompt` | Prompt analysis and structured rewrite | Any time a task description is vague or incomplete |
| `/prompt-article-readme` | README generator from project scan | New project, stale docs, or after major refactor |
| `/prompt-research` | Multi-agent codebase research | Unfamiliar codebase, architecture audit, security review |

## How It Works

### Phase 0: Prompt Perfection

Every command runs your input through a shared validation layer:

1. **Recall** — load known facts from project memory
2. **Detect** — language, type, and intent
3. **Check** — completeness criteria, pre-filling from memory
4. **Ask** — only truly unknown information
5. **Structure** — transform into executable format
6. **Approve** — wait for your confirmation

### /prompt-research: Multi-Agent Workflow

For deep research, the command spawns parallel specialist agents:

- **Explore Agent** — maps files, dependencies, entry points
- **Pattern Agent** — detects conventions and anti-patterns
- **Security Agent** — flags vulnerabilities and risks
- **Performance Agent** — identifies bottlenecks
- **Citation Agent** — grounds every finding to a source file

Results are aggregated across 2-4 iterations until gaps are resolved.

## What's New

### v5.0 — Honest 3-Command Portfolio (May 2026)

Reduced from eleven commands to three. Removed everything that was aspirational rather than functional.

**Removed:** `/prompt-hybrid`, `/prompt-technical`, `/prompt-article`, `/prompt-dotnet`, `/prompt-react`, `/deploy`, `/new-stack`, `/reflect`

**Library flattened** — no more `adapters/`, `intelligence/`, `agents/`, `orchestration/` subdirectories. All files at `library/` root.

**Skills-only format** — all three commands live in `.claude/skills/` with YAML frontmatter. The legacy `.claude/commands/` directory is gone.

[See full changelog →](/reference/changelog)

### v4.8 — Interaction Protocol

Plan-first discipline promoted to a global session protocol loaded from `CLAUDE.md`. Applies to every interaction, not only slash commands.

- Plan-First: understanding + 2-3 options + execution plan + explicit approval
- Never Auto-Execute: no git/install/build without consent
- Language: SK in / EN internal / SK out

[Read the full protocol →](/guide/interaction-protocol)

## Ready to Start?

[Install Now →](/getting-started/installation) | [Browse Commands →](/commands/) | [Architecture →](/architecture/)
