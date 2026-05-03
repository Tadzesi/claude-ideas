# DIAGNOSTICS — 2026-05

Read-only Phase 1 architecture diagnostic for `claude-ideas` (v5.0.0).
**No recommendations. No proposals. Facts only.** Phase 2 will decide actions.

Active skills considered: `prompt`, `prompt-article-readme`, `prompt-research`,
`reflect-diary`.

---

## Section 1.1 — Dependency graph for `library/` and `config/`

Reachability rules:
- **USED** = directly referenced (path-mention or `@import`) from at least one
  active skill's `SKILL.md`.
- **TRANSITIVE-ONLY** = referenced only from a USED library/config file
  (reachable via one or more hops, but no skill mentions it directly).
- **ORPHANED** = not reachable from any active skill, directly or transitively.
  Inbound refs (if any) come only from docs, archived material, installer, or
  the file's own self-reference.

Word counts use `wc -w` on the literal file. Inbound refs were collected with
`grep -rn '<basename>' --include='*.md' --include='*.json' --include='*.ps1'`
(node_modules, .git, docs-archive excluded). Only refs that constitute an
actual instruction or import are summarised in the "Inbound" column; install
manifest, docs site, and CHANGELOG mentions are noted but do not count for
reachability.

Library lives entirely at `.claude/library/` root — there are **no
subdirectories** (see Section 1.4).

Sorted: ORPHANED → TRANSITIVE-ONLY → USED.

