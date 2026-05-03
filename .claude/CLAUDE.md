# Claude Commands Library - Project Memory

This file aggregates project-specific memory and context using Claude Code's native @ import system.

---

## Memory Imports

Load persistent context from memory files:

- Session history: @.claude/memory/sessions.md
- Project profile: @.claude/memory/project-profile.md
- Learning patterns: @.claude/memory/prompt-patterns.md
- Project knowledge: @.claude/memory/project-knowledge.md
- Architecture context: @.claude/memory/architectural-context.md
- Pending observations: @.claude/memory/observations.md

---

## Rules Imports

Load path-specific rules automatically:

- Technical patterns: @.claude/rules/technical-patterns.md
- Command conventions: @.claude/rules/command-conventions.md
- Library standards: @.claude/rules/library-standards.md

---

## Quick Reference

**Commands Available:**
- `/prompt` - Prompt analysis and rewrite (Phase 0 flow)
- `/prompt-article-readme` - README generator from project analysis
- `/prompt-research` - Deep multi-agent research (orchestrator-worker, 2-4 iterations)

**Configuration:**
- Agent templates: @.claude/config/agent-templates.json

---

## Interaction Protocol (Standalone Stub)

> **Note:** When this `.claude/` directory is installed into a project that
> already has its own root `CLAUDE.md`, that root file is the authoritative
> Interaction Protocol source — see its full Interaction Protocol section.
> The stub below applies only when no root `CLAUDE.md` exists, so projects
> that install via `install-claude-commands.ps1` still inherit core rules.

**Language**
- Akceptuj slovenčinu, odpovedaj po slovensky.
- Interné myslenie, kód, commit messages, docs ostávajú v angličtine.
- Technické termíny (file paths, commands, API names) ponechávaj v origináli.

**Plan-First Execution (free conversation, direct tool calls)**
- Pred edit-om súboru, build/test runom alebo commitom: zhrň úlohu (1-2 vety),
  pri netriviálnych taskoch ponúkni 2-3 options s pros/cons, vypíš execution
  plan (súbory, kroky, riziká, verifikácia), počkaj na `y` / `yes` / `schvaľujem`.
- Výnimky: pure read-only otázky a explicit one-shot triviality.
- Inside slash commands the richer Approval Gate applies — see
  `.claude/library/prompt-perfection-core.md` Step 0.6.

**Memory Recall**
- Pred otázkou na tech stack, infrastructure, recent work, alebo decisions:
  vždy najprv skontroluj `.claude/memory/project-profile.md`, posledné 3
  záznamy v `.claude/memory/sessions.md`, a `.claude/memory/prompt-patterns.md`.
- Použi známe fakty namiesto re-pýtania.
- Operational procedure (which files, what order, output format) lives in
  `.claude/library/prompt-perfection-core.md` Step 0.2a.

**Proactive Option-Finding**
- Nie pasívny executor. Keď vidíš lepšiu cestu než user navrhuje, povedz to
  PRED exekúciou: pomenuj tradeoff, odporúč, ale rozhodnutie nechaj na userovi.

**Never Auto-Execute**
- Žiadny `git commit`, `git push`, `npm install`, `install-claude-commands.ps1`,
  ani iný destruktívny príkaz bez explicitného súhlasu.
- Obe strany musia rozumieť ČO sa ide stať, PREČO a AKO to overíme.

---

## Project Conventions

**File Naming:**
- Skills: kebab-case dir + SKILL.md (skills/prompt/SKILL.md)
- Config: kebab-case JSON (agent-templates.json)
- Library: kebab-case (prompt-perfection-core.md)

**Version Format:**
- Use semantic versioning (v5.0.0)
- Include date in version history (YYYY-MM-DD)
- Current version: 5.0.0 (Honest 3-command portfolio)

**Terminology:**
- "Explore Agent" (not ExploreAgent)
- "Complexity Score" (not just Score)
- "Phase 0" for prompt perfection stage

