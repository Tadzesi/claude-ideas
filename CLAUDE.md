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

## Commands

### `/prompt`

**Purpose:** Analyze, clarify, and perfect any prompt into an unambiguous, executable format.

**What it does:**
1. Detects language (Slovak/English)
2. Identifies prompt type (Task, Question, Bug Fix, etc.)
3. Checks completeness (goal, context, scope, constraints)
4. Asks clarifying questions if needed
5. Outputs a structured, perfected prompt

**Usage:**
```
/prompt Fix the login bug in my app
```

**Output:** A structured prompt with Goal, Context, Scope, Requirements, Constraints, and Expected Result.

---

### `/prompt-technical`

**Purpose:** Provide deep technical analysis for programming tasks with implementation options.

**What it does:**
1. Scans project structure and tech stack
2. Identifies frameworks, patterns, and conventions
3. Generates 2-3 implementation options with pros/cons
4. Recommends best approach with reasoning
5. Provides ready-to-use code scaffolding

**Usage:**
```
/prompt-technical
```

Best used after `/prompt` to get detailed implementation analysis.

**Output:** Technical analysis report with project context, implementation options, best practices checklist, and code scaffolding.

---

### `/prompt-article`

**Purpose:** Interactive wizard for writing articles with multi-platform output.

**What it does:**
1. Guides through language, type, audience, and style selection
2. Collects topic and key points
3. Generates article in selected format
4. Creates platform-specific versions (LinkedIn, Jira, Medium, Dev.to, etc.)
5. Saves markdown file to specified location

**Usage:**
```
/prompt-article
```

**Article Types:** Blog Post, LinkedIn Post, Technical Article, Tutorial, How-to Guide, Case Study, News Article, Opinion Piece

**Output:** Full article with formatted versions for each selected platform.

---

### `/prompt-article-readme`

**Purpose:** Generate or update professional README.md files by analyzing your project.

**What it does:**
1. Analyzes project structure and configuration files
2. Detects tech stack, frameworks, and dependencies
3. Guides through style selection (Minimal, Standard, Comprehensive)
4. Generates README with appropriate sections
5. Handles existing README (replace, update, merge)

**Usage:**
```
/prompt-article-readme
/prompt-article-readme --update
```

**Output:** Professional README.md tailored to your project type.

---

### `/session-end`

**Purpose:** Capture comprehensive session context to ensure zero information loss between sessions.

**What it does:**
1. Analyzes everything discussed, implemented, and learned in the current session
2. Captures 10 comprehensive sections of context:
   - Decisions Made (with rationale and trade-offs)
   - Code Changes (files modified, created, deleted)
   - Features Implemented (status: Complete/In Progress/Blocked)
   - Problems Solved (root cause → solution)
   - Technical Stack & Architecture (tech choices, patterns)
   - Key Insights (codebase understanding, discoveries)
   - User Preferences & Patterns (coding style, workflow)
   - Active Work In Progress (current task, files, blockers)
   - Project Structure Notes (important paths, organization)
   - Next Steps (actionable TODOs with file paths)
3. Appends structured summary to `.claude/memory/sessions.md`
4. Shows confirmation with count of captured items

**Usage:**
```
/session-end
```

**Best used:** Before ending a session to save all context for next time.

**Output:**
```
✅ Session saved to memory.

Captured:
- Decisions: 3
- Code Changes: 9 files
- Features: 4 (3 complete, 1 in progress)
- Problems Solved: 3
- Technical Notes: 4
- Insights: 4
- Preferences: 4 new patterns
- WIP: Documentation in progress
- Next Steps: 4 pending

Session State: Enhanced session memory with comprehensive capture
```

---

### `/session-start`

**Purpose:** Load comprehensive context from previous sessions to continue work with full project knowledge.

**What it does:**
1. Reads ALL sessions from `.claude/memory/sessions.md`
2. Aggregates cumulative context across sessions:
   - Combines all User Preferences & Patterns
   - Merges Project Structure Notes
   - Builds complete Tech Stack understanding