| File (path) | Words | Inbound refs (instructional) | Reachable from active skill? | Verdict |
|---|---:|---|---|---|
| `.claude/library/orchestration-lead.md` | 1938 | None from skills. Mentioned only in `caching-strategy.md` (as cache-candidate list), `prompt-perfection-core.md` Related Files block, install manifest, docs/architecture, CHANGELOG. `prompt-research/SKILL.md` does NOT instruct a Read of this file. | No | **ORPHANED** |
| `.claude/library/orchestration-aggregator.md` | 3563 | Same pattern: cache-list + install + docs only. No skill instructs a Read. | No | **ORPHANED** |
| `.claude/library/orchestration-iteration.md` | 2779 | Same pattern. | No | **ORPHANED** |
| `.claude/library/research-agent-citation.md` | 2078 | Listed in `prompt-research/SKILL.md` Library-Integration section as "Specialized Agents" but never as a Read instruction. Referenced by `research-adapter.md` (USED) and `caching-strategy.md`. | Yes — via `research-adapter.md` listing | **TRANSITIVE-ONLY** |
| `.claude/library/research-agent-explore.md` | 1758 | Same: listed in `prompt-research/SKILL.md` Library-Integration block, referenced by `research-adapter.md`. No live Read. | Yes — via `research-adapter.md` | **TRANSITIVE-ONLY** |
| `.claude/library/research-agent-pattern.md` | 839 | Same. | Yes — via `research-adapter.md` | **TRANSITIVE-ONLY** |
| `.claude/library/research-agent-performance.md` | 601 | Same. | Yes — via `research-adapter.md` | **TRANSITIVE-ONLY** |
| `.claude/library/research-agent-security.md` | 723 | Same. | Yes — via `research-adapter.md` | **TRANSITIVE-ONLY** |
| `.claude/config/agent-roles.json` | 784 | `prompt-research/SKILL.md:722` ("Read `.claude/config/agent-roles.json` for current agent definitions"). Also listed in `prompt-research/SKILL.md:894` Configuration Files block; referenced by `research-adapter.md`, `research-agent-explore.md`, `research-agent-citation.md`. | Yes — directly | **USED** |
| `.claude/config/agent-templates.json` | 1518 | `.claude/CLAUDE.md:38` ("Agent templates: @.claude/config/agent-templates.json"); also listed in `prompt-perfection-core.md:907` Related Files block. No skill instructs a Read of this file. | Yes — via `.claude/CLAUDE.md` import + ppc Related Files | **USED** (by import in `.claude/CLAUDE.md`) |
| `.claude/config/citation-config.json` | 519 | `prompt-research/SKILL.md:897` Configuration Files list; `research-adapter.md`, `research-agent-citation.md` reference it. No skill Read instruction. | Yes — listed in skill | **USED** (passive reference) |
| `.claude/config/complexity-rules.json` | 1000 | `prompt-research/SKILL.md:706` ("Read `.claude/config/complexity-rules.json` for current thresholds"); `prompt-perfection-core.md:61, 906` reference it. | Yes — directly | **USED** |
| `.claude/config/external-memory-config.json` | 647 | `prompt-research/SKILL.md:895` Configuration Files list; referenced by `orchestration-aggregator.md` (orphaned) and `research-adapter.md`. | Yes — listed in skill | **USED** (passive reference) |
| `.claude/config/iteration-rules.json` | 1095 | Listed in `prompt-research/SKILL.md` Configuration Files block; referenced from `orchestration-iteration.md` (orphaned) and `research-adapter.md`. | Yes — listed in skill | **USED** (passive reference) |
| `.claude/config/model-tiers.json` | 720 | `model-router.md`, `caching-strategy.md`, `prompt-perfection-core.md:906` reference it; all 3 skills' STARTUP CACHING block names it. | Yes — via library chain | **USED** |
| `.claude/config/orchestration-config.json` | 656 | `prompt-research/SKILL.md:716` ("Read `.claude/config/orchestration-config.json`"); also `:893` Configuration Files list. | Yes — directly | **USED** |
| `.claude/library/caching-strategy.md` | 541 | All 3 prompt skills (`prompt`, `prompt-article-readme`, `prompt-research`) STARTUP block: `**CACHING (Opus 4.7 — see .claude/library/caching-strategy.md):**`. Also `prompt-perfection-core.md:915` Related Files; `model-router.md:144`; `model-tiers.json:175`. | Yes — directly | **USED** |
| `.claude/library/execution-plan-template.md` | 681 | `prompt-perfection-core.md:584, 610, 885, 912`; `prompt/SKILL.md:50, 255`; `prompt-article-readme/SKILL.md:24, 39`; `prompt-research/SKILL.md:28, 51`. | Yes — directly | **USED** |
| `.claude/library/model-router.md` | 743 | `prompt-perfection-core.md` indirectly; `prompt/SKILL.md:50`, `prompt-article-readme/SKILL.md:24`, `prompt-research/SKILL.md:28, 52`; `caching-strategy.md`. | Yes — directly | **USED** |
| `.claude/library/prompt-perfection-core.md` | 4222 | All 3 prompt skills import Phase 0 from this file: `prompt/SKILL.md:385`, `prompt-article-readme/SKILL.md:24, 31`; `prompt-research/SKILL.md:24, 28`. Also imported transitively by `readme-adapter.md`, `research-adapter.md`. Foundation. | Yes — directly | **USED** |
| `.claude/library/readme-adapter.md` | 2051 | `prompt-article-readme/SKILL.md` (and that skill only). Adapter for the README domain. | Yes — directly | **USED** |
| `.claude/library/research-adapter.md` | 2424 | `prompt-research/SKILL.md` STARTUP CACHING block + Library-Integration section. | Yes — directly | **USED** |

**Summary counts:**

- ORPHANED: 3 files / 8 280 words
  (`orchestration-lead`, `orchestration-aggregator`, `orchestration-iteration`)
- TRANSITIVE-ONLY: 5 files / 5 999 words
  (all `research-agent-*.md`)
- USED: 14 files (7 library + 7 config) / 17 601 words
- `reflect-diary/SKILL.md` references **zero** files in library/ or config/ —
  it is fully self-contained.

**Caveat on "USED":** "Listed in a Related Files / Configuration Files block"
is counted as USED because the skill names the file, but it is qualitatively
weaker than an actual `Read X for Y` instruction. Only three configs receive
an explicit Read instruction inside an active skill:
`complexity-rules.json`, `orchestration-config.json`, `agent-roles.json`
(all in `prompt-research/SKILL.md` Configuration section, lines 706/716/722).

---

## Section 1.2 — `CLAUDE.md` vs `prompt-perfection-core.md` duplication

Files inspected:
- Root `CLAUDE.md` — 132 lines (read in full).
- `.claude/library/prompt-perfection-core.md` — 922 lines (read line-numbered).

