# Library System

The unified library architecture that ensures consistency across all commands.

## The Problem

Without a library system:
- Each command duplicates Phase 0 logic
- Updates require changing multiple files
- Inconsistencies creep in over time
- Maintenance becomes expensive

## The Solution

```
┌─────────────────────────────────────────────┐
│                  Commands                    │
│  prompt.md  prompt-hybrid.md  prompt-tech.md │
│      │            │              │          │
│      └────────────┼──────────────┘          │
│                   ▼                          │
│  ┌─────────────────────────────────────────┐│
│  │     prompt-perfection-core.md           ││
│  │        (Canonical Phase 0)               ││
│  └─────────────────────────────────────────┘│
│                   │                          │
│      ┌───────────┼───────────┐              │
│      ▼           ▼           ▼              │
│  ┌────────┐ ┌────────┐ ┌────────┐          │
│  │Technical│ │Article │ │ Hybrid │          │
│  │ Adapter│ │ Adapter│ │ Adapter│          │
│  └────────┘ └────────┘ └────────┘          │
└─────────────────────────────────────────────┘
```

## Core Library

**Location**: `.claude/library/prompt-perfection-core.md`

Contains:
- Universal Phase 0 flow (Steps 0.1-0.6)
- 6-criteria completeness check
- Approval gate pattern
- Optional Phase 0.15 (Predictive Intelligence)

### Usage in Commands

```markdown
## Phase 0: Prompt Perfection

**Import:** Use Phase 0 from @.claude/library/prompt-perfection-core.md
**Adaptation:** Technical (from @.claude/library/adapters/technical-adapter.md)
```

### Benefits

1. **Single source of truth** - Phase 0 defined once
2. **Consistency** - All commands behave the same
3. **Easy updates** - Change once, all benefit
4. **Smaller commands** - Less duplication

## Adapters

Adapters extend core library for specific domains.

### Technical Adapter

**Location**: `.claude/library/adapters/technical-adapter.md`

Adds to completeness check:
- Technical Stack
- Architecture
- Code Location
- Testing Strategy

Adds question templates:
- Implementation method choices
- Framework-specific options
- Testing approach selection

### Article Adapter

**Location**: `.claude/library/adapters/article-adapter.md`

Adds to completeness check:
- Target Audience
- Platform
- Tone and Style
- Content Length

### Hybrid Adapter

**Location**: `.claude/library/adapters/hybrid-adapter.md`

Adds enhancements:
- Complexity detection engine
- Agent context gathering
- Multi-agent verification
- Learning system integration

## Intelligence Components

**Location**: `.claude/library/intelligence/`

### Predictive Intelligence Core

Implements Phase 0.15:
- Journey stage detection
- Domain risk analysis
- Pattern recognition
- Proactive warnings
- Next-steps prediction

### Relationship Mapper

Connects work to previous sessions:
- Related decisions
- Similar implementations
- Dependent changes

### Warning System

Proactive warnings by domain:
- Authentication risks
- Payment processing security
- Database concerns
- API vulnerabilities

## Directory Structure

```
.claude/library/
├── prompt-perfection-core.md      # Canonical Phase 0
├── adapters/
│   ├── technical-adapter.md       # Technical domain
│   ├── article-adapter.md         # Content creation
│   ├── session-adapter.md         # Session management
│   └── hybrid-adapter.md          # Hybrid intelligence
├── intelligence/
│   ├── predictive-intelligence-core.md
│   ├── relationship-mapper.md
│   ├── warning-system.md
│   └── next-steps-predictor.md
├── orchestration/
│   ├── lead-agent-core.md         # Multi-agent coordination
│   ├── iteration-engine.md        # Research iterations
│   └── result-aggregator.md       # Combine agent results
└── agents/
    ├── explore-agent.md
    ├── pattern-agent.md
    ├── security-agent.md
    └── performance-agent.md
```

## How Commands Reference Library

### Using @ Import Syntax

Commands reference library using Claude Code's native @ syntax:

```markdown
**Import:** @.claude/library/prompt-perfection-core.md
```

This tells Claude to load and follow the referenced file's instructions.

### Layered Application

```markdown
## Phase 0: Prompt Perfection

**Import:** Use Phase 0 from @.claude/library/prompt-perfection-core.md
**Adaptation:** Technical with Hybrid Intelligence
  - @.claude/library/adapters/technical-adapter.md
  - @.claude/library/adapters/hybrid-adapter.md
**Rules:** @.claude/rules/technical-patterns.md
```

## Path-Specific Rules

**Location**: `.claude/rules/`

Rules apply based on file path using YAML frontmatter:

```markdown
---
paths: .claude/commands/prompt-technical.md
---

# Technical Patterns

Rules for technical implementation analysis...
```

### Available Rules

| Rule File | Applies To |
|-----------|------------|
| `technical-patterns.md` | Technical commands |
| `command-conventions.md` | All commands |
| `library-standards.md` | Library files |
| `config-validation.md` | Config files |

## Creating New Commands

To create a new command:

1. **Create command file**:
```markdown
# /my-command

## Phase 0: Prompt Perfection

**Import:** @.claude/library/prompt-perfection-core.md
**Adaptation:** [None / Technical / Article / Custom]

[Command-specific phases...]
```

2. **Create adapter if needed**:
```markdown
# My Domain Adapter

**Extends:** prompt-perfection-core.md

## Additional Completeness Criteria

- Custom Criterion 1
- Custom Criterion 2
```

3. **Add to skills** (optional):
```json
{
  "name": "my-command",
  "command": "/my-command",
  "description": "...",
  "file": ".claude/commands/my-command.md"
}
```

## Best Practices

### For Library Changes

1. **Test with multiple commands** - Changes affect all users
2. **Preserve backward compatibility** - Don't break existing
3. **Document changes** - Update version history
4. **Use adapters** - Domain-specific logic belongs in adapters

### For Command Authors

1. **Reference, don't duplicate** - Use @imports
2. **Create adapters** - For domain-specific needs
3. **Follow conventions** - Check existing commands
4. **Test Phase 0** - Verify the flow works

## Related

- [Phase 0](/architecture/phase-0) - The core flow
- [Hybrid Intelligence](/architecture/hybrid-intelligence) - Agent integration
- [Configuration](/reference/configuration) - Config files
