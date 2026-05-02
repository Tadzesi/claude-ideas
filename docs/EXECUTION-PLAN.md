# Execution Plan: claude-ideas Cleanup v5.0

**Goal:** Reduce repo from "AI-hype-driven feature inflation" to "honest portfolio piece signalling senior engineering".

**Context:** Owner uses only 3 commands in practice (`/prompt`, `/prompt-article-readme`, `/prompt-research`). Repo is portfolio (mainly self-use, but visible externally on GitHub profile). Goal is *less, but defensible* — not more.

**Critical execution rules (apply throughout):**

- Plan-First Execution rule from CLAUDE.md applies. Before each phase, summarize what you'll do and ask `y/n`.
- Never `git commit` or `git push` without explicit approval.
- Preserve `.claude/memory/` content (user data) unless this plan explicitly says to delete it.
- All file deletions must use `git rm` so they're tracked, not just `rm`.
- Work on a new branch: `cleanup/v5-honest-portfolio`. Do NOT push to main.
- After each phase, stop and report what was done. User reviews before next phase.

---

## Phase 0: Setup branch and inventory (READ-ONLY)

1. Create branch: `git checkout -b cleanup/v5-honest-portfolio`
2. Inventory current state — produce a single report:
   - `tree .claude/ -L 3` (or PowerShell equivalent)
   - List of files in `.claude/commands/`, `.claude/skills/`, `.claude/library/`, `.claude/library/adapters/`, `.claude/library/intelligence/`, `.claude/library/orchestration/`, `.claude/library/agents/`
   - Line counts per file in `.claude/library/` (use `wc -l` or `Get-Content | Measure-Object -Line`)
   - Total markdown lines in repo: `Get-ChildItem -Recurse -Filter *.md | Get-Content | Measure-Object -Line`
3. Print the report. **STOP. Wait for user confirmation before Phase 1.**

---

## Phase 1: Delete unused commands and skills

**Decision:** Keep only 3 commands (`prompt`, `prompt-article-readme`, `prompt-research`). Delete the rest.

### Files to delete (use `git rm`):

**Commands (legacy format):**
- `.claude/commands/prompt-hybrid.md`
- `.claude/commands/prompt-technical.md`
- `.claude/commands/prompt-article.md`
- `.claude/commands/reflect.md`

**Skills (new format):**
- `.claude/skills/prompt-hybrid/` (entire directory)
- `.claude/skills/prompt-dotnet/` (entire directory)
- `.claude/skills/prompt-react/` (entire directory)
- `.claude/skills/deploy/` (entire directory)
- `.claude/skills/new-stack/` (entire directory)
- `.claude/skills/reflect/` (entire directory)

**Adapters (only keep what kept commands need):**
- `.claude/library/adapters/technical.md` — DELETE
- `.claude/library/adapters/article.md` — DELETE (article command being removed; readme stays)
- `.claude/library/adapters/session.md` — DELETE (reflect being removed)
- `.claude/library/adapters/hybrid.md` — DELETE
- KEEP: `.claude/library/adapters/research.md` (used by `/prompt-research`)
- KEEP: anything used by `prompt` and `prompt-article-readme` — read those files first to find references.

**Intelligence library — collapse:**
- This entire `library/intelligence/` directory is the "predictive intelligence / multi-agent verification / learning system" stuff that has no benchmarks. Delete it entirely UNLESS:
  - The kept commands (`prompt`, `prompt-article-readme`, `prompt-research`) actually `import` files from it. Check first by grep-ing for `intelligence/` references in the kept commands and skills.
  - If no references → `git rm -r .claude/library/intelligence/`
  - If references exist → keep ONLY the referenced files, delete the rest.

**Orchestration library:**
- KEEP only files referenced by `/prompt-research`. Delete the rest.

**Agents library:**
- KEEP only files referenced by kept commands. Delete the rest.

**Configuration JSONs:**
- `.claude/config/cache-config.json` — DELETE if not referenced by kept commands
- `.claude/config/learning-config.json` — DELETE
- `.claude/config/agent-templates.json` — KEEP if research uses it
- `.claude/config/complexity-rules.json` — DELETE (was used by hybrid which is gone)
- Final review: any JSON config not referenced by remaining 3 commands → delete.

