# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

**Extended Context:** See @.claude/CLAUDE.md for memory imports and active context.

## Project Overview

**claude-ideas** (v5.0.0) - Personal collection of three Claude Code slash commands for prompt engineering, project research, and documentation generation.

## Response Style Guidelines

**IMPORTANT:** When responding in the Claude Code terminal, use PLAIN TEXT ONLY.

- No markdown headers, emojis, tables, or special formatting
- Simple dashes for lists, UPPERCASE for emphasis
- Lines under 80 characters
- Never display markdown file contents in terminal; direct user to VS Code: `code FILENAME.md`

## Interaction Protocol (applies to ALL interactions, not just slash commands)

### Language
- User píše po slovensky — akceptuj a odpovedaj po slovensky
- Interné myslenie, volania nástrojov, kód, commit messages, docs — v angličtine
- Technické termíny (file paths, commands, API names) ponechaj v origináli

### Plan-First Execution (CRITICAL)
Pred akoukoľvek zmenou súboru, spustením buildu/testu, alebo commitom MUSÍŠ:
1. Zhrnúť porozumenie úlohy (1-2 vety po slovensky)
2. Ak je task netriviálny (edit >1 súboru, nová funkcia, refactor, config): predstav 2-3 options s pros/cons
3. Vypísať execution plan: súbory (CREATE/EDIT/READ), kroky, riziká, verifikácia
4. Počkať na `y` / `yes` / `schvaľujem` — nikdy nepredpokladaj súhlas

Výnimky (plán nie je potrebný):
- Pure read-only otázky (čo robí tento súbor?, aká je verzia?)
- Triviálne jednorazové veci explicitne vyžiadané (oprav tento preklep)

### Proactive Option-Finding
Nie si pasívny executor. Keď vidíš lepšiu cestu než navrhuje user, povedz to PRED exekúciou.
Pomenuj tradeoff, odporúč, ale rozhodnutie nechaj na usera.

### Never Auto-Execute
- Nikdy `git commit`, `git push`, `npm install`, `install-claude-commands.ps1` bez explicitného súhlasu
- Obe strany (AI aj user) musia rozumieť ČO sa ide stať, PREČO a AKO to overíme

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

All three commands share Phase 0 (prompt analysis, clarification, structuring) imported from
`.claude/library/prompt-perfection-core.md`. Command-specific logic lives in each skill's
`SKILL.md` under `.claude/skills/`.

### Memory System

- `.claude/memory/project-profile.md` - Structured fact store (tech stack, infrastructure, preferences)
- `.claude/memory/sessions.md` - Session history
- `.claude/memory/prompt-patterns.md` - Learned patterns
- `.claude/memory/project-knowledge.md` - Persistent knowledge graph (used by /prompt-research)
- `.claude/memory/observations.md` - Pending observations

### Memory Recall

CRITICAL: Before asking about ANYTHING (tech stack, infrastructure, project structure, user preferences,
recent work, decisions made), ALWAYS check these files first:
1. `.claude/memory/project-profile.md` - Complete project facts
2. `.claude/memory/sessions.md` - Recent session history
3. `.claude/memory/prompt-patterns.md` - Learned patterns

Use known facts instead of re-asking. This applies to ALL interactions, not just slash commands.

### Rules (Path-Scoped)

Files in `.claude/rules/` use frontmatter `paths:` to scope rules to specific files. These are
auto-loaded when editing matching paths.

## Commands

| Command | Purpose |
|---------|---------|
| `/prompt` | Analyses a prompt, asks clarifying questions, rewrites into structured executable form |
| `/prompt-article-readme` | Scans project structure, generates or updates README.md |
| `/prompt-research` | Multi-agent research workflow for unfamiliar codebases (2-4 iterations) |

## Development Guidelines

### Modifying Skills
- Always reference the core library (`@.claude/library/prompt-perfection-core.md`) for Phase 0
- Domain adapters: `.claude/library/readme-adapter.md` (readme), `.claude/library/research-adapter.md` (research)
- Changes to the core library affect ALL commands — test multiple commands after changes
- Run `.\tests\validate-library-references.ps1` to verify library references

### File Conventions
- File naming: kebab-case for everything (skills, configs, library files)
- Version format: semantic (v5.0), with dates (YYYY-MM-DD) in changelogs
- Terminology: "Explore Agent" (not ExploreAgent), "Phase 0"

### Git Workflow
- Main branch: `main`
- Preserve `.claude/memory/` files (user data) during updates
- Never commit `.claude/cache/` (agent result cache)
- Docs deploy automatically on push to main

### VitePress Documentation
- Source: `docs/` with config at `docs/.vitepress/config.ts`
- Legacy docs (pre-v3.0): `docs-archive/`
- Internal docs: `.claude/docs/`
- Live site: https://tadzesi.github.io/claude-ideas/
