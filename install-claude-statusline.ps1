# Claude Code Statusline Installer
# Version: 1.0.0
# Description: Installs enhanced statusline with icons, colors, and comprehensive metrics
# Repository: https://github.com/Tadzesi/claude-ideas
# Platform: Windows PowerShell
#
# Features:
#   - Folder name and git branch with icons
#   - Context usage with color-coded progress bar
#   - Token counts (context and cumulative)
#   - Global API duration across all sessions with delta indicator
#
# Usage:
#   Direct from GitHub (no clone required):
#     iwr -useb https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-statusline.ps1 | iex
#
#   Local execution:
#     .\install-claude-statusline.ps1           # Install with prompts
#     .\install-claude-statusline.ps1 -Force    # Install without prompts
#     .\install-claude-statusline.ps1 -Uninstall # Remove configuration

param(
    [switch]$Force,      # Skip confirmation prompts
    [switch]$Uninstall   # Remove statusline configuration
)

$ErrorActionPreference = "Stop"

# --- Configuration ---
$RepoUrl = "https://raw.githubusercontent.com/Tadzesi/claude-ideas/main"
$StatuslineUrl = "$RepoUrl/.claude/scripts/statusline.ps1"
$claudeDir = Join-Path $env:USERPROFILE ".claude"
$targetStatusline = Join-Path $claudeDir "statusline.ps1"
$settingsFile = Join-Path $claudeDir "settings.json"

# --- ANSI Colors for Script Output ---
$esc = [char]27
$reset = "$esc[0m"
$cyan = "$esc[38;2;86;182;194m"
$green = "$esc[38;2;152;195;121m"
$yellow = "$esc[38;2;229;192;123m"
$red = "$esc[38;2;224;108;117m"
$gray = "$esc[38;2;150;150;150m"
$magenta = "$esc[38;2;198;120;221m"

# --- Helper Functions ---
function Write-Status($message, $type = "info") {
    switch ($type) {
        "success" { Write-Host "${green}[OK]${reset} $message" }
        "warning" { Write-Host "${yellow}[!]${reset} $message" }
        "error"   { Write-Host "${red}[X]${reset} $message" }
        default   { Write-Host "${cyan}[*]${reset} $message" }
    }
}

function Write-Header($text) {
    $line = "=" * ($text.Length + 6)
    Write-Host ""
    Write-Host "${magenta}$line${reset}"
    Write-Host "${magenta}== ${reset}$text${magenta} ==${reset}"
    Write-Host "${magenta}$line${reset}"
    Write-Host ""
}

function Write-Feature($icon, $text) {
    Write-Host "  ${cyan}$icon${reset} $text"
}

function Backup-File($filePath) {
    if (Test-Path $filePath) {
        $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
        $backupPath = "$filePath.backup-$timestamp"
        Copy-Item $filePath $backupPath
        Write-Status "Backed up: $(Split-Path -Leaf $filePath) -> $(Split-Path -Leaf $backupPath)" "success"
        return $backupPath
    }
    return $null
}

# --- Banner ---
Write-Host ""
Write-Host "${cyan}========================================================${reset}"
Write-Host "${cyan} Claude Code Statusline Installer v1.0.0${reset}"
Write-Host "${cyan} https://github.com/Tadzesi/claude-ideas${reset}"
Write-Host "${cyan}========================================================${reset}"
Write-Host ""

# --- Uninstall Mode ---
if ($Uninstall) {
    Write-Header "Claude Code Statusline Uninstaller"

    if (Test-Path $settingsFile) {
        try {
            $settings = Get-Content $settingsFile -Raw | ConvertFrom-Json
            if ($settings.statusLine) {
                # Backup before modifying
                Backup-File $settingsFile | Out-Null

                $settings.PSObject.Properties.Remove('statusLine')
                $jsonOutput = $settings | ConvertTo-Json -Depth 10
                [System.IO.File]::WriteAllText($settingsFile, $jsonOutput, [System.Text.UTF8Encoding]::new($false))
                Write-Status "Removed statusLine from settings.json" "success"
            } else {
                Write-Status "No statusLine configuration found" "warning"
            }
        } catch {
            Write-Status "Error reading settings: $_" "error"
        }
    } else {
        Write-Status "Settings file not found: $settingsFile" "warning"
    }

    # Remove the script file
    if (Test-Path $targetStatusline) {
        Remove-Item $targetStatusline -Force
        Write-Status "Removed statusline.ps1" "success"
    }

    # Remove state file
    $stateFile = Join-Path $claudeDir ".statusline-state.json"
    if (Test-Path $stateFile) {
        Remove-Item $stateFile -Force
        Write-Status "Removed state file" "success"
    }

    Write-Host ""
    Write-Status "Uninstall complete. Restart Claude Code to apply changes." "success"
    Write-Host ""
    exit 0
}

# --- Installation ---
Write-Header "Claude Code Statusline Setup"

