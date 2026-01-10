# /reflect

Analyze sessions and actively improve skills based on conversation feedback.

## Overview

| Aspect | Details |
|--------|---------|
| **Speed** | 5-15 seconds |
| **Complexity** | Medium |
| **Purpose** | Skill improvement from feedback |
| **New in** | v4.1 |

## Usage

```bash
/reflect [skill-name]

# Examples
/reflect prompt-technical
/reflect prompt-hybrid
/reflect session-end
```

## How It Works

### Step 1: Signal Detection

Claude scans the conversation for:

| Signal Type | Confidence | Examples |
|-------------|------------|----------|
| Corrections | 90% | "No, not like that", "I meant..." |
| Successes | 70% | "Perfect", "Exactly", "Yes" |
| Edge Cases | 60% | "What about...", "Can you also..." |
| Preferences | 50% | "I prefer", "I always", "I usually" |

### Step 2: Analysis

```
Skill Reflection: prompt-technical

Signals Detected:
- Corrections: 2
- Successes: 4
- Edge Cases: 1
- Preferences: 1

Proposed Changes:

[HIGH] + Add constraint:
       "Always ask about error handling strategy"
       Evidence: User corrected twice when missing

[MED]  + Add preference:
       "Include complexity score in output"
       Evidence: User requested this consistently

[LOW]  ~ Edge case noted:
       "Multi-language prompts need detection"
       Evidence: User had Slovak/English mixed prompt

Commit message: "prompt-technical: error handling, complexity score"

Apply? [Y / n / tweaks]
```

### Step 3: Apply Changes

If approved:
1. Modifies skill file directly
2. Records in `.claude/memory/prompt-patterns.md`
3. Commits changes with descriptive message

If declined:
1. Saves observations to `.claude/memory/observations.md`
2. Available for future review

## Example Session

### Scenario

You used `/prompt-technical` and Claude didn't ask about error handling. You corrected it twice. Later, the output was exactly what you wanted.

### Running Reflect

```bash
/reflect prompt-technical
```

### Output

```
Skill Reflection: prompt-technical

Signals: 2 corrections, 3 successes, 1 edge case

Proposed Changes:

[HIGH] + Constraints/NEVER:
        "Proceed without asking about error handling strategy"
        Evidence: "No, I need error handling" (2x)

[MED]  + Output Format:
        "Include estimated implementation time"
        Evidence: User asked for time estimate twice

[LOW]  ~ Note for review:
        "User prefers bullet points over paragraphs"
        Evidence: User reformatted output

Commit: "prompt-technical: require error handling, add time estimates"

Apply? [Y / n]
```

### Applying

```bash
Y
```

```
Applied to: .claude/commands/prompt-technical.md

Changes:
- Added constraint: Must ask about error handling
- Added output format: Include time estimate
- Saved observation: Bullet point preference

Committed: abc1234 prompt-technical: require error handling...

The skill will now:
✓ Always ask about error handling strategy
✓ Include implementation time estimates
```

## Signal Patterns

### Corrections (HIGH Priority)

Claude detects when you correct output:

```
"No, not like that"
"I meant..."
"Change that to..."
"Wrong, it should be..."
"Actually, I need..."
```

### Successes (MEDIUM Priority)

Claude detects approval:

```
"Perfect"
"Exactly"
"Yes, that's right"
"Great"
"Looks good"
```

### Edge Cases (MEDIUM Priority)

Claude detects missing functionality:

```
"What about..."
"Can you also..."
"Is there a way to..."
"What if..."
```

### Preferences (LOW Priority, Accumulates)

Claude detects patterns over multiple sessions:

```
"I prefer..."
"I always..."
"I usually..."
[Repeated choices in the same direction]
```

## Priority Levels

| Priority | Meaning | Action |
|----------|---------|--------|
| HIGH | Explicit correction from user | Apply immediately |
| MED | Repeated pattern or preference | Recommend applying |
| LOW | Observation for review | Save for later |

## Best Practices

### When to Run /reflect

- After using a skill multiple times
- After a session with corrections
- When you notice patterns in your feedback
- Before ending a long session

### How to Get Good Results

1. **Be explicit when correcting**: "No, I need X instead of Y"
2. **Confirm when satisfied**: "Perfect, that's exactly what I needed"
3. **Mention preferences**: "I prefer using TypeScript for new files"

### Review Saved Observations

Periodically check `.claude/memory/observations.md` for accumulated patterns that haven't been applied.

## Configuration

Settings in `.claude/config/learning-config.json`:

```json
{
  "reflection_analysis": {
    "enabled": true,
    "min_signals_to_report": 2,
    "confidence_thresholds": {
      "correction": 0.9,
      "success": 0.7,
      "edge_case": 0.6,
      "preference": 0.5
    }
  }
}
```

## Related Commands

- [/prompt-technical](/commands/prompt-technical) - Common target for reflection
- [/prompt-hybrid](/commands/prompt-hybrid) - Another common target
- [/session-end](/commands/session-end) - Consider running /reflect first
