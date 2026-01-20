# Architecture Overview

Claude Commands Library is built on a modular, extensible architecture that combines several intelligent systems.

## Core Components

```
┌─────────────────────────────────────────────────────────────────┐
│                     Claude Commands Library                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │   Commands   │  │   Library    │  │    Config    │          │
│  │  /prompt     │  │  Core + Adapt│  │   JSON files │          │
│  │  /prompt-*   │  │              │  │              │          │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘          │
│         │                 │                 │                   │
│         └────────────┬────┴─────────────────┘                   │
│                      ▼                                          │
│  ┌────────────────────────────────────────────────────┐        │
│  │              Phase 0: Prompt Perfection             │        │
│  │  Detection → Check → Clarify → Structure → Approve  │        │
│  └────────────────────────┬───────────────────────────┘        │
│                           │                                     │
│         ┌─────────────────┼─────────────────┐                  │
│         ▼                 ▼                 ▼                  │
│  ┌─────────────┐  ┌──────────────┐  ┌─────────────┐           │
│  │   Hybrid    │  │  Predictive  │  │   Multi-    │           │
│  │Intelligence │  │ Intelligence │  │   Agent     │           │
│  │  (agents)   │  │  (Phase 0.15)│  │  Research   │           │
│  └─────────────┘  └──────────────┘  └─────────────┘           │
│                                                                  │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │   Caching    │  │   Learning   │  │   Memory     │          │
│  │  Agent results│ │  Patterns    │  │  Sessions    │          │
│  └──────────────┘  └──────────────┘  └──────────────┘          │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

## Directory Structure

```
.claude/
├── commands/           # Slash command definitions
│   ├── prompt.md
│   ├── prompt-hybrid.md
│   ├── prompt-technical.md
│   ├── prompt-research.md
│   └── ...
│
├── library/            # Reusable components
│   ├── prompt-perfection-core.md    # Phase 0 canonical
│   ├── adapters/                    # Domain extensions
│   │   ├── technical-adapter.md
│   │   ├── article-adapter.md
│   │   └── hybrid-adapter.md
│   └── intelligence/                # AI systems
│       ├── predictive-intelligence-core.md
│       ├── relationship-mapper.md
│       └── warning-system.md
│
├── config/             # Configuration files
│   ├── complexity-rules.json
│   ├── agent-templates.json
│   ├── cache-config.json
│   └── learning-config.json
│
├── memory/             # Persistent data
│   ├── sessions.md
│   ├── prompt-patterns.md
│   └── observations.md
│
├── rules/              # Path-specific rules
│   ├── technical-patterns.md
│   └── command-conventions.md
│
├── skills/             # Skill configurations
│   └── prompt-technical.json
│
└── cache/              # Cached results
    └── agent-results/
```

## Key Concepts

### 1. Phase 0: The Foundation

Every command starts with Phase 0 - the prompt perfection process. This ensures clarity before execution.

[Learn about Phase 0 →](/architecture/phase-0)

### 2. Library System

Commands don't duplicate logic. They reference a shared library:

- **Core**: Universal Phase 0 implementation
- **Adapters**: Domain-specific extensions
- **Intelligence**: AI enhancement systems

[Explore the Library System →](/architecture/library-system)

### 3. Hybrid Intelligence

Automatic complexity detection determines when to use agents:

- Simple tasks: Fast inline validation
- Complex tasks: Spawn specialized agents
- Research tasks: Multi-agent orchestration

[Understand Hybrid Intelligence →](/architecture/hybrid-intelligence)

### 4. Predictive Intelligence

Phase 0.15 provides proactive guidance:

- Journey stage detection
- Domain risk analysis
- Pattern recognition
- Proactive warnings

[Discover Predictive Intelligence →](/architecture/predictive-intelligence)

### 5. Multi-Agent Research

Deep analysis using 2-5 specialized agents:

- Parallel exploration
- Iterative refinement
- Gap-driven research

[Learn about Multi-Agent Research →](/architecture/multi-agent)

## Data Flow

```
User Input: "/prompt-technical Add authentication"
     │
     ▼
┌─────────────────────────────────────────┐
│         Command: prompt-technical        │
│                                          │
│  Import: library/prompt-perfection-core  │
│  Adapt:  library/adapters/technical      │
│  Config: config/complexity-rules.json    │
└──────────────────┬──────────────────────┘
                   ▼
┌─────────────────────────────────────────┐
│         Phase 0: Prompt Perfection       │
│                                          │
│  1. Detect language, type, intent       │
│  2. Calculate complexity score          │
│  3. Check completeness (6 criteria)     │
│  4. Ask clarifying questions            │
│  5. Structure perfected prompt          │
│  6. Wait for approval                   │
└──────────────────┬──────────────────────┘
                   ▼
┌─────────────────────────────────────────┐
│       Complexity-Based Routing           │
│                                          │
│  Score 0-4:  → Manual scan              │
│  Score 5-9:  → Ask user about agent     │
│  Score 10+:  → Spawn Explore Agent      │
│  Score 15+:  → Multi-agent verification │
└──────────────────┬──────────────────────┘
                   ▼
┌─────────────────────────────────────────┐
│         Agent Exploration (if needed)    │
│                                          │
│  - Scan project structure               │
│  - Detect patterns and conventions      │
│  - Find related implementations         │
│  - Cache results for 24 hours           │
└──────────────────┬──────────────────────┘
                   ▼
┌─────────────────────────────────────────┐
│         Implementation Analysis          │
│                                          │
│  - 2-3 implementation options           │
│  - Pros/cons comparison                 │
│  - Best practices checklist             │
│  - Code scaffolding                     │
└──────────────────┬──────────────────────┘
                   ▼
┌─────────────────────────────────────────┐
│         Learning System Update           │
│                                          │
│  - Record transformation                │
│  - Track user modifications             │
│  - Update pattern database              │
└─────────────────────────────────────────┘
```

## Configuration System

All behavior is configuration-driven:

| File | Purpose |
|------|---------|
| `complexity-rules.json` | Triggers and thresholds |
| `agent-templates.json` | Agent prompts |
| `cache-config.json` | Caching settings |
| `learning-config.json` | Pattern tracking |
| `predictive-intelligence.json` | Proactive guidance |

[See Configuration Reference →](/reference/configuration)

## Next Steps

Dive deeper into specific systems:

- [Phase 0: Prompt Perfection](/architecture/phase-0)
- [Library System](/architecture/library-system)
- [Hybrid Intelligence](/architecture/hybrid-intelligence)
- [Predictive Intelligence](/architecture/predictive-intelligence)
- [Multi-Agent Research](/architecture/multi-agent)
- [Caching System](/architecture/caching)
- [Learning System](/architecture/learning)
- [Enhanced Statusline](/architecture/statusline)
