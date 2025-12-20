# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is the **Claude Commands Library** - a collection of reusable slash commands for Claude Code that enhance prompt engineering, content creation, and session management.

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

See .claude/config/RESPONSE_STYLE.txt for detailed formatting rules.

## Repository Type

- **Language:** Markdown (command definitions and documentation)
- **Platform:** Windows 11 (primary), cross-platform compatible
- **Format:** Claude Code slash commands using `.md` files

## Architecture

This repository uses a **library-based architecture** where:

1. **Core Library** (`.claude/library/prompt-perfection-core.md`) - Canonical Phase 0 implementation
2. **Adapters** (`.claude/library/adapters/`) - Domain-specific customizations for different command types
3. **Commands** (`.claude/commands/`) - Individual slash commands that reference the library
4. **Configuration** (`.claude/config/`) - JSON config files for complexity detection, agent templates, caching, etc.

### Key Architectural Pattern

Commands don't duplicate Phase 0 logic - they **reference** the library:

```markdown
## Phase 0: Prompt Perfection
**Import:** Use Phase 0 from `.claude/library/prompt-perfection-core.md`
**Adaptation:** Technical (from `.claude/library/adapters/technical-adapter.md`)
```

This ensures:
- Consistency across all commands
- Single source of truth for Phase 0
- Easy maintenance (update once, all commands benefit)
- Smaller command files (50-200 lines instead of 500+)

## Project Structure

```
.claude/
├── commands/                 # Slash commands
│   ├── prompt.md            # Basic prompt perfection
│   ├── prompt-hybrid.md     # Hybrid with agent support
│   ├── prompt-technical.md  # Technical analysis
│   ├── prompt-article.md    # Article generation
│   ├── session-start.md     # Load session context
│   └── session-end.md       # Save session context
├── library/                  # Reusable components
│   ├── prompt-perfection-core.md  # Canonical Phase 0
│   └── adapters/            # Domain-specific adaptations
│       ├── technical-adapter.md
│       ├── article-adapter.md
│       ├── session-adapter.md
│       └── hybrid-adapter.md      # Advanced features (NEW v2.0)
├── config/                   # Configuration files
│   ├── complexity-rules.json      # Complexity detection
│   ├── agent-templates.json       # Agent prompts
│   ├── cache-config.json          # Caching settings
│   ├── verification-config.json   # Multi-agent verification
│   └── learning-config.json       # Learning system
├── memory/                   # User session data (preserved on update)
│   ├── sessions.md          # Session history
│   └── prompt-patterns.md   # Learned patterns
└── cache/                    # Agent result cache
    └── agent-results/

doc/                          # Documentation
├── Unified_Library_System_Guide.md
├── Hybrid_Prompt_Perfection_Architecture.md
├── Executive_Summary_Hybrid_Prompt_System.md
└── Advanced_Features_Testing_Guide.md

install-claude-commands.ps1   # Windows installer script
```

## Installation

This repository includes an installer script for easy deployment:

```powershell
# Download installer
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-commands.ps1" -OutFile "install-claude-commands.ps1"

# Run installer in your project directory
.\install-claude-commands.ps1
```

The installer:
- Clones/updates the repository
- Deploys `.claude/` directory to your project
- Preserves user memory files during updates
- Creates backups before updates
- Verifies installation completeness

See `README-INSTALL.md` for detailed installation instructions.

---

## Version 2.0 - December 2024 Refactoring ✨

**Major Architectural Improvements:**

The v2.0 release brings significant improvements to the command library architecture:

### What Changed

**Before v2.0:**
- Each command had its own Phase 0 implementation
- Code duplication across multiple commands
- Inconsistent validation logic
- Harder to maintain (updates needed in multiple files)

**After v2.0:**
- All commands reference the unified library system
- Single source of truth for Phase 0 logic
- Consistent validation across all commands
- Easy maintenance (update library once, all commands benefit)
- New hybrid-adapter.md for reusable advanced features

### File Size Reductions

- `prompt-hybrid.md`: Reduced from 1097 to 1037 lines (~500 lines of duplication eliminated)
- All commands now 50-200 lines of domain logic + library references
- Overall codebase: More maintainable with DRY principles

### New Features in v2.0

1. **Hybrid Intelligence Adapter** (`.claude/library/adapters/hybrid-adapter.md`)
   - Reusable complexity detection
   - Agent spawning logic
   - Caching system
   - Multi-agent verification
   - Learning system integration

2. **Enhanced Documentation**
   - All commands now have version history
   - Library Integration sections
   - Clear references to core and adapters
   - Consistent structure across all commands

