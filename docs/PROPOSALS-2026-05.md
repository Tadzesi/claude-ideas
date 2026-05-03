# PROPOSALS — 2026-05

Phase 2 architecture proposals for `claude-ideas` (v5.0.0). Five decision
points, each with 2-3 alternatives, a recommendation, and an open question
the owner must resolve before execution.

**Evidence base:** `docs/DIAGNOSTICS-2026-05.md` (Phase 1, read-only). All
citations below use the form "Diag §1.X". This document proposes; it does
not modify code or skills.

---

## Proposal 2.1 — Version drift fix

**Problem.** Per Diag §1.4, the source repo has no `.claude/VERSION` file
(it is created at install time by `install-claude-commands.ps1` lines
286-288), while `package.json`, root `CLAUDE.md` line 9, and the installer
all hard-code `5.0.0` independently. The user's auto-`MEMORY.md` is also
stale at v4.9.0. Four independent write sites for the same fact = guaranteed
drift on the next bump.

### Alternatives

| Variant | Files changed at bump time | Migration cost | What's lost | What's gained |
|---|---|---|---|---|
| **A. `package.json` is canonical SOT, sync script propagates** | At bump: `package.json` only. Sync script (new, ~30 LOC PowerShell) writes into `install-claude-commands.ps1` (lines 2, 55, 287, 288, 436) and `CLAUDE.md` line 9. Optional: `.claude/VERSION` written from `package.json` at build time and gitignored. | S | Hand-editable installer header (now generated). | Single bump command. CI can fail on drift via `npm version` hook. Aligned with how npm ecosystems already work. |
| **B. New committed `.claude/VERSION` file is SOT** | At bump: `.claude/VERSION` only. Installer reads it instead of hard-coding (`Get-Content $PSScriptRoot\.claude\VERSION`). `package.json` and `CLAUDE.md` updated by a tiny pre-commit / `npm version` hook. | M | `package.json` no longer the natural SOT for an npm-published artefact (the docs site is built from this repo, so npm `version` semantics still matter). | Lowest-friction bump for non-Node contributors. Removes the install-time generation of `.claude/VERSION` (file is now source-tracked, simpler installer). |
| **C. `CLAUDE.md` header is canonical, enforced by CI test** | At bump: `CLAUDE.md` line 9. CI test (extends `tests\validate-library-references.ps1`) parses the header and asserts `package.json`, installer constants, and a generated `.claude/VERSION` all match. | M | Bump now requires touching a prose file with a specific regex; brittle if header text is reworded. | Human-readable SOT. Forces a CI step that catches drift even if owner forgets the propagation. |

### Recommendation — **Variant A**

