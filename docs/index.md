---
layout: home

hero:
  name: Claude Commands Library
  text: Transform Ideas into Precise Prompts
  tagline: Intelligent prompt engineering with agent assistance, caching, and learning for Claude Code
  image:
    src: /logo.svg
    alt: Claude Commands Library
  actions:
    - theme: brand
      text: Get Started
      link: /getting-started/
    - theme: alt
      text: View on GitHub
      link: https://github.com/Tadzesi/claude-ideas

features:
  - icon: 🔄
    title: Skill Reflection
    details: NEW v4.1 - Actively improve skills from conversation feedback. Detect corrections, successes, and preferences to propose changes.

  - icon: 🔮
    title: Predictive Intelligence
    details: v4.0 - See 2 steps ahead with proactive guidance, warnings, and next-steps prediction. Prevent problems BEFORE coding starts.

  - icon: ⚠️
    title: Proactive Warnings
    details: Domain risk analysis across authentication, payment, database, API, security, and performance. Critical warnings before you code.

  - icon: 📐
    title: Pattern Recognition
    details: Auto-detect project naming conventions, architectural patterns, and identify inconsistencies automatically.

  - icon: 🔬
    title: Multi-Agent Research System
    details: v3.0 - Deep codebase research with 2-5 specialized agents, iterative refinement, and persistent knowledge graph

  - icon: ⚡
    title: Prompt Perfection
    details: Analyze and refine any prompt to be clear and unambiguous with Phase 0 validation flow

  - icon: 🤖
    title: Intelligent Agent Assistance
    details: Automatic codebase analysis for complex tasks with smart complexity detection

  - icon: 🔍
    title: Multi-Agent Verification
    details: Cross-validate critical operations with 3 agents running in parallel

  - icon: 📚
    title: Learning System
    details: Tracks patterns, suggests smart defaults, and now actively improves skills with /reflect
---

## Quick Start

```bash
# Simple prompt perfection with LITE predictive intelligence
/prompt Fix the login bug in my app

# Intelligent prompt perfection with FULL predictive intelligence
/prompt-hybrid Implement payment processing following existing patterns

# Deep multi-agent research with predictive scoping
/prompt-research Perform comprehensive security audit

# Technical implementation with FULL predictive intelligence
/prompt-technical Add caching layer with Redis

# Skill reflection - improve skills from feedback (NEW v4.1)
/reflect prompt-hybrid

# Create an article
/prompt-article Write about CI/CD pipelines

# Generate README
/prompt-article-readme

# Session management
/session-start    # Load previous context
/session-end      # Save current work
```

## Why Claude Commands Library?

### 🎯 Zero-Guessing Execution

Every prompt is analyzed, clarified, and perfected before execution. No more ambiguous requests that lead to wrong implementations.

### 🚀 Smart Complexity Detection

Automatically detects when tasks need deep codebase analysis and spawns intelligent agents only when necessary.

### ⚡ Performance Optimized

Agent result caching provides 10-20x speed improvement for repeated or similar prompts.

### 📚 Continuous Learning

The system learns from your patterns and suggests smart defaults, improving over time.

## What's New in v4.1 🔄

Version 4.1 introduces **Skill Reflection** - actively improve skills from conversation feedback:

- 🔄 **NEW: `/reflect` Command** - Analyze sessions and propose skill improvements
- 🎯 **Signal Detection** - Detect corrections, successes, edge cases, and preferences
- 📊 **Priority Classification** - HIGH/MED/LOW coded change proposals
- ✏️ **Direct Modifications** - Apply changes to skill files with user approval
- 💾 **Observation Persistence** - Save declined changes for later review

**Before v4.1:** Passive pattern tracking
**After v4.1:** Active skill improvement from feedback

[Read v4.1 Release Notes →](https://github.com/Tadzesi/claude-ideas/blob/main/.claude/docs/v4.1-RELEASE-NOTES.md) | [Learn about /reflect →](/guide/commands/reflect)

### What Was New in v4.0 🔮

Version 4.0 introduced **Predictive Intelligence** - see 2 steps ahead with proactive guidance:

- 🔮 **Phase 0.15 Predictive Intelligence** - Journey stage detection, proactive warnings, next-steps prediction
- ⚠️ **Domain Risk Analysis** - 20+ risks across 6 domains (auth, payment, database, API, security, performance)
- 📐 **Pattern Recognition** - Auto-detect naming conventions and architectural patterns

[Read v4.0 Release Notes →](https://github.com/Tadzesi/claude-ideas/blob/main/.claude/docs/v4.0-RELEASE-NOTES.md)

### What Was New in v3.0 🔬

Version 3.0 introduced the **Multi-Agent Research System** for enterprise-grade codebase analysis:

- 🔬 **`/prompt-research` Command** - Deep multi-agent research with 2-5 specialized agents
- 🔄 **Iterative Refinement** - 2-4 iteration cycles with intelligent gap detection
- 📍 **Source Attribution** - Every finding includes file:line citations with code snippets

[Learn more about /prompt-research →](/guide/commands/prompt-research)

## Commands Overview

| Command | Purpose | Time | Complexity |
|---------|---------|------|------------|
| `/prompt` | Basic perfection + LITE predictive intelligence | ~2s | Simple |
| `/prompt-hybrid` | Intelligent with FULL predictive intelligence | 2-50s | Advanced |
| `/prompt-research` | Deep multi-agent research with predictive scoping | 60-180s | Expert |
| `/prompt-technical` | Implementation analysis + FULL predictive intelligence | 5-30s | Advanced |
| `/prompt-article` | Interactive article wizard | 2-5min | Medium |
| `/prompt-article-readme` | README generator | 10-30s | Medium |
| `/reflect` | Skill reflection and improvement 🔄 NEW | 5-15s | Medium |
| `/session-start` | Load session context | 2-5s | Simple |
| `/session-end` | Save session context | 5-10s | Simple |

## Get Started

Ready to transform your prompts? [Install the library →](/getting-started/installation)