3. **Improved Maintainability**
   - Single source of truth for Phase 0
   - Easy to add new commands (just reference the library)
   - Simple to update all commands (modify library once)
   - Clear separation of concerns (core vs. domain logic)

### Migration Guide

If you created custom commands based on v1.0:

1. Replace duplicate Phase 0 code with library references:
   ```markdown
   ## Phase 0: Prompt Perfection
   **Import:** Use Phase 0 from `.claude/library/prompt-perfection-core.md`
   **Adaptation:** [Technical/Article/Session/Hybrid] (from adapter)
   ```

2. Add version history section
3. Add Library Integration section
4. Keep your domain-specific logic in Phase 1+

See any v2.0 command for examples.

---

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

### `/prompt-technical` ✨ NOW WITH HYBRID INTELLIGENCE

**Purpose:** Provide deep technical analysis for programming tasks with automatic agent-powered codebase exploration.

**What it does:**
1. **Detects complexity** automatically (simple/moderate/complex)
2. **Scans project structure** (manual for simple tasks, agent for complex)
3. **Identifies frameworks, patterns, and conventions** from codebase
4. **Validates technical feasibility** (agent-powered when needed)
5. **Generates 2-3 implementation options** with pros/cons
6. **Recommends best approach** with reasoning based on codebase analysis
7. **Provides ready-to-use code scaffolding** matching your conventions

**Hybrid Intelligence:**
- **Simple tasks (score 0-4):** Fast manual scan (~5s)
- **Moderate tasks (score 5-9):** Asks if you want agent assistance
- **Complex tasks (score 10+):** Automatically spawns Explore agent (~20s)

**Usage:**
```
/prompt-technical Add caching following existing patterns
```

**Complexity Triggers:**
- Multi-file scope, architecture questions, pattern detection needed
- Feasibility checks, implementation planning, cross-cutting concerns

**Output:** Technical analysis report with:
- Project context (manual or agent-discovered)
- Implementation options aligned with codebase patterns
- Best practices checklist
- Code scaffolding matching conventions
- Agent insights (if agent was used)

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

### `/prompt-hybrid` ✨ INTELLIGENT PROMPT PERFECTION + ADVANCED FEATURES

**Purpose:** Transform any prompt into an unambiguous, executable format using intelligent complexity detection, autonomous agent assistance, caching, and learning.

**Core Capabilities:**
1. **Analyzes your prompt** - Detects language, type, and core intent
2. **Detects complexity** automatically using 7 trigger rules
3. **Spawns agents when needed** - Complex tasks get deep codebase analysis
4. **Validates completeness** - Dual-layer (structural + semantic)
5. **Asks clarifying questions** - Never guesses, always validates
6. **Perfects the prompt** - Structured output with all required details

**Advanced Features:** ⚡🔍📚 **NEW (December 2025)**
7. **Agent Result Caching** ⚡ - Cached results make repeated prompts 10-20x faster
8. **Multi-Agent Verification** 🔍 - Critical operations verified by 2-3 agents in parallel
9. **Learning System** 📚 - Tracks patterns, suggests smart defaults, improves over time

**The Hybrid Approach:**

```
Your Prompt
     ↓
Complexity Detection
     ↓
┌────────┴────────┐
↓                 ↓
Simple        Complex
(0-4)         (10+)
     ↓                 ↓
Inline Q&A    Check Cache ⚡
     ↓                 ↓
     │         Cache Hit? → Use Cached
     │                 ↓
     │         Cache Miss → Spawn Agent(s)
     │                 ↓
     │         Verify (if critical) 🔍
     ↓                 ↓
     └────────┬────────┘
              ↓
      Perfected Prompt
              ↓
       Track Pattern 📚
```

**Complexity Scoring:**
- **0-4 (Simple):** Fast inline validation (~2s)
- **5-9 (Moderate):** Ask user if agent assistance wanted
- **10+ (Complex):** Automatically spawn Explore agent (~20s first time, ~2s if cached)
- **15+ (Critical):** Multi-agent verification triggered (~50s)

**Triggers (with weights):**
- Multi-file scope (+5), Architecture questions (+7)
- Pattern detection (+6), Feasibility checks (+4)
- Implementation planning (+3), Cross-cutting concerns (+4)
- Refactoring tasks (+5)

**Usage:**
```
/prompt-hybrid Add user authentication following existing patterns
/prompt-hybrid Implement payment processing with security  # Triggers multi-agent
```

**Agent Capabilities (when spawned):**
- Explores relevant files automatically
- Detects existing patterns and conventions
- Validates technical feasibility
- Finds similar implementations
- Returns structured recommendations

