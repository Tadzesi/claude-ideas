# Claude Code Statusline Setup Script
# Installs enhanced statusline with folder, git, tokens, and API duration
# Usage: .\setup-statusline.ps1

param(
    [switch]$Force,      # Skip confirmation prompts
    [switch]$Uninstall   # Remove statusline configuration
)

$ErrorActionPreference = "Stop"

# --- Configuration ---
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$sourceStatusline = Join-Path $scriptDir "statusline.ps1"
$claudeDir = Join-Path $env:USERPROFILE ".claude"
$targetStatusline = Join-Path $claudeDir "statusline.ps1"
$settingsFile = Join-Path $claudeDir "settings.json"

# --- Helper Functions ---
function Write-Status($message, $type = "info") {
    switch ($type) {
        "success" { Write-Host "[OK] $message" -ForegroundColor Green }
        "warning" { Write-Host "[!] $message" -ForegroundColor Yellow }
        "error"   { Write-Host "[X] $message" -ForegroundColor Red }
        default   { Write-Host "[*] $message" -ForegroundColor Cyan }
    }
}

function Backup-File($filePath) {
    if (Test-Path $filePath) {
        $backupPath = "$filePath.backup"
        $counter = 1
        while (Test-Path $backupPath) {
            $backupPath = "$filePath.backup.$counter"
            $counter++
        }
        Copy-Item $filePath $backupPath
        Write-Status "Backed up: $filePath -> $backupPath" "success"
        return $true
    }
    return $false
}

# --- Uninstall Mode ---
if ($Uninstall) {
    Write-Host ""
    Write-Host "=== Claude Code Statusline Uninstaller ===" -ForegroundColor Magenta
    Write-Host ""

    if (Test-Path $settingsFile) {
        $settings = Get-Content $settingsFile -Raw | ConvertFrom-Json
        if ($settings.statusLine) {
            $settings.PSObject.Properties.Remove('statusLine')
            $settings | ConvertTo-Json -Depth 10 | Set-Content $settingsFile -Encoding UTF8
            Write-Status "Removed statusLine from settings.json" "success"
        } else {
            Write-Status "No statusLine configuration found" "warning"
        }
    }

    Write-Host ""
    Write-Status "Uninstall complete. Restart Claude Code to apply changes." "success"
    Write-Host ""
    exit 0
}

# --- Installation ---
Write-Host ""
Write-Host "=== Claude Code Statusline Setup ===" -ForegroundColor Magenta
Write-Host ""
Write-Host "This script will install an enhanced statusline with:"
Write-Host "  - Folder name and git branch"
Write-Host "  - Context usage progress bar"
Write-Host "  - Token counts (current and total)"
Write-Host "  - API call duration"
Write-Host ""

# --- Verify Source File ---
if (-not (Test-Path $sourceStatusline)) {
    Write-Status "Source statusline.ps1 not found at: $sourceStatusline" "error"
    Write-Status "Make sure you're running this script from the .claude directory" "error"
    exit 1
}

# --- Create .claude Directory ---
if (-not (Test-Path $claudeDir)) {
    New-Item -ItemType Directory -Path $claudeDir -Force | Out-Null
    Write-Status "Created directory: $claudeDir" "success"
}

# --- Confirmation ---
if (-not $Force) {
    Write-Host "Target location: $targetStatusline"
    Write-Host "Settings file:   $settingsFile"
    Write-Host ""
    $confirm = Read-Host "Proceed with installation? (Y/n)"
    if ($confirm -and $confirm -notmatch '^[Yy]') {
        Write-Status "Installation cancelled" "warning"
        exit 0
    }
    Write-Host ""
}

# --- Backup Existing Files ---
Write-Status "Checking for existing files..."
Backup-File $targetStatusline
Backup-File $settingsFile

# --- Copy Statusline Script ---
Write-Status "Installing statusline.ps1..."
Copy-Item $sourceStatusline $targetStatusline -Force
Write-Status "Copied statusline to: $targetStatusline" "success"

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

# Build the command string (no manual escaping - ConvertTo-Json handles it)
$statusLineCommand = "powershell.exe -NoProfile -ExecutionPolicy Bypass -File $targetStatusline"

# Create or update settings object
if ($null -eq $settings) {
    # Create new settings object
    $settings = [PSCustomObject]@{
        enabledPlugins = [PSCustomObject]@{}
        statusLine = [PSCustomObject]@{
            type = "command"
            command = $statusLineCommand
        }
    }
} else {
    # Update existing settings - preserve other properties
    if (-not $settings.enabledPlugins) {
        $settings | Add-Member -NotePropertyName "enabledPlugins" -NotePropertyValue ([PSCustomObject]@{}) -Force
    }

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
Write-Host ""
Write-Host "=== Installation Complete ===" -ForegroundColor Green
Write-Host ""
Write-Host "Statusline installed successfully!"
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Restart Claude Code to apply changes"
Write-Host "  2. The status bar will show at the bottom of the terminal"
Write-Host ""
Write-Host "Features:"
Write-Host "  - Folder and git branch display"
Write-Host "  - Context usage with progress bar"
Write-Host "  - API duration shows response time"
Write-Host ""
Write-Host "To uninstall: .\setup-statusline.ps1 -Uninstall"
Write-Host ""
