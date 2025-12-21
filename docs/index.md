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
  - icon: ⚡
    title: Prompt Perfection
    details: Analyze and refine any prompt to be clear and unambiguous with Phase 0 validation flow

  - icon: 🤖
    title: Intelligent Agent Assistance
    details: Automatic codebase analysis for complex tasks with smart complexity detection

  - icon: 🔍
    title: Multi-Agent Verification
    details: Cross-validate critical operations with 3 agents running in parallel

  - icon: ⚡
    title: Agent Result Caching
    details: 10-20x faster for repeated prompts with intelligent cache invalidation

  - icon: 📚
    title: Learning System
    details: Tracks patterns and suggests smart defaults after 3+ occurrences

  - icon: 🔧
    title: Technical Analysis
    details: Deep dive into implementation options with code scaffolding

  - icon: 📝
    title: Article Generation
    details: Interactive wizard for multi-platform content creation

  - icon: 💾
    title: Session Management
    details: Save and load work context across sessions with zero information loss
---

## Quick Start

```bash
# Simple prompt perfection
/prompt Fix the login bug in my app

# Intelligent prompt perfection with agent support
/prompt-hybrid Implement payment processing following existing patterns

# Technical implementation analysis
/prompt-technical Add caching layer with Redis

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

## What's New in v2.0

Version 2.0 introduces a **unified library system** that dramatically improves maintainability:

- ✅ **Eliminated Code Duplication** - ~500 lines of duplicate Phase 0 logic removed
- ✅ **Single Source of Truth** - All commands reference canonical library
- ✅ **Better Maintainability** - Update once, all commands benefit
- ✅ **Enhanced Documentation** - Comprehensive guides and references

[Learn more about v2.0 →](/migration/v2-migration)

## Commands Overview

| Command | Purpose | Time | Complexity |
|---------|---------|------|------------|
| `/prompt` | Basic prompt perfection | ~2s | Simple |
| `/prompt-hybrid` | Intelligent with agent support | 2-50s | Advanced |
| `/prompt-technical` | Implementation analysis | 5-30s | Advanced |
| `/prompt-article` | Interactive article wizard | 2-5min | Medium |
| `/prompt-article-readme` | README generator | 10-30s | Medium |
| `/session-start` | Load session context | 2-5s | Simple |
| `/session-end` | Save session context | 5-10s | Simple |

## Get Started

Ready to transform your prompts? [Install the library →](/getting-started/installation)
