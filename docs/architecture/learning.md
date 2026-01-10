# Learning System

Continuous improvement through pattern tracking, user preferences, and smart defaults.

## How It Works

The learning system tracks every prompt transformation:

```
┌─────────────────────────────────────────────┐
│              User Interaction                │
│   /prompt-technical Add authentication       │
└──────────────────┬──────────────────────────┘
                   ▼
┌─────────────────────────────────────────────┐
│           Phase 0 Transformation             │
│   Original → Questions → Perfected           │
└──────────────────┬──────────────────────────┘
                   ▼
┌─────────────────────────────────────────────┐
│            Learning Capture                  │
│   - Original prompt                         │
│   - Complexity score                        │
│   - Questions asked                         │
│   - User modifications                      │
│   - Approval status                         │
└──────────────────┬──────────────────────────┘
                   ▼
┌─────────────────────────────────────────────┐
│          Pattern Database                    │
│   .claude/memory/prompt-patterns.md         │
└──────────────────┬──────────────────────────┘
                   ▼
┌─────────────────────────────────────────────┐
│          Smart Defaults                      │
│   After 3+ occurrences → Suggest defaults   │
└─────────────────────────────────────────────┘
```

## What Gets Tracked

### 1. Successful Transformations

```markdown
### 2026-01-09 - Feature Implementation - Score: 8/10

**Original Prompt:**
Add user authentication

**Complexity Score:** 12 (Complex)
**Agent Used:** Yes - Explore

**Missing Information Detected:**
- Authentication method not specified
- Database context unclear
- UI requirements missing

**Questions Asked:**
1. Which authentication method? (JWT / Cookie / OAuth)
2. Which database tables to use?
3. Login UI location?

**Perfected Prompt:**
[Final structured version]

**User Modifications:** None
**Approval Status:** Approved
**Outcome Success:** Yes
```

### 2. Common Missing Information

```markdown
**Prompt Type:** Feature Implementation
**Occurrences:** 15

**Frequently Missing:**
1. Authentication method - 12 times
2. Database context - 10 times
3. Error handling strategy - 8 times

**Smart Default Suggestion:**
When user mentions "authentication", auto-suggest JWT vs OAuth choice.
```

### 3. User Preferences

```markdown
**Preference Type:** Code Style
**Confidence:** 0.85
**Occurrences:** 12

**Pattern:**
User consistently chooses async/await over callbacks

**Evidence:**
- Session 2026-01-05: "Use async/await"
- Session 2026-01-07: "Prefer async"
- Session 2026-01-09: Modified callback to async
```

### 4. Complexity Score Accuracy

```markdown
**Date Range:** 2026-01-01 - 2026-01-09
**Total Prompts:** 45

**Accuracy Metrics:**
- Correct categorization: 87%
- Over-scored (simple → complex): 8%
- Under-scored (complex → simple): 5%

**Weight Adjustment Suggestions:**
- "authentication" trigger: Adjust weight 4 → 5 (often complex)
- "logging" trigger: Adjust weight 4 → 3 (often simple)
```

### 5. Agent Effectiveness

```markdown
**Agent Type:** Explore
**Template:** explore_codebase_context
**Usage Count:** 28

**Effectiveness Metrics:**
- Relevant findings: 92%
- User satisfaction: High
- Time to complete: 18s average
- Cache hit rate: 65%

**Common Findings:**
- Pattern detection: 24 times
- File structure: 28 times
- Tech stack: 28 times
```

## Smart Defaults

After 3+ occurrences of a pattern, the system suggests defaults:

```
/prompt-technical Add feature X

Learning System Notice:
Based on your history:
- You typically choose JWT for auth (8/10 times)
- You prefer async/await (12/12 times)
- You like detailed error messages (7/10 times)

Apply these defaults? [Yes / No / Customize]
```

## The /reflect Command

Active skill improvement from conversation feedback:

```bash
/reflect prompt-technical
```

Analyzes:
- **Corrections** - Where Claude got it wrong
- **Successes** - What worked well
- **Edge Cases** - Missing functionality
- **Preferences** - Implicit choices

Proposes changes:

```
[HIGH] + Add constraint: "Always ask about error handling"
       Evidence: User corrected twice when missing

[MED]  + Add preference: "Include time estimates"
       Evidence: User requested consistently

Apply? [Y / n]
```

## Storage

### Memory Files

| File | Content |
|------|---------|
| `sessions.md` | Session summaries |
| `prompt-patterns.md` | Learning database |
| `observations.md` | Reflection signals |
| `project-knowledge.md` | Persistent context |

### Data Format

```markdown
## Pattern Categories

### 1. Successful Transformations
[Transformation records]

### 2. Common Missing Information Patterns
[Frequency analysis]

### 3. User Preference Patterns
[Detected preferences]

### 4. Complexity Score Accuracy
[Calibration data]

### 5. Agent Effectiveness
[Performance metrics]
```

## Configuration

In `.claude/config/learning-config.json`:

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
  }
}
```

## Privacy

All learning data stays local:
- Stored in `.claude/memory/`
- Never sent externally
- Git-ignored by default (user choice to commit)
- Can be cleared anytime

## Best Practices

### For Optimal Learning

1. **Be consistent** - Similar tasks train better patterns
2. **Provide feedback** - Corrections and approvals matter
3. **Use /reflect** - Active improvement from sessions
4. **Don't skip questions** - Each answer trains the system

### Managing Learning Data

```bash
# View current patterns
cat .claude/memory/prompt-patterns.md

# Clear learning data (fresh start)
rm .claude/memory/prompt-patterns.md

# Keep sessions, clear patterns
# Edit prompt-patterns.md to reset specific sections
```

## Related

- [/reflect Command](/commands/reflect) - Active skill improvement
- [Session Management](/commands/session-start) - Context continuity
- [Configuration](/reference/configuration) - Customize behavior
