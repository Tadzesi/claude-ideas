# DIAGNOSTICS-2026-05

**Branch:** cleanup/v5-honest-portfolio  
**Date:** 2026-05-02  
**Scope:** `.claude/library/`, `.claude/config/`, `.claude/skills/`, `CLAUDE.md`

Files read this session (grounding):
- `.claude/library/*.md` — 14 files, line counts via `wc -l`
- `.claude/skills/*/SKILL.md` — 4 files, grep for library/config refs
- `.claude/config/*.json` — 8 files, line counts via `wc -l`
- `CLAUDE.md`, `.claude/CLAUDE.md` — full read
- `.claude/VERSION`, `package.json` — version check

---

## 1.1 — Dependency Graph

### .claude/library/ (14 files)

| File | Lines | Direct skill refs | Library-to-library refs | Verdict |
|------|------:|-------------------|------------------------|---------|
| prompt-perfection-core.md | 922 | prompt, prompt-article-readme, prompt-research | caching-strategy, model-router | **USED** — foundation, all 3 skills |
| readme-adapter.md | 650 | prompt-article-readme | prompt-perfection-core (related) | **USED** — single skill |
| research-adapter.md | 747 | prompt-research | — | **USED** — single skill, orchestrates 8 sub-files |
| caching-strategy.md | 146 | prompt, prompt-article-readme, prompt-research | model-router, prompt-perfection-core | **USED** — all 3 skills |
| execution-plan-template.md | 156 | prompt, prompt-article-readme, prompt-research | prompt-perfection-core, caching-strategy | **USED** — all 3 skills |
| model-router.md | 160 | prompt, prompt-article-readme, prompt-research | prompt-perfection-core, caching-strategy | **USED** — all 3 skills |
| orchestration-lead.md | 567 | none directly | research-adapter invokes it | **TRANSITIVE-ONLY** |
| orchestration-iteration.md | 836 | none directly | orchestration-lead delegates to it | **TRANSITIVE-ONLY** |
| orchestration-aggregator.md | 1225 | none directly | orchestration-lead delegates to it | **TRANSITIVE-ONLY** |
| research-agent-citation.md | 745 | prompt-research (listed line 908) | research-adapter | **TRANSITIVE-ONLY** |
| research-agent-explore.md | 630 | prompt-research (listed line 907) | research-adapter | **TRANSITIVE-ONLY** |
| research-agent-pattern.md | 277 | prompt-research (listed line 911) | research-adapter | **TRANSITIVE-ONLY** |
| research-agent-performance.md | 195 | prompt-research (listed line 910) | research-adapter | **TRANSITIVE-ONLY** |
| research-agent-security.md | 215 | prompt-research (listed line 909) | research-adapter | **TRANSITIVE-ONLY** |

**Totals:** 14 files, 7,475 lines. 6 USED directly + 8 TRANSITIVE-ONLY (reachable only through research-adapter, which is itself reached only through prompt-research).

**TRANSITIVE-ONLY observation:** The 8 transitive files (orchestration-*, research-agent-*) total 5,490 lines — 73% of the library by volume. They are loaded exclusively when `/prompt-research` runs, but all 8 are referenced in the SKILL.md at lines 894–926. This is not hallucination — it is load-on-demand as documented. The architectural question (Phase 2) is whether markdown files should be replaced with real `.claude/agents/` subagents.

---

### .claude/config/ (8 files)

| File | Lines | Referenced by | Verdict |
|------|------:|---------------|---------|
| model-tiers.json | 202 | model-router.md, caching-strategy.md → all 3 skills | **USED** |
| complexity-rules.json | 453 | prompt-research SKILL.md line 706 (inline embed) | **USED** — but stale copy, not live read |
| orchestration-config.json | 315 | prompt-research SKILL.md line 721 (inline embed) | **USED** — but stale copy, not live read |
| agent-roles.json | 408 | prompt-research SKILL.md line 746 (inline embed) | **USED** — but stale copy, not live read |
| agent-templates.json | 84 | prompt-perfection-core.md (Related Files section only) | **TRANSITIVE-ONLY** — not confirmed read |
| citation-config.json | 250 | prompt-research SKILL.md line 925 (listed) | **TRANSITIVE-ONLY** |
| external-memory-config.json | 355 | prompt-research SKILL.md line 923 (listed) | **TRANSITIVE-ONLY** |
| iteration-rules.json | 453 | prompt-research SKILL.md line 924 (listed), orchestration-lead.md | **TRANSITIVE-ONLY** |

**Totals:** 8 files, 2,520 lines.

**Inline-embed smell:** `complexity-rules.json`, `orchestration-config.json`, and `agent-roles.json` content appears embedded as static text inside `prompt-research/SKILL.md` at lines 706–926 (labeled `From .claude/config/X.json:`). This makes the SKILL.md a stale copy that diverges every time the JSON is edited. These three configs are 1,176 lines combined — a significant chunk of the 2,520-line config total that could drift silently.

---

## 1.2 — CLAUDE.md vs prompt-perfection-core.md Duplication