**Caching Capabilities:** ⚡ **NEW**
- Caches agent results for 24 hours (configurable)
- Cache key: prompt + file hashes + git branch + agent template
- Auto-invalidates on file changes or branch switch
- 10-20x faster for repeated/similar prompts
- Saves agent costs (no re-analysis needed)

**Multi-Agent Verification:** 🔍 **NEW**
- Triggers for: complexity >= 15, critical keywords (payment, security, auth, migration)
- Spawns 2-3 agents with different strategies in parallel
- Consensus analysis shows agreements and disagreements
- Higher confidence for critical operations
- User chooses approach when agents disagree

**Learning System:** 📚 **NEW**
- Tracks successful prompt transformations
- Records patterns after 3+ occurrences
- Suggests smart defaults automatically
- Learns user preferences and coding patterns
- Improves complexity score accuracy over time
- Stored in: `.claude/memory/prompt-patterns.md`

**Output:** Perfected prompt with:
- Goal, Context, Scope, Requirements, Constraints, Expected Result
- Agent insights (if agent was used)
- Technical validation
- Pattern recommendations
- Cache performance (if applicable)
- Verification consensus (if multi-agent used)
- Learning insights (if pattern detected)
- All ambiguities resolved

**Performance:**
- Simple path: ~2s
- Complex path (first time): ~20s
- Complex path (cached): ~2s (10-20x faster!)
- Multi-agent verification: ~50s (3 agents in parallel)
- Learning tracking: <1s

**Configuration:**
- `.claude/config/complexity-rules.json` - Adjust triggers/weights
- `.claude/config/agent-templates.json` - Custom agent behavior
- `.claude/config/cache-config.json` - Caching settings (max age, size) ⚡ **NEW**
- `.claude/config/verification-config.json` - Multi-agent verification ⚡ **NEW**
- `.claude/config/learning-config.json` - Learning system settings 📚 **NEW**

**Cache Management:**
- View cache: `.claude/cache/agent-results/`
- Clear cache: Delete `.claude/cache/agent-results/` directory
- Cache auto-cleans at 50MB (configurable)

**Learning Data:**
- View patterns: `.claude/memory/prompt-patterns.md`
- Statistics: Total prompts, cache hit rate, approval rate, agent effectiveness

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

## Prompt Command Selection Guide

### Which Command Should You Use?

| Your Goal | Command | Why |
|-----------|---------|-----|
| **Quick prompt cleanup** | `/prompt` | Fast, simple, no codebase analysis |
| **General prompt perfection** | `/prompt-hybrid` | Smart complexity detection, agents when needed |
| **Technical implementation** | `/prompt-technical` | Deep tech analysis, auto-detects patterns |
| **Write an article** | `/prompt-article` | Interactive wizard, multi-platform output |
| **Generate README** | `/prompt-article-readme` | Project analysis, auto-detects tech stack |
| **Start session** | `/session-start` | Load previous context |
| **End session** | `/session-end` | Save current context |

### Decision Tree

```
Need prompt help?
├─ Just fix my prompt quickly → /prompt
├─ Complex task, not sure if needs analysis → /prompt-hybrid
├─ Technical implementation needed → /prompt-technical
├─ Want to write article/content → /prompt-article
└─ Need README for project → /prompt-article-readme

Session management?
├─ Starting work → /session-start
└─ Ending work → /session-end
```

### Detailed Comparison

#### `/prompt` vs `/prompt-hybrid`

**Use `/prompt` when:**
- ✅ You need quick prompt cleanup (< 2 seconds)
- ✅ The task is simple and well-defined
- ✅ You don't need codebase analysis
- ✅ You want to provide all context yourself

**Use `/prompt-hybrid` when:**
- ✅ The task might be complex (let it detect)
- ✅ You want codebase context automatically gathered
- ✅ You need pattern/convention detection
- ✅ You want technical feasibility validation
- ✅ You're unsure what information is needed

**Example:**
```
/prompt Fix typo in line 42          → Simple, use /prompt
/prompt-hybrid Add auth like existing → Complex, auto-spawns agent
```

#### `/prompt-hybrid` vs `/prompt-technical`

**Use `/prompt-hybrid` when:**
- ✅ You want the prompt perfected first
- ✅ General-purpose prompt perfection
- ✅ Not necessarily technical implementation
- ✅ Let complexity detection decide approach

**Use `/prompt-technical` when:**
- ✅ You specifically want technical analysis
- ✅ You need implementation options with code
- ✅ You want best practices checklist
- ✅ You need detailed code scaffolding
- ✅ After you've already perfected the prompt

**Workflow:**
```
/prompt-hybrid [idea]  → Perfect the prompt first
     ↓
/prompt-technical      → Then get technical analysis
```