`package.json` already exists, is already at `5.0.0`, and is the only
file in the repo with machine-readable version semantics (used by
`npm version`, VitePress builds, and any future publish step). Making it
SOT requires no new committed file and uses existing tooling. The
propagation script is small, the installer continues to write
`.claude/VERSION` at install time (no behavioural change for installed
projects), and the user's `MEMORY.md` staleness is a separate process
issue (it lives in `~/.claude/projects/...` and is auto-managed by
Claude Code, not this repo's concern).

### Anthropic alignment

Not directly addressed by Anthropic skill docs; this is a project hygiene
concern. Closest reference: <https://docs.npmjs.com/cli/v10/commands/npm-version>
(`npm version` lifecycle hooks are the natural extension point).

### Open question for owner

Do you want the sync script to run as a `version` lifecycle hook in
`package.json` (auto on `npm version patch|minor|major`) or as a
standalone `scripts/sync-version.ps1` you invoke manually? The first is
zero-friction but couples to `npm`; the second keeps PowerShell-first
contributors comfortable.

---

## Proposal 2.2 — `prompt-research` debloat

**Problem.** Per Diag §1.3, `prompt-research/SKILL.md` is 3 355 words /
902 lines — more than 2× the next skill. Per Diag §1.4, it **declares**
~17 distinct external paths in CACHING + Library-Integration blocks, but
only **3** are actually `Read` at runtime
(`complexity-rules.json`, `orchestration-config.json`, `agent-roles.json`,
lines 706/716/722). The other 14 are listed as cache candidates or
"Configured by", which is neither directive nor used — pure noise that the
agent must parse on every load.

### Alternatives

| Variant | Files changed | Migration cost | What's lost | What's gained |
|---|---|---|---|---|
| **A. Progressive disclosure rewrite** | `prompt-research/SKILL.md` shrinks to <1500 words. Library-Integration footer (lines ~860-897) deleted; CACHING block trimmed to actually-used files. Each remaining external file documented inline at point of use as `Read X when you need Y` (Anthropic best-practice phrasing). No library files moved. | S | The "map" view of which files exist (replaceable by a `references/INDEX.md` or by the existing `docs/`). | -55% skill size, true on-demand loading, easier review. Aligns with Anthropic skills best-practices on progressive disclosure. |
| **B. Split into real subagents under `.claude/agents/`** | New: `.claude/agents/explore.md`, `security.md`, `performance.md`, `pattern.md`, `citation.md` (5 files with proper Anthropic frontmatter). Move bodies from `.claude/library/research-agent-*.md`. `prompt-research/SKILL.md` rewritten to invoke subagents via Task tool. Installer updated to deploy `.claude/agents/`. README + docs site updated. | L | Inline cohesion (skill currently describes orchestration in one place). Possible regression risk on iteration loop if subagent boundary is wrong. | Real Anthropic subagent semantics, isolated context per agent, parallelism is first-class, the 5 `research-agent-*.md` files become live code instead of TRANSITIVE-ONLY references (Diag §1.1). |
| **C. Accept eager declaration, document why** | One paragraph added to `prompt-research/SKILL.md` justifying the dependency surface as a deliberate predictability tradeoff. No file moves. | S | Nothing technical. | Honesty. Shipping cost: zero. But does not address the underlying noise. |

### Recommendation — **Variant A** (with Variant B as a follow-up if 2.3 lands)

Variant A is the cheapest correct move: it directly fixes Diag §1.4's
"declared but not Read" surface and brings the skill in line with
Anthropic's progressive-disclosure guidance
(<https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices>:
"Use SKILL.md for triggers and a brief overview... reference supporting
files only when needed"). Variant B is the architecturally clean answer
but multiplies blast radius — it should only be attempted **after** A
proves the smaller surface is actually correct, and after Proposal 2.3
decides the fate of `library/research-agent-*.md`.

### Anthropic alignment

- <https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices>
  (progressive disclosure, ≤5000 words, "Read X when you need Y" pattern)
- <https://docs.claude.com/en/docs/claude-code/sub-agents> (only relevant
  to Variant B; subagent frontmatter and Task-tool invocation contract)

### Open question for owner

Is `prompt-research`'s value primarily its **orchestration script** (one
agent that knows the whole flow) or its **specialist roles** (5 agents
with distinct expertise)? If the former, A is sufficient. If the latter,
A is a stepping stone to B and you should plan both.

---

## Proposal 2.3 — `library/` vs `agents/` refactor

**Dependency note:** outcome here is partially constrained by Proposal
2.2. If 2.2 picks Variant B (real subagents), this proposal collapses
into "execute the move." Read 2.2 first.

**Problem.** Per Diag §1.1, eight files in `.claude/library/` simulate
agent roles as markdown prompts:
- 3 ORPHANED: `orchestration-lead.md` (1 938 w), `orchestration-aggregator.md`
  (3 563 w), `orchestration-iteration.md` (2 779 w) — total 8 280 words
  reachable from no active skill.
- 5 TRANSITIVE-ONLY: `research-agent-{citation,explore,pattern,performance,security}.md`
  (5 999 words) — referenced only via `research-adapter.md` lists, never
  Read directly by a skill.

The folder name `library/` implies "shared utilities"; the contents are
"agent prompts." Naming and reality have drifted.

### Alternatives

| Variant | Files changed | Migration cost | What's lost | What's gained |
|---|---|---|---|---|
| **A. Promote to real subagents in `.claude/agents/`** | Move all 8 files (or just the 5 research-agent ones) into `.claude/agents/` with proper YAML frontmatter (`name`, `description`, `tools`). Update `research-adapter.md` references. Installer updated to deploy `.claude/agents/`. `prompt-research/SKILL.md` rewritten to invoke via Task tool. | L | Inline narrative of orchestration (now distributed). | Real Anthropic subagent semantics; orphans become live code. Pre-req for Proposal 2.2 Variant B. |
| **B. Rename folder to `library/agent-prompts/` for honesty** | `git mv .claude/library/{orchestration-*,research-agent-*}.md .claude/library/agent-prompts/`. Update all inbound refs (Diag §1.1 lists them — primarily `caching-strategy.md`, `prompt-perfection-core.md` Related Files block, install manifest, docs site, CHANGELOG, `research-adapter.md`). Installer manifest updated. | M | None functionally. | Folder name now matches contents. Zero behaviour change. Safer than A. |
| **C. Delete the 3 orphans, keep the 5 research-agent files** | Delete `orchestration-{lead,aggregator,iteration}.md`. Update `caching-strategy.md` cache-candidate list, `prompt-perfection-core.md` Related Files block, install manifest, docs/architecture pages, CHANGELOG. Add a one-paragraph note in `prompt-research/SKILL.md` explaining why the 5 specialist prompts remain in `library/` (used as reference material by `research-adapter.md`). | S | 8 280 words of unreachable prose. Some of it may contain useful design notes — owner should grep before deleting. | Smallest, safest cleanup. Forces an honest answer about whether orchestration files were ever live. |

