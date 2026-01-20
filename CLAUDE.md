# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

**Extended Context:** See @.claude/CLAUDE.md for memory imports and active context.

## Project Overview

**Claude Commands Library** - A collection of reusable slash commands for Claude Code that enhance prompt engineering, content creation, and session management using a library-based architecture.

---

## Response Style Guidelines

**IMPORTANT: Terminal Response Formatting**

When responding in the Claude Code terminal, use PLAIN TEXT ONLY to avoid rendering issues.

DO NOT use in terminal responses:
- Markdown headers (##, ###)
- Emojis (all types)
- Markdown tables
- Special bullets or formatting
- Lines over 80 characters

DO use in terminal responses:
- Plain text only
- Simple dashes for lists (-)
- UPPERCASE for emphasis
- Blank lines between sections
- Simple indentation

For markdown files:
- NEVER display markdown file contents in terminal
- Read files using Read tool when needed
- Respond in plain text only
- Direct user to VS Code for viewing: code FILENAME.md

See `.claude/config/RESPONSE_STYLE.txt` for detailed formatting rules.

---

## Architecture

**Library-Based Pattern:**
1. **Core Library** - `.claude/library/prompt-perfection-core.md` (Phase 0)
2. **Adapters** - `.claude/library/adapters/` (domain customizations)
3. **Commands** - `.claude/commands/` (reference library)
4. **Configuration** - `.claude/config/` (JSON configs)

Commands reference the library instead of duplicating Phase 0 logic, ensuring consistency and maintainability.

---

## Current Version: v4.1 (January 2026)

**Skill Reflection System** - Actively analyze conversations and propose skill improvements based on corrections, successes, and user preferences.

**NEW in v4.1: /reflect Command**
- `/reflect` - Analyze session and propose skill improvements (5-15s)
- Signal detection (corrections, successes, edge cases, preferences)
- Priority-coded change proposals (HIGH/MED/LOW)
- Direct skill file modifications with user approval
- Observation persistence for later review
- Integration with learning system

**From v4.0: Predictive Intelligence (Phase 0.15)**
- Journey stage detection (6 stages: exploring/planning/implementing/debugging/refactoring/reviewing)
- Proactive warnings (prevent problems BEFORE they occur)
- Domain risk analysis (security, compliance, performance)
- Project pattern recognition (auto-detect conventions)
- Relationship mapping (connect to previous work)
- Next-steps prediction (forecast logical followups)
- Smart scoping (Focused/Balanced/Comprehensive options)

**From v3.0: Multi-Agent Research System**
- `/prompt-research` - Deep multi-agent analysis (2-5 agents, 2-4 iterations)
- Specialized agents: Explore, Citation, Security, Performance, Pattern
- External memory: Persistent knowledge across sessions
- Comprehensive reports: 15-20 pages with file:line citations

**Backward Compatible:** All v4.0, v3.0, v2.0, and v1.0 commands work unchanged.

**See:** `.claude/docs/v4.1-RELEASE-NOTES.md` for full changelog.

---

## Installation

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-commands.ps1" -OutFile "install-claude-commands.ps1"
.\install-claude-commands.ps1
```

Installer clones repo, deploys `.claude/` directory, preserves user memory files.
See `README-INSTALL.md` for details.

---

## Commands

### Prompt Perfection

**`/prompt`** - Quick prompt cleanup and validation (2s) **NEW v4.0: LITE Predictive Intelligence**
- Detects language, type, completeness
- Asks clarifying questions
- Proactive warnings and next-steps (LITE)
- Outputs structured prompt

**`/prompt-hybrid`** - Intelligent perfection with agents (2-30s) **NEW v4.0: FULL Predictive Intelligence**
- Auto-detects complexity
- Spawns agents when needed (score 10+)
- Journey stage detection and proactive guidance
- Domain risk analysis and security warnings
- Pattern recognition and relationship mapping
- Next-steps prediction with scope options
- Caching, multi-agent verification, learning system
- Config: complexity-rules.json, predictive-intelligence.json

**`/prompt-research`** - Deep multi-agent research (60-180s) **NEW v3.0**
- 2-5 specialized agents in parallel
- 2-4 iteration cycles with gap-driven refinement
- Persistent knowledge graph
- Use for: security audits, performance analysis, architecture review

**`/prompt-technical`** - Technical analysis with hybrid intelligence (5-30s)
- Detects complexity, spawns agents for complex tasks
- Implementation options with pros/cons
- Code scaffolding matching codebase patterns

### Content Creation

**`/prompt-article`** - Interactive article wizard
- Multi-platform output (LinkedIn, Medium, Dev.to, etc.)
- Saves markdown to specified location

**`/prompt-article-readme`** - README generator
- Analyzes project, detects tech stack
- Minimal/Standard/Comprehensive styles

### Session Management

**`/session-start`** - Load previous context
- Aggregates all sessions, preferences, patterns
- Shows active work, pending next steps

**`/session-end`** - Save comprehensive context
- Captures 10 sections: decisions, code changes, features, insights, etc.
- Appends to `.claude/memory/sessions.md`

### Skill Improvement

**`/reflect`** - Analyze session and improve skills (5-15s) **NEW v4.1**
- Signal detection (corrections, successes, edge cases, preferences)
- Priority-coded change proposals (HIGH/MED/LOW)
- Direct skill file modifications with user approval
- Observation persistence for later review

---

## Command Selection

| Goal | Command | Speed |
|------|---------|-------|
| Quick cleanup | `/prompt` | 2s |
| General perfection | `/prompt-hybrid` | 2-30s |
| Deep research | `/prompt-research` | 60-180s |
| Technical impl | `/prompt-technical` | 5-30s |
| Article | `/prompt-article` | Interactive |
| README | `/prompt-article-readme` | 30s |
| Improve skills | `/reflect` | 5-15s |

**See:** `.claude/docs/comparisons.md` for detailed decision trees and workflows.

---

## Configuration Files

**Complexity Detection:**
- `.claude/config/complexity-rules.json` - Triggers, weights, thresholds

**Agent System:**
- `.claude/config/agent-templates.json` - Agent prompts
- `.claude/config/cache-config.json` - Caching settings
- `.claude/config/verification-config.json` - Multi-agent verification
- `.claude/config/learning-config.json` - Learning system

**v3.0 Research System:**
- `.claude/config/orchestration-config.json` - Research strategies
- `.claude/config/iteration-rules.json` - Convergence criteria
- `.claude/config/agent-roles.json` - Agent definitions
- `.claude/config/citation-config.json` - Citation formatting
- `.claude/config/external-memory-config.json` - Memory persistence

---

## Project Structure

```
.claude/
├── commands/           # Slash commands
├── library/            # Core + adapters + orchestration + agents
├── config/             # JSON configs
├── memory/             # Sessions, patterns, knowledge graph
├── cache/              # Agent results, iteration checkpoints
└── docs/               # Extended documentation (NEW)
    ├── version-history.md
    ├── comparisons.md
    └── roadmap.md

docs/                   # VitePress documentation site
docs-archive/           # Legacy documentation (v2.0 and earlier)
```

---

## Development Practices

### Working with Commands
1. Use library system - reference `.claude/library/prompt-perfection-core.md`
2. Use adapters for domain-specific logic
3. Test Phase 0 validation flow

### Working with Library
1. Changes affect ALL commands - test multiple commands
2. Verify backward compatibility
3. Use adapters for domain needs, keep core universal

### Working with Configuration
1. Validate JSON syntax: `Get-Content file.json | ConvertFrom-Json`
2. Test complexity detection, agent spawning, cache invalidation

### Git Workflow
- Main branch: `main`
- Preserve `.claude/memory/` (user data)
- Never commit `.claude/cache/`

---

## Documentation

**VitePress Site:** https://tadzesi.github.io/claude-ideas/

**Quick References:**
- Version history: `.claude/docs/version-history.md`
- Command comparisons: `.claude/docs/comparisons.md`
- Future roadmap: `.claude/docs/roadmap.md`

**Legacy Docs (v2.0):** `docs-archive/`

---

## Hybrid System Architecture

**Complexity Detection Engine:**
- Location: `.claude/config/complexity-rules.json`
- 7 trigger rules with weights
- Thresholds: Simple (0-4), Moderate (5-9), Complex (10+), Research (20+)

**Triggers:**
- Multi-file scope (+5), Architecture questions (+7)
- Pattern detection (+6), Feasibility checks (+4)
- Implementation planning (+3), Cross-cutting concerns (+4)
- Refactoring tasks (+5)

**Agent Types:**
- **Explore Agent** (Haiku, 30s) - Codebase exploration, patterns
- **Plan Agent** (Sonnet, 60s) - Implementation planning
- **Security Agent** (Sonnet, 45s) - OWASP Top 10, vulnerabilities
- **Performance Agent** (Sonnet, 45s) - Bottlenecks, N+1 queries
- **Pattern Agent** (Haiku, 30s) - Conventions, consistency

**Performance:**
- Simple path: ~2s
- Complex path (first): ~20s
- Complex path (cached): ~2s (10-20x faster)
- Multi-agent verification: ~50s
- Research (standard): ~120s

---

## Implementation Status

**PRODUCTION READY (v3.0 - December 2025)**

**Core Features:**
- Automatic complexity detection
- Intelligent agent spawning
- Dual-layer validation
- Template-based agents
- All commands v3.0 compatible

**Advanced Features:**
- Agent result caching (10-20x speedup)
- Multi-agent verification (2-3 agents parallel)
- Learning system (pattern tracking)
- External memory (persistent knowledge graph)
- Iterative refinement (2-4 cycles)

**See:** `.claude/docs/roadmap.md` for future enhancements.

---

**Current Version:** v4.1 (Skill Reflection System)
**Documentation:** https://tadzesi.github.io/claude-ideas/
**Repository:** https://github.com/Tadzesi/claude-ideas
