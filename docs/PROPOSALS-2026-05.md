# PROPOSALS-2026-05

**Based on:** DIAGNOSTICS-2026-05.md  
**Date:** 2026-05-03  
**Status:** Awaiting selection — no files changed yet

Reply with a list of IDs (e.g. `2.1, 2.4`) or `all` or `none`.

---

## 2.1 — Version Drift: `.claude/VERSION` = 4.7.0

**Problem:** `.claude/VERSION` was not bumped during the v5.0.0 release. Everything else says 5.0.0. The file serves no runtime purpose in v5 (no skill reads `$CLAUDE_VERSION`).

| | Option A — Delete the file | Option B — Fix the value | Option C — Make it canonical |
|-|---------------------------|--------------------------|------------------------------|
| **What** | Remove `.claude/VERSION` entirely | Change content to `5.0.0` | Add a CI check: `package.json` version must match `.claude/VERSION`; installer reads from it |
| **Pros** | Eliminates the drift source; one fewer file to maintain | Fast, safe | Single source of truth going forward |
| **Cons** | Loses the file if you ever want it back | Drift will recur next release without a guard | Adds complexity; CI must run before every release |
| **Effort** | 1 file delete + 1 commit | 1 line edit + 1 commit | `.github/workflows/` change + installer edit |

**Recommendation:** Option A. The file has no reader in v5. Deleting is safer than silently having a stale file next release.

---

## 2.2 — prompt-research Debloat (~5,600 words, stale config embeds)

**Problem:**
1. `prompt-research/SKILL.md` is ~930 lines / ~5,600 words — above Anthropic's ~5,000-word guideline.
2. Lines 706–926 contain config file content (`complexity-rules.json`, `orchestration-config.json`, `agent-roles.json`) copy-pasted as static text. When those JSON files change, the SKILL.md becomes stale silently.

| | Option A — Progressive disclosure | Option B — Extract to library | Option C — Accept as-is |
|-|----------------------------------|-------------------------------|-------------------------|
| **What** | Remove inline config embeds from lines 706–926. Replace with: `"Read .claude/config/complexity-rules.json when determining complexity threshold"`. Claude reads live JSON at runtime. | Move the agent-role and orchestration narrative into a new `.claude/library/research-instructions.md`. SKILL.md becomes a thin dispatcher. | Document the staleness risk; add a comment that embeds must be updated manually when JSON changes. |
| **Result** | SKILL.md drops to ~550–600 lines; config is always current | SKILL.md drops to ~200 lines; behavior concentrated in library | SKILL.md stays 930 lines |
| **Pros** | Fast (edit 1 file); live JSON; no new files | Maximum Anthropic alignment; cleanest skill | Zero change risk |
| **Cons** | Claude reads 3 JSON files at runtime (minor latency) | Adds another library file; more indirection | Drift risk remains; next JSON edit will silently break assumptions |
| **Effort** | Edit SKILL.md lines 706–926 (~30 min) | Edit SKILL.md + Write new library file (~90 min) | Write a comment (~5 min) |

**Recommendation:** Option A. Removes the staleness problem with minimal restructuring. Option B is architectural improvement territory — worth doing only if you also do proposal 2.3.

---

## 2.3 — 8 Transitive Library Files: Markdown vs Real Agents

**Problem:** Eight files (orchestration-lead, orchestration-iteration, orchestration-aggregator, research-agent-*) simulate agent behaviour in markdown. They total 5,490 lines. Anthropic now supports real `.claude/agents/` subagents with isolated context windows and tool access.

| | Option A — Migrate to .claude/agents/ | Option B — Keep as library markdown | Option C — Delete unused agents |
|-|--------------------------------------|-------------------------------------|----------------------------------|
| **What** | Convert each markdown "agent" to a proper `.claude/agents/<name>.md` subagent. research-adapter.md becomes the orchestration glue that spawns real agents. | No change — markdown instructions work today; Claude follows them inline. | Identify which of the 8 are actually invoked in practice; delete the ones never called. |
| **Pros** | Isolated context per agent (less prompt pollution); Anthropic-native pattern; each agent can use its own tools | Zero migration risk; works in all Claude Code versions | Reduces library size without architectural churn |
| **Cons** | Claude Code agent spawning has its own quota/latency tradeoffs; significant rewrite; research-adapter.md must be redesigned | 5,490 lines of markdown loaded into context; no isolation | Still leaves the architectural mismatch |
| **Effort** | Large (2–4 hours; each agent is a non-trivial rewrite) | Zero | Read logs to identify which agents fire; delete the rest (~1 hour) |

**Recommendation:** Option B for now, with Option C as a quick-win cleanup. Option A is the right long-term direction but requires Claude Code agents documentation review and a separate branch — not in scope for this cleanup. If you pick 2.2-A (debloat), the inline config references in lines 706–926 go away, which already reduces the worst staleness risk. The transitive files themselves are fine as markdown — they just shouldn't be copy-pasted into SKILL.md.

