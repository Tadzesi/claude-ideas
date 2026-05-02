# Phase 2 Addendum: Migrate to skills/ and flatten library

This replaces Phase 2 of original EXECUTION-PLAN.md.

**Important order swap:** Do Part B (flatten library) BEFORE Part A (migrate commands to skills). Reason: skills will reference flattened paths, so flatten first to avoid double rework.

---

## Part B: Flatten library hierarchy (DO FIRST)

### Step 2.B.1: Decide orchestration consolidation

Three files in `library/orchestration/` (lead-agent.md, iteration-engine.md, result-aggregator.md, total 2 628 lines).

Read each file's first 50 lines to assess coupling.

Decision rule:
- Combined under 2 000 lines AND tightly coupled (frequent cross-references) → merge into single `library/research-orchestration.md`
- Combined over 2 000 lines OR loosely coupled → flatten as `library/orchestration-{lead,iteration,aggregator}.md`

Given total is 2 628 lines, default toward flatten (not merge). Print recommendation. **STOP. User decides.**

If MERGE chosen:
```powershell
# Concatenate with section headers, then git rm originals
# (manual step - assistant generates merged file content)
git rm .claude/library/orchestration/lead-agent.md
git rm .claude/library/orchestration/iteration-engine.md
git rm .claude/library/orchestration/result-aggregator.md
# New file created: .claude/library/research-orchestration.md
Remove-Item .claude/library/orchestration/
```

If FLATTEN chosen:
```powershell
git mv .claude/library/orchestration/lead-agent.md         .claude/library/orchestration-lead.md
git mv .claude/library/orchestration/iteration-engine.md   .claude/library/orchestration-iteration.md
git mv .claude/library/orchestration/result-aggregator.md  .claude/library/orchestration-aggregator.md
Remove-Item .claude/library/orchestration/
```

### Step 2.B.2: Flatten agents

```powershell
git mv .claude/library/agents/explore.md      .claude/library/research-agent-explore.md
git mv .claude/library/agents/citation.md     .claude/library/research-agent-citation.md
git mv .claude/library/agents/security.md     .claude/library/research-agent-security.md
git mv .claude/library/agents/performance.md  .claude/library/research-agent-performance.md
git mv .claude/library/agents/pattern.md      .claude/library/research-agent-pattern.md
Remove-Item .claude/library/agents/
```

### Step 2.B.3: Flatten adapters

After Phase 1, only `research-adapter.md` (and possibly `context-editing.md`, `memory-tool.md`) remain.

```powershell
git mv .claude/library/adapters/research-adapter.md .claude/library/research-adapter.md

# If survived Phase 1:
if (Test-Path .claude/library/adapters/context-editing.md) {
    git mv .claude/library/adapters/context-editing.md .claude/library/context-editing.md
}
if (Test-Path .claude/library/adapters/memory-tool.md) {
    git mv .claude/library/adapters/memory-tool.md .claude/library/memory-tool.md
}

Remove-Item .claude/library/adapters/
```

### Step 2.B.4: Update all references

Find dangling references after moves:

```powershell
Get-ChildItem -Recurse -Filter *.md |
    Select-String -Pattern "library/orchestration/|library/agents/|library/adapters/" |
    Select-Object Path, LineNumber, Line |
    Format-Table -AutoSize
```

For each hit, generate replacement. Common patterns:

| Old path | New path |
|---|---|
| `library/agents/explore.md` | `library/research-agent-explore.md` |
| `library/agents/citation.md` | `library/research-agent-citation.md` |
| `library/agents/security.md` | `library/research-agent-security.md` |
| `library/agents/performance.md` | `library/research-agent-performance.md` |
| `library/agents/pattern.md` | `library/research-agent-pattern.md` |
| `library/adapters/research-adapter.md` | `library/research-adapter.md` |
| `library/adapters/context-editing.md` | `library/context-editing.md` |
| `library/adapters/memory-tool.md` | `library/memory-tool.md` |
| `library/orchestration/lead-agent.md` | `library/orchestration-lead.md` (or merged) |
| `library/orchestration/iteration-engine.md` | `library/orchestration-iteration.md` (or merged) |
| `library/orchestration/result-aggregator.md` | `library/orchestration-aggregator.md` (or merged) |

Apply replacements. Print each before/after. **STOP. User reviews diff.**

### Step 2.B.5: Commit Part B

```powershell
git add -A
git status
# STOP. User approves.

git commit -m "refactor: flatten library hierarchy (v5 phase 2 part b)

orchestration/: {merged|flattened with prefix}
agents/: flattened with research-agent-* prefix
adapters/: flattened (only research-adapter remained after phase 1)

All cross-references updated. Content preserved."
```

**STOP. Then proceed to Part A.**

---

## Part A: Migrate to skills/ format (after Part B)

### Step 2.A.1: Read template skill

