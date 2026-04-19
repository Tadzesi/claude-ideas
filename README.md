# Claude Prompt Commands

[![Documentation](https://img.shields.io/badge/docs-live-brightgreen)](https://tadzesi.github.io/claude-ideas/)
[![GitHub Pages](https://github.com/Tadzesi/claude-ideas/actions/workflows/deploy-docs.yml/badge.svg)](https://github.com/Tadzesi/claude-ideas/actions/workflows/deploy-docs.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

A collection of Claude Code slash commands for prompt engineering, refinement, and content generation. Transform vague ideas into precise, executable prompts with intelligent agent assistance, caching, and learning.

**Version 4.8** - April 2026

## Features

- 🗣️ **Interaction Protocol** - Global SK/EN language rules, plan-first execution, no auto-execute (NEW v4.8)
- ⚡ **Dynamic Model Routing** - Skills suggest haiku/sonnet/opus per task, ~30-45% token savings (v4.7)
- 🔮 **Options-First** - 2-3 alternatives shown by default with cost estimates before execution (v4.7)
- 📋 **Execution Plan** - Mandatory pre-approval plan listing files, steps, model, and risks (v4.7)
- 🛡️ **Anti-Hallucination Contract** - HARD-GATE checklist + NEVER rules in every skill (NEW v4.6)
- 🌍 **Universal Skills** - All skills read config from personal-profile.md, no hardcoded values (v4.5)
- 🔵 **Project-Aware Commands** - /prompt-dotnet and /prompt-react scan your project automatically (v4.4)
- 🚀 **Deploy & Stack** - /deploy and /new-stack for project-aware deployment workflows (v4.3)
- 🔄 **Skill Reflection** - Actively improve skills from conversation feedback (v4.1)
- 📊 **Enhanced Statusline** - Color-coded context bar, tokens, API duration with icons (v4.1)
- 🔮 **Predictive Intelligence** - See 2 steps ahead with proactive guidance (v4.0)
- ⚠️ **Proactive Warnings** - Prevent problems BEFORE coding starts (v4.0)
- 📐 **Pattern Recognition** - Auto-detect project conventions and architectural patterns (v4.0)
- ⚡ **Prompt Perfection** - Analyze and refine any prompt to be clear and unambiguous
- 🤖 **Intelligent Agent Assistance** - Automatic codebase analysis for complex tasks
- 🔍 **Multi-Agent Verification** - Cross-validate critical operations with 3 agents
- 🔬 **Multi-Agent Research** - Deep codebase research with orchestrated agents and iterative refinement
- ⚡ **Agent Result Caching** - 10-20x faster for repeated prompts
- 📚 **Learning System** - Tracks patterns, suggests smart defaults, and improves skills with /reflect
- 🔧 **Technical Analysis** - Deep dive into implementation options with code scaffolding
- 📝 **Article Generation** - Interactive wizard for multi-platform content creation
- 📄 **README Generation** - Auto-generate professional documentation from project analysis

## Documentation

### 📚 Interactive Documentation (NEW!)

**[VitePress Documentation Site](https://tadzesi.github.io/claude-ideas/)** - Beautiful, searchable documentation

```bash
# Development server
npm run docs:dev

# Build documentation
npm run docs:build

# Preview production build
npm run docs:preview
```

### 📄 Additional Documentation

- **[Project Overview](CLAUDE.md)** - Detailed project documentation, architecture, and development practices
- **[Archived Documentation](docs-archive/)** - Historical documentation from v2.0 and earlier (migrated to VitePress)

---

## What's New in Version 4.8 🗣️

**Interaction Protocol (April 2026)**

Version 4.8 promotes Phase 0 discipline from individual skills to a **global protocol** loaded at session start. Now every interaction — not just `/prompt*` calls — follows the same rules.

### Headline Additions (`CLAUDE.md`)

🗣️ **Language Protocol**
- User píše po slovensky → Claude odpovedá po slovensky
- Tool calls, commit messages, code, docs → English
- Technical terms (paths, APIs) preserved verbatim

📋 **Plan-First Execution (mandatory)**
- Before any file change, build, test, or commit:
  1. Summarise understanding (1-2 sentences)
  2. Present 2-3 options for non-trivial work
  3. Emit an execution plan (files, steps, risks, verification)
  4. Wait for explicit approval — never assume consent

🔎 **Proactive Option-Finding**
- Claude is no longer a passive executor
- If a better path exists than what the user proposed, say so BEFORE executing
- Name the tradeoff, recommend, but leave the decision to the user

🛑 **Never Auto-Execute**
- No `git commit`, `git push`, `npm install`, or installer runs without explicit approval
- Both sides (AI + user) must understand WHAT, WHY, and HOW to verify

### Why It Matters

Previously, plan-first discipline lived only inside `/prompt*` skills. Normal conversation bypassed it — leading to unwanted auto-execution and token waste when assumptions were wrong. v4.8 fixes this at the root: `CLAUDE.md` is loaded into every session automatically.

Read the full guide: [Interaction Protocol](https://tadzesi.github.io/claude-ideas/guide/interaction-protocol.html)

---

## What's New in Version 4.7 ⚡

**Dynamic Model Routing + Smarter Phase 0 (April 2026)**

Version 4.7 makes every prompt cheaper to run and clearer to approve through three Phase 0 additions.

### Headline Features

⚡ **Dynamic Model Routing**
- New `model-router.md` decision algorithm routes haiku/sonnet/opus per task
- MODEL HINT shown in every Execution Plan
- Estimated 30-45% token savings for typical workflows

🔮 **Curiosity Gate (Step 0.25)**
- Confidence score 0-100 on every prompt analysis
- Mandatory assumption ledger when confidence drops below 100%
- No more silent guessing

📋 **Options-First (Step 0.35)**
- 2-3 alternatives shown BY DEFAULT for Task/Feature/Bug Fix/Refactor/Config
- Each option shows model tier + token-cost estimate
- `switch [haiku|sonnet|opus]` at approval gate to cut cost

📄 **Execution Plan (Step 0.55)**
- Mandatory pre-approval block: verified files, steps, tools, risks, MODEL HINT
- `switch [tier]` changes model before approving

---

## What Was New in Version 4.6 🛡️

**Superprompting: Anti-Hallucination Contract (April 2026)**

- HARD-GATE checklist in every skill (pre-flight before any output)
- NEVER rules (domain-specific prohibitions per skill)
- Chain-of-Thought REASONING block in Step 0.1
- Core library v2.0 with Mermaid flowchart and Grounding Protocol

---

## What Was New in Version 4.5 🌍

**Universal Skills + Project-Aware Commands (March 2026)**

Version 4.5 makes all skills fully universal - no hardcoded values anywhere. Skills read configuration dynamically from `personal-profile.md`.

### Headline Features

🌍 **Universal Skills**
- All skills removed hardcoded usernames, server addresses, paths
- `/deploy` and `/new-stack` now read server config from `personal-profile.md`
- Safer defaults - no accidental deploys to wrong servers

🔵 **Project-Aware Commands (v4.4)**
- `/prompt-dotnet` - scans `.csproj`, `Program.cs`, detects framework version and patterns
- `/prompt-react` - scans `package.json`, `vite.config`, detects React version and setup
- Both include scan fallbacks when project files are missing

🚀 **Removed: /session-start and /session-end**
- Replaced by Claude Code's built-in **auto-memory system**
- No manual session saving needed - Claude Code handles context automatically
- Cleaner workflow, one less step between sessions

---

## What Was New in Version 4.1 🔄

**AI Fluency Framework + Skill Reflection (January 2026)**

🤝 **AI Fluency Framework Integration** - Delegation Assessment, Interaction Mode Detection, Discernment Hints based on Anthropic's official AI Fluency research.

📊 **Enhanced Statusline** - Color-coded context bar, tokens, API duration with delta indicator.

🔄 **`/reflect` Command** - Analyze session signals, propose priority-coded skill improvements (HIGH/MED/LOW), apply with user approval.

See [v4.1 Release Notes](.claude/docs/v4.1-RELEASE-NOTES.md) for complete details.

---

## What Was New in Version 4.0 🔮

**Predictive Intelligence System (January 2026)**

Version 4.0 introduced **Predictive Intelligence** - see "2 steps ahead" with proactive guidance.

- 🔮 **Phase 0.15 Predictive Intelligence** - Journey stage detection, proactive warnings, next-steps prediction
- ⚠️ **Domain Risk Analysis** - 20+ risks across 6 domains (auth, payment, database, API, security, performance)
- 📐 **Pattern Recognition** - Auto-detect naming conventions and architectural patterns
- 🔗 **Relationship Mapping** - Connect current work to previous tasks

See [v4.0 Release Notes](.claude/docs/v4.0-RELEASE-NOTES.md) for complete details.

---

## What Was New in Version 3.0

**Multi-Agent Research System (December 2025)**

Version 3.0 introduced a **comprehensive multi-agent research system** with orchestrated agents and iterative refinement.

- 🔬 `/prompt-research` - Deep multi-agent research with 2-5 specialized agents
- 🤖 5 Specialized Research Agents (Explore, Citation, Security, Performance, Pattern)
- 🧠 External Memory System with persistent knowledge graph
- 📄 15-20 page comprehensive research reports

---

## What Was New in Version 2.0

**Unified Library System (December 2024)**

Version 2.0 introduced a **unified library system** that dramatically improved maintainability and consistency:

### Key Improvements

✅ **Eliminated Code Duplication**
- Reduced prompt-hybrid.md from 1097 to 1037 lines
- ~500 lines of duplicate Phase 0 logic removed across all commands
- All commands now reference a single source of truth

✅ **New Hybrid Intelligence Adapter**
- Reusable complexity detection engine
- Agent spawning with caching
- Multi-agent verification
- Learning system integration
- Available at: `.claude/library/adapters/hybrid-adapter.md`

✅ **Enhanced Documentation**
- All commands now include version history
- Clear library references and integration guides
- Consistent structure across all 7 commands
- Migration guide for custom commands

✅ **Better Maintainability**
- Single source of truth for Phase 0 logic
- Update library once, all commands benefit
- Easy to add new commands (just reference library)
- Clear separation: core vs. domain logic

### Architecture

```
.claude/
├── library/
│   ├── prompt-perfection-core.md    # Universal Phase 0
│   └── adapters/
│       ├── technical-adapter.md
│       ├── article-adapter.md
│       ├── session-adapter.md
│       └── hybrid-adapter.md        # NEW: Advanced features
├── commands/                         # All commands reference library
│   ├── prompt.md                    # v2.0 - Library-based
│   ├── prompt-hybrid.md             # v2.0 - Refactored
│   ├── prompt-technical.md          # v2.0 - Enhanced docs
│   ├── prompt-article.md            # v2.0 - Library refs
│   ├── prompt-article-readme.md     # v2.0 - Library refs
│   ├── session-start.md             # v2.0 - Already perfect
│   └── session-end.md               # v2.0 - Already perfect
└── config/                          # Configuration-driven
    ├── complexity-rules.json
    ├── agent-templates.json
    ├── cache-config.json            # Agent caching
    ├── verification-config.json     # Multi-agent
    └── learning-config.json         # Learning system
```

**Result:** 100% of commands now fully understandable and maintainable.

See [CLAUDE.md](CLAUDE.md) for complete v2.0 details and migration guide.

---

## Quick Start

```bash
# 1. Simple prompt perfection
/prompt Fix the login bug in my app

# 2. Intelligent prompt perfection with agent support
/prompt-hybrid Implement payment processing following existing patterns

# 3. Technical implementation analysis
/prompt-technical Add caching layer with Redis

# 4. Project-aware commands (NEW v4.4)
/prompt-dotnet Add authentication to ASP.NET Core API
/prompt-react Add a data table component with sorting

# 5. Skill reflection - improve skills from feedback
/reflect prompt-hybrid

# 6. Create an article
/prompt-article Write about CI/CD pipelines

# 7. Generate README
/prompt-article-readme
```

## Prerequisites

- [Claude Code CLI](https://claude.ai/code) installed and configured
- Windows 11 (or compatible environment)
- Git (for session/branch management features)

## Installation

### Quick Install (PowerShell)

```powershell
# Download and run installer
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-commands.ps1" -OutFile "install-claude-commands.ps1"
.\install-claude-commands.ps1
```

### Manual Install

1. Clone the repository:

```powershell
git clone <repository-url>
cd claude-ideas
```

2. Copy `.claude/` to your project:

```powershell
cp -r .claude C:\your-project\
```

3. Verify installation:

```powershell
ls .claude\commands\*.md
# Should show 7 command files
```

See **[README-INSTALL.md](README-INSTALL.md)** for detailed installation instructions.

## Enhanced Statusline (NEW v4.1)

A beautiful, informative statusline for Claude Code with icons and color-coded metrics.

```
■ my-project | ⎇ main | ████████░░ 45% | ● 27k/200k | ▶ 89k/15k | ◆ 3.2s (+1.1s)
```

**Features:**
- 📁 Folder name and git branch with icons
- 📊 Color-coded context bar (green → yellow → orange → red)
- 📈 Context tokens and cumulative totals
- ⏱️ Global API duration with delta indicator

### Quick Install

```powershell
iwr -useb https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-statusline.ps1 | iex
```

Then restart Claude Code.

See **[Statusline Installation Guide](.claude/docs/statusline-install.md)** for detailed options.

## Available Commands (11 Total)

### Prompt Engineering

| Command | Purpose | Time | Complexity |
|---------|---------|------|------------|
| `/prompt` | Basic prompt perfection + LITE predictive intelligence | ~2s | Simple |
| `/prompt-hybrid` ⚡🔍📚🔮 | Intelligent with FULL predictive intelligence, agent support, caching, multi-agent verification, learning | 2-50s | Advanced |
| `/prompt-research` 🔬 | Deep multi-agent research with predictive scoping | 60-180s | Research |

### Technical Analysis

| Command | Purpose | Time | Complexity |
|---------|---------|------|------------|
| `/prompt-technical` 🤖🔮 | Implementation analysis with FULL predictive intelligence and hybrid intelligence | 5-30s | Advanced |

### Project-Aware Commands

| Command | Purpose | Time | Complexity |
|---------|---------|------|------------|
| `/prompt-dotnet` 🔵 | .NET project-aware prompt perfection (scans .csproj, Program.cs) | ~3s | Simple |
| `/prompt-react` ⚛️ | React project-aware prompt perfection (scans package.json, vite.config) | ~3s | Simple |

### Content Creation

| Command | Purpose | Time | Complexity |
|---------|---------|------|------------|
| `/prompt-article` | Interactive article wizard | 2-5min | Medium |
| `/prompt-article-readme` | README generator | 10-30s | Medium |

### Deployment & Infrastructure

| Command | Purpose | Time | Complexity |
|---------|---------|------|------------|
| `/deploy` 🚀 | Project-aware deployment workflow (reads personal-profile.md) | Interactive | Medium |
| `/new-stack` 🐳 | Docker stack scaffold (universal, reads personal-profile.md) | ~5s | Simple |

### Skill Improvement

| Command | Purpose | Time | Complexity |
|---------|---------|------|------------|
| `/reflect` 🔄 | Analyze session and propose skill improvements | 5-15s | Medium |

## Command Overview

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

### `/reflect`

**Purpose:** Analyze conversation sessions and propose skill improvements based on feedback signals.

**What it does:**
1. Detects conversation signals:
   - Corrections (HIGH): "no", "not like that", explicit fixes
   - Successes (MEDIUM): "perfect", "great", accepted outputs
   - Edge cases (MEDIUM): missing features, workarounds
   - Preferences (accumulative): repeated choices, styles
2. Proposes priority-coded changes (HIGH/MED/LOW)
3. Applies changes to skill files with user approval
4. Saves observations for later review

**Usage:**
```
/reflect prompt-hybrid
/reflect prompt-technical
/reflect
```

**Best used:** After a skill-heavy session, especially when you made corrections.

**Output:**
```
Skill Reflection: prompt-hybrid

Signals: 2 corrections, 3 successes

Proposed changes:

[HIGH] + Constraints/NEVER:
        "Use gradients unless requested"
        Evidence: User said "no" twice

[MED]  + Smart Default:
        "Default to TypeScript"
        Evidence: Chose TS 3/3 times

Apply these changes? [Y/n]
```

---

## Recent Improvements (December 2025)

### Phase 0: Prompt Perfection Framework

All prompt commands now include a standardized **Phase 0: Prompt Perfection** flow that ensures every prompt is analyzed, clarified, and perfected before execution.

**The Phase 0 Flow:**

1. **Step 0.1: Initial Analysis**
   - Detects language (Slovak/English)
   - Identifies prompt type (Task, Question, Bug Fix, etc.)
   - Extracts core intent

2. **Step 0.2: Completeness Check**
   - Verifies goal, context, scope, constraints, and success criteria
   - Marks missing items for clarification

3. **Step 0.3: Clarification**
   - Asks questions about ambiguous items
   - Presents multiple implementation options when applicable
   - Marks recommended approach with reasoning

4. **Step 0.4: Correction**
   - Fixes grammar, spelling, and structure
   - Preserves technical terms exactly as written
   - Makes prompts clear and actionable

5. **Step 0.5: Structure the Perfect Prompt**
   - Transforms into executable format
   - Outputs: Goal, Context, Scope, Requirements, Constraints, Expected Result

**Example: Before Phase 0**
```
/prompt Fix bug in user login
```

**After Phase 0 Analysis:**
```
Detected Language: English
Prompt Type: Bug Fix

Completeness Check:
✓ Goal: Fix login bug
✗ Context: Which framework? ASP.NET? React?
✗ Scope: Frontend validation or backend authentication?
✗ Success Criteria: How to verify fix?

Questions:
1. What login framework are you using?
2. What specific error occurs?
3. Which layer needs fixing (UI, API, database)?

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
```

### Smart Defaults

Specialized commands now auto-detect context to reduce repetitive questions:

- **`/prompt-article`** - Auto-detects "Article/Content Creation" as prompt type
- **`/prompt-article-readme`** - Auto-detects current directory and project type from configuration files
- **`/prompt-technical`** - Auto-analyzes project structure, tech stack, and existing patterns

**Example: Smart Defaults in Action**

```
/prompt-article Write about AI in healthcare

Phase 0 Output:
✓ Goal: Auto-filled: "Write an article"
✓ Context: Auto-filled: "article content"
✓ Output Format: Auto-detected: "Article"

Smart Defaults Applied:
- Output format: Article (auto-detected from command type)
- Wizard will collect: topic, audience, style, platform
```

### Consistency Across All Commands

All four prompt commands now follow the same pattern:

```
Phase 0 (Analyze → Clarify → Correct → Structure)
    ↓
Wait for User Approval (y/n/modifications)
    ↓
Execute Command-Specific Logic (wizard/analysis/generation)
```

This ensures:
- ✅ No ambiguous prompts slip through
- ✅ Users see exactly what will be executed
- ✅ Context-aware smart defaults reduce friction
- ✅ Consistent user experience across all commands

---

## Project Structure

```
.claude/
  commands/               # Old format (still works)
    prompt.md
    prompt-hybrid.md
    prompt-technical.md
    prompt-research.md
    prompt-article.md
    prompt-article-readme.md
    reflect.md
  skills/                 # New Skills format (v4.5, YAML frontmatter)
    prompt/SKILL.md
    prompt-hybrid/SKILL.md
    prompt-dotnet/SKILL.md
    prompt-react/SKILL.md
    deploy/SKILL.md
    new-stack/SKILL.md
    reflect/SKILL.md
  library/                # Core library system
    prompt-perfection-core.md
    adapters/
    intelligence/
  memory/                 # Your session data
    project-profile.md    # Populate for best results
    sessions.md
    prompt-patterns.md
  config/                 # Configuration
    complexity-rules.json
    agent-templates.json
    learning-config.json
```

## Workflow Example

1. **Start with a vague idea:**
   ```
   /prompt add user authentication to my app
   ```

2. **Get technical implementation details:**
   ```
   /prompt-technical
   ```

3. **Document your feature:**
   ```
   /prompt-article-readme --update
   ```

4. **Write about it:**
   ```
   /prompt-article
   ```

## Tips for Best Results

1. **Be specific** - Include context about your project and goals
2. **Answer questions** - The wizards ask clarifying questions for a reason
3. **Chain commands** - Use `/prompt` first, then `/prompt-technical` for implementation
4. **Iterate** - Use modification options after generation to refine output
5. **Trust complexity detection** - Let hybrid commands decide when to use agents
7. **Leverage caching** - Repeated prompts are 10-20x faster with agent result caching

## Need More Help?

### 📚 Documentation

- **[Complete Command Reference Guide](doc/Command_Reference_Guide.md)** - 200+ page comprehensive guide with:
  - Detailed command documentation with example flows
  - Architecture and flow diagrams (ASCII art)
  - Advanced features guide (caching, multi-agent, learning)
  - Example workflows for common scenarios
  - Troubleshooting section with solutions
  - Configuration files reference
  - Best practices and performance tips

- **[Quick Reference](doc/Quick_Reference.md)** - Fast lookup guide with:
  - Command cheat sheet
  - Decision tree for command selection
  - Complexity quick reference
  - Common workflows
  - Troubleshooting quick fixes
  - Performance tips

- **[Project Overview (CLAUDE.md)](CLAUDE.md)** - Project documentation with:
  - Repository architecture and structure
  - Library-based system explanation
  - Installation guide
  - Development practices
  - Command selection guide
  - Future enhancements roadmap

### 🎯 Command Selection Guide

Not sure which command to use? See the decision tree in [Quick Reference](doc/Quick_Reference.md#decision-tree) or follow this simple guide:

| Your Need | Recommended Command |
|-----------|---------------------|
| Fix/improve a prompt (simple) | `/prompt` |
| Fix/improve a prompt (complex, needs codebase analysis) | `/prompt-hybrid` |
| Technical implementation help | `/prompt-technical` |
| .NET / C# implementation help | `/prompt-dotnet` |
| React / frontend implementation help | `/prompt-react` |
| Improve skills from feedback | `/reflect` |
| Write article/blog post | `/prompt-article` |
| Generate/update README | `/prompt-article-readme` |
| Deploy to server | `/deploy` |
| Scaffold Docker stack | `/new-stack` |

### 🤖 Advanced Features

**Available in `/prompt-hybrid`:**

- ⚡ **Agent Result Caching** - Results cached for 24h, 10-20x faster for repeated prompts
  - Configuration: `.claude/config/cache-config.json`
  - Clear cache: `rm -r .claude/cache/agent-results/`

- 🔍 **Multi-Agent Verification** - 3 agents cross-validate critical operations
  - Triggers: Complexity ≥15, critical keywords (payment, security, auth)
  - Manual trigger: Add `--verify` flag

- 📚 **Learning System** - Tracks patterns, suggests smart defaults after 3+ occurrences
  - Configuration: `.claude/config/learning-config.json`
  - View patterns: `.claude/memory/prompt-patterns.md`

See [Command Reference Guide - Advanced Features](doc/Command_Reference_Guide.md#advanced-features-guide) for detailed documentation.

## Future Enhancements

The prompt command system can be further improved with these enhancements:

### High Priority

1. **Example Library**
   - Add interactive examples to each command
   - Show before/after transformations
   - Include domain-specific examples (web dev, data science, DevOps)

2. **Validation & Error Handling**
   - Add validation for common input mistakes
   - Detect and warn about overly vague prompts
   - Suggest corrections for typical errors

3. **Quick Syntax Support**
   - Enable shortcuts like `/prompt-article sk linkedin "topic"`
   - Support inline parameters to skip wizard steps
   - Add flags for common options (e.g., `--update`, `--comprehensive`)

### Medium Priority

4. **Prompt Templates**
   - Pre-built templates for common scenarios
   - Save custom templates for reuse
   - Share templates across projects

5. **History & Learning**
   - Track frequently used prompts
   - Suggest improvements based on patterns
   - Learn from user modifications

6. **Multi-language Enhancements**
   - Expand beyond Slovak/English
   - Language-specific style guides
   - Cultural context awareness

### Low Priority

7. **Integration Features**
   - Export prompts to external tools
   - Integration with project management systems
   - API for programmatic access

8. **Advanced Smart Defaults**
   - ML-based context prediction
   - Project-specific learning
   - Auto-detection of coding patterns and preferences

9. **Collaborative Features**
   - Share perfected prompts with team
   - Prompt review workflow
   - Team-specific templates and conventions

### Experimental

10. **Prompt Analytics**
    - Measure prompt quality improvements
    - Track success rates
    - Identify common clarification needs

11. **Voice Input Support**
    - Transcribe spoken prompts
    - Real-time clarification dialogue
    - Voice-optimized wizards

12. **Visual Prompt Builder**
    - Drag-and-drop prompt construction
    - Visual completeness indicators
    - Interactive decision trees

---

**Want to contribute?** These enhancements are tracked in the project backlog. PRs welcome!

## License

MIT
