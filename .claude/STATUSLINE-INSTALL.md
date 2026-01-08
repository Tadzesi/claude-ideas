# Claude Code Statusline Installation Guide

Enhanced statusline for Claude Code displaying folder, git branch, context usage, tokens, and last API response time.

## What You Get

```
claude-ideas | [main] | ████████░░ 78.5% | In:12.3k Out:2.1k | Total:89.2k/15.6k | API:3.2s
```

Components:
- **Folder name** - Current working directory
- **Git branch** - Current branch in brackets
- **Progress bar** - Visual context window usage
- **Context %** - Percentage of context used
- **In/Out tokens** - Current request tokens
- **Total tokens** - Cumulative session tokens
- **API duration** - Last API call response time (not cumulative)

## Prerequisites

- Windows 10/11
- PowerShell 5.1 or later (pre-installed on Windows)
- Claude Code CLI installed

## Installation Methods

### Method 1: Automatic (Recommended)

1. Download or clone this repository:
   ```powershell
   git clone https://github.com/Tadzesi/claude-ideas.git
   cd claude-ideas
   ```

2. Run the setup script:
   ```powershell
   .\.claude\setup-statusline.ps1
   ```

3. Restart Claude Code

### Method 2: Manual Installation

1. Create the `.claude` directory in your user profile (if it doesn't exist):
   ```powershell
   New-Item -ItemType Directory -Path "$env:USERPROFILE\.claude" -Force
   ```

2. Copy `statusline.ps1` to your `.claude` directory:
   ```powershell
   Copy-Item ".\.claude\statusline.ps1" "$env:USERPROFILE\.claude\statusline.ps1"
   ```

3. Create or edit `settings.json` in your `.claude` directory:
   ```powershell
   notepad "$env:USERPROFILE\.claude\settings.json"
   ```

4. Add this configuration (or merge with existing settings):
   ```json
   {
     "enabledPlugins": {},
     "statusLine": {
       "type": "command",
       "command": "powershell.exe -NoProfile -ExecutionPolicy Bypass -File C:\\Users\\YOUR_USERNAME\\.claude\\statusline.ps1"
     }
   }
   ```

   **Important:** Replace `YOUR_USERNAME` with your actual Windows username.

5. Restart Claude Code

## Verification

After restarting Claude Code, you should see the statusline at the bottom of the terminal.

To verify the installation:
```powershell
# Check if statusline.ps1 exists
Test-Path "$env:USERPROFILE\.claude\statusline.ps1"

# Check if settings.json has statusLine configured
Get-Content "$env:USERPROFILE\.claude\settings.json"
```

## Uninstallation

Run the setup script with the `-Uninstall` flag:
```powershell
.\.claude\setup-statusline.ps1 -Uninstall
```

Or manually remove the `statusLine` section from `settings.json`.

## Troubleshooting

### Statusline not appearing
1. Ensure Claude Code is restarted after installation
2. Check that `settings.json` has correct path (double backslashes in JSON)
3. Verify PowerShell execution policy allows script execution

### API duration shows large number on first call
This is normal. The first call after restart shows total (no previous value to calculate difference). Subsequent calls show only the last response time.

### State file location
The script stores the previous API duration in:
```
~\.claude\.statusline-state
```
This file is automatically created and can be safely deleted.

## Files

| File | Location | Purpose |
|------|----------|---------|
| `statusline.ps1` | `~\.claude\` | Main statusline script |
| `settings.json` | `~\.claude\` | Claude Code configuration |
| `.statusline-state` | `~\.claude\` | Stores previous API duration for calculation |

## Backup

The setup script automatically creates `.backup` files before overwriting:
- `statusline.ps1.backup`
- `settings.json.backup`

To restore:
```powershell
Copy-Item "$env:USERPROFILE\.claude\statusline.ps1.backup" "$env:USERPROFILE\.claude\statusline.ps1" -Force
Copy-Item "$env:USERPROFILE\.claude\settings.json.backup" "$env:USERPROFILE\.claude\settings.json" -Force
```