3. Highlights active work and pending items
4. Presents organized summary with 7 key sections:
   - Active Work In Progress (current task, files, blockers)
   - Pending Next Steps (all uncompleted TODOs)
   - Recent Session Summary (last session with key decisions)
   - Project Context (tech stack, architecture, important locations)
   - User Preferences & Patterns (accumulated across all sessions)
   - Key Insights Library (codebase understanding built over time)
   - Session History (total sessions, current branch, last active)
5. Asks what to work on today

**Usage:**
```
/session-start
```

**Best used:** At the beginning of a session to load full context and resume work seamlessly.

**Output:**
```
🔄 Session Context Loaded

## 📌 Active Work In Progress
Current Task: Documentation updates for command reference
Files: README.md, CLAUDE.md
Status: Ready to continue

## ✅ Pending Next Steps
- [ ] Update README.md with session commands
- [ ] Update CLAUDE.md with identical documentation
- [ ] Verify no differences between files

## 🎯 Recent Session Summary
Last Session: 2024-12-15 - main
Enhanced session memory system with 10-section comprehensive capture...

[Additional sections with full context...]

What would you like to work on today?
```

---

## Core Principles

1. **Task Completion is Non-Negotiable**: Build must succeed, tests must pass, task status synced in both tasks.md AND TodoWrite
2. **Simple Steps Over Complex Workflows**: Use `/spectacular.0-quick` for simple features
3. **Validation Before Completion**: Run `validate-implementation.ps1` before marking complete
4. **Production-Ready Defaults**: No placeholder code, error handling included, security addressed

## Future Enhancements: Prompt Commands

The following enhancements can further improve the prompt command system:

### Immediate Next Steps (High Priority)

1. **Example Library Integration**
   - Add `.claude/commands/examples/` directory with interactive examples
   - Include before/after transformations for each command
   - Domain-specific examples (ASP.NET Core, React, SQL Server tasks)

2. **Validation & Error Detection**
   - Implement prompt quality scoring
   - Detect overly vague requests and suggest refinements
   - Warn about common pitfalls (missing context, unclear scope)

3. **Quick Syntax & Shortcuts**
   - Support inline parameters: `/prompt-article sk linkedin "AI in Healthcare"`
   - Add flags: `--update`, `--comprehensive`, `--minimal`
   - Enable command chaining: `/prompt + /prompt-technical`

### Medium-Term Enhancements

4. **Prompt Template System**
   - Pre-built templates in `.claude/templates/prompts/`
   - Templates for common scenarios (bug fix, feature add, refactor, review)
   - User-saveable custom templates
   - Project-specific template library

5. **Learning & History**
   - Track prompt patterns in `.claude/memory/prompt-history.md`
   - Analyze frequent clarification questions to improve smart defaults
   - Suggest improvements based on user modification patterns
   - Auto-learn project-specific context over time

6. **Multi-Language Support**
   - Expand beyond Slovak/English (German, French, Spanish, etc.)
   - Language-specific coding conventions and style guides
   - Cultural context awareness for article generation

### Long-Term Vision

7. **Integration & Automation**
   - Export perfected prompts to Jira, Azure DevOps, GitHub Issues
   - API for programmatic prompt perfection
   - CI/CD integration for automated prompt validation

8. **Advanced Context Intelligence**
   - ML-based context prediction from codebase
   - Auto-detect coding patterns and team conventions
   - Project memory: remember decisions, patterns, preferences
   - Cross-project learning for multi-repo workspaces

9. **Team Collaboration Features**
   - Shared prompt library in `.claude/team/prompts/`
   - Prompt review workflow (like code review)
   - Team-specific smart defaults and conventions
   - Prompt quality metrics and dashboards

### Experimental Ideas

10. **Prompt Analytics Dashboard**
    - Track: clarity improvements, time saved, success rates
    - Identify patterns in missing information
    - Measure Phase 0 effectiveness

11. **Natural Language Processing Enhancements**
    - Voice input support for hands-free prompting
    - Real-time clarification dialogue
    - Sentiment analysis for tone adjustment

12. **Visual Prompt Builder**
    - GUI overlay for drag-and-drop prompt construction
    - Visual completeness indicators
    - Interactive decision trees for complex tasks

---

**Implementation Notes:**
- High priority items align with current Phase 0 architecture
- All enhancements should preserve the Phase 0 flow
- Maintain backward compatibility with existing commands
- See `README.md` for detailed enhancement descriptions
