# Commands Overview

The Claude Commands Library provides 9 powerful slash commands organized into five categories.

## All Commands

| Command | Category | Purpose | Time | Complexity |
|---------|----------|---------|------|------------|
| `/prompt` | Prompt Engineering | Basic prompt perfection | ~2s | Simple |
| `/prompt-hybrid` | Prompt Engineering | Intelligent with agent support | 2-50s | Advanced |
| `/prompt-research` | Research & Analysis | Deep multi-agent research | 60-180s | Expert |
| `/prompt-technical` | Technical Analysis | Implementation planning | 5-30s | Advanced |
| `/prompt-article` | Content Creation | Interactive article wizard | 2-5min | Medium |
| `/prompt-article-readme` | Content Creation | README generator | 10-30s | Medium |
| `/session-start` | Session Management | Load session context | 2-5s | Simple |
| `/session-end` | Session Management | Save session context | 5-10s | Simple |
| `/reflect` | Skill Improvement | Analyze and improve skills | 5-15s | Medium |

## Command Categories

### 🎯 Prompt Engineering

Transform vague ideas into precise, executable prompts:

#### `/prompt`
- **Purpose:** Fast, simple prompt perfection
- **Time:** ~2 seconds
- **Best for:** Quick clarification, single-file tasks
- **Features:** Language detection, type identification, completeness check

[Learn more →](/guide/commands/prompt)

#### `/prompt-hybrid`
- **Purpose:** Intelligent prompt perfection with agent assistance
- **Time:** 2-50 seconds (depending on complexity)
- **Best for:** Complex tasks, pattern detection, feasibility checks
- **Features:**
  - Automatic complexity detection
  - Agent spawning when needed
  - Result caching (10-20x faster)
  - Multi-agent verification
  - Learning system

[Learn more →](/guide/commands/prompt-hybrid)

### 🔬 Research & Analysis

Deep codebase research with orchestrated agents:

#### `/prompt-research`
- **Purpose:** Comprehensive multi-agent research **NEW v3.0**
- **Time:** 60-180 seconds (depending on strategy)
- **Best for:** Security audits, performance analysis, architecture understanding
- **Features:**
  - 2-5 specialized research agents
  - Iterative refinement (2-4 cycles)
  - Source attribution (file:line citations)
  - Persistent knowledge graph
  - 15-20 page research reports
  - Smart convergence detection

