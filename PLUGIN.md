# Claude Commands Library Plugin

A Claude Code plugin providing reusable slash commands for prompt engineering, content creation, and session management.

---

## Installation

### From GitHub (Recommended)

```powershell
# Windows PowerShell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-commands.ps1" -OutFile "install-claude-commands.ps1"
.\install-claude-commands.ps1
```

```bash
# macOS/Linux
curl -fsSL https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-commands.sh | bash
```

### Manual Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Tadzesi/claude-ideas.git
   ```

2. Copy `.claude/` directory to your project:
   ```bash
   cp -r claude-ideas/.claude/ your-project/.claude/
   ```

3. Copy `CLAUDE.md` to your project root:
   ```bash
   cp claude-ideas/CLAUDE.md your-project/
   ```

---

## Available Commands

### Prompt Engineering

| Command | Description | Speed |
|---------|-------------|-------|
| `/prompt` | Quick prompt cleanup and validation | 2s |
| `/prompt-hybrid` | Intelligent perfection with agents | 2-30s |
| `/prompt-technical` | Technical implementation analysis | 5-30s |
| `/prompt-research` | Deep multi-agent research | 60-180s |

### Content Creation

| Command | Description |
|---------|-------------|
| `/prompt-article` | Interactive article writing wizard |
| `/prompt-article-readme` | README generator with tech detection |

### Session Management

| Command | Description |
|---------|-------------|
| `/session-start` | Load previous session context |
| `/session-end` | Save comprehensive session context |

### Skill Improvement

| Command | Description | Speed |
|---------|-------------|-------|
| `/reflect` | Analyze and improve skills | 5-15s |

---

## Quick Start

1. Start a Claude Code session in your project
2. Run `/session-start` to load any previous context
3. Use `/prompt-technical` for implementation tasks
4. Run `/session-end` before ending your session

---

## Configuration

### Complexity Rules

Edit `.claude/config/complexity-rules.json` to customize:
- Trigger keywords and weights
- Complexity thresholds
- Agent selection rules

### Agent Templates

Edit `.claude/config/agent-templates.json` to customize:
- Agent prompts
- Model selection (haiku/sonnet)
- Timeout settings

### Learning System

Edit `.claude/config/learning-config.json` to:
- Enable/disable learning
- Set pattern detection thresholds
- Configure observation storage

---

## Plugin Structure

```
.claude/
├── commands/          # Slash command definitions
├── library/           # Core library + adapters
│   ├── prompt-perfection-core.md
│   ├── adapters/      # Domain-specific adapters
│   └── intelligence/  # Predictive intelligence
├── config/            # JSON configuration files
├── memory/            # Persistent memory files
├── rules/             # Path-specific rules
├── skills/            # Skill configurations
└── CLAUDE.md          # Project memory with @ imports

plugin.json            # Plugin manifest
PLUGIN.md              # This documentation
```

---

## Features

### Hybrid Intelligence

Automatic complexity detection with three execution paths:
- **Simple (0-4)**: Fast inline validation
- **Moderate (5-9)**: Optional agent assistance
- **Complex (10+)**: Automatic agent spawning

### Predictive Intelligence (v4.0+)

Proactive guidance including:
- Journey stage detection
- Domain risk analysis
- Pattern recognition
- Proactive warnings
- Next-steps prediction

### Learning System

Continuous improvement through:
- Pattern tracking
- User preference learning
- Smart defaults after 3+ occurrences
- Skill reflection and modification

### Native Claude Code Integration

Uses Claude Code's native features:
- @ import syntax for file references
- .claude/rules/ for path-specific rules
- CLAUDE.md hierarchy for memory
- Hooks integration (optional)

---

## Memory System

### CLAUDE.md Hierarchy

1. **Project Root**: `CLAUDE.md` - Main project instructions
2. **Plugin Directory**: `.claude/CLAUDE.md` - Memory imports
3. **Rules**: `.claude/rules/*.md` - Path-specific rules
4. **Local**: `CLAUDE.local.md` - Personal preferences (gitignored)

### @ Import Syntax

Reference files using @ imports:
```markdown
See @.claude/memory/sessions.md for session history.
Configuration in @.claude/config/complexity-rules.json.
```

---

## Version History

- **v4.1** (January 2026): Skill Reflection System
- **v4.0** (January 2026): Predictive Intelligence
- **v3.0** (December 2025): Multi-Agent Research
- **v2.0** (November 2025): Hybrid Intelligence
- **v1.0** (October 2025): Initial Release

---

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make changes following `.claude/rules/` conventions
4. Test with multiple commands
5. Submit a pull request

---

## License

MIT License - See LICENSE file for details.

---

## Support

- **Documentation**: https://tadzesi.github.io/claude-ideas/
- **Issues**: https://github.com/Tadzesi/claude-ideas/issues
- **Discussions**: https://github.com/Tadzesi/claude-ideas/discussions
