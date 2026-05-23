# claude-ideas

Personal collection of Claude Code slash commands for prompt engineering, project research, and documentation generation.

This is a personal tooling repo. Public for portfolio reasons. Use at your own risk; no support promised.

## What it does

Three commands for Claude Code:

- `/prompt` — Analyses an unclear prompt, asks targeted clarifying questions, and rewrites it into a structured executable form (Goal, Context, Scope, Requirements, Constraints, Expected Result). Bilingual (Slovak/English).
- `/prompt-article-readme` — Scans a project's structure and config files, then generates or updates a `README.md` matching the detected stack and conventions.
- `/prompt-research` — Multi-step research workflow for unfamiliar projects. Uses up to 5 real Anthropic subagents in parallel via the Task tool (`research-explore`, `research-pattern`, `research-security`, `research-performance`, `research-citation` — each with isolated context and per-agent model routing). Iterates on findings (2-4 cycles with gap-driven refinement), produces a single consolidated report with file:line citations on every claim. Designed for "I have to start working on a codebase I've never seen" situations.

## Design choices worth noting

- **Plan-First Execution.** Before any file edit, build, test, or commit, the assistant must summarise the task, present 2-3 implementation options for non-trivial work, and wait for explicit approval. Never auto-executes destructive operations. See `CLAUDE.md`.
- **Bilingual interaction protocol.** User writes Slovak, assistant responds in Slovak. Internal thinking, code, and commit messages stay in English. Technical terms and file paths preserved as-is.
- **Memory recall before asking.** Assistant must check `.claude/memory/project-profile.md`, `sessions.md`, and `prompt-patterns.md` before asking the user to re-state context already known.

These rules live in `CLAUDE.md` and apply to every interaction in this repo, not just slash commands.

## Session memory

A `PreCompact` hook writes a diary entry to `.claude/memory/diary/` before Claude Code compacts long conversations. Entries capture task summary, design decisions (with the WHY), challenges, solutions, and observed preferences.

- **Automatic** — fires at every `/compact`, no manual step needed.
- **Per-project** — each project keeps its own diary under its own `.claude/memory/diary/`.
- **`/reflect-diary`** — manual skill that reads accumulated entries, identifies recurring patterns (2+ occurrences), and proposes updates to `project-profile.md`. Nothing is written without explicit approval.

The installer (`install-claude-commands.ps1`) deploys the hook to `~/.claude/hooks/` and registers it in `~/.claude/settings.json` automatically.

## Installation

Three ways to install, depending on what you want.

---

### Option A — Global install (recommended for personal use)

Installs skills, library and config into `~/.claude/` so the commands are available in **every project** without per-project setup. Also deploys a `CLAUDE.md` template and `memory/global-facts.md` on first run — edit them to match your machine after install.

```powershell
git clone https://github.com/Tadzesi/claude-ideas.git
cd claude-ideas
.\install-claude-commands.ps1 -Global
```

After install, fill in your details:
- `~/.claude/CLAUDE.md` — language, working style, machine-specific paths
- `~/.claude/memory/global-facts.md` — active projects, shared infrastructure (SSH, DBs, etc.)

To update to the latest version later, run the same command again. Existing `CLAUDE.md` and memory files are never overwritten.

---

### Option B — Per-project install

Installs into a specific project directory. Use this if you want project-isolated skills or you are installing into a shared repo.

```powershell
git clone https://github.com/Tadzesi/claude-ideas.git
cd claude-ideas
.\install-claude-commands.ps1 -InstallPath "C:\your\project"
```

Or download and run directly without cloning:

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-commands.ps1" -OutFile "install-claude-commands.ps1"
.\install-claude-commands.ps1 -InstallPath "C:\your\project"
```

---

### Option C — Manual copy

Copy `.claude/` directly into your project. No script needed.

```powershell
git clone https://github.com/Tadzesi/claude-ideas.git
Copy-Item -Path "claude-ideas\.claude" -Destination "C:\your\project\" -Recurse
```

---

### Updating

Re-run the same install command. Memory files are preserved; skills and library are updated.

```powershell
# Global update
.\install-claude-commands.ps1 -Global

# Per-project update
.\install-claude-commands.ps1 -InstallPath "C:\your\project" -Force
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
  skills/                Three skill definitions (/prompt, /prompt-article-readme, /prompt-research)
  agents/                5 real Anthropic subagents for /prompt-research (v5.2+)
  library/               Shared Phase 0 prompt-perfection logic + adapters
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
