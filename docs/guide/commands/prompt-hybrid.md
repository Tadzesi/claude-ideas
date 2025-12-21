# /prompt-hybrid

Intelligent prompt perfection with automatic agent assistance, caching, multi-agent verification, and learning.

## Overview

The most advanced command in the library, combining Phase 0 validation with intelligent complexity detection and autonomous agent assistance.

- **Time:** 2-50 seconds (depending on complexity)
- **Complexity:** Advanced
- **Best for:** Complex tasks, pattern detection, feasibility validation

## Core Features

- ⚡ **Automatic Complexity Detection** - 7 trigger rules
- 🤖 **Intelligent Agent Spawning** - Only when needed
- ⚡ **Agent Result Caching** - 10-20x faster repeated prompts
- 🔍 **Multi-Agent Verification** - 2-3 agents for critical ops
- 📚 **Learning System** - Tracks patterns, suggests defaults
- ✅ **Dual-Layer Validation** - Structural + semantic

## How It Works

```
Your Prompt
     ↓
Complexity Detection (automatic)
     ↓
┌────────┴────────┐
↓                 ↓
Simple        Complex
(0-4)         (10+)
     ↓                 ↓
Inline Q&A    Check Cache ⚡
     ↓                 ↓
     │         Cache Hit? → Use Cached
     │                 ↓
     │         Cache Miss → Spawn Agent(s)
     │                 ↓
     │         Verify (if critical) 🔍
     ↓                 ↓
     └────────┬────────┘
              ↓
      Perfected Prompt
              ↓
       Track Pattern 📚
```

## Complexity Detection

### Scoring System

| Trigger | Weight | Examples |
|---------|--------|----------|
| Multi-file scope | +5 | "across files", "entire codebase" |
| Architecture questions | +7 | "how does", "where is" |
| Pattern detection | +6 | "existing pattern", "match existing" |
| Feasibility check | +4 | "is it possible", "can we" |
| Implementation planning | +3 | "implement", "build" |
| Cross-cutting concerns | +4 | "authentication", "logging" |
| Refactoring tasks | +5 | "refactor", "restructure" |

### Complexity Categories

- **0-4 (Simple):** Fast inline validation (~2s)
- **5-9 (Moderate):** Ask user if agent wanted
- **10+ (Complex):** Auto-spawn agent (~20s first, ~2s cached)
- **15+ (Critical):** Multi-agent verification (~50s)

## Usage

```bash
/prompt-hybrid [your prompt]
```

### Examples

#### Simple Task (Score 0-4)
```bash
/prompt-hybrid Fix typo in README.md line 42
```
- No agent spawned
- Fast inline validation
- Time: ~2 seconds

#### Complex Task (Score 10+)
```bash
/prompt-hybrid Add user authentication following existing patterns
```
- Triggers: Pattern detection (+6) + Cross-cutting (+4) + Implementation (+3) = 13
- Agent spawns automatically
- Finds JWT pattern in codebase
- Returns enhanced recommendations
- Time: ~20s first time, ~2s if cached

#### Critical Task (Score 15+)
```bash
/prompt-hybrid Implement payment processing with security
```
- Triggers multi-agent verification
- 2-3 agents cross-validate
- Shows consensus analysis
- Time: ~50 seconds

## Advanced Features

### Agent Result Caching ⚡

**How it works:**
- Caches agent analysis for 24 hours
- Cache key: prompt + file hashes + git branch + agent template
- Auto-invalidates on file changes or branch switch
- 10-20x faster for repeated prompts

**Example:**
```bash
# First time
/prompt-hybrid Add caching to API
# Time: ~20s (agent analyzes codebase)

# Same prompt 2 hours later
/prompt-hybrid Add caching to API
# Time: ~2s (cache hit! ⚡)
```

### Multi-Agent Verification 🔍

**Triggers when:**
- Complexity score >= 15
- Critical keywords: payment, security, auth, migration
- User adds `--verify` flag

**What happens:**
- Spawns 2-3 agents with different strategies in parallel
- Each analyzes independently
- System shows consensus analysis
- User chooses approach if disagreements exist

**Example output:**
```
✅ Multi-Agent Verification Complete

Agreement Level: High (85%)

Unanimous Findings:
- Use existing AuthService pattern
- JWT tokens with 24h expiration

Disagreements:
⚠️ Agent 1: Suggests OAuth integration
⚠️ Agent 2: Suggests 2FA requirement
```

### Learning System 📚

**What it learns:**
- Successful prompt transformations
- Common missing information patterns
- User modification preferences
- Complexity score accuracy

**Smart Defaults:**
After 3 occurrences, suggests auto-applying context.

**Example:**
```
💡 Learning Insight Detected

Pattern: "authentication" prompts missing security requirements
Occurrences: 3

Suggested Smart Default:
Auto-include:
- Security scanning checklist
- Password hashing method
- Token expiration strategy

Apply this smart default? (yes/no)
```

## Configuration

Customizable via config files:

- `.claude/config/complexity-rules.json` - Adjust triggers/weights
- `.claude/config/agent-templates.json` - Custom agent behavior
- `.claude/config/cache-config.json` - Caching settings
- `.claude/config/verification-config.json` - Multi-agent settings
- `.claude/config/learning-config.json` - Learning thresholds

[Learn more about configuration →](/reference/configuration)

## Performance

| Path | Time | Use Case |
|------|------|----------|
| Simple (inline) | ~2s | Quick prompts, single file |
| Complex (first) | ~20s | Multi-file, patterns, feasibility |
| Complex (cached) | ~2s | Repeated/similar prompts |
| Multi-agent | ~50s | Critical operations verification |

## When to Use

### Use `/prompt-hybrid` when:

✅ **Complex task** - Might need codebase analysis
✅ **Pattern detection** - Following existing conventions
✅ **Feasibility check** - Technical validation needed
✅ **Uncertain scope** - Let complexity detection decide
✅ **Want caching benefits** - Repeated similar tasks

### Use `/prompt` instead when:

❌ **Very simple** - Single quick change
❌ **No codebase context** - You have all info
❌ **Speed critical** - Need instant response

## Tips for Best Results

1. **Trust complexity detection** - Let it decide agent usage
2. **Leverage caching** - Similar prompts use cached results
3. **Review verification** - Multi-agent shows perspectives
4. **Accept smart defaults** - Learning improves with usage
5. **Clear cache when needed** - Delete `.claude/cache/agent-results/` if stale

## Next Steps

- [Learn about advanced features](/guide/advanced-features/caching)
- [Configure complexity detection](/reference/configuration)
- [Explore agent caching](/guide/advanced-features/caching)
- [Understand multi-agent verification](/guide/advanced-features/multi-agent)
