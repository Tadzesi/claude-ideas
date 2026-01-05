# /reflect - Skill Reflection

<Badge type="tip" text="v4.1" /> <Badge type="info" text="NEW" />

Analyze conversation sessions to detect what worked, what didn't, and propose specific skill improvements.

## Overview

The `/reflect` command transforms passive pattern tracking into **active skill improvement**. It analyzes your conversation for corrections, successes, edge cases, and preferences, then proposes specific changes to make skills work better for you.

**Key Innovation:** Instead of just logging patterns, `/reflect` actively proposes changes and can apply them directly to skill files.

## Quick Start

```bash
# After using a skill, run reflect
/reflect prompt-hybrid

# Or let it ask which skill
/reflect
```

## When to Use

| Scenario | Use /reflect |
|----------|--------------|
| After correcting Claude multiple times | Yes |
| Skill keeps missing your preferences | Yes |
| Found an edge case not handled | Yes |
| Session went smoothly | Optional (captures successes) |
| End of skill-heavy session | Recommended |

## How It Works

### Signal Detection

`/reflect` scans your conversation for four types of signals:

#### 1. Corrections (HIGH Priority)

Detected when you:
- Said "no", "not like that", "I meant..."
- Explicitly corrected output
- Asked for changes immediately after generation

```
User: "No, I wanted dark theme, not light"
→ Signal: CORRECTION (confidence: 0.92)
→ Proposed: Add "Default to dark theme" constraint
```

#### 2. Successes (MEDIUM Priority)

Detected when you:
- Said "perfect", "great", "exactly"
- Accepted output without modification
- Built on top of the output

```
User: "Perfect, exactly what I needed"
→ Signal: SUCCESS (confidence: 0.78)
→ Pattern: Preserve this output style
```

#### 3. Edge Cases (MEDIUM Priority)

Detected when you:
- Asked about features not offered
- Had to use workarounds
- Encountered scenarios not covered

```
User: "What about monorepo structures?"
→ Signal: EDGE_CASE (confidence: 0.62)
→ Proposed: Note for review - add monorepo support
```

#### 4. Preferences (Accumulative)

Detected when you:
- Repeatedly chose the same option
- Showed consistent style preferences
- Always selected certain tools/frameworks

```
User: Chose TypeScript 3/3 times
→ Signal: PREFERENCE (confidence: 0.72)
→ Proposed: Default to TypeScript
```

## Example Session

### Running /reflect

```
User: /reflect prompt-hybrid

Claude:
┌─────────────────────────────────────────┐
│ Skill Reflection: prompt-hybrid         │
│                                         │
│ Signals: 2 corrections, 3 successes     │
│                                         │
│ Proposed changes:                       │
│                                         │
│ [HIGH] + Constraints/NEVER:             │
│         "Use gradients unless requested"│
│         Evidence: User said "no" twice  │
│                                         │
│ [HIGH] + Question Priority:             │
│         "Ask about theme preference"    │
│         Evidence: User corrected theme  │
│                                         │
│ [MED]  + Smart Default:                 │
│         "Default to TypeScript"         │
│         Evidence: Chose TS 3/3 times    │
│                                         │
│ Commit: "prompt-hybrid: no gradients,   │
│          theme question, TS default"    │
└─────────────────────────────────────────┘

Apply these changes? [Y/n]
```

### Applying Changes

```
User: Y

Claude:
✓ Applied 3 changes to prompt-hybrid.md
✓ Saved patterns to prompt-patterns.md

Changes applied:
- [x] Added constraint: no gradients
- [x] Added question: theme preference
- [x] Set default: TypeScript

The skill will now incorporate these learnings.
```

## Configuration

Configure in `.claude/config/learning-config.json`:

```json
{
  "reflection_analysis": {
    "enabled": true,
    "min_signals_to_report": 2,
    "confidence_thresholds": {
      "correction": 0.6,
      "success": 0.5,
      "edge_case": 0.4,
      "preference": 0.4
    }
  }
}
```

### Options

| Setting | Default | Description |
|---------|---------|-------------|
| `enabled` | `true` | Enable/disable reflection |
| `min_signals_to_report` | `2` | Minimum signals needed |
| `confidence_thresholds` | varies | Per-category thresholds |
| `accumulation_window` | `5` | Sessions for preference tracking |

## Priority Levels

| Priority | Color | Meaning | Action |
|----------|-------|---------|--------|
| HIGH | Red | Direct corrections | Apply first |
| MED | Yellow | Patterns, preferences | Recommend applying |
| LOW | Cyan | Observations | Review before applying |

## Memory Integration

`/reflect` integrates with the learning system:

**Reads from:**
- Current conversation (signals)
- `.claude/memory/prompt-patterns.md` (history)

**Writes to:**
- `.claude/commands/[skill].md` (changes)
- `.claude/memory/prompt-patterns.md` (patterns)
- `.claude/memory/observations.md` (pending items)

## Workflow Examples

### Workflow 1: After Corrections

```bash
# Use a skill, make corrections
/prompt-hybrid "Add user auth"
# Claude suggests OAuth, you wanted JWT
"No, I meant JWT tokens"

# After session, reflect
/reflect prompt-hybrid
# Proposes: Add question about auth type
```

### Workflow 2: End of Session

```bash
# After a productive session
/reflect
# Choose skill to analyze
# Review all signals from session
```

### Workflow 3: Preference Tracking

```bash
# Over multiple sessions...
# Always choose Grid over Flexbox
# Always choose TypeScript

/reflect prompt-technical
# Proposes: Default to Grid, Default to TypeScript
```

## Comparison with Related Features

### /reflect vs /session-end

| Feature | /reflect | /session-end |
|---------|----------|--------------|
| Purpose | Improve skills | Save context |
| Analysis | Active (proposes changes) | Passive (records) |
| Output | Skill modifications | Session memory |
| When to use | After corrections | End of session |

### /reflect vs Learning System

| Feature | /reflect | Learning System |
|---------|----------|-----------------|
| Approach | Active analysis | Passive tracking |
| Changes | Immediate proposals | Pattern accumulation |
| User control | Full approval | Background |
| Trigger | Manual command | Automatic |

## Best Practices

1. **Run after meaningful sessions** - Need enough interaction for signals
2. **Focus on one skill at a time** - Better analysis quality
3. **Review HIGH items promptly** - Direct user feedback
4. **Let preferences accumulate** - Confidence grows over time
5. **Save observations for review** - LOW items may become patterns

## Troubleshooting

### No Signals Detected

**Problem:** "Insufficient signals detected"

**Solutions:**
- Ensure you actually used the skill in conversation
- Have enough interaction (corrections, approvals)
- Lower `min_signals_to_report` in config

### Changes Not Applied

**Problem:** Edit failed

**Solutions:**
- Verify skill file exists in `.claude/commands/`
- Check section headers match expected format
- Review proposed change for accuracy

### Too Many LOW Items

**Problem:** Output cluttered with observations

**Solutions:**
- Increase confidence thresholds in config
- Increase `min_signals_to_report`
- Focus on HIGH/MED items first

## Related

- [Learning System](/guide/advanced-features/learning-system) - Pattern tracking
- [Session Management](/guide/commands/session-management) - Context capture
- [Configuration Reference](/reference/configuration) - All settings