Write-Host "This script will install an enhanced statusline with:"
Write-Host ""
Write-Feature ([char]0x25A0) "Folder name with icon (cyan)"
Write-Feature ([char]0x2387) "Git branch with icon (green)"
Write-Feature ([char]0x2588) "Context usage bar (color-coded: green/yellow/orange/red)"
Write-Feature ([char]0x25CF) "Context tokens display"
Write-Feature ([char]0x25B6) "Cumulative token counts"
Write-Feature ([char]0x25C6) "Global API duration with delta indicator"
Write-Host ""

# --- Display Paths ---
Write-Host "${gray}Installation paths:${reset}"
Write-Host "  Source:   $StatuslineUrl"
Write-Host "  Target:   $targetStatusline"
Write-Host "  Settings: $settingsFile"
Write-Host ""

# --- Confirmation ---
if (-not $Force) {
    $confirm = Read-Host "Proceed with installation? [Y/n]"
    if ($confirm -and $confirm -notmatch '^[Yy]') {
        Write-Status "Installation cancelled" "warning"
        exit 0
    }
    Write-Host ""
}

# --- Create .claude Directory ---
if (-not (Test-Path $claudeDir)) {
    New-Item -ItemType Directory -Path $claudeDir -Force | Out-Null
    Write-Status "Created directory: $claudeDir" "success"
}

# --- Backup Existing Files ---
Write-Status "Checking for existing files..."
$backupStatusline = Backup-File $targetStatusline
$backupSettings = Backup-File $settingsFile

# --- Download Statusline Script from GitHub ---
Write-Status "Downloading statusline.ps1 from GitHub..."
try {
    $statuslineContent = Invoke-WebRequest -Uri $StatuslineUrl -UseBasicParsing -ErrorAction Stop
    [System.IO.File]::WriteAllText($targetStatusline, $statuslineContent.Content, [System.Text.UTF8Encoding]::new($false))
    Write-Status "Downloaded and installed statusline.ps1" "success"
} catch {
    Write-Status "Failed to download statusline.ps1: $_" "error"
    Write-Host ""
    Write-Host "${yellow}Troubleshooting:${reset}"
    Write-Host "  1. Check your internet connection"
    Write-Host "  2. Try accessing the URL in a browser:"
    Write-Host "     $StatuslineUrl"
    Write-Host "  3. If the issue persists, clone the repository and run locally"
    Write-Host ""
    exit 1
}

# --- Configure Settings ---
Write-Status "Configuring Claude Code settings..."

# Load existing settings or create new
$settings = $null
if (Test-Path $settingsFile) {
    try {
        $existingContent = Get-Content $settingsFile -Raw -Encoding UTF8
        if ($existingContent -and $existingContent.Trim()) {
            $settings = $existingContent | ConvertFrom-Json
        }
    } catch {
        Write-Status "Could not parse existing settings, creating new" "warning"
    }
}

# Build the command string
$statusLineCommand = "powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"$targetStatusline`""

# Create or update settings object
if ($null -eq $settings) {
    # Create new settings object
    $settings = [PSCustomObject]@{
        statusLine = [PSCustomObject]@{
            type = "command"
            command = $statusLineCommand
        }
    }
} else {
    # Update existing settings - preserve other properties
    $statusLineObj = [PSCustomObject]@{
        type = "command"
        command = $statusLineCommand
    }

    if ($settings.statusLine) {
        $settings.statusLine = $statusLineObj
    } else {
        $settings | Add-Member -NotePropertyName "statusLine" -NotePropertyValue $statusLineObj -Force
    }
}

# Save settings (no BOM, proper formatting)
$jsonOutput = $settings | ConvertTo-Json -Depth 10
[System.IO.File]::WriteAllText($settingsFile, $jsonOutput, [System.Text.UTF8Encoding]::new($false))
Write-Status "Updated settings: $settingsFile" "success"

# --- Complete ---
Write-Header "Installation Complete"

Write-Host "${green}Statusline installed successfully!${reset}"
Write-Host ""
Write-Host "${cyan}Next steps:${reset}"
Write-Host "  1. Restart Claude Code to apply changes"
Write-Host "  2. The status bar will appear at the bottom of the terminal"
Write-Host ""
Write-Host "${cyan}Status line format:${reset}"
Write-Host "  ${cyan}[folder]${reset} ${gray}|${reset} ${green}[branch]${reset} ${gray}|${reset} [bar] ${gray}|${reset} [tokens] ${gray}|${reset} ${yellow}[api time]${reset}"
Write-Host ""
Write-Host "${cyan}Color coding for context bar:${reset}"
Write-Host "  ${green}Green${reset}  - 0-50% usage"
Write-Host "  ${yellow}Yellow${reset} - 50-75% usage"
Write-Host "  ${esc}[38;2;209;154;102mOrange${reset} - 75-90% usage"
Write-Host "  ${red}Red${reset}    - 90%+ usage"
Write-Host ""
Write-Host "${cyan}Commands:${reset}"
Write-Host "  ${gray}Update:${reset}    iwr -useb https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-statusline.ps1 | iex"
Write-Host "  ${gray}Uninstall:${reset} Run this script with -Uninstall flag"
Write-Host ""
