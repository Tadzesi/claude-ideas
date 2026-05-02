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
  - icon: 🤝
    title: AI Fluency Framework
    details: Aligned with Anthropic's 4Ds model - Delegation, Description, Discernment, Diligence. Explicit human vs AI task distribution.
    link: /architecture/ai-fluency
    linkText: Learn about AI Fluency

  - icon: 🎯
    title: Zero-Ambiguity Prompts
    details: Every prompt goes through Phase 0 validation with 9 criteria - detecting missing information, asking clarifying questions, and structuring requests.
    link: /architecture/phase-0
    linkText: Learn about Phase 0

  - icon: 🔬
    title: Multi-Agent Research
    details: Deep codebase analysis with 2-5 specialized agents working in parallel, iterative refinement, and comprehensive reports.
    link: /architecture/multi-agent
    linkText: Research System

  - icon: 🧠
    title: Project-Aware Memory
    details: Commands load your project profile, recent sessions, and learned patterns on every invocation. Tech stack, preferences, and past work are pre-filled automatically - zero repeated questions.
    link: /architecture/phase-0#memory-recall
    linkText: How Memory Works

  - icon: 🎓
    title: Skills Format (v4.3)
    details: Commands use native Claude Code Skills format with YAML frontmatter. Claude auto-suggests the right skill based on your request. Fully backward-compatible with existing .claude/commands/ files.
    link: /architecture/skills-format
    linkText: Skills Format Guide

  - icon: 🛡️
    title: Anti-Hallucination Contract (v4.6)
    details: Every skill has a HARD-GATE checklist and NEVER rules that prevent Claude from inventing file paths, versions, or facts. Chain-of-Thought REASONING block requires grounding every stated fact to a source file.
    link: /reference/changelog#460-april-2026
    linkText: What's New in v4.6

  - icon: 🚀
    title: Opus 4.7 Optimisation (v4.9)
    details: Prompt caching breakpoints on stable library files (~90% input cost reduction on warm hits), Fast Path Phase 0 for trivial prompts (~40% token savings), model tier split into opus-fast (4.6) vs opus-smart (4.7 with 1M context beta + 8K thinking budget), context-editing adapter for /prompt-research iterations, native memory-tool bridge.
    link: /reference/changelog#490-april-2026
    linkText: What's New in v4.9

  - icon: 🗣️
    title: Interaction Protocol (v4.8)
    details: Plan-first execution, SK/EN language rules, proactive option-finding, and never-auto-execute — now enforced globally in every session via CLAUDE.md, not only inside /prompt commands.
    link: /guide/interaction-protocol
    linkText: Read the Protocol

  - icon: ⚡
    title: Dynamic Model Routing (v4.7)
    details: Skills now suggest the optimal Claude tier (haiku/sonnet/opus) per task, emit an Execution Plan before any file is touched, and present 2-3 alternatives by default. Curiosity Gate publishes an assumption ledger whenever confidence is below 100%. Estimated 30-45% token savings.
    link: /reference/changelog#470-april-2026
    linkText: What's New in v4.7

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

Commands show real-time progress as they run.

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

1. **Recall** - Load known facts from project profile
2. **Detect** - Language, type, and intent
3. **Check** - 6 completeness criteria, pre-filling from memory
4. **Ask** - Only truly unknown information
5. **Structure** - Transform into executable format
6. **Approve** - Wait for your confirmation

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

### v4.9 - Opus 4.7 Optimisation

Token + context savings targeted at `claude-opus-4-7`. Seven additive
changes, all backward compatible.

**Highlights:**

- **Prompt caching strategy** — `cache_control: ephemeral` breakpoints on
  stable library files (core-library, model-router, exec-plan-template,
  model-tiers, adapters). Expected ~90% input cost reduction on warm
  cache hits. 5m default TTL, 1h beta TTL via
  `extended-cache-ttl-2025-04-11`.
- **Fast Path in Phase 0** — trivial prompts (complexity score < 5,
  single file, no security flags) short-circuit to Steps 0.1 → 0.5 →
  0.6. Saves ~40% Phase 0 tokens on simple tasks.
- **Model tier split** — `opus` is now `opus-fast` (Opus 4.6, 200K ctx,
  4K thinking, interactive) vs `opus-smart` (Opus 4.7, 1M ctx beta, 8K
  thinking, interleaved thinking beta). Router picks based on
  depth-vs-latency tradeoff.
- **Per-tier thinking budget** — `thinking_budget_tokens` in
  `model-tiers.json`: haiku 0 / sonnet 2K / opus-fast 4K / opus-smart 8K.
- **Context-editing adapter** — applies
  `context-management-2025-06-27` with `clear_tool_uses_20250919` to
  prevent 200K context exhaustion during `/prompt-research` iterations.
- **Memory-tool adapter** — bridge to native `memory_20250818` with a
  Phase A/B/C/D progressive migration plan.
- **Consolidated CHANGELOG-skills.md** — Version History deduped across
  all seven skills (~5K tokens saved per skill load).
- **Batch API hint** in `/reflect` for 50% cost reduction on non-urgent
  SDK-driven runs.

