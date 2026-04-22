# Model Router

**Version:** 2.0
**Last Updated:** 2026-04-22
**Config:** `.claude/config/model-tiers.json` (v2.0 — opus split)
**Purpose:** Decide which Claude model tier (haiku / sonnet / opus-fast /
opus-smart) best fits a given task and surface that hint to the user BEFORE
execution. Reduces token cost without reducing quality.

**v2.0 change:** `opus` is now split:
- `opus-fast` = Opus 4.6 (`claude-opus-4-6`), interactive, 200K ctx, 4K thinking
- `opus-smart` = Opus 4.7 (`claude-opus-4-7`), 1M ctx beta, 8K thinking,
  interleaved thinking, 1h cache TTL beta. Default for research / security.

Legacy "opus" hints in older skills still resolve to `opus-smart` (default).

---

## When to Invoke

Call this router at two points in Phase 0:

1. **After Step 0.2 (Completeness Check)** — emit MODEL HINT as part of the
   "What I Still Need" block when you have enough info to classify the task.
2. **Inside Step 0.55 (Execution Plan)** — include the final recommended tier
   as a line in the plan so the user can act on it before approval.

---

## Routing Algorithm

Use facts already gathered in Phase 0 (prompt type, scope, complexity score,
escalation triggers). Apply in order — first match wins.

### 1. Hard de-escalation

If ANY de-escalation trigger fires -> suggest **haiku**:
- Memory recall only (no file edits)
- Plain-text status, listing, or summary of known facts
- Single-file typo, rename, or one-line config change

### 2. Hard escalation

If ANY escalation trigger fires -> suggest **opus-smart** (4.7):
- Security or credential handling
- Breaking change across public API
- Framework major-version migration
- User explicitly requested deep analysis or research
- Multi-agent research mode (score >= 30)
- Context required exceeds 200K tokens (1M beta)

If escalation fires BUT user is in interactive session and wall-clock
matters more than depth → suggest **opus-fast** (4.6, /fast).

### 3. By complexity score

| Score | Tier        |
|-------|-------------|
| 0-4   | haiku       |
| 5-9   | sonnet      |
| 10-19 | sonnet      |
| 20-29 | opus-fast   |
| 30+   | opus-smart  |

### 3a. Smart vs Fast decision (when opus tier selected)

Prefer **opus-smart** when:
- Novel problem, no existing pattern
- Needs 1M context window (beta `context-1m-2025-08-07`)
- Research / security with multiple iterations
- Depth > speed

Prefer **opus-fast** when:
- Familiar refactor pattern
- Interactive session, user actively waiting
- 200K context sufficient
- `/fast` already toggled in Claude Code

### 4. By prompt type (if no complexity score yet)

Look up in `model-tiers.json -> routing_rules.by_prompt_type`.

### 5. By file count

| Files | Tier    |
|-------|---------|
| 1     | haiku   |
| 2-5   | sonnet  |
| 6+    | opus    |

### 6. Default

If nothing else matches -> **sonnet** (balanced default).

---

## Output Format

Always surface the hint as ONE line in the user-facing block. Never more than
two sentences. Example:

```
MODEL HINT: Task fits haiku (claude-haiku-4-5). Consider /model haiku to
save ~93% tokens versus opus.
```

If current session already runs the recommended tier:

```
MODEL HINT: Current model is appropriate for this task.
```

If task needs escalation:

```
MODEL HINT: Task benefits from opus (claude-opus-4-7) for deeper reasoning.
Consider /model opus before approval.
```

---

## NEVER

- Never invent model IDs — always read from `model-tiers.json`.
- Never suggest a tier change without a one-sentence reason.
- Never suggest opus-smart for tasks under complexity score 10 unless an
  escalation trigger fired (wasteful — 15× haiku cost).
- Never suggest opus-fast for tasks under complexity score 20 unless
  user has /fast already toggled.
- Never skip the hint — even "keep current" is explicit communication.

---

## ALWAYS

- Always surface the hint BEFORE the approval gate, not after.
- Always name the concrete tier (haiku / sonnet / opus), not vague terms like
  "a smaller model".
- Always include the estimated savings percentage when suggesting a switch
  down (values from `estimated_savings_pct` in the config).
- Always include thinking budget hint when recommending sonnet / opus-fast /
  opus-smart (from `tiers.{tier}.thinking_budget_tokens`).
- Always recommend caching when the same library files load repeatedly in a
  session (see `.claude/library/caching-strategy.md`).

---

## Usage in SKILL files

Add this block near the end of Phase 0 (just before the approval gate):

```markdown
### Model Selection

Apply the routing algorithm in `.claude/library/model-router.md` using the
facts gathered above (prompt type, scope, file count, triggers). Output the
MODEL HINT line as part of the execution plan.
```

No duplication of routing logic inside each skill — reference this file.
