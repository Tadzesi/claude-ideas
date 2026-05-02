# Anthropic Prompt Caching Strategy

**Version:** 1.0
**Last Updated:** 2026-04-22
**Purpose:** Reduce input token cost by 70-90% on repeat skill invocations
by marking stable library files as cacheable via `cache_control`.

---

## What this is

Anthropic prompt caching (`cache_control: {type: "ephemeral"}`) lets the
API reuse the prefix of the prompt across calls. Cache reads cost ~10% of
base input tokens. TTL options:

- 5 minutes (default ephemeral)
- 1 hour (beta `extended-cache-ttl-2025-04-11`)

For Opus 4.7 (input ~$15/MTok), a 90% cache hit on a 6K-token library
prefix saves ~$0.08 per invocation. Across a session: significant.

---

## What to cache (stable, rarely changes)

Mark these as cacheable via `cache_control` breakpoint AT THE END of each:

1. `.claude/library/prompt-perfection-core.md` — Phase 0 canonical flow
2. `.claude/library/model-router.md` — routing algorithm
3. `.claude/library/execution-plan-template.md` — plan format
4. `.claude/config/model-tiers.json` — tier definitions
5. `.claude/config/complexity-rules.json` — scoring rules
6. `.claude/library/*-adapter.md` — domain adapters
7. `.claude/library/orchestration-*.md` — multi-agent coordination
9. `.claude/CHANGELOG-skills.md` — consolidated version history

## What NOT to cache (volatile)

- `.claude/memory/sessions.md` — appends every session
- `.claude/memory/observations.md` — frequent edits
- User prompt itself
- Tool results

---

## Cache breakpoint placement

Anthropic supports up to 4 cache breakpoints per request. Order from most
stable to least:

```
[1] System prompt + tool definitions
[2] core-library + model-router + exec-plan-template (block A — stable)
[3] adapters + intelligence + orchestration (block B — semi-stable)
[4] memory/project-profile.md (block C — changes occasionally)
--- (no cache below this line) ---
sessions.md, user prompt, tool results
```

---

## How skills should reference this

Each SKILL.md STARTUP block should include:

```
CACHING: Library files (core, model-router, exec-plan-template, model-tiers,
adapters) are stable across calls — flag them with cache_control: ephemeral
when constructing the API request. See .claude/library/caching-strategy.md.
```

Skills do not call the API directly (Claude Code harness does), but this
hint surfaces the intent so harness/tooling that respects cache markers
applies them, and so any custom integration via the Anthropic SDK knows
which prefixes to mark.

---

## Direct SDK usage (Anthropic API integration)

When building a custom client that calls Claude with these libraries:

```python
messages = [...]
system = [
    {"type": "text", "text": tool_definitions},
    {
        "type": "text",
        "text": load("library/prompt-perfection-core.md")
              + load("library/model-router.md")
              + load("library/execution-plan-template.md")
              + load("config/model-tiers.json"),
        "cache_control": {"type": "ephemeral"}  # block A
    },
    {
        "type": "text",
        "text": load("memory/project-profile.md"),
        "cache_control": {"type": "ephemeral"}  # block C
    }
]
```

For 1-hour TTL on the most stable block, add beta header:
`anthropic-beta: extended-cache-ttl-2025-04-11` and use
`cache_control: {type: "ephemeral", ttl: "1h"}`.

---

## Expected savings (Opus 4.7)

| Scenario | Cache hit rate | Cost vs no cache |
|---|---|---|
| First call (cold) | 0% | 100% (cache write +25%) |
| Subsequent within 5 min | ~95% | ~15% |
| Subsequent within 1 hour (beta TTL) | ~90% | ~20% |
| Across multi-day sessions | 0% (TTL expired) | 100% |

A typical /prompt or /prompt-research session (5-10 invocations within an hour) cuts
input cost by ~70-85%.

---

## Verification

To confirm caching is active, check API response headers/usage block:

```json
"usage": {
  "input_tokens": 412,
  "cache_creation_input_tokens": 0,
  "cache_read_input_tokens": 6234,
  "output_tokens": 187
}
```

`cache_read_input_tokens > 0` = working. Bill is on `input_tokens` (full
price) + `cache_read_input_tokens` × 0.10.

---

## Related

- @.claude/library/prompt-perfection-core.md
- @.claude/library/model-router.md
- @.claude/library/execution-plan-template.md
- @.claude/config/model-tiers.json
