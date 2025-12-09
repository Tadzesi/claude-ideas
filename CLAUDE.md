# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a SpecTacular workflow workspace - a structured feature development pipeline for Claude Code projects.

## Environment

- Platform: Windows 11
- Use Windows-compatible commands (cmd, PowerShell)

## Tech Stack

- ASP.NET Core (backend)
- React (frontend)
- SQL Server (database)

## SpecTacular Workflow Commands

The project uses a 5-step pipeline for feature development. Use these slash commands:

| Command | Purpose |
|---------|---------|
| `/spectacular.0-quick` | Full pipeline in one command (spec → plan → tasks → implement → validate) |
| `/spectacular.1-spec` | Create feature branch and specification document |
| `/spectacular.2-plan` | Generate technical implementation plan |
| `/spectacular.3-tasks` | Generate actionable task list from spec and plan |
| `/spectacular.4-implement` | Execute all tasks in tasks.md |
| `/spectacular.5-validate` | Validate implementation (tasks, build, tests) |
| `/spectacular.dashboard` | Launch task monitor and spec viewer |

## Key Scripts (PowerShell)

```powershell
# Create new feature branch and spec
.spectacular/scripts/powershell/create-new-feature.ps1 -Json "feature description"

# Validate implementation completeness
.spectacular/scripts/powershell/validate-implementation.ps1

# Setup plan for current feature
.spectacular/scripts/powershell/setup-plan.ps1 -Json
```

## Project Structure

```
specs/                         # Feature specifications (numbered branches)
  ###-feature-name/
    spec.md                    # Feature specification
    plan.md                    # Implementation plan
    tasks.md                   # Actionable task checklist
.spectacular/
  memory/constitution.md       # Core principles and tech stack
  templates/                   # Templates for spec, plan, tasks
  scripts/powershell/          # Automation scripts
.claude/
  commands/                    # Slash command definitions
  tasks/                       # Task index and backlog
```

## Core Principles

1. **Task Completion is Non-Negotiable**: Build must succeed, tests must pass, task status synced in both tasks.md AND TodoWrite
2. **Simple Steps Over Complex Workflows**: Use `/spectacular.0-quick` for simple features
3. **Validation Before Completion**: Run `validate-implementation.ps1` before marking complete
4. **Production-Ready Defaults**: No placeholder code, error handling included, security addressed