**Memory files — preserve user data:**
- KEEP all `.claude/memory/*.md` (these are user runtime data, untouched by cleanup)

**PowerShell installers:**
- KEEP `install-claude-commands.ps1` but update it to install only the 3 kept commands (Phase 4)
- KEEP `install-claude-statusline.ps1` (statusline is a legitimate standalone feature)

### Action

1. First, do a `grep -r` (or `Select-String`) for imports/references in kept files BEFORE deleting anything from `library/`. Print findings.
2. Present the final delete list. **STOP. Wait for user `y/n` per category.**
3. Execute `git rm` in batches. Commit with message `chore: remove unused commands and skills (v5 cleanup phase 1)`.

---

## Phase 2: Consolidate library structure

**Goal:** Flat structure. No more 4-level abstraction for what's now ~3-5 markdown files.

### Target structure after Phase 2:

```
.claude/
  commands/
    prompt.md
    prompt-article-readme.md
    prompt-research.md
  skills/
    prompt/SKILL.md
    prompt-article-readme/SKILL.md
    prompt-research/SKILL.md
  library/
    prompt-perfection-core.md      # Phase 0 logic
    research-orchestration.md       # consolidated from orchestration/
  memory/                            # untouched
  config/                            # only configs actually referenced
  rules/                             # path-scoped rules (keep)
  docs/                              # internal docs (audit, see Phase 3)
```

### Actions

