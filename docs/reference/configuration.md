# Configuration Reference

Reference for all configuration files in `.claude/config/`.

## Configuration Files Overview

| File | Purpose |
|------|---------|
| `agent-templates.json` | Agent prompt templates for `/prompt-research` |
| `orchestration-config.json` | Multi-agent research orchestration |
| `iteration-rules.json` | Research convergence and gap detection |
| `agent-roles.json` | Agent role definitions |
| `citation-config.json` | Citation formatting rules |
| `external-memory-config.json` | Persistent knowledge graph settings |
| `complexity-rules.json` | Prompt complexity scoring |
| `model-tiers.json` | Model tier definitions (haiku / sonnet / opus) |

## agent-templates.json

Agent prompt templates used by `/prompt-research`.

```json
{
  "templates": {
    "explore_codebase_context": {
      "type": "Explore",
      "model": "haiku",
      "timeout": 30000,
      "prompt": "Analyze the codebase structure focusing on:\n1. Project organization\n2. Key files and directories\n3. Framework and dependencies\n4. Naming conventions\n5. Existing patterns relevant to: {task}"
    },
    "security_audit_specialist": {
      "type": "Security",
      "model": "sonnet",
      "timeout": 45000,
      "prompt": "Perform security audit:\n1. OWASP Top 10 check\n2. Input validation\n3. Authentication flows\n4. Authorization checks\n5. Data exposure risks"
    },
    "performance_analyzer": {
      "type": "Performance",
      "model": "sonnet",
      "timeout": 45000,
      "prompt": "Analyze performance:\n1. N+1 query detection\n2. Memory usage\n3. Algorithm complexity\n4. Caching opportunities\n5. Blocking operations"
    },
    "pattern_validator": {
      "type": "Pattern",
      "model": "haiku",
      "timeout": 30000,
      "prompt": "Validate code patterns:\n1. Naming conventions\n2. Code style consistency\n3. Architectural patterns\n4. Best practice compliance"
    }
  }
}
```

### Template Variables

| Variable | Description |
|----------|-------------|
| `{task}` | The research goal |
| `{context}` | Additional context |
| `{files}` | Relevant file list |

## orchestration-config.json

Controls multi-agent research orchestration.

```json
{
  "research_mode": {
    "default_strategy": "parallel",
    "max_agents": 5,
    "max_iterations": 4,
    "convergence_threshold": 0.85
  },
  "lead_agent": {
    "model": "sonnet",
    "synthesis_style": "comprehensive",
    "gap_detection": true
  },
  "agent_selection": {
    "auto_detect": true,
    "minimum_agents": 2,
    "selection_criteria": "task_relevance"
  },
  "result_aggregation": {
    "merge_strategy": "consensus",
    "conflict_handling": "document_all",
    "confidence_weighting": true
  }
}
```

## iteration-rules.json

Research iteration and convergence settings.

```json
{
  "gap_detection": {
    "enabled": true,
    "min_coverage": 0.80,
    "categories": ["security", "performance", "patterns", "architecture", "testing"]
  },
  "convergence": {
    "method": "confidence_threshold",
    "threshold": 0.85,
    "max_iterations": 4,
    "diminishing_returns_threshold": 0.1
  },
  "early_termination": {
    "enabled": true,
    "conditions": ["no_new_findings", "critical_found", "user_interrupt"]
  },
  "checkpoint": {
    "enabled": true,
    "storage": ".claude/cache/iteration-checkpoints",
    "auto_resume": true
  }
}
```

## complexity-rules.json

Prompt complexity scoring — used by `/prompt` to determine how much Phase 0 work is needed.

```json
{
  "rules": [
    { "name": "multi_file_scope", "weight": 5, "triggers": ["all", "every", "across", "throughout"] },
    { "name": "architecture_questions", "weight": 7, "triggers": ["how should", "best approach", "architecture"] },
    { "name": "refactoring_tasks", "weight": 5, "triggers": ["refactor", "restructure", "reorganize"] },
    { "name": "cross_cutting_concerns", "weight": 4, "triggers": ["logging", "auth", "validation", "caching"] },
    { "name": "implementation_planning", "weight": 3, "triggers": ["implement", "add feature", "build", "create"] }
  ],
  "thresholds": {
    "simple": { "max": 4 },
    "moderate": { "min": 5, "max": 9 },
    "complex": { "min": 10, "max": 19 },
    "research": { "min": 20 }
  }
}
```

## model-tiers.json

Model tier definitions used by the model router.

```json
{
  "tiers": {
    "haiku": { "model": "claude-haiku-4-5", "thinking_budget_tokens": 0 },
    "sonnet": { "model": "claude-sonnet-4-6", "thinking_budget_tokens": 2000 },
    "opus-fast": { "model": "claude-opus-4-6", "thinking_budget_tokens": 4000 },
    "opus-smart": { "model": "claude-opus-4-7", "thinking_budget_tokens": 8000 }
  }
}
```

## external-memory-config.json

Persistent knowledge graph used by `/prompt-research`.

```json
{
  "enabled": true,
  "knowledge_graph": {
    "path": ".claude/memory/project-knowledge.md",
    "auto_update": true,
    "max_nodes": 500
  },
  "research_history": {
    "path": ".claude/memory/research-history.md",
    "retention_days": 30,
    "max_entries": 100
  }
}
```

## File Locations Summary

```
.claude/
├── config/
│   ├── agent-templates.json
│   ├── orchestration-config.json
│   ├── iteration-rules.json
│   ├── agent-roles.json
│   ├── citation-config.json
│   ├── external-memory-config.json
│   ├── complexity-rules.json
│   └── model-tiers.json
├── library/
│   ├── prompt-perfection-core.md
│   ├── readme-adapter.md
│   ├── research-adapter.md
│   ├── caching-strategy.md
│   ├── model-router.md
│   ├── orchestration-*.md
│   └── research-agent-*.md
└── memory/
    ├── project-profile.md
    ├── sessions.md
    ├── prompt-patterns.md
    └── project-knowledge.md
```

## Validation

```powershell
# PowerShell — validate JSON syntax
Get-Content .claude/config/agent-templates.json | ConvertFrom-Json
```

```bash
# Bash
cat .claude/config/agent-templates.json | python -m json.tool
```

## Related

- [Multi-Agent Research](/architecture/multi-agent)
- [Agent Caching](/architecture/caching)
- [Phase 0 Flow](/architecture/phase-0)
