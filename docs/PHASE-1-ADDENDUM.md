# Phase 1 Addendum: Delete unused content

This replaces Phase 1 of original EXECUTION-PLAN.md, based on Phase 0 inventory findings.

**Locked decisions:**
1. All commands migrate to `skills/SKILL.md` format (Phase 2)
2. Research infrastructure: pragmatic flatten, content preserved
3. v4.9 Opus files: grep-test, default DELETE if no references
4. `example-custom-command.md`: DELETE

**Execution rules unchanged:** Plan-First, no auto-commit, no push to main, stop after each step for `y/n`.

---

## Step 1.1: Grep audit (READ-ONLY)

Run BEFORE any deletion. Determines what stays in `library/` and `config/`.

```powershell
$keepFiles = @(
    ".claude/commands/prompt.md",
    ".claude/commands/prompt-article-readme.md",
    ".claude/commands/prompt-research.md",
    ".claude/skills/prompt/SKILL.md"
)

foreach ($file in $keepFiles) {
    if (Test-Path $file) {
        Write-Host "=== $file ===" -ForegroundColor Cyan
        Select-String -Path $file -Pattern "library/|@\.claude|adapters/|intelligence/|orchestration/|agents/|caching-strategy|model-router|model-tiers|complexity-rules|learning-config|predictive-intelligence|verification-config|external-memory" |
            Select-Object -ExpandProperty Line |
            Sort-Object -Unique
    }
}
```

Print output. Categorise each unique reference:
- **REFERENCED-KEEP:** imported by keep-file
- **NOT-REFERENCED:** safe to delete

**STOP. User reviews findings.**

---

## Step 1.2: Delete commands and skills

After user `y`:

```powershell
# Commands
git rm .claude/commands/prompt-hybrid.md
git rm .claude/commands/prompt-technical.md
git rm .claude/commands/prompt-article.md
git rm .claude/commands/reflect.md
git rm .claude/commands/example-custom-command.md

# Skills directories
git rm -r .claude/skills/prompt-hybrid/
git rm -r .claude/skills/prompt-dotnet/
git rm -r .claude/skills/prompt-react/
git rm -r .claude/skills/deploy/
git rm -r .claude/skills/new-stack/
git rm -r .claude/skills/reflect/
```

Skip silently if any directory doesn't exist.

---

## Step 1.3: Delete library files

**Adapters — definite deletes:**
```powershell
git rm .claude/library/adapters/article.md
git rm .claude/library/adapters/hybrid.md
git rm .claude/library/adapters/technical.md
```

**Adapters — context-editing.md, memory-tool.md (257 lines combined):**
- Apply Step 1.1 grep result
- NOT referenced by `prompt-research.md` → DELETE
- Referenced → KEEP
- Print intended action, **STOP for confirmation**

**Adapters — research-adapter.md:** KEEP (used by `/prompt-research`)

**Intelligence directory — DELETE entirely:**
```powershell
git rm -r .claude/library/intelligence/
```

If grep found that `/prompt-research` references something here (edge case), MOVE that single file to flat `library/<name>.md` first, then delete the rest of `intelligence/`.

**Orchestration directory — KEEP for now** (Phase 2 will flatten)

**Agents directory — KEEP for now** (Phase 2 will flatten)

**Standalone library files (grep-test):**

```
caching-strategy.md (147 lines)
model-router.md (160 lines)
execution-plan-template.md (156 lines)
```

Decision protocol per file:
- Referenced by keep-file → KEEP in place
- NOT referenced + content reads as personal notes → `git mv` to `docs-archive/v4.9-opus-notes/`
- NOT referenced + content is runtime LLM instructions → `git rm`

Print intended action per file. **STOP. User confirms each.**

---

## Step 1.4: Delete config files

**Definite deletes** (used by removed features):
```powershell
git rm .claude/config/complexity-rules.json
git rm .claude/config/learning-config.json
git rm .claude/config/predictive-intelligence.json
git rm .claude/config/verification-config.json
git rm .claude/config/external-memory-config.json
```

**Conditional (grep-test):**
- `model-tiers.json` (202 lines) — likely DELETE if model-router.md was deleted
- `agent-templates.json` (84 lines) — likely KEEP (research uses agents)
- 6 unmentioned config JSONs — list them and apply same grep test

Print findings. **STOP for confirmation.**

---

## Step 1.5: Commit Phase 1

```powershell
git add -A
git status   # Print for review. STOP. User approves.

git commit -m "chore: remove unused commands, skills, library, configs (v5 phase 1)

Removed 5 commands: prompt-hybrid, prompt-technical, prompt-article, reflect, example-custom-command.
Removed 6 skills directories.
Removed library/intelligence/ (5 files, 2874 lines).
Removed library/adapters/{article,hybrid,technical}.md.
Removed config files for deleted features.

Kept: prompt, prompt-article-readme, prompt-research.
Kept: library/prompt-perfection-core.md, adapters/research-adapter.md.
Kept: orchestration/ and agents/ (Phase 2 will flatten).

See ROADMAP.md and CHANGELOG v5.0.0 for rationale."
```

**STOP after Phase 1 commit. Wait for user approval before Phase 2.**

---

## Expected reduction after Phase 1

Approximate based on Phase 0 inventory:
- Commands: 5 550 → ~2 065 lines (3 keeps: prompt 303 + readme 694 + research 1 068)
- Skills: 6 directories → 1 directory
- Library: 11 727 → ~7 200 lines (kept: core 1 006 + research-adapter 751 + orchestration 2 628 + agents 2 062 + maybe context-editing 257 + maybe execution-plan-template 156)
- Config: 13 files → ~3-5 files

Total markdown reduction: rough estimate -8 000 to -10 000 lines.