[Learn more →](/guide/commands/prompt-hybrid#prompt-research)

### 🔧 Technical Analysis

Deep implementation guidance for programming tasks:

#### `/prompt-technical`
- **Purpose:** Technical implementation analysis
- **Time:** 5-30 seconds
- **Best for:** Implementation planning, tech stack analysis
- **Features:**
  - Project structure scanning
  - Framework and pattern detection
  - 2-3 implementation options
  - Code scaffolding
  - Best practices checklist

[Learn more →](/guide/commands/prompt-technical)

### 📝 Content Creation

Generate articles and documentation:

#### `/prompt-article`
- **Purpose:** Interactive article generation wizard
- **Time:** 2-5 minutes
- **Best for:** Blog posts, technical articles, tutorials
- **Features:**
  - 8 article types
  - Multi-platform output (LinkedIn, Medium, Dev.to)
  - Interactive wizard
  - Language support (Slovak/English)

[Learn more →](/guide/commands/prompt-article)

#### `/prompt-article-readme`
- **Purpose:** Professional README generator
- **Time:** 10-30 seconds
- **Best for:** Project documentation
- **Features:**
  - Automatic project analysis
  - Tech stack detection
  - 3 style levels (Minimal, Standard, Comprehensive)
  - Handles existing README

[Learn more →](/guide/commands/prompt-article)

### 💾 Session Management

Zero information loss between sessions:

#### `/session-start`
- **Purpose:** Load comprehensive session context
- **Time:** 2-5 seconds
- **Best for:** Resuming work
- **Features:**
  - Loads all previous sessions
  - Aggregates cumulative context
  - Highlights active work
  - Presents pending items

[Learn more →](/guide/commands/session-management)

#### `/session-end`
- **Purpose:** Save comprehensive session context
- **Time:** 5-10 seconds
- **Best for:** Ending work session
- **Features:**
  - 10-section comprehensive capture
  - Decisions, code changes, features
  - Problems solved, insights
  - Active work and next steps

[Learn more →](/guide/commands/session-management)

### 🔄 Skill Improvement

Analyze sessions and improve skills based on feedback:

#### `/reflect`
- **Purpose:** Analyze conversation and propose skill improvements **NEW v4.1**
- **Time:** 5-15 seconds
- **Best for:** After corrections, end of skill-heavy sessions
- **Features:**
  - Signal detection (corrections, successes, edge cases)
  - Priority-coded change proposals (HIGH/MED/LOW)
  - Direct skill file modifications
  - Observation persistence for later review
  - Integration with learning system

[Learn more →](/guide/commands/reflect)

## Which Command Should I Use?

### Quick Selection Guide

| Your Goal | Command | Why |
|-----------|---------|-----|
| Quick prompt cleanup | `/prompt` | Fast, simple, no codebase analysis |
| General prompt perfection | `/prompt-hybrid` | Smart complexity detection |
| Deep research & analysis | `/prompt-research` | Multi-agent, comprehensive reports |
| Technical implementation | `/prompt-technical` | Deep tech analysis, patterns |
| Write an article | `/prompt-article` | Interactive wizard, multi-platform |
| Generate README | `/prompt-article-readme` | Auto-detects tech stack |
| Start session | `/session-start` | Load previous context |
| End session | `/session-end` | Save current context |
| Improve skills | `/reflect` | Learn from corrections and feedback |

### Decision Flow

```
Need prompt help?
├─ Just fix quickly → /prompt
├─ Complex, not sure → /prompt-hybrid
├─ Deep research needed → /prompt-research
├─ Need implementation → /prompt-technical
├─ Write article → /prompt-article
└─ Need README → /prompt-article-readme

Research & Analysis?
├─ Security audit → /prompt-research
├─ Performance investigation → /prompt-research
├─ Architecture analysis → /prompt-research
└─ Pattern discovery → /prompt-research

Session management?
├─ Starting work → /session-start
└─ Ending work → /session-end

Skill improvement?
├─ After corrections → /reflect
├─ Skill keeps missing preferences → /reflect
└─ End of skill-heavy session → /reflect
```

## Command Comparison

### `/prompt` vs `/prompt-hybrid`

**Use `/prompt` when:**
- ✅ Quick prompt cleanup (< 2 seconds)
- ✅ Simple, well-defined task
- ✅ No codebase analysis needed
- ✅ You provide all context

**Use `/prompt-hybrid` when:**
- ✅ Task might be complex
- ✅ Need codebase context gathered
- ✅ Pattern/convention detection needed
- ✅ Feasibility validation required
- ✅ Unsure what information needed

### `/prompt-hybrid` vs `/prompt-technical`

**Use `/prompt-hybrid` when:**
- ✅ Want prompt perfected first
- ✅ General-purpose perfection
- ✅ Not necessarily technical
- ✅ Let complexity decide approach

**Use `/prompt-technical` when:**
- ✅ Specifically want technical analysis
- ✅ Need implementation options with code
- ✅ Want best practices checklist
- ✅ Need detailed code scaffolding
- ✅ After perfecting the prompt

## Common Workflows

### Workflow 1: From Idea to Implementation

```bash
/prompt-hybrid "Add feature X"  # Perfect prompt
/prompt-technical               # Technical analysis
# Implement
/session-end                    # Save context
```

### Workflow 2: Article Writing

```bash
/prompt-article "Topic"  # Interactive wizard
# Generate for platforms
/session-end             # Save work
```

### Workflow 3: Documentation

```bash
/prompt-article-readme  # Generate README
# Review and customize
/session-end            # Save changes
```

## Next Steps

- [Explore individual commands](/guide/commands/prompt)
- [Learn about Phase 0 validation](/guide/architecture/library-system)
- [Configure complexity detection](/reference/configuration)
