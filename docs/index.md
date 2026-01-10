---
layout: home

hero:
  name: Claude Commands Library
  text: Transform Ideas into Precise Prompts
  tagline: Stop guessing. Start executing. Intelligent prompt engineering for Claude Code.
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
    title: Zero-Ambiguity Prompts
    details: Every prompt goes through Phase 0 validation - detecting missing information, asking clarifying questions, and structuring requests before execution.
    link: /architecture/phase-0
    linkText: Learn about Phase 0

  - icon: 🤖
    title: Intelligent Agent Assistance
    details: Complex tasks automatically spawn specialized agents for codebase exploration, pattern detection, and implementation planning.
    link: /architecture/hybrid-intelligence
    linkText: Explore Hybrid Intelligence

  - icon: 🔮
    title: Predictive Intelligence
    details: See problems before they happen. Proactive warnings, domain risk analysis, and next-steps prediction guide your development.
    link: /architecture/predictive-intelligence
    linkText: Discover Predictions

  - icon: 📊
    title: Enhanced Statusline
    details: Real-time context tracking with visual progress bars, token usage, and API duration monitoring directly in your terminal.
    link: /architecture/statusline
    linkText: Setup Statusline

  - icon: 🔬
    title: Multi-Agent Research
    details: Deep codebase analysis with 2-5 specialized agents working in parallel, iterative refinement, and comprehensive reports.
    link: /architecture/multi-agent
    linkText: Research System

  - icon: 📚
    title: Learning System
    details: The library learns from your patterns, suggests smart defaults, and actively improves skills through the /reflect command.
    link: /architecture/learning
    linkText: See Learning
---

## The Problem

You write a prompt. Claude guesses what you meant. You get something close but not quite right. You clarify. Claude tries again. Repeat.

**This wastes time and tokens.**

## The Solution

Claude Commands Library ensures every prompt is **perfect before execution**:

```bash
# Before: Vague prompt leads to wrong implementation
"Add login to my app"

# After: Phase 0 asks what you actually need
/prompt-technical Add login to my app

# Claude asks:
# - Which authentication method? (JWT / OAuth / Session)
# - Which database stores users?
# - What UI framework for the login form?
# - Should I add password reset functionality?

# Result: Precise implementation matching your exact needs
```

## Quick Start

### 1. Install

```powershell
# Download and run installer
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-commands.ps1" -OutFile "install.ps1"
.\install.ps1
```

### 2. Use Commands

```bash
# Perfect any prompt (2 seconds)
/prompt Fix the authentication bug

# Technical analysis with agent assistance (5-30 seconds)
/prompt-technical Implement caching with Redis

# Deep multi-agent research (1-3 minutes)
/prompt-research Perform security audit of payment system

# Save your work
/session-end
```

### 3. Track Progress

Install the [Enhanced Statusline](/architecture/statusline) to see real-time metrics:

```
■ my-project | ⎇ main | ████████░░ 45% | ● 27k/155k | ▶ 89k/15k | ◆ 3.2s
```

## Command Overview

| Command | Purpose | Speed | When to Use |
|---------|---------|-------|-------------|
| `/prompt` | Basic prompt perfection | ~2s | Quick fixes, simple tasks |
| `/prompt-hybrid` | Intelligent with agents | 2-30s | Complex tasks, codebase changes |
| `/prompt-technical` | Implementation analysis | 5-30s | New features, refactoring |
| `/prompt-research` | Deep multi-agent research | 60-180s | Security audits, architecture review |
| `/prompt-article` | Article writing wizard | Interactive | Blog posts, documentation |
| `/session-start` | Load previous context | ~2s | Beginning of session |
| `/session-end` | Save current context | ~5s | End of session |
| `/reflect` | Improve skills from feedback | 5-15s | After using a command |

## How It Works

### Phase 0: Prompt Perfection

Every command runs your prompt through validation:

1. **Detect** - Language, type, and intent
2. **Check** - 6 completeness criteria (Goal, Context, Scope, Requirements, Constraints, Expected Result)
3. **Ask** - Clarifying questions for missing information
4. **Structure** - Transform into executable format
5. **Approve** - Wait for your confirmation

### Hybrid Intelligence

Tasks are scored for complexity (0-50+):

- **Simple (0-4)**: Fast inline validation
- **Moderate (5-9)**: Optional agent assistance
- **Complex (10-19)**: Automatic agent exploration
- **Research (20+)**: Multi-agent deep analysis

### Continuous Learning

The system tracks:

- Successful transformations
- Your modification patterns
- Common missing information
- Agent effectiveness

After 3+ occurrences, it suggests smart defaults.

## What's New

### v4.1 - Skill Reflection

```bash
/reflect prompt-technical
```

Analyzes your session and proposes improvements to commands based on corrections, successes, and preferences.

### v4.0 - Predictive Intelligence

- Journey stage detection (exploring → implementing → debugging)
- Proactive warnings before you make mistakes
- Domain risk analysis (security, payment, performance)

### v3.0 - Multi-Agent Research

- 2-5 specialized agents in parallel
- Iterative refinement with gap detection
- Comprehensive reports with file:line citations

## Ready to Start?

<div class="custom-block tip">
  <p><strong>New to Claude Commands?</strong></p>
  <p>Follow the <a href="/getting-started/">Getting Started Guide</a> for a complete walkthrough.</p>
</div>

[Install Now →](/getting-started/installation) | [Browse Commands →](/commands/) | [Understand Architecture →](/architecture/)
