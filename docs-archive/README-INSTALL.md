# Claude Commands Library - Installation Guide

**Version:** 1.0
**Repository:** https://github.com/Tadzesi/claude-ideas
**Platform:** Windows

---

## Quick Start

### One-Line Installation

1. Download the installer:
   ```powershell
   Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-commands.ps1" -OutFile "install-claude-commands.ps1"
   ```

2. Run the installer:
   ```powershell
   .\install-claude-commands.ps1
   ```

That's it! The script will install all Claude commands and libraries to your current directory.

---

## Prerequisites

### 1. Git Installation

**Check if Git is installed:**
```powershell
git --version
```

**If not installed:**
- Download from: https://git-scm.com/download/win
- Install with default options
- Restart PowerShell after installation

### 2. GitHub Authentication (Private Repository)

Since this is a private repository, you need to authenticate with GitHub.

**Option A: Personal Access Token (Recommended)**

1. Generate a Personal Access Token:
   - Go to: https://github.com/settings/tokens
   - Click "Generate new token" → "Generate new token (classic)"
   - Select scopes: `repo` (full control of private repositories)
   - Generate and copy the token

2. Configure Git credential helper:
   ```powershell
   git config --global credential.helper wincred
   ```

3. Clone the repo once manually (Git will ask for credentials):
   ```powershell
   git clone https://github.com/Tadzesi/claude-ideas.git
   ```
   - Username: Your GitHub username
   - Password: Your Personal Access Token (not your GitHub password)

4. Windows will save the credentials, and the installer will work automatically

**Option B: SSH Key**

1. Generate SSH key:
   ```powershell
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```

2. Add to GitHub:
   - Copy public key: `cat ~/.ssh/id_ed25519.pub`
   - Go to: https://github.com/settings/keys
   - Click "New SSH key" and paste

3. Test connection:
   ```powershell
   ssh -T git@github.com
   ```

---

## Installation Methods

### Method 1: Install to Current Directory (Recommended)

```powershell
# Download installer
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-commands.ps1" -OutFile "install-claude-commands.ps1"

# Run in your project directory
cd C:\YourProject
.\install-claude-commands.ps1
```

The `.claude` directory will be created in `C:\YourProject\.claude`

### Method 2: Install to Specific Directory

```powershell
.\install-claude-commands.ps1 -InstallPath "C:\MyProjects\MyProject"
```

### Method 3: Force Reinstall

```powershell
.\install-claude-commands.ps1 -Force
```

Reinstalls even if already installed (useful for fixing corrupted installations)

### Method 4: Skip Backup

```powershell
.\install-claude-commands.ps1 -SkipBackup
```

Skips creating backup before update (faster, but not recommended)

---

## What Gets Installed

The installer deploys the following structure:

```
.claude/
├── commands/                 # Slash commands
│   ├── prompt.md
│   ├── prompt-hybrid.md
│   ├── prompt-technical.md
│   ├── prompt-article.md
│   ├── session-start.md
│   └── session-end.md
├── library/                  # Reusable Phase 0 library
│   ├── prompt-perfection-core.md
│   └── adapters/
│       ├── session-adapter.md
│       ├── technical-adapter.md
│       └── article-adapter.md
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

---

## Installation Process

The installer performs these steps:

1. **Prerequisites Check**
   - Verifies Git is installed
   - Tests GitHub authentication

2. **Backup Creation** (if updating)
   - Creates backup in `.claude-backup/claude-backup-YYYYMMDD-HHMMSS/`
   - Preserves all your data

3. **Repository Sync**
   - Clones repo (first install) OR pulls latest (update)
   - Uses temporary directory during installation

4. **Deployment**
   - Copies `commands/`, `library/`, `config/` directories
   - **Preserves** `memory/` directory (your session data)
   - Creates `cache/` if needed

5. **Verification**
   - Checks all required files are present
   - Verifies core library exists
   - Counts installed commands

6. **Cleanup**
   - Removes temporary files
   - Shows installation summary

---

## Updating to Latest Version

### Automatic Update Check

Simply run the installer again:

```powershell
.\install-claude-commands.ps1
```

The script will:
1. Detect existing installation
2. Ask if you want to update
3. Create backup
4. Pull latest changes from GitHub
5. Deploy updates while preserving your memory files

### Manual Update

```powershell
# Navigate to the temp directory where repo was cloned
cd $env:TEMP\claude-commands-temp\claude-ideas

# Pull latest changes
git pull origin main

# Run installer again
cd C:\YourProject
.\install-claude-commands.ps1 -Force
```

---

## Preserving Your Data

### What Gets Preserved

The installer **automatically preserves** these during updates:

✅ `.claude/memory/sessions.md` - Your session history
✅ `.claude/memory/prompt-patterns.md` - Learning system data
✅ Any custom files you added to `.claude/memory/`

### What Gets Updated

These are **replaced** with the latest versions:

🔄 `.claude/commands/` - All slash commands
🔄 `.claude/library/` - Core library and adapters
🔄 `.claude/config/` - Configuration files (may reset your customizations)

### Backup Your Customizations

**Before updating**, if you've customized config files:

```powershell
# Backup your custom config
Copy-Item ".claude\config\complexity-rules.json" "complexity-rules-custom.json"

