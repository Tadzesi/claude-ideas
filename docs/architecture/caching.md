# Agent Caching

Smart result caching that provides 10-20x speedup on repeated queries.

## Why Caching?

Without caching:
```
Query 1: "Analyze authentication patterns" → 20 seconds
Query 2: "Analyze authentication patterns" → 20 seconds
Query 3: "Analyze authentication patterns" → 20 seconds

Total: 60 seconds
```

With caching:
```
Query 1: "Analyze authentication patterns" → 20 seconds (cache miss)
Query 2: "Analyze authentication patterns" → 2 seconds (cache hit)
Query 3: "Analyze authentication patterns" → 2 seconds (cache hit)

Total: 24 seconds (60% faster)
```

## How It Works

### Cache Key Generation

```
┌─────────────────────────────────────────────────────────────┐
│                     Cache Key                                │
│                                                              │
│  hash(                                                       │
│    prompt_text +           ← What you're asking              │
│    relevant_file_hashes +  ← Current file states             │
│    git_branch +            ← Which branch                    │
│    agent_template          ← Which agent type                │
│  )                                                           │
└─────────────────────────────────────────────────────────────┘
```

### Cache Lookup Flow

```
Prompt Received
      │
      ▼
┌─────────────────┐     Cache    ┌─────────────────┐
│ Generate Cache  │────  Hit ───▶│  Return Cached  │
│      Key        │              │     Result      │
└────────┬────────┘              └─────────────────┘
         │
    Cache Miss
         │
         ▼
┌─────────────────┐
│   Run Agent     │
│   (Full Query)  │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Store Result   │
│   in Cache      │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Return Result   │
└─────────────────┘
```

## Cache Storage

### Location

```
.claude/cache/
├── agent-results/           # Cached agent outputs
│   ├── abc123.json
│   ├── def456.json
│   └── ...
├── iteration-checkpoints/   # Research iteration state
│   ├── research-001/
│   │   ├── iteration-1.json
│   │   └── iteration-2.json
│   └── ...
└── pattern-cache/           # Detected patterns
    └── codebase-patterns.json
```

### Cache Entry Format

```json
{
  "key": "sha256:abc123...",
  "created_at": "2026-01-09T14:30:00Z",
  "expires_at": "2026-01-10T14:30:00Z",
  "agent_type": "explore",
  "prompt_hash": "def456...",
  "file_hashes": {
    "src/auth/login.js": "ghi789...",
    "src/models/user.js": "jkl012..."
  },
  "result": {
    "findings": [...],
    "recommendations": [...],
    "metadata": {...}
  }
}
```

## Cache Invalidation

### Automatic Triggers

The cache automatically invalidates when:

| Trigger | Description |
|---------|-------------|
| **File Change** | Any file in the query scope is modified |
| **Branch Switch** | Git branch changes |
| **TTL Expiry** | Default 24 hours elapsed |
| **Manual Clear** | User clears cache |

### Smart Invalidation

Only relevant entries are invalidated:

```
File Changed: src/auth/login.js

Cache Entries:
✗ "Analyze auth patterns" (uses login.js) → Invalidated
✓ "Check database queries" (doesn't use login.js) → Kept
✓ "Review API routes" (doesn't use login.js) → Kept
```

## Configuration

### cache-config.json

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

### Settings Explained

| Setting | Default | Description |
|---------|---------|-------------|
| `enabled` | true | Enable/disable caching |
| `max_size_mb` | 50 | Maximum cache size |
| `cleanup_strategy` | "lru" | Least Recently Used cleanup |
| `ttl.default` | "24h" | Default time-to-live |
| `compression` | true | Compress cached results |

## Cache Control

### Bypass Cache

Force fresh analysis:

```bash
/prompt-hybrid --no-cache Analyze authentication patterns
```

### Clear Cache

Clear all cached results:

```bash
rm -rf .claude/cache/agent-results/*
```

Or selective clearing:

```bash
# Clear only exploration results
rm .claude/cache/agent-results/explore-*.json
```

### View Cache Status

```bash
# Check cache size
du -sh .claude/cache/

# List cached entries
ls -la .claude/cache/agent-results/
```

## Performance Impact

### Measured Speedups

| Scenario | Without Cache | With Cache | Speedup |
|----------|---------------|------------|---------|
| Simple explore | 20s | 2s | 10x |
| Pattern analysis | 30s | 2s | 15x |
| Security audit | 45s | 3s | 15x |
| Multi-agent | 90s | 5s | 18x |

### Memory Tradeoff

| Cache Size | Typical Entries | Impact |
|------------|-----------------|--------|
| 10 MB | ~50 queries | Minimal |
| 25 MB | ~125 queries | Low |
| 50 MB | ~250 queries | Moderate |

## Best Practices

### Let Cache Work

Don't constantly clear cache. The system handles invalidation intelligently.

### Use Consistent Prompts

Similar prompts with minor variations may not hit cache:

```
❌ "Analyze auth patterns"
❌ "Analyze authentication patterns"
❌ "analyze authentication patterns"

✓ Use consistent terminology
```

### Cache Warm-Up

For new projects, run common queries once to prime cache:

```bash
/prompt-hybrid Explore project structure
/prompt-hybrid Detect code patterns
/prompt-hybrid Analyze dependencies
```

### Monitor Cache Health

Periodically check cache is working:

```bash
# Should see files created after queries
ls -lt .claude/cache/agent-results/ | head -5
```

## Troubleshooting

### Cache Not Hitting

**Symptom:** Same query runs full analysis each time

**Causes:**
1. Files changed between queries
2. Branch switched
3. Prompt slightly different
4. Cache disabled in config

**Solution:** Check `cache-config.json` and file timestamps

### Cache Too Large

**Symptom:** `.claude/cache/` growing unbounded

**Cause:** LRU cleanup not running or max_size too high

**Solution:**
```json
{
  "storage": {
    "max_size_mb": 25,
    "cleanup_strategy": "lru"
  }
}
```

### Stale Results

**Symptom:** Cache returns outdated analysis

**Cause:** File tracking missed a change

**Solution:**
```bash
rm -rf .claude/cache/agent-results/*
```

## Related

- [Hybrid Intelligence](/architecture/hybrid-intelligence) - Agent system
- [Multi-Agent Research](/architecture/multi-agent) - Iteration caching
- [Configuration](/reference/configuration) - All cache settings

