# Enhanced Statusline

Enhanced statusline for Claude Code with icons, colors, and comprehensive metrics.

## What You Get

```
■ claude-ideas | ⎇ main | ████████░░ 45.2% | ● 90.4k/200k | ▶ 89.2k/15.6k | ◆ 3.2s (+1.1s)
```

### Components

| Icon | Component | Description |
|------|-----------|-------------|
| ■ | Folder name | Current working directory (cyan) |
| ⎇ | Git branch | Current branch (green) |
| ████ | Progress bar | Visual context usage (color-coded) |
| ● | Context | Current context tokens / usable max |
| ▶ | Total | Cumulative session tokens (input/output) |
| ◆ | API duration | Global cumulative time with delta (+last call) |

### Color Coding

The context progress bar changes color based on usage:

- **Green** (0-50%) - Plenty of room
- **Yellow** (50-75%) - Moderate usage
- **Orange** (75-90%) - Getting full
- **Red** (90%+) - Near limit

## Prerequisites

- Windows 10/11
- PowerShell 5.1 or later (pre-installed on Windows)
- Claude Code CLI installed

## Quick Install

Run this command in PowerShell - no need to clone the repository:

```powershell
iwr -useb https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-statusline.ps1 | iex
```

Then restart Claude Code.

## Installation Methods

### Method 1: One-Line Install (Recommended)

```powershell
iwr -useb https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-statusline.ps1 | iex
```

### Method 2: Download and Run

1. Download the installer:
   ```powershell
   Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-statusline.ps1" -OutFile "install-claude-statusline.ps1"
   ```

2. Run the installer:
   ```powershell
   .\install-claude-statusline.ps1
   ```

3. Restart Claude Code

### Method 3: From Cloned Repository

If you already have the repository cloned:

```powershell
cd claude-ideas
.\install-claude-statusline.ps1
```

### Method 4: Manual Installation

1. Create the `.claude` directory in your user profile:
   ```powershell
   New-Item -ItemType Directory -Path "$env:USERPROFILE\.claude" -Force
   ```

2. Download `statusline.ps1` to your `.claude` directory:
   ```powershell
   Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/.claude/scripts/statusline.ps1" -OutFile "$env:USERPROFILE\.claude\statusline.ps1"
   ```

3. Create or edit `settings.json` in your `.claude` directory:
   ```powershell
   notepad "$env:USERPROFILE\.claude\settings.json"
   ```

4. Add this configuration (or merge with existing settings):
   ```json
   {
     "statusLine": {
       "type": "command",
       "command": "powershell.exe -NoProfile -ExecutionPolicy Bypass -File C:/Users/YOUR_USERNAME/.claude/statusline.ps1"
     }
   }
   ```

   ::: warning
   Replace `YOUR_USERNAME` with your actual Windows username. Use **forward slashes** (`/`) in the path — Claude Code uses bash internally on Windows, and backslashes are silently dropped, causing the statusline to not appear.
   :::

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

## Updating

To update to the latest version, simply run the installer again:

```powershell
iwr -useb https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-statusline.ps1 | iex
```

Or with Force flag (skips confirmation):

```powershell
.\install-claude-statusline.ps1 -Force
```

## Uninstallation