---

## 2.4 — CLAUDE.md ↔ prompt-perfection-core.md Duplication

**Problem:** Plan-First / Approval Gate is defined in two places with different wording:
- `CLAUDE.md`: "Počkať na y / yes / schvaľujem — nikdy nepredpokladaj súhlas"
- `prompt-perfection-core.md` Step 0.6: full approval gate with `switch [haiku|sonnet|opus]` option

If one is updated without the other, Claude gets contradictory signals depending on whether it's in a skill or in free conversation.

| | Option A — CLAUDE.md as thin pointer | Option B — Harden the boundary | Option C — Accept both, add comment |
|-|--------------------------------------|-------------------------------|-------------------------------------|
| **What** | Remove the Plan-First detail from CLAUDE.md; replace with: "In slash commands: follow Phase 0 Step 0.6. Outside slash commands: present a plan and wait for y/yes before any file change." One sentence, no duplicate gate. | Explicitly scope each gate: CLAUDE.md gate = free conversation only. Core Step 0.6 = slash commands only. Add a header to each: "This rule applies to [scope]." | Add a `<!-- SYNC WITH CLAUDE.md -->` comment to Step 0.6 and vice versa. |
| **Pros** | Single source of truth for gate logic | Clear separation; both can evolve independently | Zero structural change; low risk |
| **Cons** | Loses the explicit Slovak/English approval keywords from CLAUDE.md (user may need them) | Adds two scoped headers that must be kept accurate | Comments rot; doesn't prevent future divergence |
| **Effort** | Edit CLAUDE.md (~15 min) | Edit CLAUDE.md + edit prompt-perfection-core.md (~30 min) | Add two comments (~10 min) |

**Recommendation:** Option B. Explicit scoping is cleaner than a pointer and safer than a comment. CLAUDE.md governs free conversation; core governs skill flow. They serve different trigger contexts and can legitimately have different wording.

---

## 2.5 — reflect-diary as Template: Apply Minimalism to Other Skills?

**Problem / Question:** `reflect-diary` (97 lines, 0 library dependencies) is the cleanest skill in the repo. The three prompt skills have STARTUP blocks that read 3 memory files before any user input — a design choice to pre-fill context. The question is whether that trade-off is still the right default.

| | Option A — Keep STARTUP in all prompt skills | Option B — Remove STARTUP, use CLAUDE.md memory recall | Option C — Make STARTUP opt-in |
|-|----------------------------------------------|-------------------------------------------------------|-------------------------------|
| **What** | No change. STARTUP pre-fills project context on every skill invocation. | Remove STARTUP blocks from all three prompt skills. CLAUDE.md already says "check memory files before asking". | Add `[skip startup with /prompt --fast]` hint to YAML argument-hint. |
| **Pros** | User sees project context before answering; zero repeated questions | Reduces token cost per invocation; aligns with reflect-diary pattern | Flexible; power users skip, new users get help |
| **Cons** | Reads 3 files on every invocation even when context is obvious | CLAUDE.md memory recall is a softer hint; Claude may still ask "which stack?" | Adds complexity to the skill interface |
| **Effort** | Zero | Edit 3 SKILL.md files (remove STARTUP blocks ~30 min) | Edit 3 SKILL.md files + YAML frontmatter (~45 min) |

**Recommendation:** Option A — keep as-is. The STARTUP blocks exist because without them Claude asks "what's your tech stack?" on every invocation. The 3-file read is cheap compared to one back-and-forth clarification. `reflect-diary` works without STARTUP because it has no project-specific questions — it just reads diary files. That's a fundamentally different use case.

**Key finding:** reflect-diary is NOT a template for the other skills — it's a different category (stateless utility vs. project-aware assistant). The minimalism is correct for its use case, not universally better.

---

## Decision Table

| ID | Issue | Rec. | Alt. if rec. is wrong |
|----|-------|------|----------------------|
| 2.1 | VERSION drift | **A** — delete the file | B — fix to 5.0.0 |
| 2.2 | prompt-research debloat + stale embeds | **A** — progressive disclosure (remove inline config) | B — extract to library |
| 2.3 | 8 transitive markdown "agents" | **B** — keep + **C** — delete unused ones | A — migrate to .claude/agents/ (later) |
| 2.4 | CLAUDE.md ↔ core duplication | **B** — explicit scope headers | A — thin pointer |
| 2.5 | reflect-diary as template? | **A** — keep STARTUP, don't apply minimalism | B — remove STARTUP |

---

Ktoré proposals chceš executovať a v akom poradí?  
Reply: list IDs (napr. `2.1, 2.4`) alebo `all` alebo `none`.
