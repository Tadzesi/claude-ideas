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