1. Read `.claude/library/prompt-perfection-core.md`. Verify it's the canonical Phase 0 source for the 3 kept commands. If yes, keep as-is.
2. If `/prompt-research` had multiple files in `library/orchestration/` (lead-agent, iteration-engine, result-aggregator) — read them. If they're <500 lines combined, **merge into single `library/research-orchestration.md`**. The "lead agent / iteration / aggregator" 3-file split is over-engineered for solo project. If >500 lines combined, leave as orchestration/ directory but flatten one level.
3. If any `library/agents/*.md` files remain (referenced by research), move them to flat `library/agent-<name>.md`. Update references in research command/skill.
4. Decide: do you keep both `commands/` (legacy) AND `skills/` (new format) for the same 3 things? **No.** Pick ONE format.
   - Recommendation: keep `skills/` (Anthropic's current direction). Delete `commands/` directory entirely.
   - If user prefers legacy `commands/` format: do the opposite. But not both.
5. Update all internal references after moves. Run a `grep -r "library/intelligence"`, `grep -r "library/adapters"`, `grep -r "library/orchestration/"` to catch dangling references.
6. Commit with message: `refactor: flatten library structure (v5 phase 2)`

**STOP after Phase 2 and report final structure. Wait for user approval before Phase 3.**

---

## Phase 3: Audit and trim docs

### docs/ directory

1. List all files in `docs/`. Print sizes.
2. The repo currently advertises a "200+ page Command Reference Guide" for what is now 3 commands. This is wildly disproportionate. Actions:
   - If `doc/Command_Reference_Guide.md` exists, delete it (`git rm`). For 3 commands, the README + skill files are enough.
   - If `doc/Quick_Reference.md` exists, also delete it. Same reason.
   - Keep VitePress site (`docs/`) but trim:
     - Remove pages for deleted commands (hybrid, technical, dotnet, react, article, deploy, new-stack, reflect)
     - Update `docs/.vitepress/config.ts` sidebar to reflect 3 commands only
3. `docs-archive/` — leave untouched (it's labeled archive).
4. `.claude/docs/` — internal docs:
   - Keep `statusline-install.md`
   - Delete release notes for v4.x that are not v4.9 (or consolidate into single `RELEASE-NOTES.md` with terse entries)
   - Delete `comparisons.md` if it compares deleted commands
5. Commit: `docs: trim documentation to match 3-command scope (v5 phase 3)`

**STOP. Report.**

---

## Phase 4: Rewrite README.md

Replace entire content of root `README.md` with the version below.

**Critical principles:**
- No emojis (your own CLAUDE.md says PLAIN TEXT in terminal — apply same standard to README)
- No vague metrics ("~90% cost reduction", "10-20x faster") unless followed by reproducible benchmark
- No "Future Enhancements" section in README — move to separate `ROADMAP.md`
- Tone: matter-of-fact, what it does, how to install, examples. No marketing copy.
- Length target: fits in one browser screen on GitHub (roughly 100-150 lines)

### New README.md content:

```markdown
# claude-ideas

Personal collection of Claude Code slash commands for prompt engineering, project research, and documentation generation.

This is a personal tooling repo. Public for portfolio reasons. Use at your own risk; no support promised.

## What it does

Three commands for Claude Code:

- `/prompt` — Analyses an unclear prompt, asks targeted clarifying questions, and rewrites it into a structured executable form (Goal, Context, Scope, Requirements, Constraints, Expected Result). Bilingual (Slovak/English).
- `/prompt-article-readme` — Scans a project's structure and config files, then generates or updates a `README.md` matching the detected stack and conventions.
- `/prompt-research` — Multi-step research workflow for unfamiliar projects: spawns parallel exploration agents, iterates on findings, produces a single consolidated report. Designed for "I have to start working on a codebase I've never seen" situations.

## Design choices worth noting

- **Plan-First Execution.** Before any file edit, build, test, or commit, the assistant must summarise the task, present 2-3 implementation options for non-trivial work, and wait for explicit approval. Never auto-executes destructive operations. See `CLAUDE.md`.
- **Bilingual interaction protocol.** User writes Slovak, assistant responds in Slovak. Internal thinking, code, and commit messages stay in English. Technical terms and file paths preserved as-is.
- **Memory recall before asking.** Assistant must check `.claude/memory/project-profile.md`, `sessions.md`, and `prompt-patterns.md` before asking the user to re-state context already known.

These rules live in `CLAUDE.md` and apply to every interaction in this repo, not just slash commands.

## Installation

Clone the repo, then copy `.claude/` into your project:

```powershell
git clone https://github.com/Tadzesi/claude-ideas.git
cp -r claude-ideas/.claude /your/project/
```

Or use the PowerShell installer:

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-commands.ps1" -OutFile "install-claude-commands.ps1"
.\install-claude-commands.ps1
```

## Statusline (optional)

A separate statusline shows folder, git branch, context usage bar, token counters, and global API duration with delta. Install:

```powershell
iwr -useb https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-statusline.ps1 | iex
```

Restart Claude Code after install.

## Repository structure

```
.claude/
  skills/                Three skill definitions
  library/               Shared Phase 0 prompt-perfection logic
  memory/                Runtime data (project profile, sessions, patterns)
  config/                JSON configuration
  rules/                 Path-scoped rules
CLAUDE.md                Interaction protocol and architecture
README.md                This file
ROADMAP.md               Possible future work
```

## Requirements

- Claude Code CLI
- Windows 11 (PowerShell installers); the `.claude/` directory itself is OS-agnostic
- Git

## License

MIT
```

After replacing, commit: `docs: rewrite README to match real scope (v5 phase 4)`

**STOP. Show diff. Wait for approval.**

---

## Phase 5: Rewrite CLAUDE.md

Trim CLAUDE.md to remove references to deleted commands and over-engineered architecture descriptions.

### Specific edits:

1. **Remove** the `Library-Based Pattern (Core Concept)` description of Adapters / Skills (PRIMARY) / Commands (LEGACY) / Intelligence / Orchestration / Agents — that 7-bullet architecture list. Replace with a single short paragraph:

   > All three commands share Phase 0 (prompt analysis, clarification, structuring) imported from `.claude/library/prompt-perfection-core.md`. Command-specific logic lives in each skill's `SKILL.md`.

2. **Remove** the `Complexity Detection` section (it described `/prompt-hybrid` which is gone).

3. **Remove** the `Rules (Path-Scoped)` section UNLESS rules are actively used. If used, keep but verify the description matches reality.

4. **Update** the Commands table to list only the 3 kept commands. Drop the speed estimates unless benchmarked.

5. **Keep**:
   - Response Style Guidelines section
   - Interaction Protocol (Language, Plan-First Execution, Proactive Option-Finding, Never Auto-Execute) — this is the real value of the repo
   - Memory Recall section
   - Build and Development Commands section (after removing references to removed tests/configs)

6. **Remove** the `Extended Context: See @.claude/CLAUDE.md` line if `.claude/CLAUDE.md` no longer exists or no longer makes sense.

Commit: `docs: trim CLAUDE.md to match 3-command scope (v5 phase 5)`

**STOP. Show diff. Wait for approval.**

---

## Phase 6: Create ROADMAP.md (move "Future Enhancements" out of README)

Create new file `ROADMAP.md` at repo root. Content:

```markdown
# Roadmap

Possible future work. No timelines, no commitments. Listed because they came up while building current commands.

## Things that would justify a v5.x release

- **Benchmark `/prompt-research`.** Pick 3 representative codebases (small library, medium app, large monorepo). Measure: time-to-first-useful-finding, total tokens consumed, agent iteration count. Publish methodology and numbers in `tests/benchmarks/`.
- **Consolidate `/prompt` Phase 0 into a single, testable function.** Currently distributed across multiple library files. Goal: one canonical implementation with input/output examples that can be regression-tested.

## Things that might not happen

- ML-based context prediction
- Visual prompt builder
- Voice input
- Team collaboration features

These were aspirational. Listed so future-me doesn't re-discover them.
```

Commit: `docs: extract roadmap from README (v5 phase 6)`

---

## Phase 7: Bump version and write honest CHANGELOG entry

1. Update `package.json` version to `5.0.0`.
2. Prepend new entry to `CHANGELOG.md`:

```markdown
## [5.0.0] - 2026-05-01

### Removed
- Eight slash commands (`prompt-hybrid`, `prompt-technical`, `prompt-dotnet`, `prompt-react`, `prompt-article`, `deploy`, `new-stack`, `reflect`). They existed but were not used in practice.
- "Predictive Intelligence", "Multi-Agent Verification", "Learning System" components. These were marketed in v4.x without benchmarks. Removed pending real measurement.
- 4-layer library structure (adapters, intelligence, orchestration, agents). Flattened to single `library/` directory.
- "Future Enhancements" section from README. Moved to `ROADMAP.md`.

### Changed
- README rewritten to describe what the repo actually does, not what it aspirationally claims.
- CLAUDE.md trimmed to remove references to deleted components.

### Kept
- `/prompt`, `/prompt-article-readme`, `/prompt-research`
- Plan-First Execution rule
- Bilingual (Slovak/English) interaction protocol
- Memory recall protocol
- Statusline

### Why
v4.x had feature inflation without measurement. v5.0 is a deliberate reduction to what is actually used and defensible. Future versions will only add features with reproducible benchmarks.
```

3. Commit: `chore: bump to v5.0.0 (v5 phase 7)`

---

## Phase 8: Final verification (READ-ONLY)

1. Run validation script if it exists: `.\tests\validate-library-references.ps1`
2. Search for dangling references:
   - `grep -r "prompt-hybrid"` — should only appear in CHANGELOG and docs-archive
   - `grep -r "prompt-technical"` — same
   - `grep -r "library/intelligence"` — should be zero hits in active files
   - `grep -r "library/adapters"` — should be zero hits in active files
3. Print final `tree .claude/ -L 3`
4. Print final repo line count: `Get-ChildItem -Recurse -Filter *.md | Get-Content | Measure-Object -Line`
5. Compare to Phase 0 numbers. Report reduction.

**STOP. Final report. Do NOT push to main. User decides when to merge or push.**

---

## Out of scope for this cleanup

- Renaming any of the 3 kept commands
- Changing internal logic of Phase 0 prompt-perfection-core
- Adding any new functionality
- Touching `.claude/memory/` user data
- Touching `docs-archive/`

## If anything is unclear

Before proceeding with any phase, if a file's contents contradict this plan or you find dependencies not documented here, **stop and ask**. Do not improvise around the user.
