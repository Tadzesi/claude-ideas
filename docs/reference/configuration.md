# Configuration Reference

Complete reference for all configuration files in the Claude Commands Library.

## Configuration Files Overview

All configuration files are located in `.claude/config/`:

| File | Purpose |
|------|---------|
| `complexity-rules.json` | Complexity detection triggers and thresholds |
| `agent-templates.json` | Agent prompt templates |
| `cache-config.json` | Caching behavior |
| `verification-config.json` | Multi-agent verification |
| `learning-config.json` | Learning system settings |
| `predictive-intelligence.json` | Phase 0.15 behavior |
| `orchestration-config.json` | Multi-agent research |
| `iteration-rules.json` | Research convergence |
| `agent-roles.json` | Agent definitions |
| `citation-config.json` | Citation formatting |
| `external-memory-config.json` | Persistent memory |

## complexity-rules.json

Controls when agents are spawned based on prompt complexity.

```json
{
  "rules": [
    {
      "name": "multi_file_scope",
      "weight": 5,
      "triggers": ["all", "every", "across", "throughout"],
      "description": "Task spans multiple files"
    },
    {
      "name": "architecture_questions",
      "weight": 7,
      "triggers": ["how should", "best approach", "architecture", "design"],
      "description": "Architectural decisions needed"
    },
    {
      "name": "pattern_detection",
      "weight": 6,
      "triggers": ["like", "similar to", "existing pattern", "following"],
      "description": "Needs to find existing patterns"
    },
    {
      "name": "feasibility_checks",
      "weight": 4,
      "triggers": ["possible", "can we", "is it feasible", "doable"],
      "description": "Feasibility assessment required"
    },
    {
      "name": "refactoring_tasks",
      "weight": 5,
      "triggers": ["refactor", "restructure", "reorganize", "clean up"],
      "description": "Code refactoring involved"
    },
    {
      "name": "cross_cutting_concerns",
      "weight": 4,
      "triggers": ["logging", "auth", "validation", "caching", "error handling"],
      "description": "Cross-cutting concern detected"
    },
    {
      "name": "implementation_planning",
      "weight": 3,
      "triggers": ["implement", "add feature", "build", "create"],
      "description": "Implementation planning needed"
    }
  ],
  "thresholds": {
    "simple": { "max": 4 },
    "moderate": { "min": 5, "max": 9 },
    "complex": { "min": 10, "max": 19 },
    "research": { "min": 20 }
  },
  "user_factors": {
    "security_critical": 1.5,
    "high_impact": 1.3,
    "multi_team": 1.2,
    "external_dependency": 1.1
  }
}
```

### Thresholds Explained

| Score | Path | Agent |
|-------|------|-------|
| 0-4 | Simple | None |
| 5-9 | Moderate | Optional (user choice) |
| 10-19 | Complex | Automatic |
| 20+ | Research | Multi-agent |

### Adding Custom Rules

Add new triggers by creating additional rule objects:

```json
{
  "name": "your_custom_rule",
  "weight": 5,
  "triggers": ["your", "trigger", "words"],
  "description": "When this applies"
}
```

## agent-templates.json

Defines agent prompts and configurations.

```json
{
  "templates": {
    "explore_codebase_context": {
      "type": "Explore",
      "model": "haiku",
      "timeout": 30000,
      "prompt": "Analyze the codebase structure focusing on:\n1. Project organization\n2. Key files and directories\n3. Framework and dependencies\n4. Naming conventions\n5. Existing patterns relevant to: {task}"
    },
    "technical_implementation": {
      "type": "Plan",
      "model": "sonnet",
      "timeout": 60000,
      "prompt": "Design implementation for: {task}\n\nAnalyze:\n1. Required changes\n2. Dependencies\n3. Testing strategy\n4. Potential issues"
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
  },
  "trigger_mappings": {
    "pattern_detection": "explore_codebase_context",
    "architecture_questions": "technical_implementation",
    "security_concerns": "security_audit_specialist",
    "performance_concerns": "performance_analyzer",
    "consistency_checks": "pattern_validator"
  }
}
```

### Template Variables

| Variable | Description |
|----------|-------------|
| `{task}` | The user's prompt |
| `{context}` | Additional context |
| `{files}` | Relevant file list |
| `{patterns}` | Detected patterns |

## cache-config.json

Controls agent result caching.

```json
{
  "enabled": true,
  "storage": {
    "path": ".claude/cache/agent-results",
    "max_size_mb": 50,
    "cleanup_strategy": "lru"
  },
  "ttl": {
    "default": "24h",
    "agent_results": "24h",
    "pattern_cache": "48h",
    "iteration_checkpoints": "12h"
  },
  "invalidation": {
    "on_file_change": true,
    "on_branch_switch": true,
    "track_dependencies": true
  },
  "performance": {
    "async_storage": true,
    "compression": true
  }
}
```

### TTL Formats

Supported time formats:
- `"1h"` - Hours
- `"24h"` - Hours
- `"7d"` - Days
- `"1w"` - Weeks

## verification-config.json

Multi-agent verification settings.

