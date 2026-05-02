# Session Memory

Diary entries capture what happened in each Claude Code session so context survives across conversations and machines.

## How it works

A `PreCompact` hook fires automatically before Claude Code compacts a long conversation. It outputs an instruction that Claude reads and uses to write a structured diary entry to `.claude/memory/diary/` in the current project.

Entries use the format `YYYY-MM-DD-session-N.md` and contain:

- **Task Summary** — what the user was trying to accomplish
- **Work Done** — bullet list of completed items
- **Design Decisions** — key choices and the WHY behind them
- **Challenges Encountered** — errors, failed approaches, user corrections
- **Solutions Applied** — how problems were resolved
- **User Preferences Observed** — code style, workflow preferences, language protocol
- **Context** — project type, languages, frameworks used in the session

Diary entries are per-project (stored in the project's `.claude/memory/diary/`), never committed to git (`.gitignore` excludes `*.md` in that directory), and never shared between projects.

## Installation

The `install-claude-commands.ps1` installer handles everything automatically:

1. Copies `pre-compact.sh` to `~/.claude/hooks/`
2. Adds a `PreCompact` block to `~/.claude/settings.json`

This runs on every machine where you run the installer — including work laptops.

To verify the hook is registered, run `/hooks` inside Claude Code and look for `PreCompact | auto`.

## Manual diary entry

For short but important sessions where `/compact` never fires:

```
Create a diary entry for this session and save it to .claude/memory/diary/
```

Claude will write the entry using the same format as the automatic hook.

## /reflect-diary

After accumulating a few entries, run `/reflect-diary` to analyse patterns:

```
/reflect-diary
/reflect-diary last 5
/reflect-diary from 2026-05-01 to 2026-05-31
```

The skill reads the diary entries, identifies preferences and decisions that appear in 2 or more entries (strong pattern: 3+), cross-checks against the existing `project-profile.md`, and presents proposed updates.

**Nothing is written automatically.** You approve each proposed change individually before it is applied to `project-profile.md`.

## What is not automated

- Updates to `CLAUDE.md` — always manual, to prevent drift
- Cross-project pattern detection — each project's diary is independent
- Processed-entry tracking — low volume per project makes a log file unnecessary
