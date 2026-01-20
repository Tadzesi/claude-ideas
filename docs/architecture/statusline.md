# Enhanced Statusline

Real-time context tracking with visual progress bars, token usage, and API duration monitoring.

## What You Get

```
■ my-project | ⎇ main | ████████░░ 45.2% | ● 27k/155k | ▶ 89.2k/15.6k | ◆ 3.2s (+1.1s)
```

### Components

| Icon | Component | Description | Color |
|------|-----------|-------------|-------|
| ■ | Folder | Current working directory | Cyan |
| ⎇ | Branch | Git branch name | Green |
| ████ | Progress | Context usage bar | Green→Yellow→Orange→Red |
| ● | Context | Current / Usable max tokens | White |
| ▶ | Total | Session input / output tokens | White |
| ◆ | API Time | Cumulative time (+ last call) | Yellow |

### Color Coding

The progress bar changes color based on context usage:

| Usage | Color | Meaning |
|-------|-------|---------|
| 0-50% | Green | Plenty of room |
| 50-75% | Yellow | Moderate usage |
| 75-90% | Orange | Getting full |
| 90%+ | Red | Near limit, consider `/compact` |

## Installation

### Quick Install (Recommended)

```powershell
iwr -useb https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-statusline.ps1 | iex
```

Then restart Claude Code.

### Manual Installation

1. Create `.claude` directory in your user profile:
```powershell
New-Item -ItemType Directory -Path "$env:USERPROFILE\.claude" -Force
```

2. Download the statusline script:
```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/.claude/scripts/statusline.ps1" -OutFile "$env:USERPROFILE\.claude\statusline.ps1"
```

3. Create or edit `settings.json`:
```powershell
notepad "$env:USERPROFILE\.claude\settings.json"
```

4. Add this configuration:
```json
{
  "statusLine": {
    "type": "command",
    "command": "powershell.exe -NoProfile -ExecutionPolicy Bypass -File C:\\Users\\YOUR_USERNAME\\.claude\\statusline.ps1"
  }
}
```

::: warning
Replace `YOUR_USERNAME` with your actual Windows username.
:::

5. Restart Claude Code

## How It Works

### Trigger Mechanism

Claude Code has a built-in statusline hook. When configured:

```json
{
  "statusLine": {
    "type": "command",
    "command": "powershell.exe -NoProfile -ExecutionPolicy Bypass -File statusline.ps1"
  }
}
```

Claude Code executes this command **after each API response** and displays the output at the bottom of the terminal.

### Data Flow

```
┌─────────────┐     JSON via stdin     ┌──────────────────┐     stdout     ┌─────────────┐
│ Claude Code │ ──────────────────────>│ statusline.ps1   │ ─────────────> │  Terminal   │
│   (Host)    │                        │ (PowerShell)     │                │  Display    │
└─────────────┘                        └──────────────────┘                └─────────────┘
```

1. Claude Code pipes JSON data to the script via **stdin**
2. Script reads and parses the JSON
3. Script formats output with colors and icons
4. Claude Code displays it at terminal bottom

### JSON Data Structure

Claude Code provides this data:

```json
{
  "cwd": "C:\\Projects\\my-project",
  "session_id": "abc123",
  "context_window": {
    "context_window_size": 200000,
    "current_usage": {
      "input_tokens": 45000,
      "cache_creation_input_tokens": 0,
      "cache_read_input_tokens": 12000
    },
    "total_input_tokens": 89000,
    "total_output_tokens": 15000
  },
  "cost": {
    "total_api_duration_ms": 32000
  }
}
```

### Context Calculation

The statusline calculates context usage against **usable context**, not total:

| Model | Total | Reserved | Usable |
|-------|-------|----------|--------|
| Opus | 200k | 22.5% | 155k |
| Sonnet | 200k | ~20% | 160k |
| Haiku | 200k | ~15% | 170k |

This matches Claude's context warnings.

### API Duration Tracking

Tracks time spent in API calls:

- **Global cumulative**: Total time across all sessions
- **Delta indicator**: Time for last API call (+Xs)
- **Session detection**: Resets appropriately on new session

State stored in: `~\.claude\.statusline-state.json`

## Verification

After installation, verify:

```powershell
# Check script exists
Test-Path "$env:USERPROFILE\.claude\statusline.ps1"

# Check settings
Get-Content "$env:USERPROFILE\.claude\settings.json"
```

## Updating

Run the installer again:

```powershell
iwr -useb https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-statusline.ps1 | iex
```

Or with Force flag:

```powershell
.\install-claude-statusline.ps1 -Force
```

## Uninstallation

```powershell
.\install-claude-statusline.ps1 -Uninstall
```

Or manually remove `statusLine` from `settings.json`.

## Troubleshooting

### Statusline Not Appearing

1. Restart Claude Code after installation
2. Check `settings.json` has correct path (double backslashes)
3. Verify PowerShell execution policy allows scripts

### Shows "---%" on First Load

Normal before first API call. Will populate after sending a message.

### Download Fails

1. Check internet connection
2. Try URL directly in browser
3. Configure proxy if needed

### Backup and Restore

The installer creates timestamped backups:

```powershell
# List backups
Get-ChildItem "$env:USERPROFILE\.claude\*.backup*"

# Restore
Copy-Item "statusline.ps1.backup-XXXXXXXX-XXXXXX" "statusline.ps1" -Force
```

## Technical Details

### Files

| File | Location | Purpose |
|------|----------|---------|
| `install-claude-statusline.ps1` | Repository root | Installer |
| `statusline.ps1` | `.claude\scripts\` | Source script |
| `statusline.ps1` | `~\.claude\` | Installed script |
| `settings.json` | `~\.claude\` | Claude Code config |
| `.statusline-state.json` | `~\.claude\` | API duration state |

### State Persistence

```json
{
  "global_cumulative_ms": 180000,
  "last_session_total_ms": 32000,
  "last_call_ms": 1100,
  "session_id": "abc123"
}
```

Enables:
- Global cumulative time across sessions
- Delta indicator for last call
- Session detection by ID change

## Known Limitations

::: info
The context percentage is an approximation. Claude Code's statusline JSON provides cumulative session tokens, not actual context window usage. The `/context` command shows accurate values.
:::

## Related

- [Installation](/getting-started/installation) - Full library setup
- [Configuration](/reference/configuration) - All config options
