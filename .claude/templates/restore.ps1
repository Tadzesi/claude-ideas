# restore.ps1 — New PC restore script for claude-personal repo
# Run from the root of the cloned claude-personal repo

$ErrorActionPreference = "Stop"
$claudeDir = Join-Path $env:USERPROFILE ".claude"
$memoryDir = Join-Path $claudeDir "memory"

Write-Host "Restoring personal Claude config..." -ForegroundColor Cyan

# Create directories if missing
if (-not (Test-Path $memoryDir)) {
    New-Item -ItemType Directory -Path $memoryDir -Force | Out-Null
    Write-Host "[OK] Created $memoryDir" -ForegroundColor Green
}

# Copy personal-profile.md
$src = Join-Path $PSScriptRoot "memory\personal-profile.md"
$dst = Join-Path $memoryDir "personal-profile.md"

if (Test-Path $src) {
    Copy-Item $src $dst -Force
    Write-Host "[OK] Restored personal-profile.md to $dst" -ForegroundColor Green
} else {
    Write-Host "[!] personal-profile.md not found in repo" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Restore complete." -ForegroundColor Green
Write-Host "Restart Claude Code for changes to take effect." -ForegroundColor Cyan