### Common Workflows

**Workflow 1: From Idea to Implementation**
```
1. /prompt-hybrid "Add feature X"
   → Perfects prompt, gathers context

2. /prompt-technical
   → Technical analysis, implementation options

3. Implement (Claude executes the plan)

4. /session-end
   → Save session context
```

**Workflow 2: Article Writing**
```
1. /prompt-article "Write about topic X"
   → Interactive wizard

2. Generate article for multiple platforms

3. /session-end
   → Save work
```

**Workflow 3: Documentation**
```
1. /prompt-article-readme
   → Generate README from project

2. Review and customize

3. /session-end
   → Save changes
```

---

## Hybrid Prompt System Architecture

### How It Works

The hybrid system combines **prompt-based commands** with **autonomous agents** for optimal performance:

**Key Components:**

1. **Complexity Detection Engine**
   - Location: `.claude/config/complexity-rules.json`
   - 7 trigger rules with configurable weights
   - Automatic scoring: Simple (0-4), Moderate (5-9), Complex (10+)

2. **Agent Templates**
   - Location: `.claude/config/agent-templates.json`
   - 4 specialized templates for different analysis types
   - Customizable for your domain

3. **Hybrid Commands**
   - `/prompt-hybrid` - General prompt perfection
   - `/prompt-technical` - Technical analysis

### Complexity Triggers Reference

| Trigger | Weight | Examples | Agent Type |
|---------|--------|----------|------------|
| Multi-file scope | 5 | "across files", "entire codebase" | Explore |
| Architecture questions | 7 | "how does", "where is" | Explore |
| Pattern detection | 6 | "existing pattern", "match existing" | Explore |
| Feasibility check | 4 | "is it possible", "can we" | Explore |
| Implementation planning | 3 | "implement", "build" | Plan |
| Cross-cutting concerns | 4 | "authentication", "logging" | Explore |
| Refactoring tasks | 5 | "refactor", "restructure" | Explore |

**Example Scoring:**
```
Prompt: "Add caching following existing patterns"
Triggers:
  - "existing patterns" → Pattern detection (+6)
  - "caching" → Cross-cutting concern (+4)
Total: 10 → Complex → Agent spawns automatically
```

### Agent Types

**Explore Agent** (Haiku, 30s timeout)
- Fast codebase exploration
- Pattern and convention detection
- File discovery
- Context gathering

**Plan Agent** (Sonnet, 60s timeout)
- Implementation planning
- Architectural analysis
- Trade-off evaluation

### Configuration

**Customize Complexity Rules:**
```json
// .claude/config/complexity-rules.json
{
  "rules": [
    {
      "id": "your_custom_trigger",
      "name": "Custom Trigger",
      "triggers": ["keyword1", "keyword2"],
      "weight": 5,
      "agent": "Explore"
    }
  ],
  "thresholds": {
    "simple": {"max": 4},
    "moderate": {"min": 5, "max": 9},
    "complex": {"min": 10}
  }
}
```

**Customize Agent Templates:**
```json
// .claude/config/agent-templates.json
{
  "templates": {
    "your_custom_template": {
      "agent": "Explore",
      "model": "haiku",
      "prompt_template": "Your custom instructions..."
    }
  }
}
```

### Performance Metrics

| Path | Time | Use Case |
|------|------|----------|
| Simple (inline) | ~2s | Quick prompts, single file |
| Moderate (ask) | ~2s or ~20s | User chooses depth |
| Complex (agent) | ~20s | Multi-file, patterns, feasibility |

**Agent Performance:**
- Explore (Haiku): ~15-25s, cost-effective
- Plan (Sonnet): ~25-40s, higher quality

---

## Development Practices for This Repository

### Working with Commands

**When adding or modifying commands:**

1. **Use the Library System** - Don't duplicate Phase 0 logic
   - Reference `.claude/library/prompt-perfection-core.md`
   - Use adapters from `.claude/library/adapters/` when needed
   - Keep commands focused on their specific functionality

2. **Follow the Pattern** - Study existing commands as templates
   - `prompt.md` - Simplest example
   - `prompt-hybrid.md` - Most complex (with agents, caching, learning)
   - `session-end.md` - Session management pattern

3. **Test Changes** - Verify commands work as expected
   - Test Phase 0 validation flow
   - Verify import references work correctly
   - Check domain-specific adaptations apply properly

### Working with the Library

**When modifying core library:**

1. **Impact Analysis** - Changes affect ALL commands
   - Test with at least 2-3 different commands
   - Verify backward compatibility
   - Update version number in library file

