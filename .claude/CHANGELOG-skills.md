# Skills Changelog (Consolidated)

**Last Updated:** 2026-04-22
**Purpose:** Single source of truth for all skill version history.
Replaces per-skill Version History blocks (~15 KB / 5K tokens saved).

---

## v4.1 / v2.1 — 2026-04-16 (all skills)

Aligned with `prompt-perfection-core.md` v2.1.

- Step 0.25 Curiosity Gate: confidence scoring + assumption ledger
- Step 0.35 Options-First: 2-3 alternatives by default for
  Task / Feature / Bug Fix / Refactor / Config
- Step 0.55 Execution Plan + MODEL HINT for non-Question prompts
- Approval gate adds `switch [haiku|sonnet|opus]` response
- New refs: model-router.md, execution-plan-template.md, model-tiers.json

Skills bumped: prompt v4.1, prompt-hybrid v4.1, prompt-dotnet v2.1,
prompt-react v2.1, reflect v2.1, deploy v2.1, new-stack v2.1.

---

## v4.0 / v2.0 — 2026-04-07 (all skills)

Aligned with `prompt-perfection-core.md` v2.0.

- HARD-GATE Anti-Hallucination block added after STARTUP
- NEVER section with skill-specific rules
- Few-shot examples (correct vs incorrect output)
- Removed hardcoded values from STARTUP templates
- REASONING block required before Step 0.11

---

## v3.0 — 2026-03-03 (skills format migration)

- Converted from `.claude/commands/` markdown to `.claude/skills/` Skills
  format with YAML frontmatter
- STARTUP section: loads project-profile.md + sessions.md first
- Project-aware completeness check (skips known facts)
- Session-aware: references recent work from sessions.md
- New skills introduced: prompt, prompt-hybrid, prompt-dotnet, prompt-react,
  reflect, deploy, new-stack

---

## v2.1 — 2026-01-20

- AI Fluency alignment (Common Mistakes, AI Limitations sections)

## v2.0 — 2024-12-19

- Migrated to unified library system (`.claude/library/`)

## v1.0 — initial

- Standalone Phase 0 implementation per command

---

## Per-skill notes

### prompt
Quick prompt cleanup with project memory pre-fill. ~2s wall clock.

### prompt-hybrid
Adds complexity scoring (0-30+) and conditional agent spawning.
Score >= 10 spawns Explore agent. Score >= 20 → research mode.

### prompt-dotnet
.NET project scan (Program.cs, .csproj, Startup.cs) before Phase 0.
Pre-fills target framework, packages, hosting model.

### prompt-react
React/Vite project scan (package.json, vite.config.ts, tsconfig).
Pre-fills React version, build tool, TypeScript settings.

### reflect
Analyzes session signals from `.claude/memory/observations.md` and
proposes skill file improvements. v2.1 candidate for Batch API
(P3.2 — 50% discount on non-urgent).

### deploy
Project-aware deployment workflow. Reads
`.claude/memory/personal-profile.md` for SSH/server credentials.

### new-stack
Docker stack scaffold (universal). Reads `personal-profile.md` for port
allocation and naming conventions.

---

## v4.7 / v4.8 project-level changes (not per-skill)

See `CHANGELOG.md` (project root) for:
- v4.7.0 (2026-04-17): Dynamic Model Routing + Smarter Phase 0
- v4.8.0 (2026-04-19): Interaction Protocol (global SK/EN, plan-first)
