---
name: reflect-diary
description: Analyze session diary entries for this project, identify recurring patterns, and PROPOSE (not auto-apply) updates to memory files.
---

# Reflect on Session Diary Entries

Read diary entries from this project, find patterns, propose memory updates.
Do NOT modify any file without explicit user approval.

## Parameters

Accept optional filters after the command:
- `last N` — analyze N most recent entries (default: all available)
- `from YYYY-MM-DD to YYYY-MM-DD` — date range
- (no parameter) — analyze all entries in .claude/memory/diary/

## Steps

### 1. Locate diary entries

Directory: `.claude/memory/diary/`
Files named: `YYYY-MM-DD-session-N.md`
Sort newest-first. List them to the user before proceeding.

If no entries exist: inform user and stop. Suggest: "Ask me to create a diary entry for this session first."

### 2. Read and parse entries

From each entry extract:
- User Preferences Observed
- Design Decisions (and the WHY)
- Challenges Encountered
- Solutions Applied
- Work Done

### 3. Identify patterns

- Pattern = preference or approach appearing in 2+ entries
- Strong pattern = 3+ entries
- One-off = note but do NOT propose for permanent storage
- Contradictions = flag explicitly for user to resolve

Cross-check against `.claude/memory/project-profile.md`:
- If a pattern already documented there: skip (no duplicate proposal)
- If a pattern contradicts something there: flag the conflict

### 4. Present findings in plain text

Format (no markdown headers, no emojis, 80-char lines):

```
DIARY REFLECTION — [date range analyzed]
Entries analyzed: N

PATTERNS FOUND (2+ occurrences):
  1. [pattern description] — seen N times
     Proposed: add to project-profile.md under [section]
  2. ...

STRONG PATTERNS (3+ occurrences):
  1. [pattern description] — seen N times
     Proposed: add to project-profile.md under [section]

ONE-OFFS (noted, not proposed for permanent storage):
  - [item]

ALREADY DOCUMENTED (skipped):
  - [item already in project-profile.md]

CONFLICTS DETECTED:
  - [diary says X, project-profile.md says Y — please resolve]
```

### 5. STOP — await explicit approval

Ask exactly:
"Which changes do you want to apply? Reply: all / none / [list numbers, e.g. 1 3]"

Do NOT proceed to step 6 without a response. Do NOT assume silence = approval.

### 6. Apply only approved changes

For each approved item:
- Edit `.claude/memory/project-profile.md` with the specific addition/update
- Report the exact change made (show before/after for modified lines)

### 7. Confirm completion

List what was changed, what was skipped, and the date range of analyzed entries.

## Hard Rules

- NEVER auto-update project-profile.md, sessions.md, CLAUDE.md, or any file in step 5
- NEVER create or write to processed.log
- Output is plain text — no markdown rendering in terminal
- If fewer than 3 entries: proceed but prefix findings with "LOW CONFIDENCE (< 3 entries)"