### Recommendation — **Variant C**, with Variant A queued if 2.2 picks B

Variant C is the lowest-risk, highest-truth move. The 3 orphaned
orchestration files have **zero** inbound instructional refs (Diag §1.1)
— they fail the basic "is this code or is this a museum piece?" test.
The 5 research-agent files are at least transitively reachable; leave
them until Proposal 2.2's outcome tells us whether they should become
real subagents (A) or stay as prose (status quo). If 2.2 lands on
Variant B, escalate this proposal to A immediately.

### Anthropic alignment

- <https://docs.claude.com/en/docs/claude-code/sub-agents> — subagent
  frontmatter contract, file location convention (`.claude/agents/`)

### Open question for owner

Before deletion: do `orchestration-lead.md`, `orchestration-aggregator.md`,
or `orchestration-iteration.md` contain design notes, decision rationale,
or examples that exist nowhere else (e.g. in `docs/`)? If yes, salvage
into `docs/architecture/` first, then delete. If no, delete in one PR.

---

## Proposal 2.4 — `CLAUDE.md` ↔ `prompt-perfection-core.md` deduplication

**Problem.** Per Diag §1.2, four conventions are actively duplicated
between root `CLAUDE.md` (interaction-layer policy) and
`.claude/library/prompt-perfection-core.md` (Phase 0 implementation):
Plan-First, Approval Gate, Memory Recall, Proactive Option-Finding. Diag
flags Proactive Option-Finding as **HIGH** divergence risk and Approval
Gate / Memory Recall as **MEDIUM** — the Approval Gate vocabulary already
differs (`y/yes/schvaľujem` in CLAUDE.md vs. `approve/modify/explain/switch`
in ppc-core lines 626-664).

### Alternatives

| Variant | Files changed | Migration cost | What's lost | What's gained |
|---|---|---|---|---|
| **A. Strict layering — CLAUDE.md owns interaction, ppc owns prompt-structuring** | `prompt-perfection-core.md`: delete duplicate copies of Plan-First / Memory Recall / Proactive (Steps 0.2a, 0.25 framing, 0.35), keep only the Approval Gate (Step 0.6) since it is the slash-command-internal mechanism. Add cross-link to CLAUDE.md at top. `CLAUDE.md`: keep Interaction Protocol section as SOT for free conversation. Skills unchanged (they import ppc and continue to work). | M | Phase 0's self-contained quality (currently you can read ppc top-to-bottom and understand everything). | Each rule has exactly one home. No drift possible. Minimal skill churn. |
| **B. ppc is SOT for Phase 0, CLAUDE.md becomes thin `@import` wrapper** | `CLAUDE.md` Interaction Protocol section replaced with a one-line "see Phase 0 for full rules" pointing at ppc. `prompt-perfection-core.md` adds an Interaction Protocol block at top, lifted from CLAUDE.md. | M | The natural reading order (free-conversation users now have to chase an import to see the rules). Also: projects that install only `.claude/` without root CLAUDE.md still get the rules — but projects that install root CLAUDE.md without ppc lose them. | True single-source. Aligns with Anthropic's `@import` pattern. |
| **C. Status quo + automated drift-detection test** | New `tests/validate-conventions-parity.ps1` greps both files for the 4 duplicated phrases and fails if they diverge beyond a tolerance. Wired into CI / `validate-library-references.ps1`. | S | Nothing — duplication remains. | Cheap insurance. Owner keeps current narrative comfort. |

### Recommendation — **Variant A**

Variant A best matches the actual architectural intent visible in the
codebase: CLAUDE.md (lines 27-38) already says Plan-First's scope is
"voľná konverzácia a priame tool calls", and ppc-core line 618 already
says the Approval Gate's scope is "Inside slash commands". The boundary
is already drawn — the duplication is just lazy enforcement. Variant B
inverts the dependency direction (a project-root file importing from a
library is awkward). Variant C accepts the smell.

**Critical install consideration:** projects that install only `.claude/`
via `install-claude-commands.ps1` (without copying root `CLAUDE.md`) lose
the Interaction Protocol entirely. The installer should either (a) copy
`CLAUDE.md` into target's root by default, or (b) embed a minimal
Interaction Protocol stub in `.claude/CLAUDE.md`. This is a **separate
small workstream** triggered by Variant A, not a blocker.

