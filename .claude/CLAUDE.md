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