2. **Adapter Pattern** - Use adapters for domain-specific logic
   - Don't modify core for domain-specific needs
   - Create/update adapters instead
   - Keep core universal

### Working with Configuration

**When modifying config files:**

1. **Validate JSON** - Ensure valid JSON syntax
   ```powershell
   Get-Content .claude/config/complexity-rules.json | ConvertFrom-Json
   ```

2. **Test Changes** - Verify config works as expected
   - Test complexity detection with different prompts
   - Verify agent templates spawn correctly
   - Check cache invalidation rules

### Documentation Standards

**When updating documentation:**

1. **Keep CLAUDE.md in Sync** - This file is the source of truth
   - Update here first, then other docs
   - Maintain consistency across README.md and CLAUDE.md

2. **Version Documentation** - Track major changes
   - Update version numbers in library files
   - Document breaking changes
   - Maintain backward compatibility when possible

### Git Workflow

**For this repository:**

- Main branch is `main`
- Keep command files atomic (one command per file)
- Preserve `.claude/memory/` directory (user data)
- Never commit cache files (`.claude/cache/`)

### Testing New Features

**Manual testing workflow:**

1. Install to a test project: `.\install-claude-commands.ps1 -InstallPath "C:\TestProject"`
2. Test the command: `/your-command test input`
3. Verify Phase 0 flow works correctly
4. Check output matches expectations
5. Test edge cases and error handling

## Hybrid System - Implementation Status

### ✅ Completed (December 2025)

**Hybrid Prompt Perfection System** - PRODUCTION READY

**Core Features:**
- ✅ Automatic complexity detection engine
- ✅ Intelligent agent spawning (Explore & Plan agents)
- ✅ Dual-layer validation (structural + semantic)
- ✅ Template-based agent system
- ✅ Configuration files for customization
- ✅ `/prompt-hybrid` command (standalone)
- ✅ `/prompt-technical` with hybrid intelligence
- ✅ Comprehensive documentation

**Advanced Features:** ⚡🔍📚 **NEW (December 2025)**
- ✅ **Agent Result Caching** - 10-20x faster for repeated prompts
- ✅ **Multi-Agent Verification** - Cross-validate critical operations with 2-3 agents
- ✅ **Learning System** - Track patterns, suggest smart defaults, improve over time
- ✅ **Consensus Analysis** - Aggregate findings from multiple agents
- ✅ **Cache Invalidation** - Auto-detect file/branch changes
- ✅ **Pattern Tracking** - Learn from successful transformations
- ✅ **Smart Defaults** - Auto-suggest context after 3+ pattern occurrences

**Core System Files:**
- `.claude/commands/prompt-hybrid.md` - Main hybrid command
- `.claude/config/complexity-rules.json` - Complexity detection rules
- `.claude/config/agent-templates.json` - Agent prompt templates
- `doc/Hybrid_Prompt_Perfection_Architecture.md` - Full architecture
- `doc/Executive_Summary_Hybrid_Prompt_System.md` - Quick reference

**Advanced Features Files:** ⚡ **NEW**
- `.claude/config/cache-config.json` - Agent caching configuration
- `.claude/config/verification-config.json` - Multi-agent verification settings
- `.claude/config/learning-config.json` - Learning system configuration
- `.claude/memory/prompt-patterns.md` - Pattern tracking database

**Performance:**
- Simple path: ~2s
- Complex path (first time): ~20s
- Complex path (cached): ~2s (10-20x improvement!)
- Multi-agent verification: ~50s (3 agents in parallel)

**See documentation:**
- Core system: `doc/Executive_Summary_Hybrid_Prompt_System.md`
- Advanced features: `.claude/commands/prompt-hybrid.md` (sections: "Advanced Features Guide")

---

## Future Enhancements: Prompt Commands

The following enhancements can further improve the prompt command system:

### Next Steps (High Priority)

1. **Example Library Integration**
   - Add `.claude/commands/examples/` directory with interactive examples
   - Include before/after transformations for each command
   - Domain-specific examples (ASP.NET Core, React, SQL Server tasks)

2. **Prompt Quality Scoring** ← Partially implemented via complexity detection
   - Enhance scoring with quality metrics
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

5. **Learning & History** ✅ **COMPLETED (December 2025)**
   - ✅ Track prompt patterns in `.claude/memory/prompt-patterns.md`
   - ✅ Analyze frequent clarification questions to improve smart defaults
   - ✅ Suggest improvements based on user modification patterns
   - ✅ Auto-learn project-specific context over time
   - ✅ Agent result caching for performance
   - ✅ Multi-agent verification for critical operations
   - See: Advanced Features in `/prompt-hybrid`

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