### Anthropic alignment

- <https://docs.claude.com/en/docs/claude-code/memory> — memory file
  hierarchy and `@import` semantics; supports the "one file owns one
  concept" pattern.

### Open question for owner

Is the installed `.claude/` folder meant to be standalone (drop it into
any project, no root files needed), or does it always co-exist with a
project-specific root `CLAUDE.md`? Variant A's deduplication is only
safe if the answer is the second.

---

## Proposal 2.5 — `reflect-diary` as template

**Problem.** Per Diag §1.3, `reflect-diary` is 447 words / 97 lines / 0
external references — fully self-contained, with a clear Hard Rules
section. The other three skills weigh 1 614-3 355 words and import
`prompt-perfection-core.md` (4 222 words) plus 4-17 other paths. Question:
should the others be flattened to match?

### Alternatives

| Variant | Files changed | Migration cost | What's lost from prompt / prompt-article-readme / prompt-research | What's gained |
|---|---|---|---|---|
| **A. Rewrite the other 3 skills in reflect-diary's minimalist style — drop the `@import` to ppc** | Inline the relevant Phase 0 steps into each skill. ppc-core becomes reference doc only (or deleted). 4 222 words duplicated 3× = ~12 600 words across the three skills. | L | Shared Phase 0 evolution (a fix in ppc currently propagates to all 3); shared Anti-Hallucination Contract (ppc lines 12-35); shared model-router and execution-plan templates would also need inlining; shared Approval Gate vocabulary. Net: every Phase 0 improvement becomes a 3-file change. | Each skill is self-contained and independently inspectable. |
| **B. Keep core-import as feature, add opt-in minimalist mode** | New `.claude/library/prompt-perfection-core-mini.md` (~600 words: just Anti-Hallucination + Approval Gate + the canonical step list as references). Each skill chooses which to import via frontmatter or a top-level switch. | M | Nothing — additive. | Authors of new skills get a lean starting point. ppc full version remains for the 3 existing skills. |
| **C. Accept reflect-diary as outlier — its use case is fundamentally simpler** | None. Document this in `.claude/CLAUDE.md` or in `reflect-diary/SKILL.md` itself. | S | Nothing. | Honest. reflect-diary analyses existing data (no prompt rewriting → no Phase 0 needed). The other 3 transform user prompts into executable form (Phase 0 is the value). |

### Recommendation — **Variant C**

Phase 0 is the **product** of the prompt / prompt-article-readme /
prompt-research skills — flattening it (Variant A) destroys what makes
them useful. reflect-diary doesn't import Phase 0 because reflect-diary
isn't a prompt-perfection skill; it's an analysis skill with a different
job. The diagnostic surfaces a real difference, but the difference is
correct, not a bug. Variant B is reasonable insurance for future skills,
but YAGNI — wait until a 5th skill actually wants the lean path.

### Anthropic alignment

- <https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices>
  ("supporting files for content used only some of the time" — exactly
  what `prompt-perfection-core.md` is for the 3 prompt skills).

### Open question for owner

Is there a 4th or 5th skill on the roadmap that would benefit from the
lean style? If yes, B becomes worth doing now. If reflect-diary remains
the only analysis-style skill for the next ~6 months, lock in C.

---

## Decision matrix

| Proposal | Recommended variant | Effort | Blast radius | Dependencies | Reversibility |
|---|---|---|---|---|---|
| 2.1 — Version drift | A (`package.json` SOT + sync script) | S | Installer + CLAUDE.md header (low; humans rarely read these) | None | High — delete script, hand-edit again |
| 2.2 — prompt-research debloat | A (progressive disclosure rewrite) | S | One skill file; runtime behaviour unchanged | None (B follow-up depends on 2.3) | High — git revert |
| 2.3 — library/ vs agents/ | C (delete 3 orphans) | S | 5 inbound non-instructional refs to update | **Soft-depends on 2.2 outcome** (escalate to A if 2.2 picks B) | Medium — `git revert` brings files back; rebuilding cache-list refs is annoying |
| 2.4 — CLAUDE.md ↔ ppc dedup | A (strict layering) | M | All 3 prompt skills load ppc — they see fewer steps but still work; installer behaviour for `.claude/`-only installs needs a separate fix | None blocking, but installer fix is a follow-up | Medium — restoring duplicated blocks is mechanical |
| 2.5 — reflect-diary as template | C (accept as outlier, document) | S | Documentation only | None | Trivial |

---

*End of proposals. Execution requires explicit owner approval per
CLAUDE.md Plan-First protocol — no changes have been made.*