| Convention | CLAUDE.md location | prompt-perfection-core.md location | Drift risk |
|-----------|-------------------|-----------------------------------|------------|
| Memory Recall order | "CRITICAL: Before asking... check project-profile.md, sessions.md, prompt-patterns.md" | Step 0.1 RECALL — same three files | **MEDIUM** — if file list changes in one place, the other lags |
| Plan-First / Approval Gate | "Pred akoukoľvek zmenou... 1. Zhrnúť... 4. Počkať na y/yes" (global protocol) | Step 0.6 APPROVE — approval gate keywords | **HIGH** — two gates, different wording. If approval keywords change in core, CLAUDE.md still lists old ones |
| Language protocol (SK/EN) | Explicit: "User píše po slovensky... Interné myslenie v angličtine" | Step 0.1 detects prompt language implicitly | **LOW** — CLAUDE.md is more explicit; core detection is a subset |
| Never Auto-Execute | "Nikdy git commit, git push, npm install bez súhlasu" | Not in core | **NONE** — correct separation; global rule stays in CLAUDE.md |
| Execution Plan format | Not in CLAUDE.md | Step 0.55 → execution-plan-template.md | **NONE** — correct; CLAUDE.md doesn't need to know the format |
| Coding conventions | "File naming: kebab-case, Version: semantic" | Not in core | **NONE** — correct separation; project conventions belong in CLAUDE.md |

**Highest-risk duplication: Plan-First / Approval Gate.** CLAUDE.md tells Claude to "počkať na y/yes/schvaľujem" globally. prompt-perfection-core.md Step 0.6 has its own approval gate with its own wording and response options (`switch [haiku|sonnet|opus]`). When a user interacts outside a skill (plain conversation), only CLAUDE.md fires. Inside a skill, Step 0.6 fires. These are not identical — they can contradict.

**Memory Recall order:** Both list the same three files in the same order today. Safe, but fragile — a single edit in one place breaks the other.

---

## 1.3 — Anthropic Alignment Audit

Reference: https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices

| Skill | Lines | Est. words | Gerund name? | Pushy description? | Bundled scripts? | Config inline-pasted? | Key concern |
|-------|------:|-----------:|-------------|-------------------|-----------------|----------------------|-------------|
| prompt | 421 | ~2,100 | No — noun | No | No | No | Name is a noun, not gerund |
| prompt-article-readme | 465 | ~2,300 | No — noun phrase | No | No | No | Name is descriptive but not gerund; hyphen-heavy |
| prompt-research | 930 | ~5,600 | No — noun phrase | No | No | YES (3 configs, lines 706–926) | **OVER** ~5,000-word guideline; stale config embeds |
| reflect-diary | 97 | ~490 | No — verb+noun | No | No | No | Cleanest skill in repo; benchmark for the others |

**5,000-word limit:** Only `prompt-research` exceeds the guideline (~5,600 words estimated). The three inline-pasted config blocks (complexity-rules, orchestration-config, agent-roles) account for approximately 300–500 lines of that total. Removing them and replacing with runtime `Read` instructions would likely bring the skill within the limit.

**Gerund naming:** None of the 4 skills use gerund form. Anthropic recommends names like "Generating a README" or "Researching a codebase". The current names are all noun/verb phrases. This is a discoverability concern (Claude auto-invokes skills based on description match, not name), not a functional break.

**Pushy descriptions:** None found. All descriptions are neutral statements of what the skill does, not instructions telling Claude when to use it.

**Bundled scripts:** None. All skills are pure markdown instructions. Correct.

**reflect-diary as benchmark:** At 97 lines and 0 external dependencies, `reflect-diary` matches Anthropic's progressive-disclosure recommendation perfectly. It states what it does, gives a clear flow, and reads nothing until the user runs it. The other three skills have STARTUP blocks that read 3 memory files before any user question — this is a deliberate trade-off (context pre-filling) but worth revisiting.

---

## 1.4 — Version Drift

| Source | Value |
|--------|-------|
| `.claude/VERSION` | **4.7.0** |
| `package.json` version | **5.0.0** |
| CLAUDE.md header | 5.0.0 |
| `.claude/CLAUDE.md` header | 5.0.0 |
| installer announce | 5.0.0 |

`.claude/VERSION` was not updated during the v5.0.0 release. It is the only file still on 4.7.0.

**Canonical source question (for Phase 2):** There are four places that could be canonical. `package.json` is the npm standard; `.claude/VERSION` was added for Claude Code `$CLAUDE_VERSION` variable access; CLAUDE.md is human-readable; installer reads from none of these (it hardcodes "5.0.0" in a `Write-Host` string). No automated enforcement exists.

---

## Summary

| Area | Issue | Severity |
|------|-------|----------|
| `.claude/VERSION` | 4.7.0 while everything else is 5.0.0 | Low (no runtime impact, confusing for humans) |
| prompt-research/SKILL.md | 930 lines, ~5,600 words — over Anthropic guideline | Medium |
| prompt-research/SKILL.md | Config content copy-pasted at lines 706–926 (stale, will drift) | Medium |
| 8 transitive library files | Only used by prompt-research; total 5,490 lines of markdown simulating agents | Low-Medium (architectural, not broken) |
| CLAUDE.md ↔ core | Plan-First / Approval Gate duplicated with different wording | Medium |
| Skill names | None use gerund form per Anthropic recommendation | Low |

---

Pokračovať na PHASE 2 návrhmi? (y/n)
