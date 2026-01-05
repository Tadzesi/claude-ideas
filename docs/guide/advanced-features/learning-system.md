# Learning System

<Badge type="tip" text="v4.1 Enhanced" />

The Learning System tracks patterns and improves skills over time. With v4.1, it now includes **active skill reflection** through the `/reflect` command.

## Overview

The Learning System has two modes:

| Mode | Description | Trigger |
|------|-------------|---------|
| **Passive** | Tracks patterns in background | Automatic |
| **Active** | Proposes skill improvements | `/reflect` command |

## What It Learns

### Passive Tracking

- **Successful transformations** - What prompt structures work
- **Missing information patterns** - What questions to ask
- **User preferences** - Repeated choices and styles
- **Complexity accuracy** - How well scores predict difficulty
- **Agent effectiveness** - Which agents help most

### Active Reflection (NEW v4.1)

- **Corrections** - What user had to fix
- **Successes** - What worked perfectly
- **Edge cases** - Scenarios not covered
- **Preferences** - Consistent choices

## Smart Defaults

After 3+ occurrences of a pattern, the system can auto-suggest context:

```
Pattern detected: User always chooses TypeScript
Confidence: 0.85
Occurrences: 5

→ Suggest: Default to TypeScript for new projects
```

## /reflect Command

<Badge type="info" text="NEW v4.1" />

The `/reflect` command transforms passive tracking into active improvement:

```bash
# After using a skill
/reflect prompt-hybrid

# Output shows:
# - Corrections detected
# - Successes detected
# - Proposed changes
# - Option to apply
```

[Learn more about /reflect →](/guide/commands/reflect)

## Configuration

Configure in `.claude/config/learning-config.json`:

```json
{
  "learning_settings": {
    "enabled": true,
    "pattern_storage": ".claude/memory/prompt-patterns.md",
    "learning_threshold": 3,
    "auto_suggest_improvements": true,
    "track_user_modifications": true
  },
  "reflection_analysis": {
    "enabled": true,
    "min_signals_to_report": 2,
    "observation_storage": ".claude/memory/observations.md",
    "confidence_thresholds": {
      "correction": 0.6,
      "success": 0.5,
      "edge_case": 0.4,
      "preference": 0.4
    }
  }
}
```

### Settings

| Setting | Default | Description |
|---------|---------|-------------|
| `enabled` | `true` | Enable learning system |
| `learning_threshold` | `3` | Occurrences before suggesting |
| `auto_suggest_improvements` | `true` | Show suggestions automatically |
| `track_user_modifications` | `true` | Track user changes |

### Reflection Settings (v4.1)

| Setting | Default | Description |
|---------|---------|-------------|
| `min_signals_to_report` | `2` | Minimum signals for reflection |
| `confidence_thresholds` | varies | Per-category thresholds |

## Data Storage

### Pattern Storage

`.claude/memory/prompt-patterns.md`

Tracks:
- Successful prompt transformations
- Missing information patterns
- User preferences with confidence scores
- Complexity score accuracy

### Observation Storage (v4.1)

`.claude/memory/observations.md`

Tracks:
- Pending observations from `/reflect`
- Applied changes
- Dismissed observations

## How It Works

### Passive Flow

```
1. User runs /prompt-hybrid
2. System tracks:
   - What was missing in original prompt
   - What questions were asked
   - What user changed in output
   - Final approval/rejection
3. Patterns accumulated over time
4. After threshold: Suggest smart defaults
```

### Active Flow (v4.1)

```
1. User runs /reflect [skill]
2. System analyzes conversation for:
   - Corrections (HIGH priority)
   - Successes (MEDIUM priority)
   - Edge cases (MEDIUM priority)
   - Preferences (accumulative)
3. Proposes specific changes
4. User approves/declines
5. Changes applied to skill files
```

## Pattern Categories

### Prompt Types

```json
{
  "prompt_types": {
    "categories": [
      "bug_fix",
      "feature_implementation",
      "refactoring",
      "architecture_question",
      "code_review",
      "performance_optimization"
    ]
  }
}
```

### Signal Types (v4.1)

```json
{
  "signal_patterns": {
    "correction": ["no", "not like that", "I meant"],
    "success": ["perfect", "great", "exactly"],
    "edge_case": ["what about", "can you also"],
    "preference": ["I prefer", "always use"]
  }
}
```

## Best Practices

1. **Let patterns accumulate** - Don't expect immediate suggestions
2. **Run /reflect after corrections** - Capture what went wrong
3. **Review HIGH priority items** - Direct user feedback
4. **Check observations periodically** - LOW items may become patterns

## Troubleshooting

### No Suggestions Appearing

- Check `learning_threshold` (default: 3)
- Verify `enabled: true` in config
- Ensure pattern storage file exists

### /reflect Not Detecting Signals

- Run after actual skill usage
- Need 2+ signals by default
- Check `min_signals_to_report` setting

### Patterns Not Saving

- Verify `.claude/memory/` directory exists
- Check file permissions
- Ensure pattern storage path is correct

## Related

- [/reflect Command](/guide/commands/reflect) - Active skill improvement
- [Configuration Reference](/reference/configuration) - All settings
- [Caching](/guide/advanced-features/caching) - Performance optimization
