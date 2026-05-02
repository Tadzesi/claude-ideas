# Architecture Overview

Claude Commands Library is built on a shared Phase 0 foundation with two domain adapters and a multi-agent research system.

## Structure

```
.claude/
├── skills/
│   ├── prompt/SKILL.md
│   ├── prompt-article-readme/SKILL.md
│   └── prompt-research/SKILL.md
│
├── library/
│   ├── prompt-perfection-core.md    # Phase 0 canonical
│   ├── readme-adapter.md            # /prompt-article-readme
│   ├── research-adapter.md          # /prompt-research
│   ├── caching-strategy.md
│   ├── model-router.md
│   ├── execution-plan-template.md
│   ├── orchestration-aggregator.md
│   ├── orchestration-iteration.md
│   ├── orchestration-lead.md
│   ├── research-agent-explore.md
│   ├── research-agent-pattern.md
│   ├── research-agent-security.md
│   ├── research-agent-performance.md
│   └── research-agent-citation.md
│
├── config/
│   ├── agent-templates.json
│   ├── orchestration-config.json
│   ├── iteration-rules.json
│   ├── agent-roles.json
│   ├── citation-config.json
│   ├── external-memory-config.json
│   ├── complexity-rules.json
│   └── model-tiers.json
│
├── memory/
│   ├── project-profile.md
│   ├── sessions.md
│   ├── prompt-patterns.md
│   └── project-knowledge.md
│
└── rules/
    ├── command-conventions.md
    ├── library-standards.md
    └── config-validation.md
```

## Key Concepts

### 1. Phase 0: The Foundation

Every command begins with Phase 0 — a shared validation layer imported from `prompt-perfection-core.md`. It detects intent, recalls known facts from project memory, checks completeness, asks only genuinely unknown questions, structures the result, and waits for approval.

[Learn about Phase 0 →](/architecture/phase-0)

### 2. Domain Adapters

`/prompt-article-readme` and `/prompt-research` extend Phase 0 with domain-specific logic via adapters:

- `readme-adapter.md` — project scan, stack detection, README style levels
- `research-adapter.md` — iteration strategy, gap detection, report format

### 3. Multi-Agent Research

`/prompt-research` runs 2-4 iteration cycles using 5 specialist agents in parallel:
Explore, Pattern, Security, Performance, Citation. Each iteration resolves gaps from the previous one.

[Learn about Multi-Agent Research →](/architecture/multi-agent)

### 4. Library System

Commands reference shared library files instead of duplicating logic. Changes to `prompt-perfection-core.md` affect all three commands.

[Explore the Library System →](/architecture/library-system)

### 5. Skills Format

All three commands use native Claude Code Skills format with YAML frontmatter. Claude auto-suggests the right skill based on the `description` field.

[Skills Format →](/architecture/skills-format)

### 6. AI Fluency Framework

Phase 0 is aligned with Anthropic's 4Ds model: Delegation, Description, Discernment, Diligence.

[AI Fluency Framework →](/architecture/ai-fluency)

## Data Flow

```
User: /prompt-research Understand the auth system

     ▼
┌─────────────────────────────────┐
│  research-adapter.md            │
│  Load: prompt-perfection-core   │
│  Extend: research strategy      │
└──────────────┬──────────────────┘
               ▼
┌─────────────────────────────────┐
│  Phase 0: Prompt Perfection     │
│  Recall → Check → Ask → Approve │
└──────────────┬──────────────────┘
               ▼
┌─────────────────────────────────┐
│  orchestration-lead.md          │
│  Spawn 2-5 agents in parallel   │
└──────────────┬──────────────────┘
               ▼
┌─────────────────────────────────┐
│  Iteration 1-4                  │
│  Aggregate → Detect gaps        │
│  → Next iteration or converge   │
└──────────────┬──────────────────┘
               ▼
       Consolidated report
       with file:line citations
```

## Configuration

All behaviour is configuration-driven. See [Configuration Reference →](/reference/configuration)

## Next Steps

- [Phase 0: Prompt Perfection](/architecture/phase-0)
- [AI Fluency Framework](/architecture/ai-fluency)
- [Library System](/architecture/library-system)
- [Multi-Agent Research](/architecture/multi-agent)
- [Agent Caching](/architecture/caching)
- [Skills Format](/architecture/skills-format)