Download and run the installer with the `-Uninstall` flag:

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-statusline.ps1" -OutFile "install-claude-statusline.ps1"
.\install-claude-statusline.ps1 -Uninstall
```

Or manually remove the `statusLine` section from `settings.json`.

## How It Works

### Trigger Mechanism

Claude Code has a built-in statusline hook. When configured in `settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "powershell.exe -NoProfile -ExecutionPolicy Bypass -File statusline.ps1"
  }
}
```

Claude Code automatically executes this command **after each API response** and displays the output at the bottom of the terminal.

### Data Flow

```
┌─────────────┐     JSON via stdin     ┌──────────────────┐     stdout     ┌─────────────┐
│ Claude Code │ ──────────────────────>│ statusline.ps1   │ ─────────────> │  Terminal   │
│   (Host)    │                        │ (PowerShell)     │                │  Display    │
└─────────────┘                        └──────────────────┘                └─────────────┘
```

1. Claude Code pipes JSON data to the script via **stdin**
2. Script reads: `$jsonInput = [Console]::In.ReadToEnd()`
3. Script parses: `$data = $jsonInput | ConvertFrom-Json`
4. Script outputs formatted string to **stdout**
5. Claude Code displays it at bottom of terminal

### JSON Data Structure

Claude Code provides this JSON structure to the statusline script:

```json
{
  "cwd": "C:\\Projects\\my-project",
  "session_id": "abc123",
  "context_window": {
    "context_window_size": 200000,
    "used_percentage": 45.2,
    "remaining_percentage": 54.8,
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

### Data Sources

| Field | Source | Description |
|-------|--------|-------------|
| `cwd` | Claude Code | Current working directory |
| `session_id` | Claude Code | Unique session identifier |
| `context_window_size` | Claude Code | Total context window (200k) |
| `used_percentage` | Claude Code | Approximate usage % (excludes system prompt + tool overhead) |
| `current_usage.input_tokens` | Last API call | Tokens in last request |
| `total_input_tokens` | Claude Code | Cumulative input tokens |
| `total_output_tokens` | Claude Code | Cumulative output tokens |
| `total_api_duration_ms` | Claude Code | Session API time (ms) |
| Git branch | Local git | Retrieved via `git rev-parse` |

### State Persistence

API duration tracking across sessions uses a state file:

**Location:** `~\.claude\.statusline-state.json`

```json
{
  "global_cumulative_ms": 180000,
  "last_session_total_ms": 32000,
  "last_call_ms": 1100,
  "session_id": "abc123"
}
```

This enables:
- **Global cumulative time** - Total API time across all sessions
- **Delta indicator** - Time spent in the last API call (+Xs)
- **Session detection** - Detects new sessions by ID change or time reset

## Technical Details

### Context Calculation

The statusline uses **`context_window.used_percentage`** directly from Claude Code's JSON. This is an **approximation** — the field excludes system prompt tokens, Claude Code's built-in tool definitions, and MCP tool schemas (e.g., playwright, claude-in-chrome). Actual context usage is typically **10–20% higher** than displayed, and the `~` prefix on the percentage reflects this.

Color thresholds are shifted down by 15% relative to actual usage thresholds to compensate for the known under-reporting.

**Fallback chain** (when `used_percentage` is unavailable):
1. `current_usage` tokens / `context_window_size`
2. `total_input_tokens` / `context_window_size`

**Autocompact** triggers at **~95%** of the context window by default. Customize with:
```bash
CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=80  # trigger at 80%
```

The denominator in the token display is always the full `context_window_size` (200k), not an artificially reduced "usable" value.

### API Duration Tracking

The statusline tracks API duration across all sessions:

- **Global cumulative**: Total time spent in API calls across all sessions
- **Delta indicator**: Time spent in the last API call (+Xs)
- **Session detection**: Automatically resets delta on new session

State is stored in `~\.claude\.statusline-state.json`.

### Files

| File | Location | Purpose |
|------|----------|---------|
| `install-claude-statusline.ps1` | Repository root | Installer script |
| `statusline.ps1` | `.claude\scripts\` | Source statusline script |
| `statusline.ps1` | `~\.claude\` | Installed script (user home) |
| `settings.json` | `~\.claude\` | Claude Code configuration |
| `.statusline-state.json` | `~\.claude\` | API duration state |

## Troubleshooting

### Statusline not appearing

1. Ensure Claude Code is restarted after installation
2. Check that `settings.json` uses **forward slashes** (`/`) in the path — backslashes are silently dropped by Claude Code's bash shell on Windows, causing the script to not run at all
3. Verify PowerShell execution policy: `Get-ExecutionPolicy` (must be `RemoteSigned` or `Unrestricted`)

### Context shows "---%" on first load

This is normal before the first API call. After sending your first message, the context percentage will appear.

### Download fails

1. Check your internet connection
2. Try accessing the URL directly in a browser
3. If behind a proxy, configure PowerShell proxy settings

### Backup and Restore

The installer automatically creates timestamped backup files before overwriting:
- `statusline.ps1.backup-YYYYMMDD-HHMMSS`
- `settings.json.backup-YYYYMMDD-HHMMSS`

To restore:

```powershell
# List backups
Get-ChildItem "$env:USERPROFILE\.claude\*.backup*"

# Restore specific backup
Copy-Item "$env:USERPROFILE\.claude\statusline.ps1.backup-XXXXXXXX-XXXXXX" "$env:USERPROFILE\.claude\statusline.ps1" -Force
```

## Known Limitations

::: warning Context percentage is an approximation
`used_percentage` from the statusline JSON excludes system prompt, Claude Code tool definitions, and MCP tool schemas (playwright, claude-in-chrome, etc. can add 10–20% of overhead not counted). The `~` prefix on the displayed percentage and the downward-shifted color thresholds help compensate. For precise values, use `/context` inside Claude Code.
:::