```json
{
  "enabled": true,
  "trigger_threshold": 15,
  "verification_agents": {
    "count": 3,
    "types": ["explore", "pattern", "security"],
    "parallel": true
  },
  "consensus": {
    "required_agreement": 0.67,
    "conflict_resolution": "majority",
    "report_disagreements": true
  },
  "timeout": {
    "per_agent": 45000,
    "total": 120000
  }
}
```

### Consensus Methods

| Method | Description |
|--------|-------------|
| `majority` | Use what most agents agree on |
| `unanimous` | Require all agents to agree |
| `weighted` | Weight by agent expertise |

## learning-config.json

Learning system configuration.

```json
{
  "enabled": true,
  "pattern_storage": ".claude/memory/prompt-patterns.md",
  "learning_threshold": 3,
  "auto_suggest_improvements": true,
  "track_modifications": true,
  "smart_defaults_threshold": 3,
  "confidence_threshold": 0.75,
  "reflection_analysis": {
    "enabled": true,
    "min_signals_to_report": 2
  },
  "tracking": {
    "transformations": true,
    "missing_info": true,
    "user_preferences": true,
    "complexity_accuracy": true,
    "agent_effectiveness": true
  }
}
```

### What Gets Tracked

| Metric | Purpose |
|--------|---------|
| `transformations` | Successful prompt improvements |
| `missing_info` | Commonly missing information |
| `user_preferences` | Detected user patterns |
| `complexity_accuracy` | Scoring calibration |
| `agent_effectiveness` | Agent performance |

## predictive-intelligence.json

Phase 0.15 predictive features.

```json
{
  "enabled": true,
  "journey_detection": {
    "enabled": true,
    "stages": [
      "exploring",
      "planning",
      "implementing",
      "debugging",
      "refactoring",
      "reviewing"
    ]
  },
  "domain_warnings": {
    "enabled": true,
    "domains": {
      "security": {
        "triggers": ["auth", "password", "token", "encryption", "session"],
        "severity": "high"
      },
      "payment": {
        "triggers": ["payment", "billing", "checkout", "subscription"],
        "severity": "critical"
      },
      "database": {
        "triggers": ["migration", "schema", "delete", "truncate"],
        "severity": "high"
      },
      "api": {
        "triggers": ["api", "endpoint", "public", "external"],
        "severity": "medium"
      }
    }
  },
  "pattern_recognition": {
    "enabled": true,
    "scan_depth": 3,
    "cache_duration": "24h"
  },
  "relationship_mapping": {
    "enabled": true,
    "max_related": 5,
    "session_lookback": 5
  },
  "next_steps": {
    "enabled": true,
    "scope_options": true,
    "max_predictions": 3
  }
}
```

## orchestration-config.json

Multi-agent research orchestration.

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

Research iteration settings.

```json
{
  "gap_detection": {
    "enabled": true,
    "min_coverage": 0.80,
    "categories": [
      "security",
      "performance",
      "patterns",
      "architecture",
      "testing"
    ]
  },
  "convergence": {
    "method": "confidence_threshold",
    "threshold": 0.85,
    "max_iterations": 4,
    "diminishing_returns_threshold": 0.1
  },
  "early_termination": {
    "enabled": true,
    "conditions": [
      "no_new_findings",
      "critical_found",
      "user_interrupt"
    ]
  },
  "checkpoint": {
    "enabled": true,
    "storage": ".claude/cache/iteration-checkpoints",
    "auto_resume": true
  }
}
```

## external-memory-config.json

Persistent memory settings.

```json
{
  "enabled": true,
  "knowledge_graph": {
    "path": ".claude/memory/knowledge-graph.md",
    "auto_update": true,
    "max_nodes": 500,
    "relationship_types": [
      "depends_on",
      "calls",
      "extends",
      "implements",
      "related_to"
    ]
  },
  "research_history": {
    "path": ".claude/memory/research-history.md",
    "retention_days": 30,
    "max_entries": 100
  },
  "session_linking": {
    "enabled": true,
    "max_links": 10
  }
}
```

## File Locations Summary

```
.claude/
├── config/
│   ├── complexity-rules.json
│   ├── agent-templates.json
│   ├── cache-config.json
│   ├── verification-config.json
│   ├── learning-config.json
│   ├── predictive-intelligence.json
│   ├── orchestration-config.json
│   ├── iteration-rules.json
│   ├── agent-roles.json
│   ├── citation-config.json
│   └── external-memory-config.json
├── memory/
│   ├── sessions.md
│   ├── prompt-patterns.md
│   ├── observations.md
│   ├── project-knowledge.md
│   ├── knowledge-graph.md
│   └── research-history.md
└── cache/
    ├── agent-results/
    └── iteration-checkpoints/
```

## Validation

Validate JSON syntax before use:

```powershell
# PowerShell
Get-Content .claude/config/complexity-rules.json | ConvertFrom-Json
```

```bash
# Bash
cat .claude/config/complexity-rules.json | python -m json.tool
```

## Related

- [Hybrid Intelligence](/architecture/hybrid-intelligence) - Uses complexity-rules
- [Caching](/architecture/caching) - Uses cache-config
- [Learning System](/architecture/learning) - Uses learning-config

