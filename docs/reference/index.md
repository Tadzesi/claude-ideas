# Reference

Complete reference documentation for the Claude Commands Library.

## Quick Links

<div class="grid-cards">

### [Configuration](/reference/configuration)
All configuration files with complete JSON schemas and examples.

### [Best Practices](/reference/best-practices)
Guidelines for effective usage based on real-world patterns.

### [Troubleshooting](/reference/troubleshooting)
Common issues and solutions.

### [Changelog](/reference/changelog)
Version history and upgrade guides.

</div>

## Configuration Files

| File | Purpose | Documentation |
|------|---------|---------------|
| `complexity-rules.json` | Complexity detection | [View](/reference/configuration#complexity-rules-json) |
| `agent-templates.json` | Agent behavior | [View](/reference/configuration#agent-templates-json) |
| `cache-config.json` | Caching settings | [View](/reference/configuration#cache-config-json) |
| `verification-config.json` | Multi-agent verification | [View](/reference/configuration#verification-config-json) |
| `learning-config.json` | Learning system | [View](/reference/configuration#learning-config-json) |
| `predictive-intelligence.json` | Phase 0.15 | [View](/reference/configuration#predictive-intelligence-json) |

## Command Quick Reference

| Command | Purpose | Speed |
|---------|---------|-------|
| `/prompt` | Quick prompt cleanup | ~2s |
| `/prompt-hybrid` | Intelligent perfection | 2-30s |
| `/prompt-research` | Deep multi-agent analysis | 60-180s |
| `/prompt-technical` | Technical implementation | 5-30s |
| `/prompt-article` | Article writing wizard | Interactive |
| `/prompt-article-readme` | README generation | ~30s |
| `/session-start` | Load session context | ~3s |
| `/session-end` | Save session context | ~5s |
| `/reflect` | Skill improvement | 5-15s |

## File Locations

```
.claude/
├── commands/           # Slash commands
├── library/            # Core libraries and adapters
├── config/             # JSON configuration files
├── memory/             # Persistent session data
├── cache/              # Agent result cache
└── rules/              # Path-specific rules
```

## Getting Help

1. Check [Troubleshooting](/reference/troubleshooting) for common issues
2. Review [Best Practices](/reference/best-practices) for usage tips
3. Report issues at [GitHub](https://github.com/Tadzesi/claude-ideas/issues)

