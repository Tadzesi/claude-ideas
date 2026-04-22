# Context Editing Adapter

**Version:** 1.0
**Last Updated:** 2026-04-22
**Parent Library:** `.claude/library/prompt-perfection-core.md`
**Purpose:** Apply Anthropic's `context-management-2025-06-27` with the
`clear_tool_uses_20250919` strategy in long-running multi-iteration
sessions (primarily `/prompt-research`) so old tool_result blocks do not
fill the 200K context.

---

## When to apply

Trigger conditions (any one):
- Complexity score >= 20 (research mode)
- /prompt-research with strategy `broad` or `comprehensive`
- Multi-iteration agent loop where iteration count >= 2
- Glob/Grep results that exceed 5K tokens accumulated

Skip for:
- Single-pass /prompt or /prompt-hybrid (score < 20)
- Sessions under 5 tool calls total
- When using `context-mode` MCP (it already keeps raw output out of context)

---

## Configuration

Add to API request:

```json
{
  "model": "claude-opus-4-7",
  "betas": ["context-management-2025-06-27"],
  "context_management": {
    "edits": [
      {
        "type": "clear_tool_uses_20250919",
        "trigger": {
          "type": "input_tokens",
          "value": 100000
        },
        "keep": {
          "type": "tool_uses",
          "value": 5
        },
        "clear_at_least": {
          "type": "input_tokens",
          "value": 20000
        }
      }
    ]
  }
}
```

**Tuning per use case:**

| Use case | trigger | keep | clear_at_least |
|---|---|---|---|
| /prompt-research broad | 80K | 5 last | 20K |
| /prompt-research comprehensive | 100K | 8 last | 30K |
| Long /prompt-hybrid session | 60K | 3 last | 15K |

---

## Interaction with iteration engine

When `clear_tool_uses` fires between iterations:

1. Iteration N completes — citations and findings extracted to
   `.claude/memory/citation-index.md` and `project-knowledge.md`.
2. `clear_tool_uses` removes tool_result blocks from iterations 1..N-keep.
3. Iteration N+1 starts with **summaries from memory** + last `keep`
   tool_uses, not the raw Glob/Grep dumps.
4. CitationAgent re-grounds findings via memory file references, not raw
   re-reads.

This is the only safe way to run 4-iteration comprehensive research on
opus-smart without context exhaustion.

---

## Verification

API response includes context-management metadata:

```json
"context_management": {
  "applied_edits": [
    {
      "type": "clear_tool_uses_20250919",
      "cleared_tool_uses": 12,
      "cleared_input_tokens": 23400
    }
  ]
}
```

`cleared_input_tokens > 0` = working. Audit by sampling iteration logs.

---

## Anti-patterns

- Do NOT clear when results have not been summarised to memory yet —
  losing tool_result without persisting findings = lost work.
- Do NOT use with `/prompt` (single-pass, no iteration).
- Do NOT combine with aggressive 5m cache TTL — cache hits and
  context-edits both modify the prefix; verify together.

---

## Related

- @.claude/library/orchestration/iteration-engine.md
- @.claude/library/orchestration/result-aggregator.md
- @.claude/library/caching-strategy.md
- @.claude/library/adapters/memory-tool-adapter.md