Read `.claude/skills/prompt/SKILL.md` to understand:
- YAML frontmatter format (fields, ordering)
- Section header conventions
- Import syntax for `library/`

This is the template for migration. Print summary of structure.

### Step 2.A.2: Migrate prompt-article-readme

1. `mkdir .claude/skills/prompt-article-readme/`
2. Create `.claude/skills/prompt-article-readme/SKILL.md`
3. Frontmatter pattern:
   ```yaml
   ---
   name: prompt-article-readme
   description: <1-2 sentence summary used by Claude Code for skill matching>
   <other fields matching prompt/SKILL.md>
   ---
   ```
4. Port content from `commands/prompt-article-readme.md` (694 lines):
   - Purpose
   - Phase 0 reference (import `library/prompt-perfection-core.md`)
   - Skill-specific logic (project scanning, README generation)
   - Examples
5. Verify SKILL.md structure matches template
6. `git rm .claude/commands/prompt-article-readme.md`
7. **STOP. User reviews skill content.**

Commit:
```powershell
git commit -m "refactor: migrate prompt-article-readme to skills/ format (v5 phase 2 part a)"
```

### Step 2.A.3: Migrate prompt-research

Same procedure for `commands/prompt-research.md` (1 068 lines) → `skills/prompt-research/SKILL.md`.

Critical: imports must use FLATTENED paths from Part B. Verify with grep after migration:
```powershell
Select-String -Path .claude/skills/prompt-research/SKILL.md -Pattern "library/agents/|library/adapters/|library/orchestration/"
# Should return zero results
```

If any old paths slip through, fix before committing.

```powershell
git rm .claude/commands/prompt-research.md
git commit -m "refactor: migrate prompt-research to skills/ format (v5 phase 2 part a)"
```

### Step 2.A.4: Verify prompt skill

`.claude/skills/prompt/SKILL.md` already exists. Check:
- Does `commands/prompt.md` still exist? If yes, verify skill is canonical version, then `git rm commands/prompt.md`
- Does skill reference any deleted library files (from Phase 1)? Update if so.
- Does skill use updated flattened paths? Update if not.

```powershell
git rm .claude/commands/prompt.md   # if exists
git commit -m "chore: remove legacy prompt.md command (v5 phase 2 part a)"
```

### Step 2.A.5: Remove commands/ directory

After all three migrations done:

```powershell
ls .claude/commands/
# Expected: empty or only files we explicitly chose to keep

# If empty:
Remove-Item .claude/commands/ -Recurse
git add -A
git commit -m "chore: remove empty commands/ directory (v5 phase 2 part a)"
```

If anything unexpected remains, **STOP and report** before proceeding.

---

## Step 2.X: Final Phase 2 verification

```powershell
# Should show flat library/ with no subdirectories except possibly memory/, config/, rules/, docs/
tree .claude/ -L 2

# No legacy paths in any markdown
Get-ChildItem -Recurse -Filter *.md |
    Select-String -Pattern "library/orchestration/|library/agents/|library/adapters/|@\.claude/commands/" |
    Select-Object Path, LineNumber, Line

# Skills directory should have exactly 3 entries
ls .claude/skills/
```

Print final tree. **STOP. Wait for user approval before Phase 3.**

---

## Expected state after Phase 2

```
.claude/
  skills/
    prompt/SKILL.md
    prompt-article-readme/SKILL.md
    prompt-research/SKILL.md
  library/
    prompt-perfection-core.md
    research-adapter.md
    research-agent-explore.md
    research-agent-citation.md
    research-agent-security.md
    research-agent-performance.md
    research-agent-pattern.md
    orchestration-lead.md          (or research-orchestration.md if merged)
    orchestration-iteration.md
    orchestration-aggregator.md
    [maybe: context-editing.md, memory-tool.md]
  memory/                            (untouched)
  config/                            (only kept JSONs)
  rules/                             (path-scoped rules)
  docs/                              (Phase 3 will trim)
CLAUDE.md
README.md
CHANGELOG.md
ROADMAP.md
package.json
```

No more: `commands/`, `library/adapters/`, `library/agents/`, `library/orchestration/`, `library/intelligence/`.

---

## Phase 3 onwards

Phase 3-8 from original EXECUTION-PLAN.md apply with these notes:

- **Phase 3 docs trim:** docs/architecture/ has 12 pages mostly referencing deleted features. Default DELETE most. Keep only pages describing kept architecture.
- **Phase 4 README rewrite:** content from original plan unchanged.
- **Phase 5 CLAUDE.md trim:** add note that `commands/` directory no longer exists; only `skills/`.
- **Phase 7 CHANGELOG:** add lines:
  - "Migrated all commands to skills/ format. commands/ directory removed."
  - "Flattened library/ hierarchy: removed adapters/, agents/, orchestration/, intelligence/ subdirectories."
