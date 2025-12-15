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

## Prompt Commands

Commands for perfecting prompts and generating content. All prompt commands follow a **standardized Phase 0 flow** that ensures clarity and completeness before execution.

### Phase 0: Prompt Perfection Flow

Every prompt command starts with Phase 0 to transform vague requests into precise, executable instructions:

1. **Step 0.1: Initial Analysis**
   - Detects language (Slovak/English)
   - Identifies prompt type (Task, Question, Bug Fix, Explanation, Code Review, etc.)
   - Extracts core intent

2. **Step 0.2: Completeness Check**
   - Verifies: Goal, Context, Scope, Constraints, Success Criteria
   - Marks missing items for clarification
   - Uses smart defaults where applicable

3. **Step 0.3: Clarification**
   - Asks questions about ambiguous or missing information
   - Presents multiple implementation options when valid approaches exist
   - Marks recommended approach with reasoning

4. **Step 0.4: Correction**
   - Fixes grammar, spelling, sentence structure
   - Preserves technical terms, code references, variable names EXACTLY
   - Makes prompts clear, specific, and actionable

5. **Step 0.5: Structure the Perfect Prompt**
   - Outputs structured format: Goal, Context, Scope, Requirements, Constraints, Expected Result
   - Ready for execution with ZERO ambiguity

6. **Wait for Approval**
   - User reviews perfected prompt
   - Can approve (`y`), cancel (`n`), or request modifications
   - Ensures user sees exactly what will be executed

7. **Execute Command-Specific Logic**
   - Only after approval, execute the specialized command logic
   - `/prompt`: Outputs perfected prompt
   - `/prompt-technical`: Runs technical analysis and generates code scaffolding
   - `/prompt-article`: Launches interactive article wizard
   - `/prompt-article-readme`: Analyzes project and generates README

### Smart Defaults

Specialized commands auto-detect context to streamline the process:

- **`/prompt-article`**: Auto-detects prompt type as "Article/Content Creation"
- **`/prompt-article-readme`**: Auto-detects current directory and project structure from config files (package.json, *.csproj, etc.)
- **`/prompt-technical`**: Auto-analyzes tech stack, framework, architecture patterns, and existing code conventions

Smart defaults are clearly marked in output (e.g., *(auto-detected)*) so users know what was inferred.

### Command Reference

| Command | Purpose | Smart Defaults |
|---------|---------|----------------|
| `/prompt` | Perfect any prompt - analyze, clarify, correct, structure | Language detection |
| `/prompt-technical` | Technical implementation analysis with code scaffolding | Project structure, tech stack, patterns |
| `/prompt-article` | Interactive article writing wizard (blog, LinkedIn, tutorial, etc.) | Article type, output format |
| `/prompt-article-readme` | README.md generator with project analysis | Project type, directory, tech stack |

### Usage Example

```
User: /prompt Fix login bug

Claude (Phase 0):
Detected Language: English
Prompt Type: Bug Fix

Completeness Check:
✓ Goal: Fix login bug
✗ Context: MISSING - Which framework? ASP.NET? React?
✗ Scope: MISSING - Frontend or backend? Which file?
✗ Success Criteria: MISSING - How to verify fix?

Questions:
1. What authentication framework are you using?
2. What specific error occurs?
3. Which layer needs fixing (UI, API, database)?

[After user answers...]

Perfected Prompt:
Goal: Fix null reference exception in ASP.NET Core login API
Context: ASP.NET Core 6.0, SQL Server, JWT authentication
Scope: UserController.Login() method, line 47
Requirements:
  1. Handle null email input
  2. Add proper error logging
  3. Return appropriate HTTP status codes
Constraints: Maintain existing JWT token structure
Expected Result: Login API handles invalid input gracefully

⏸️ Waiting for approval. Reply y/n/modifications

User: y

Claude: [Proceeds with implementation...]
```

## Session Memory

Persistent context between Claude Code sessions.

| Command | Purpose |
|---------|---------|
| `/session-end` | Save session context (decisions, changes, next steps) |
| `/session-start` | Load previous session context |

@.claude/memory/sessions.md

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
