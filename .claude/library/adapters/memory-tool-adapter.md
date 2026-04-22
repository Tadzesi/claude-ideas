# Native Memory Tool Adapter

**Version:** 1.0
**Last Updated:** 2026-04-22
**Parent Library:** `.claude/library/prompt-perfection-core.md`
**Purpose:** Bridge between the project's file-based `.claude/memory/`
system and Anthropic's native `memory_20250818` tool. Allows skills to
choose: file-based (current default, portable across sessions) or
native (server-side persistence, no file I/O, automatic injection by
the API).

---

## Background

The project currently uses a bespoke file-based memory:
- `.claude/memory/project-profile.md`
- `.claude/memory/sessions.md`
- `.claude/memory/observations.md`
- `.claude/memory/project-knowledge.md`
- `.claude/memory/citation-index.md`

Anthropic's native `memory_20250818` tool offers:
- Server-side memory store keyed by user/session
- Automatic injection at request time
- Built-in eviction policies
- No file-system dependency

Both can coexist. This adapter defines when to use which.

---

## Decision matrix

| Need | Use |
|---|---|
| Cross-machine portability (git-tracked) | File-based (current) |
| Multi-developer team shared knowledge | File-based (commit to repo) |
| Per-user private context | Native memory tool |
| Long sessions with token-budget pressure | Native (auto-inject only relevant slices) |
| Audit trail of what was remembered | File-based (visible in git diff) |
| Quick recall under 200ms | Native (server-side) |
| Works offline / no API call | File-based |

**Recommended hybrid:** keep `project-profile.md`, `sessions.md`,
`observations.md` file-based (team-visible, git-tracked). Move per-user
ephemeral state to native memory tool — e.g. "user prefers terse output
this session", recent agent findings cache.

---

## Configuration

Add to API request when invoking memory tool:

```json
{
  "model": "claude-opus-4-7",
  "tools": [
    {
      "type": "memory_20250818",
      "name": "memory"
    }
  ],
  "betas": ["memory-2025-08-18"]
}
```

The model can then call:
- `memory.store(key, value)` — persist
- `memory.recall(key)` — fetch
- `memory.list()` — enumerate keys
- `memory.delete(key)` — remove

---

## Migration path (progressive, no breaking changes)

**Phase A — additive (current commit):**
- This adapter exists; skills do not yet call memory tool.
- Documentation links from caching-strategy.md.

**Phase B — opt-in per skill:**
- Add `memory_tool: enabled` flag to skill frontmatter.
- Skills with flag = enabled register memory tool in their API request.
- Test with `/reflect` first (low blast radius).

**Phase C — hybrid default:**
- Ephemeral state (current-session preferences) → memory tool.
- Durable knowledge (project facts, conventions) → file-based.
- Skills read from both, preferring memory tool when key exists there.

**Phase D — full native (optional, may never be needed):**
- File-based becomes export/backup format.
- Day-to-day operation uses memory tool.

---

## Skill integration template

For a skill that wants to use memory tool:

```yaml
---
name: example-skill
description: ...
memory_tool: enabled         # NEW — opts into native memory
memory_keys:
  - user_preferences
  - last_agent_findings
---

## STARTUP

Read project-profile.md (file-based, durable).
THEN call memory.recall("user_preferences") for session ephemera.
Merge — file-based facts win on conflict (auditable source of truth).
```

---

## Anti-patterns

- Do NOT duplicate facts across both systems silently. Pick one home per fact.
- Do NOT store secrets in either system (use env vars / personal-profile.md).
- Do NOT use memory tool for facts that should be in git (architecture
  decisions, conventions) — those belong in file-based memory.
- Do NOT turn this on for all skills at once. Phase B → C → maybe D.

---

## Related

- @.claude/library/caching-strategy.md
- @.claude/library/adapters/context-editing-adapter.md
- @.claude/memory/project-profile.md
- @.claude/memory/sessions.md
