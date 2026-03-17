# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

**Extended Context:** See @.claude/CLAUDE.md for memory imports and active context.

## Project Overview

**Claude Commands Library** (v4.4) - A collection of reusable slash commands for Claude Code that enhance prompt engineering, content creation, and session management. Commands use a library-based architecture where a shared core (Phase 0) handles prompt analysis/perfection, and domain-specific adapters customize behavior.

## Response Style Guidelines

**IMPORTANT:** When responding in the Claude Code terminal, use PLAIN TEXT ONLY.

- No markdown headers, emojis, tables, or special formatting
- Simple dashes for lists, UPPERCASE for emphasis
- Lines under 80 characters
- Never display markdown file contents in terminal; direct user to VS Code: `code FILENAME.md`

## Build and Development Commands

```powershell
# VitePress documentation site
npm run docs:dev          # Dev server with hot reload
npm run docs:build        # Production build (output: docs/.vitepress/dist/)
npm run docs:preview      # Preview production build

# Validate library references (PowerShell)
.\tests\validate-library-references.ps1         # Run test suite
.\tests\validate-library-references.ps1 -Verbose  # With details

# Validate JSON config syntax
Get-Content .claude/config/<file>.json | ConvertFrom-Json

# Install commands to another project
.\install-claude-commands.ps1
.\install-claude-commands.ps1 -InstallPath "C:\target" -Force
```

Docs auto-deploy to GitHub Pages on push to `main` via `.github/workflows/deploy-docs.yml`.

## Architecture

### Library-Based Pattern (Core Concept)

All slash commands share a common **Phase 0: Prompt Perfection** flow. Instead of duplicating this logic, commands import it from a single core library:

```
User Input -> Phase 0 (core library) -> Domain Adapter -> Command-Specific Logic
```

- **Core Library:** `.claude/library/prompt-perfection-core.md` - Canonical Phase 0 flow (analyze, clarify, correct, structure)
- **Adapters:** `.claude/library/adapters/` - Domain customizations (technical, article, session, hybrid, research)
- **Commands:** `.claude/commands/` - Old format (still works), OR `.claude/skills/` - New Skills format with YAML frontmatter
- **Intelligence:** `.claude/library/intelligence/` - Predictive intelligence, reflection, warnings, next-steps prediction
- **Orchestration:** `.claude/library/orchestration/` - Multi-agent research coordination (lead agent, iteration engine, result aggregator)
- **Agents:** `.claude/library/agents/` - Specialized agent definitions (explore, citation, security, performance, pattern)
- **Configuration:** `.claude/config/` - JSON configs for complexity rules, agent templates, caching, learning, etc.

### Complexity Detection

The hybrid system (`/prompt-hybrid`, `/prompt-technical`) uses a scoring engine (`.claude/config/complexity-rules.json`) with 7 weighted triggers. Based on score: Simple (0-4) runs manually, Moderate (5-9) asks user, Complex (10+) spawns agents, Research (20+) uses multi-agent orchestration.

### Memory System

- `.claude/memory/project-profile.md` - Structured fact store (tech stack, infrastructure, preferences)
- `.claude/memory/sessions.md` - Session history (legacy, maintained manually or via `/reflect`)
- `.claude/memory/prompt-patterns.md` - Learning system patterns
- `.claude/memory/project-knowledge.md` - Persistent knowledge graph
- `.claude/memory/observations.md` - Pending observations from `/reflect`

### Memory Recall (v4.3)

CRITICAL: Before asking about ANYTHING (tech stack, infrastructure, project structure, user preferences,
recent work, decisions made), ALWAYS check these files first:
1. `.claude/memory/project-profile.md` - Complete project facts (NOW POPULATED v2.0)
2. `.claude/memory/sessions.md` - Recent session history
3. `.claude/memory/prompt-patterns.md` - Learned patterns

Use known facts instead of re-asking. This applies to ALL interactions, not just slash commands.
The project-profile.md v2.0 contains: project identity, tech stack, infrastructure, structure,
commands list, architecture, user preferences, workflows, and known gotchas.

### Rules (Path-Scoped)

Files in `.claude/rules/` use frontmatter `paths:` to scope rules to specific files. These are auto-loaded when editing matching paths.

## Commands

| Command | Purpose | Speed |
|---------|---------|-------|
| `/prompt` | Quick prompt cleanup with LITE predictive intelligence | ~2s |
| `/prompt-hybrid` | Full complexity detection, agent spawning, caching, learning | 2-30s |
| `/prompt-technical` | Technical implementation analysis with code scaffolding | 5-30s |
| `/prompt-research` | Deep multi-agent research (2-5 agents, 2-4 iterations) | 60-180s |
| `/prompt-dotnet` | .NET project-aware prompt perfection (scans .csproj, Program.cs) | ~3s |
| `/prompt-react` | React project-aware prompt perfection (scans package.json, vite.config) | ~3s |
| `/prompt-article` | Interactive article wizard (multi-platform) | Interactive |
| `/prompt-article-readme` | README generator from project analysis | ~30s |
| `/deploy` | Project-aware deployment workflow (reads personal-profile.md) | Interactive |
| `/new-stack` | Docker stack scaffold (universal, reads personal-profile.md) | ~5s |
| `/reflect` | Analyze session signals, propose skill file improvements | 5-15s |

See `.claude/docs/comparisons.md` for decision trees.

## Development Guidelines

### Modifying Commands
- Always reference the core library (`@.claude/library/prompt-perfection-core.md`) for Phase 0
- Use adapters in `.claude/library/adapters/` for domain-specific logic; keep core universal
- Changes to the core library affect ALL commands - test multiple commands after changes
- Run `.\tests\validate-library-references.ps1` to verify library references, version history, and adapter mappings

### File Conventions
- File naming: kebab-case for everything (commands, configs, library files)
- Version format: semantic (v4.1), with dates (YYYY-MM-DD) in changelogs
- Terminology: "Explore Agent" (not ExploreAgent), "Complexity Score", "Phase 0"

### Git Workflow
- Main branch: `main`
- Preserve `.claude/memory/` files (user data) during updates
- Never commit `.claude/cache/` (agent result cache)
- Docs deploy automatically on push to main

### VitePress Documentation
- Source: `docs/` with config at `docs/.vitepress/config.ts`
- Legacy docs (pre-v3.0): `docs-archive/`
- Internal docs: `.claude/docs/` (release notes, roadmap, comparisons)
- Live site: https://tadzesi.github.io/claude-ideas/