[See full changelog entry →](/reference/changelog#490-april-2026)

### v4.8 - Interaction Protocol

Plan-first discipline promoted from individual `/prompt*` skills to a **global
session protocol** loaded from `CLAUDE.md`. Applies to every interaction, not
only slash commands.

**Four rules:**

- **Language** — SK in / EN internal / SK out; technical terms verbatim
- **Plan-First** — summarise understanding, present 2-3 options for non-trivial work, emit an execution plan, wait for explicit approval
- **Proactive Option-Finding** — Claude proposes better paths BEFORE executing; names tradeoffs, recommends, user decides
- **Never Auto-Execute** — no `git commit`, `git push`, `npm install`, installer runs without explicit consent

**Why it matters:** previously, normal conversation bypassed Phase 0 discipline
and auto-executed. v4.8 fixes the root cause — `CLAUDE.md` is loaded into
every session automatically.

[Read the full protocol →](/guide/interaction-protocol)

### v4.7 - Dynamic Model Routing + Smarter Phase 0

Three major additions to Phase 0 that make every prompt cheaper to run and clearer to approve:

**Curiosity Gate (Step 0.25)** — confidence score 0-100 with a mandatory
assumption ledger whenever confidence drops below 100%. No more silent guessing:
```
ASSUMPTIONS I AM MAKING (correct me if wrong)
- Block goes BEFORE Step 0.6, not after.
- Minor version bump (v4.1) is appropriate.

Confidence: 85%
```

**Options-First (Step 0.35)** — 2-3 alternatives shown BY DEFAULT for
Task/Feature/Bug Fix/Refactor/Config prompts. Each option carries a model tier
(haiku/sonnet/opus) and token-cost estimate so you choose knowing the tradeoff.

**Execution Plan + MODEL HINT (Step 0.55)** — mandatory block before the
approval gate. Lists verified files, numbered steps, tools, risks, verification,
effort, and assumptions. Plus one line:
```
MODEL HINT: sonnet (claude-sonnet-4-6) — multi-step single-file edit.
Savings vs current: ~80% (switch from opus).
```

**Approval gate** adds a new response: `switch [haiku|sonnet|opus]` — change
model before approving to cut cost.

**Estimated token savings: 30-45%** through Haiku default for simple tasks
(memory recall, single-file edits, deploy scaffolds, README generation).

### v4.6 - Superprompting: Anti-Hallucination Contract

Every skill now has a built-in contract that prevents Claude from inventing facts:

**HARD-GATE blocks** — pre-flight checklist in every skill before any output:
```
- [ ] project-profile.md read this session
- [ ] No version numbers copied from templates — all from read files
- [ ] No file paths invented — all verified with Read or Glob
```

**NEVER rules** — explicit domain-specific prohibitions (e.g. `/prompt-dotnet` will never state a NuGet version without reading `.csproj`).

**Chain-of-Thought REASONING block** — Step 0.1 now requires:
```
REASONING
Prompt type: Task (Feature) — because input contains "add" + specific component name
Facts from project-profile.md: Stack is Node.js/VitePress, kebab-case conventions
Cannot determine: which specific file to edit
```

**Core library v2.0** with Mermaid flowchart and Grounding Protocol.

### v4.5 - Universal Skills

- `/session-start` and `/session-end` removed — replaced by Claude Code auto-memory
- `/deploy` and `/new-stack` are now universal — all server config read from `personal-profile.md`
- `/prompt-dotnet` and `/prompt-react` scan fallbacks added (monorepo support)
- Very High complexity threshold corrected: 20+ (was 15+)

### v4.4 - .NET + React Project-Aware Skills

Two new project-aware skills that scan your codebase before asking any questions:

**`/prompt-dotnet`** - Reads `.csproj`, `Program.cs`, `appsettings.json`, Docker files:

```
PROJECT SCAN COMPLETE
Framework: net10.0
Architecture: Minimal API
Auth: JWT
ORM: EF Core | DB: PostgreSQL — ConnectionStrings:Default
Docker: yes — stack: myapp
Packages: FluentValidation, Serilog, MediatR
```

**`/prompt-react`** - Reads `package.json`, `vite.config.ts`, `tsconfig.json`:

```
PROJECT SCAN COMPLETE
React: 19.0.0 | TypeScript: yes, strict: yes
Router: React Router v6
State: Zustand
Data fetching: TanStack Query
Base path: /appname/
```

Both skills apply best practices for the detected stack automatically — no repeated questions.

### v4.3 - Skills Format & Project-Aware Commands

**Skills Format** - Commands now use the native Claude Code Skills format:

```yaml
---
name: prompt
description: Transform any prompt into an unambiguous, executable format...
argument-hint: "[your prompt or task description]"
---
```

Claude automatically suggests the right skill based on `description`. No more manual `/prompt` when Claude already knows what you need.

**Project-Aware Startup** - Every command loads project context first:

```
CONTEXT LOADED FROM PROJECT PROFILE
Project: My App v2.1 | Stack: Node.js + PostgreSQL
Platform: macOS | Branch: feature/auth
Recent work: Added JWT middleware (yesterday)

What else do you need for this task?
```

**Zero Repeated Questions** - The populated `project-profile.md` eliminates asking the same questions across sessions. Tech stack, preferences, structure - all pre-filled automatically.

### v4.2 - Memory Recall & AI Fluency

**Memory Recall** - Commands remember your project between sessions:

```
Session 1: "What framework?" → "Express + TypeScript"
Session 2: Context: Express + TypeScript (from project profile) ✓
```

**AI Fluency** - Full 4Ds Framework integration:
- **Delegation** - Quick Delegation Check in all commands
- **Description** - 9 criteria completeness check
- **Discernment** - Post-Execution Evaluation with feedback loop
- **Diligence** - Responsibility reminders in Approval Gate

### v4.1 - Skill Reflection

```bash
/reflect
```

- Signal detection (corrections, successes, edge cases)
- Priority-coded change proposals (HIGH/MED/LOW)
- Direct skill file modifications with approval

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
