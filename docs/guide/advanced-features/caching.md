# Agent Result Caching

10-20x faster for repeated prompts with intelligent cache invalidation.

## How It Works

- Caches agent analysis for 24 hours
- Cache key: prompt + file hashes + git branch
- Auto-invalidates on changes
- Saves agent costs

## Configuration

`.claude/config/cache-config.json`

## Cache Management

View: `.claude/cache/agent-results/`
Clear: Delete the directory

[Full documentation coming soon]