Note: root `CLAUDE.md` imports `@.claude/CLAUDE.md` (line 5). `.claude/CLAUDE.md`
is short and mostly delegates to memory + rules; conventions below were located
by `grep -n` across both files.

| Convention | Location in `CLAUDE.md` | Location in `prompt-perfection-core.md` | Risk if they diverge |
|---|---|---|---|
| **Plan-First Execution** | Lines 27–38, "### Plan-First Execution (CRITICAL)". Scope explicitly noted: "voľná konverzácia a priame tool calls. Vo vnútri slash commandov rieši approval gate Phase 0 Step 0.6." | Step 0.55 (line 577) "Execution Plan + Model Selection — mandatory for all non-Question prompts" + Step 0.6 (line 616) "Approval Gate" with explicit cross-link: "Scope: Inside slash commands (Phase 0 flow). Free conversation is governed by CLAUDE.md Plan-First." (line 618). | **LOW** — boundary is explicitly carved on both sides. Risk: if either side is renamed/removed, the cross-link goes stale silently. |
| **Approval Gate** | Implicit in Plan-First ("Počkať na `y` / `yes` / `schvaľujem`") at line 34 | Step 0.6 (line 616), full output template (lines 626–664), accepted responses table (`approve`, `modify`, `explain`, `switch`, `reset`). | **MEDIUM** — `CLAUDE.md` only knows `y / yes / schvaľujem`; ppc-core knows `approve / modify [X] / explain [X] / switch [tier]`. The two vocabularies differ. Slash-command users see one set, free-conversation users see another. |
| **Memory Recall** | Lines 84–92, "### Memory Recall" — CRITICAL block instructing to check `project-profile.md`, `sessions.md`, `prompt-patterns.md` before asking. Applies to ALL interactions. | Step 0.2a (line 262) "Memory Recall (v1.6 — ALWAYS LOAD FIRST)" — same intent, slightly different file list (also references `personal-profile.md`, `architectural-context.md` in places). | **MEDIUM** — same rule expressed twice. If file list changes (e.g. memory restructure), both sides must be updated in sync; nothing enforces this. |
| **Language rules (SK user / EN code)** | Lines 22–25, "### Language" — explicit 3-bullet rule. | Step 0.1 (line 119) "Detect language: Slovak / English / Other". The detect step is procedural, not a policy statement. No "respond in Slovak, code in English" rule inside ppc-core. | **LOW** — different concerns. CLAUDE.md sets policy, ppc-core sets a detection action. Asymmetry is intentional but undocumented. |
| **Never Auto-Execute** | Lines 44–46, "### Never Auto-Execute" — git/install/npm explicitly forbidden without approval. | — (no equivalent block; ppc-core's Approval Gate covers slash-command execution but does not enumerate forbidden auto-actions). | **MEDIUM** — only stated in CLAUDE.md. If a future skill executes inside Phase 0 without re-checking, the rule isn't surfaced. |
| **Proactive Option-Finding** | Lines 40–42, "### Proactive Option-Finding" — Claude must surface better paths PRE-execution. | Step 0.35 (line 442) "Options-First — default ON for Task/Feature/Bug Fix/Refactor". Almost the same idea, framed as a Phase 0 step. | **HIGH** — same behaviour described twice with different triggers and granularity. CLAUDE.md says "always when you see a better path"; ppc Step 0.35 says "default ON for these prompt types, show 2–3 options". If one is updated, the other will quietly drift. |
| **Phase 0 step list** | Line 73: "All three commands share Phase 0 (prompt analysis, clarification, structuring) imported from `.claude/library/prompt-perfection-core.md`". One sentence, no enumeration. | Lines 44–55 contain the full canonical flow text: `0.1 → 0.11 → 0.12 → 0.2 → 0.25 → 0.3 → 0.35 → 0.4 → 0.5 → 0.55 → 0.6`. Plus Fast Path (line 58). | **LOW** — CLAUDE.md correctly delegates ("imported from"). Single source of truth. No duplication. |
| **Execution Plan format** | — (not in CLAUDE.md) | Step 0.55 (line 577) → delegates to `execution-plan-template.md`. | **NONE** — correctly single-sourced. |
| **Anti-Hallucination Contract** | — | ppc-core lines 12–35 ("## Anti-Hallucination Contract"). | **NONE** — only in ppc; appropriate. |
| **Response style (plain text in terminal)** | Lines 11–18, "## Response Style Guidelines" — no markdown/emojis/headers, 80-char lines. | — (not in ppc). | **NONE** — correctly single-sourced in CLAUDE.md. |
| **Project version / project overview** | Lines 7–9 (claims "v5.0.0", "three slash commands"). | Self-version line in ppc footer ("v2.1 (2026-04-16)"). | **MEDIUM** — see Section 1.4 (version drift). |

**Pure-overlap conventions** (same intent, expressed in both files):
Plan-First, Approval Gate, Memory Recall, Proactive Option-Finding.
That is **4 conventions** with active duplication risk.

---

## Section 1.3 — Anthropic alignment audit per skill

References used to score:
- https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices
  (gerund/verb-noun naming, ≤ ~5000 words, non-pushy descriptions, progressive
  disclosure, gotchas)
- https://code.claude.com/docs/en/skills (frontmatter fields, supporting files)
- https://github.com/anthropics/skills (template, scripts/, references/, assets/)

| Skill | Words in SKILL.md | External refs (count + list) | Gerund name? | Pushy description? | Bundled scripts/references/assets? | Gotchas section? | Notes |
|---|---:|---|---|---|---|---|---|
| `prompt` | 1837 (421 lines) | **5** library refs in body: `prompt-perfection-core.md`, `model-router.md`, `execution-plan-template.md`, `model-tiers.json` (via STARTUP CACHING block), `caching-strategy.md`. No external `Read` outside startup. | **No** — bare noun "prompt" (not "prompting" / "perfecting-prompts"). | No. Description: "Transform any prompt into an unambiguous, executable format. Use when the user wants to refine or perfect a prompt…" — neutral, "Use when" phrasing matches Anthropic guidance. | No. Only `SKILL.md` in dir. | No explicit "Gotchas" header, but contains `**Editing core library:**` warning at line 385 — a single inline caveat. | Has `persona:` field in frontmatter (multi-line YAML block) — not a standard Anthropic frontmatter field; specific to this project. |
| `prompt-article-readme` | 1614 (465 lines) | **5** library refs: `prompt-perfection-core.md`, `readme-adapter.md`, `execution-plan-template.md`, `model-router.md`, `model-tiers.json`. | **No** — compound noun "prompt-article-readme". Not gerund / verb-noun (e.g. "generating-readmes", "writing-readme"). | No. "Generates or updates a professional README.md for any project … Use when the user wants to create or update a README with an interactive wizard." Neutral. | No. Only `SKILL.md`. README templates are inline (Usage section, ~3.9 KB indexed) rather than in `references/`. | No "Gotchas" section. | Embeds full example READMEs and section templates inline — could be `references/templates/*.md`. |
| `prompt-research` | 3355 (902 lines) | **17 distinct external paths** referenced in body: `project-knowledge.md`, `architectural-context.md` (memory STARTUP); `prompt-perfection-core.md`, `research-adapter.md`, `execution-plan-template.md`, `model-router.md`, `model-tiers.json`, `orchestration-lead.md`, `orchestration-iteration.md`, `orchestration-aggregator.md` (CACHING block); `complexity-rules.json`, `orchestration-config.json`, `agent-roles.json` (live `Read` instructions, lines 706/716/722); `external-memory-config.json`, `citation-config.json`, `iteration-rules.json` (Configuration Files list); 5 `research-agent-*.md` (Library-Integration list). | **No** — bare noun. | Borderline. "Deep multi-agent research command for comprehensive codebase analysis using orchestrator-worker architecture with iterative refinement. Use for architecture analysis, security audits, performance investigations…" — long, name-drops architecture, but ends with "Use for" rather than "MUST use immediately". Not pushy by Anthropic's hard examples. | No subdirs. All 902 lines live in single `SKILL.md`. | No explicit "Gotchas" header. Contains a "Troubleshooting" section (lines indexed: Research Takes Too Long, Low Coverage, Too Many Findings, Cache Not Working) which serves a similar role. | **Largest skill by far.** 3355 words is below the 5000-word soft ceiling, but >2× the next skill. Library-Integration block (lines ~860–897) lists 14+ files as "configured by" / "uses" — most are not actually Read at runtime, creating reachability noise (see 1.1 TRANSITIVE-ONLY rows). |
| `reflect-diary` | 447 (97 lines) | **0** library refs. **0** config refs. Only points at `.claude/memory/diary/` (data) and `.claude/memory/` files for proposed updates. Fully self-contained. | **No** — but verb-noun-ish ("reflect" + noun "diary"). Closer to gerund than the others. | No. "Analyze session diary entries for this project, identify recurring patterns, and PROPOSE (not auto-apply) updates to memory files." — very plain, includes explicit safety hint ("PROPOSE not auto-apply"). | No. Only `SKILL.md`. | Has "Hard Rules" section (indexed) — functions as a gotchas/constraints block. Closest of the four to Anthropic's pattern. | Reads as a model of what Anthropic skill best-practices encourage: minimal, single-file, self-contained, explicit safety rule, no external reach. |

**Cross-skill observations:**

- 0 of 4 skills use gerund/verb-noun names. All use bare-noun or
  domain-prefixed bare-noun.
- 0 of 4 skills have a `references/`, `scripts/`, or `assets/` subdirectory.
  All knowledge is in the body of `SKILL.md` (or imported from `library/`).
- 1 of 4 skills (`prompt-research`) has multi-line description that name-drops
  architecture; could be tightened.
- 1 of 4 skills (`reflect-diary`) follows the Anthropic-template style closely
  (small, self-contained, Hard Rules block).
- Only `prompt/SKILL.md` uses the non-standard `persona:` frontmatter field.
- No skill has an explicit `## Gotchas` header; `prompt-research` has
  "Troubleshooting" and `reflect-diary` has "Hard Rules" as functional
  equivalents.

---

## Section 1.4 — Quick facts

### Version drift

| Source | Stated version | Notes |
|---|---|---|
| `.claude/VERSION` | **NOT FOUND** | File does not exist on disk in this worktree. |
| `package.json` (`"version"` field) | `5.0.0` | Confirmed. |
| `install-claude-commands.ps1` | `5.0.0` (multiple sites: header `### Version: 5.0.0`, `"5.0.0" \| Out-File ... VERSION`, `Write-Success "Version file created (v5.0.0)"`). The installer **creates** `.claude/VERSION` on install. | The installer is the SOT for the on-disk VERSION file in target installs; it is missing in source. |
| Root `CLAUDE.md` (line 9) | `claude-ideas (v5.0.0)` | Matches package.json. |
| `.claude/library/prompt-perfection-core.md` | Self-version `v2.1 (2026-04-16)` (per CHANGELOG-skills pointer in body) — does **not** track project version. | Independent versioning. |
| Memory `MEMORY.md` header | `Last Updated: 2026-04-22`, `Project: claude-ideas (Claude Commands Library v4.9.0)` | **STALE** — claims v4.9.0 while project is at v5.0.0. |

**Drift summary:** Two real drifts: (1) `.claude/VERSION` file missing from
the source repo (only created on install); (2) the user's auto-`MEMORY.md` is
stale at v4.9.0. `package.json`, `CLAUDE.md`, and the installer agree on v5.0.0.

### Library file count: root vs subdirectories

- `.claude/library/*.md` (root): **14** files
- `.claude/library/**/*` (any subdirectory, mindepth ≥ 2): **0** files
- **There are no subdirectories under `library/`.** All files are flat.
  (CLAUDE.md / memory mentions an "adapters/" path in places but that path
  does not exist on disk — confirmed by `find .claude/library -mindepth 2`.)

### `prompt-research` SKILL.md — every external file it instructs the agent to read

Captured by grepping for `Read \``, `read \``, `@.claude`, and explicit Read
verbs in the body of `.claude/skills/prompt-research/SKILL.md`. The file does
not eagerly inline config bodies (any past inline embeds have been removed —
the body now contains short Read instructions only). Relevant lines:

| Line | Instruction | File |
|---:|---|---|
| 21 | `Read \`.claude/memory/project-knowledge.md\`` | memory |
| 22 | `Read \`.claude/memory/architectural-context.md\`` | memory |
| 23 (implied) | "Read last 3 sessions from `.claude/memory/sessions.md`" | memory |
| 51 | `(see @.claude/library/execution-plan-template.md` | library import |
| 52 | `and @.claude/library/model-router.md)` | library import |
| 706 | `Read \`.claude/config/complexity-rules.json\` for current thresholds.` | config |
| 716 | `Read \`.claude/config/orchestration-config.json\` for strategy templates.` | config |
| 722 | `Read \`.claude/config/agent-roles.json\` for current agent definitions.` | config |

Plus the STARTUP CACHING block (lines 27–34) **names** as cache candidates:
`prompt-perfection-core`, `research-adapter`, `execution-plan-template`,
`model-router`, `model-tiers`, `orchestration-lead`, `orchestration-iteration`,
`orchestration-aggregator`. Naming a file as a cache candidate is not the
same as instructing a Read; the orchestration-* files are listed but never
Read by any active skill (see Section 1.1 — these are the 3 ORPHANED rows).

The Library-Integration footer (lines ~860–897) **lists** another 14+ paths
under "Configured by" / "Specialized Agents" / "External Memory" headings.
These are descriptive, not directive — no Read verb.

**Eager-loading verdict (factual, not opinion):** the skill body does NOT
inline-paste config JSON or library content. It does, however, **declare** a
large dependency surface (~17 distinct external paths) in CACHING + Library-
Integration blocks. Three of those paths are actually Read at runtime
(`complexity-rules`, `orchestration-config`, `agent-roles`); the rest are
named but not opened by the skill itself.

---

## Files actually read this session (evidence appendix)

Files opened in full or examined with `cat -n` / `sed -n`:

- `CLAUDE.md` (root, 132 lines, full)
- `.claude/CLAUDE.md` (full)
- `.claude/library/prompt-perfection-core.md` (full, 922 lines, line-numbered)
- `.claude/skills/prompt/SKILL.md` (full, 421 lines + frontmatter)
- `.claude/skills/prompt-article-readme/SKILL.md` (full, 465 lines + frontmatter)
- `.claude/skills/prompt-research/SKILL.md` (full, 902 lines + frontmatter; key
  ranges 700–730 and 880–930 re-read line-by-line for inline-embed check)
- `.claude/skills/reflect-diary/SKILL.md` (full, 97 lines + frontmatter)
- `package.json` (version field only)
- `install-claude-commands.ps1` (version-related lines only, via grep)

Directory listings:
- `.claude/library/` (flat listing)
- `.claude/config/` (flat listing)
- `.claude/skills/*/` (subdirectory check — confirmed all skills are
  single-file)

Word counts (`wc -w`):
- All 14 files in `.claude/library/`
- All 8 files in `.claude/config/`
- All 4 active `SKILL.md` files

Inbound-reference grep (one query per filename, scoped to `*.md` / `*.json`
/ `*.ps1`, excluding `node_modules`, `.git/`, `docs-archive`):
- `prompt-perfection-core`, `readme-adapter`, `research-adapter`,
  `model-router`, `execution-plan-template`, `caching-strategy`,
  `orchestration-lead`, `orchestration-aggregator`,
  `orchestration-iteration`, `research-agent-citation`,
  `research-agent-explore`, `research-agent-pattern`,
  `research-agent-performance`, `research-agent-security`,
  `agent-roles`, `agent-templates`, `citation-config`,
  `complexity-rules`, `external-memory-config`, `iteration-rules`,
  `model-tiers`, `orchestration-config`

Files NOT opened (not required for diagnostic): all `.claude/library/*.md`
bodies (only inbound refs were inspected, not contents); `.claude/config/*.json`
bodies (only inbound refs); `docs/` site pages; `.claude/memory/*` files;
`tests/`; CHANGELOG bodies (only grep hits surfaced).

---

*End of diagnostic. Phase 2 (recommendations) intentionally not included.*
