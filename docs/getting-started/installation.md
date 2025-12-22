# Installation

::: tip Interactive Documentation
This installation guide is part of our comprehensive [VitePress Documentation Site](https://tadzesi.github.io/claude-ideas/). Browse the full documentation with search, navigation, and interactive examples!
:::

## Prerequisites

Before installing, ensure you have:

- [Claude Code CLI](https://claude.ai/code) installed and configured
- Windows 11 (or compatible environment)
- Git installed (`git --version` to check)

## Quick Installation

### One-Line Install

```powershell
# Download installer
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-commands.ps1" -OutFile "install-claude-commands.ps1"

# Run installer
.\install-claude-commands.ps1
```

That's it! The script will install all Claude commands and libraries to your current directory.

## Installation Methods

### Install to Current Directory

```powershell
cd C:\YourProject
.\install-claude-commands.ps1
```

The `.claude` directory will be created in your project.

### Install to Specific Directory

```powershell
.\install-claude-commands.ps1 -InstallPath "C:\MyProjects\MyProject"
```

### Force Reinstall

```powershell
.\install-claude-commands.ps1 -Force
```

Useful for fixing corrupted installations.

## What Gets Installed

The installer deploys the following structure:

```
.claude/
├── commands/                 # Slash commands (7 total)
│   ├── prompt.md
│   ├── prompt-hybrid.md
│   ├── prompt-technical.md
│   ├── prompt-article.md
│   ├── prompt-article-readme.md
│   ├── session-start.md
│   └── session-end.md
├── library/                  # Reusable Phase 0 library
│   ├── prompt-perfection-core.md
│   └── adapters/
│       ├── technical-adapter.md
│       ├── article-adapter.md
│       ├── session-adapter.md
│       └── hybrid-adapter.md
├── config/                   # Configuration files
│   ├── complexity-rules.json
│   ├── agent-templates.json
│   ├── cache-config.json
│   ├── verification-config.json
│   └── learning-config.json
├── memory/                   # Your session data (PRESERVED on update)
│   ├── sessions.md
│   └── prompt-patterns.md
└── cache/                    # Agent result cache
    └── agent-results/
```

## Updating

Simply run the installer again:

```powershell
.\install-claude-commands.ps1
```

The script will:
1. Detect existing installation
2. Create backup
3. Pull latest changes from GitHub
4. Deploy updates while **preserving your memory files**

## Data Preservation

### What Gets Preserved (During Updates)

✅ `.claude/memory/sessions.md` - Your session history
✅ `.claude/memory/prompt-patterns.md` - Learning system data
✅ Any custom files in `.claude/memory/`

### What Gets Updated

🔄 `.claude/commands/` - All slash commands
🔄 `.claude/library/` - Core library and adapters
🔄 `.claude/config/` - Configuration files

::: warning
If you've customized config files, back them up before updating:

```powershell
Copy-Item ".claude\config\complexity-rules.json" "complexity-rules-custom.json"
```
:::

## Troubleshooting

### Git Not Installed

Install Git from [git-scm.com](https://git-scm.com/download/win), restart PowerShell, and try again.

### GitHub Authentication Failed

Configure credential helper:

```powershell
git config --global credential.helper wincred
```

Clone repo manually to authenticate:

```powershell
git clone https://github.com/Tadzesi/claude-ideas.git
```

Enter your GitHub username and Personal Access Token.

### Permission Denied

Run PowerShell as Administrator, or:

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

### Deployment Failed

1. Close Claude Code if running
2. Run with Force flag: `.\install-claude-commands.ps1 -Force`
3. If still fails, manually delete `.claude` and reinstall

## Uninstallation

To completely remove:

```powershell
# Remove .claude directory
Remove-Item -Path ".claude" -Recurse -Force

# Remove backups (optional)
Remove-Item -Path ".claude-backup" -Recurse -Force
```

## Next Steps

- [Quick Start Guide](/getting-started/quick-start)
- [Explore Commands](/guide/commands/)
- [Configuration Reference](/reference/configuration)
