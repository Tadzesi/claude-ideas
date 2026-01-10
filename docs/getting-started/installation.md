# Installation

Get Claude Commands Library running in your project in under 2 minutes.

## Prerequisites

Before installing, ensure you have:

- **Claude Code CLI** - [Install from claude.ai/code](https://claude.ai/code)
- **Windows 10/11** - PowerShell 5.1 or later (pre-installed)
- **Git** - [Download from git-scm.com](https://git-scm.com/download/win)

Verify your setup:

```powershell
claude --version    # Should show Claude Code version
git --version       # Should show Git version
```

## Quick Installation

### One-Line Install

```powershell
# Download and run the installer
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-commands.ps1" -OutFile "install-claude-commands.ps1"
.\install-claude-commands.ps1
```

The installer will:

1. Clone the repository
2. Deploy `.claude/` directory to your project
3. Preserve any existing memory files
4. Display available commands

## Installation Options

### Install to Current Directory

```powershell
cd C:\YourProject
.\install-claude-commands.ps1
```

### Install to Specific Directory

```powershell
.\install-claude-commands.ps1 -InstallPath "C:\Projects\MyApp"
```

### Force Reinstall

If you have a corrupted installation:

```powershell
.\install-claude-commands.ps1 -Force
```

## What Gets Installed

```
your-project/
├── .claude/
│   ├── commands/           # Slash commands
│   │   ├── prompt.md
│   │   ├── prompt-hybrid.md
│   │   ├── prompt-technical.md
│   │   ├── prompt-research.md
│   │   ├── prompt-article.md
│   │   ├── prompt-article-readme.md
│   │   ├── session-start.md
│   │   ├── session-end.md
│   │   └── reflect.md
│   ├── library/            # Core library system
│   │   ├── prompt-perfection-core.md
│   │   ├── adapters/
│   │   └── intelligence/
│   ├── config/             # Configuration files
│   │   ├── complexity-rules.json
│   │   ├── agent-templates.json
│   │   └── learning-config.json
│   ├── memory/             # Your session data
│   │   ├── sessions.md
│   │   └── prompt-patterns.md
│   ├── rules/              # Path-specific rules
│   └── skills/             # Skill configurations
├── CLAUDE.md               # Project instructions
└── plugin.json             # Plugin manifest
```

## Verify Installation

After installation, verify everything works:

```powershell
# Check .claude directory exists
Test-Path ".claude"

# List installed commands
Get-ChildItem ".claude\commands"
```

Start Claude Code in your project:

```powershell
claude
```

Then try a command:

```bash
/prompt Hello, test installation
```

You should see Claude run the prompt through Phase 0 validation.

## Updating

To update to the latest version:

```powershell
.\install-claude-commands.ps1
```

The installer automatically:

1. Detects existing installation
2. Creates backup of current files
3. Pulls latest from GitHub
4. **Preserves your memory files** (sessions.md, prompt-patterns.md)

::: warning Config Customizations
If you've customized config files, back them up before updating:

```powershell
Copy-Item ".claude\config\complexity-rules.json" "my-complexity-rules.json"
```
:::

## Optional: Enhanced Statusline

Add real-time metrics to your terminal:

```powershell
iwr -useb https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-statusline.ps1 | iex
```

This displays:

```
■ my-project | ⎇ main | ████████░░ 45% | ● 27k/155k | ▶ 89k/15k | ◆ 3.2s
```

[Learn more about the statusline →](/architecture/statusline)

## Troubleshooting

### "Git is not recognized"

Install Git from [git-scm.com](https://git-scm.com/download/win), then restart PowerShell.

### "Execution policy" error

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

### "Access denied" error

1. Close Claude Code if running
2. Run PowerShell as Administrator
3. Try installation again

### Commands not appearing

1. Verify `.claude/commands/` exists
2. Restart Claude Code
3. Check CLAUDE.md is in project root

### GitHub authentication failed

```powershell
git config --global credential.helper wincred
git clone https://github.com/Tadzesi/claude-ideas.git
```

Enter your GitHub username and Personal Access Token when prompted.

## Uninstallation

To completely remove:

```powershell
# Remove .claude directory
Remove-Item -Path ".claude" -Recurse -Force

# Remove project files (optional)
Remove-Item "CLAUDE.md", "plugin.json", "PLUGIN.md" -Force

# Remove backups (optional)
Remove-Item -Path ".claude-backup" -Recurse -Force
```

## Next Steps

Installation complete! Continue with:

- [Quick Start Guide](/getting-started/quick-start) - Try your first commands
- [Your First Prompt](/getting-started/first-prompt) - Detailed walkthrough
- [Commands Overview](/commands/) - See all available commands