# After update, compare and merge changes
# Use a diff tool or manually merge your customizations back
```

---

## Troubleshooting

### Error: "Git is not installed"

**Solution:**
1. Install Git from https://git-scm.com/download/win
2. Restart PowerShell
3. Run installer again

### Error: "GitHub authentication failed"

**Solution:**
1. Configure credential helper:
   ```powershell
   git config --global credential.helper wincred
   ```

2. Clone repo manually to authenticate:
   ```powershell
   git clone https://github.com/Tadzesi/claude-ideas.git
   ```

3. Enter your GitHub username and Personal Access Token
4. Run installer again

### Error: "Access denied" or "Permission denied"

**Solution:**
1. Run PowerShell as Administrator:
   - Right-click PowerShell
   - Select "Run as Administrator"

2. Or change execution policy:
   ```powershell
   Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
   ```

### Error: "Deployment failed"

**Solution:**
1. Check if `.claude` directory is in use (close Claude Code if running)
2. Run with Force flag:
   ```powershell
   .\install-claude-commands.ps1 -Force
   ```

3. If still fails, manually delete `.claude` and reinstall:
   ```powershell
   Remove-Item -Path ".claude" -Recurse -Force
   .\install-claude-commands.ps1
   ```

### Error: "Verification failed"

**Possible causes:**
- Incomplete download
- Network interruption during clone
- Corrupted files

**Solution:**
1. Delete temp directory:
   ```powershell
   Remove-Item -Path "$env:TEMP\claude-commands-temp" -Recurse -Force
   ```

2. Run installer again:
   ```powershell
   .\install-claude-commands.ps1 -Force
   ```

---

## Uninstallation

To completely remove Claude commands:

```powershell
# Remove .claude directory
Remove-Item -Path ".claude" -Recurse -Force

# Remove backups (optional)
Remove-Item -Path ".claude-backup" -Recurse -Force

# Remove installer script (optional)
Remove-Item -Path "install-claude-commands.ps1"
```

---

## Advanced Usage

### Install for Multiple Projects

The `.claude` directory is project-specific. Install in each project:

```powershell
# Project 1
cd C:\Projects\ProjectA
.\install-claude-commands.ps1

# Project 2
cd C:\Projects\ProjectB
.\install-claude-commands.ps1
```

Each project gets its own commands and memory.

### Shared Installation (Alternative)

To share commands across projects, create a symbolic link:

```powershell
# Install once
cd C:\Projects\SharedClaude
.\install-claude-commands.ps1

# Link from other projects
cd C:\Projects\ProjectA
New-Item -ItemType SymbolicLink -Path ".claude" -Target "C:\Projects\SharedClaude\.claude"
```

**Note:** Symbolic links require administrator privileges.

### Offline Installation

If you have the repository on a USB drive or network share:

1. Copy the repository folder to your machine
2. Modify the installer script:
   - Change `$RepoUrl` to local path: `$RepoUrl = "C:\Path\To\claude-ideas"`
   - Comment out git clone/pull commands
   - Point directly to the local folder

---

## Version Management

### Check Installed Version

```powershell
# Read version from installer
Get-Content "install-claude-commands.ps1" | Select-String "Version:"

# Check last update time
Get-Item ".claude" | Select-Object LastWriteTime
```

### Rollback to Previous Version

If an update causes issues:

```powershell
# List available backups
Get-ChildItem ".claude-backup"

# Restore from specific backup
$backupDate = "20241219-143022"
Remove-Item -Path ".claude" -Recurse -Force
Copy-Item -Path ".claude-backup\claude-backup-$backupDate" -Destination ".claude" -Recurse
```

---

## Security Considerations

### Private Repository Access

- This repository is private and requires authentication
- Personal Access Tokens are stored securely by Windows Credential Manager
- Only you can access your private repository
- Never share your Personal Access Token

### Script Execution

- The installer modifies files on your system
- Always review scripts before running
- Source code is available in the repository
- Run with least privilege (don't use Administrator unless needed)

### Data Privacy

- Your session memory files never leave your machine
- No telemetry or tracking
- All data stays local

---

## FAQ

**Q: Do I need to install on every computer?**
A: Yes, run the installer on each Windows machine where you want to use Claude commands.

**Q: Will updates overwrite my session history?**
A: No, the `.claude/memory/` directory is always preserved during updates.

**Q: Can I customize the commands?**
A: Yes, but customizations will be lost on update. Keep backups of your changes and reapply after updates.

**Q: How often should I update?**
A: Run the installer whenever you want the latest features. Check the repository for changelog.

**Q: Can I use this on Linux or Mac?**
A: This installer is Windows-only. For Linux/Mac, manually clone the repo and copy the `.claude` directory.

**Q: What if I have conflicts in my customizations?**
A: Backup your custom config files before updating, then manually merge changes after the update.

---

## Support

### Resources

- **Repository:** https://github.com/Tadzesi/claude-ideas
- **Documentation:** See `doc/` directory in repository
- **Library Guide:** `doc/Unified_Library_System_Guide.md`

### Getting Help

1. Check this guide first
2. Review troubleshooting section
3. Check repository Issues (if public access granted)
4. Contact repository owner

---

## Quick Reference

### Installation

```powershell
# Download and install
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-commands.ps1" -OutFile "install-claude-commands.ps1"
.\install-claude-commands.ps1
```

### Update

```powershell
# Just run the installer again
.\install-claude-commands.ps1
```

### Backup Your Memory

```powershell
# Manual backup before risky operations
Copy-Item ".claude\memory" "claude-memory-backup-$(Get-Date -Format 'yyyyMMdd')" -Recurse
```

### Restore from Backup

```powershell
# List backups
Get-ChildItem ".claude-backup"

# Restore specific backup
Remove-Item ".claude" -Recurse -Force
Copy-Item ".claude-backup\claude-backup-YYYYMMDD-HHMMSS" ".claude" -Recurse
```

---

**Installation complete! Enjoy your Claude commands library! 🚀**
