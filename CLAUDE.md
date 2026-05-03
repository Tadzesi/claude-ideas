# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

**Extended Context:** See @.claude/CLAUDE.md for memory imports and active context.

## Project Overview

**claude-ideas** (v5.1.0) - Personal collection of three Claude Code slash commands for prompt engineering, project research, and documentation generation.

## Response Style Guidelines

**IMPORTANT:** When responding in the Claude Code terminal, use PLAIN TEXT ONLY.

- No markdown headers, emojis, tables, or special formatting
- Simple dashes for lists, UPPERCASE for emphasis
- Lines under 80 characters
- Never display markdown file contents in terminal; direct user to VS Code: `code FILENAME.md`

## Interaction Protocol (applies to ALL interactions, not just slash commands)

### Language
- User pÃ­Å¡e po slovensky â€” akceptuj a odpovedaj po slovensky
- InternÃ© myslenie, volania nÃ¡strojov, kÃ³d, commit messages, docs â€” v angliÄtine
- TechnickÃ© termÃ­ny (file paths, commands, API names) ponechaj v originÃ¡li

### Plan-First Execution (CRITICAL)
_Scope: voÄ¾nÃ¡ konverzÃ¡cia a priame tool calls. Vo vnÃºtri slash commandov rieÅ¡i approval gate Phase 0 Step 0.6._

Pred akoukoÄ¾vek zmenou sÃºboru, spustenÃ­m buildu/testu, alebo commitom MUSÃÅ :
1. ZhrnÃºÅ¥ porozumenie Ãºlohy (1-2 vety po slovensky)
2. Ak je task netriviÃ¡lny (edit >1 sÃºboru, novÃ¡ funkcia, refactor, config): predstav 2-3 options s pros/cons
3. VypÃ­saÅ¥ execution plan: sÃºbory (CREATE/EDIT/READ), kroky, rizikÃ¡, verifikÃ¡cia
4. PoÄkaÅ¥ na `y` / `yes` / `schvaÄ¾ujem` â€” nikdy nepredpokladaj sÃºhlas

VÃ½nimky (plÃ¡n nie je potrebnÃ½):
- Pure read-only otÃ¡zky (Äo robÃ­ tento sÃºbor?, akÃ¡ je verzia?)
- TriviÃ¡lne jednorazovÃ© veci explicitne vyÅ¾iadanÃ© (oprav tento preklep)

### Proactive Option-Finding
Nie si pasÃ­vny executor. KeÄ vidÃ­Å¡ lepÅ¡iu cestu neÅ¾ navrhuje user, povedz to PRED exekÃºciou.
Pomenuj tradeoff, odporÃºÄ, ale rozhodnutie nechaj na usera.

### Never Auto-Execute
- Nikdy `git commit`, `git push`, `npm install`, `install-claude-commands.ps1` bez explicitnÃ©ho sÃºhlasu
- Obe strany (AI aj user) musia rozumieÅ¥ ÄŒO sa ide staÅ¥, PREÄŒO a AKO to overÃ­me

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

# Version bump (package.json is the single source of truth)
# 1. Edit package.json "version" field
# 2. Propagate to installer header, banner, and CLAUDE.md project line:
.\scripts\sync-version.ps1
.\scripts\sync-version.ps1 -Check     # CI mode: exit 1 if drift
.\scripts\sync-version.ps1 -DryRun    # preview, write nothing
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
- Changes to the core library affect ALL commands â€” test multiple commands after changes
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
