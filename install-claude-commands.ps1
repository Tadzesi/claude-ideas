# Claude Commands Library Installer
# Version: 4.2.0
# Description: Installs/updates Claude commands and libraries from GitHub repository (v4.2 with AI Fluency Framework)
# Repository: https://github.com/Tadzesi/claude-ideas
# Platform: Windows PowerShell

<#
.SYNOPSIS
    Installs or updates Claude commands library from GitHub repository.

.DESCRIPTION
    This script clones or updates the claude-ideas repository and deploys the .claude directory
    to your local machine. It preserves user data (memory files) during updates and creates
    backups before making changes.

.PARAMETER InstallPath
    Target directory for installation. Default: Current directory

.PARAMETER SkipBackup
    Skip creating backup before update

.PARAMETER Force
    Force reinstall even if already installed

.EXAMPLE
    .\install-claude-commands.ps1
    Standard installation to current directory

.EXAMPLE
    .\install-claude-commands.ps1 -InstallPath "C:\MyProjects" -Force
    Force reinstall to specific directory
#>

param(
    [string]$InstallPath = $PWD.Path,
    [switch]$SkipBackup = $false,
    [switch]$Force = $false
)

# Configuration
$RepoUrl = "https://github.com/Tadzesi/claude-ideas.git"
$RepoName = "claude-ideas"
$ClaudeDir = ".claude"
$TempDir = Join-Path $env:TEMP "claude-commands-temp"
$BackupDir = Join-Path $InstallPath ".claude-backup"

# Colors for output
function Write-Success { param($Message) Write-Host "[OK] $Message" -ForegroundColor Green }
function Write-Error { param($Message) Write-Host "[ERROR] $Message" -ForegroundColor Red }
function Write-Info { param($Message) Write-Host "[INFO] $Message" -ForegroundColor Cyan }
function Write-Warning { param($Message) Write-Host "[WARNING] $Message" -ForegroundColor Yellow }

# Banner
Write-Host "`n========================================================" -ForegroundColor Cyan
Write-Host " Claude Commands Library Installer v4.2.0" -ForegroundColor Cyan
Write-Host " https://github.com/Tadzesi/claude-ideas" -ForegroundColor Cyan
Write-Host "========================================================`n" -ForegroundColor Cyan

# Check if Git is installed
function Test-GitInstalled {
    try {
        $null = git --version
        return $true
    } catch {
        return $false
    }
}

# Check if GitHub authentication is configured
function Test-GitHubAuth {
    try {
        $result = git ls-remote $RepoUrl 2>&1
        return $LASTEXITCODE -eq 0
    } catch {
        return $false
    }
}

# Create backup of existing .claude directory
function Backup-ClaudeDirectory {
    param([string]$SourcePath)

    if (-not (Test-Path $SourcePath)) {
        Write-Info "No existing installation found. Skipping backup."
        return $true
    }

    if ($SkipBackup) {
        Write-Warning "Skipping backup (-SkipBackup flag set)"
        return $true
    }

    Write-Info "Creating backup..."

    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $backupPath = Join-Path $BackupDir "claude-backup-$timestamp"

    try {
        if (-not (Test-Path $BackupDir)) {
            New-Item -ItemType Directory -Path $BackupDir -Force | Out-Null
        }

        Copy-Item -Path $SourcePath -Destination $backupPath -Recurse -Force
        Write-Success "Backup created: $backupPath"
        return $true
    } catch {
        Write-Error "Backup failed: $_"
        return $false
    }
}

# Clone or pull repository
function Get-Repository {
    param([string]$TempPath)

    $repoPath = Join-Path $TempPath $RepoName

    if (Test-Path $repoPath) {
        Write-Info "Repository exists. Pulling latest changes..."
        Push-Location $repoPath
        try {
            git pull origin main 2>&1 | Out-Null
            if ($LASTEXITCODE -eq 0) {
                Write-Success "Repository updated to latest version"
                Pop-Location
                return $repoPath
            } else {
                Write-Warning "Git pull failed. Removing and re-cloning..."
                Pop-Location
                Remove-Item -Path $repoPath -Recurse -Force
            }
        } catch {
            Pop-Location
            Write-Warning "Error during pull: $_"
        }
    }

    Write-Info "Cloning repository..."
    try {
        git clone $RepoUrl $repoPath 2>&1 | Out-Null
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Repository cloned successfully"
            return $repoPath
        } else {
            Write-Error "Git clone failed. Check your GitHub authentication."
            return $null
        }
    } catch {
        Write-Error "Clone failed: $_"
        return $null
    }
}

# Deploy .claude directory
function Deploy-ClaudeDirectory {
    param(
        [string]$SourcePath,
        [string]$TargetPath
    )

    $sourceClaudeDir = Join-Path $SourcePath $ClaudeDir
    $targetClaudeDir = Join-Path $TargetPath $ClaudeDir

    if (-not (Test-Path $sourceClaudeDir)) {
        Write-Error ".claude directory not found in repository"
        return $false
    }

    Write-Info "Deploying Claude commands..."

    try {
        # Preserve existing memory directory
        $memoryBackup = $null
        $targetMemoryDir = Join-Path $targetClaudeDir "memory"

        if (Test-Path $targetMemoryDir) {
            Write-Info "Preserving existing memory files..."
            $memoryBackup = Join-Path $env:TEMP "claude-memory-backup-$(Get-Date -Format 'yyyyMMddHHmmss')"
            Copy-Item -Path $targetMemoryDir -Destination $memoryBackup -Recurse -Force
        }

        # Deploy directories that should be updated
        $directoriesToDeploy = @("commands", "library", "config", "rules", "scripts", "docs")

        # Create parent directory if needed
        if (-not (Test-Path $targetClaudeDir)) {
            New-Item -ItemType Directory -Path $targetClaudeDir -Force | Out-Null
        }

        foreach ($dir in $directoriesToDeploy) {
            $sourceDir = Join-Path $sourceClaudeDir $dir
            $targetDir = Join-Path $targetClaudeDir $dir

            if (Test-Path $sourceDir) {
                Write-Info "Deploying $dir..."

                # Remove old directory if exists
                if (Test-Path $targetDir) {
                    Remove-Item -Path $targetDir -Recurse -Force
                }

                # Copy new directory
                Copy-Item -Path $sourceDir -Destination $targetDir -Recurse -Force
                Write-Success "$dir deployed"
            } else {
                Write-Warning "$dir not found in repository"
            }
        }

        # Deploy CLAUDE.md file (memory imports)
        $sourceClaudeMd = Join-Path $sourceClaudeDir "CLAUDE.md"
        $targetClaudeMd = Join-Path $targetClaudeDir "CLAUDE.md"
        if (Test-Path $sourceClaudeMd) {
            Copy-Item -Path $sourceClaudeMd -Destination $targetClaudeMd -Force
            Write-Success "CLAUDE.md deployed"
        }

        # Clean up directories that should not exist (removed in newer versions)
        $obsoleteDirs = @("skills", "tasks")
        foreach ($dir in $obsoleteDirs) {
            $obsoleteDir = Join-Path $targetClaudeDir $dir
            if (Test-Path $obsoleteDir) {
                Write-Info "Removing obsolete directory: $dir..."
                Remove-Item -Path $obsoleteDir -Recurse -Force
                Write-Success "Removed obsolete: $dir"
            }
        }

        # Clear cache on update to avoid stale results
        $targetCacheDir = Join-Path $targetClaudeDir "cache"
        if (Test-Path $targetCacheDir) {
            Write-Info "Clearing cache for fresh start..."
            Remove-Item -Path $targetCacheDir -Recurse -Force
            New-Item -ItemType Directory -Path $targetCacheDir -Force | Out-Null
            Write-Success "Cache cleared"
        }

        # Restore memory directory
        if ($memoryBackup -and (Test-Path $memoryBackup)) {
            Write-Info "Restoring memory files..."
            if (Test-Path $targetMemoryDir) {
                Remove-Item -Path $targetMemoryDir -Recurse -Force
            }
            Copy-Item -Path $memoryBackup -Destination $targetMemoryDir -Recurse -Force
            Remove-Item -Path $memoryBackup -Recurse -Force
            Write-Success "Memory files restored"
        } else {
            # Create memory directory if it doesn't exist
            if (-not (Test-Path $targetMemoryDir)) {
                New-Item -ItemType Directory -Path $targetMemoryDir -Force | Out-Null
                Write-Success "Memory directory created"
            }
        }

        # Create version file to track installed version
        $versionFile = Join-Path $targetClaudeDir "VERSION"
        "4.2.0" | Out-File -FilePath $versionFile -Encoding UTF8 -NoNewline
        Write-Success "Version file created (v4.2.0)"

        return $true
    } catch {
        Write-Error "Deployment failed: $_"
        return $false
    }
}

# Verify installation
function Test-Installation {
    param([string]$TargetPath)

    $targetClaudeDir = Join-Path $TargetPath $ClaudeDir

    Write-Info "Verifying installation..."

    $requiredDirs = @("commands", "library", "config", "rules")
    $missingDirs = @()

    foreach ($dir in $requiredDirs) {
        $dirPath = Join-Path $targetClaudeDir $dir
        if (-not (Test-Path $dirPath)) {
            $missingDirs += $dir
        }
    }

    if ($missingDirs.Count -gt 0) {
        Write-Error "Verification failed. Missing directories: $($missingDirs -join ', ')"
        return $false
    }

    # Check for key files
    $coreLibrary = Join-Path $targetClaudeDir "library\prompt-perfection-core.md"
    if (-not (Test-Path $coreLibrary)) {
        Write-Error "Core library not found: $coreLibrary"
        return $false
    }

    # Check version file
    $versionFile = Join-Path $targetClaudeDir "VERSION"
    if (Test-Path $versionFile) {
        $installedVersion = Get-Content $versionFile -Raw
        Write-Info "Installed version: $installedVersion"
    }

    # Count commands
    $commandsDir = Join-Path $targetClaudeDir "commands"
    $commandCount = (Get-ChildItem -Path $commandsDir -Filter "*.md" | Measure-Object).Count

    if ($commandCount -eq 0) {
        Write-Error "No command files found"
        return $false
    }

    Write-Success "Verification passed"
    Write-Info "  - Found $commandCount command(s)"
    Write-Info "  - Core library: OK"
    Write-Info "  - Directory structure: OK"

    return $true
}

# Show installation summary
function Show-Summary {
    param([string]$TargetPath)

    $targetClaudeDir = Join-Path $TargetPath $ClaudeDir

    Write-Host "`n========================================================" -ForegroundColor Green
    Write-Host " Installation Summary" -ForegroundColor Green
    Write-Host "========================================================`n" -ForegroundColor Green

    Write-Host "Installation Path: " -NoNewline
    Write-Host "$targetClaudeDir" -ForegroundColor Yellow

    Write-Host "`nInstalled Components:" -ForegroundColor Cyan

    # Commands
    $commandsDir = Join-Path $targetClaudeDir "commands"
    $commands = Get-ChildItem -Path $commandsDir -Filter "*.md" -ErrorAction SilentlyContinue
    Write-Host "  Commands: " -NoNewline
    Write-Host "$($commands.Count)" -ForegroundColor Yellow
    foreach ($cmd in $commands) {
        Write-Host "    - $($cmd.BaseName)" -ForegroundColor Gray
    }

    # Library
    $libraryDir = Join-Path $targetClaudeDir "library"
    Write-Host "`n  Library:" -ForegroundColor Cyan
    Write-Host "    - prompt-perfection-core.md" -ForegroundColor Gray

    $adaptersDir = Join-Path $libraryDir "adapters"
    if (Test-Path $adaptersDir) {
        $adapters = Get-ChildItem -Path $adaptersDir -Filter "*.md"
        Write-Host "    Adapters: $($adapters.Count)" -ForegroundColor Gray
        foreach ($adapter in $adapters) {
            Write-Host "      - $($adapter.BaseName)" -ForegroundColor DarkGray
        }
    }

    # Memory
    $memoryDir = Join-Path $targetClaudeDir "memory"
    if (Test-Path $memoryDir) {
        $memoryFiles = Get-ChildItem -Path $memoryDir -File
        Write-Host "`n  Memory Files: " -NoNewline
        Write-Host "$($memoryFiles.Count)" -ForegroundColor Yellow
    }

    Write-Host "`n" -NoNewline
    Write-Success "Installation complete!"

    # v4.2 Feature Announcement
    Write-Host "`n========================================" -ForegroundColor Magenta
    Write-Host "  NEW IN VERSION 4.2 (January 2026)" -ForegroundColor Magenta
    Write-Host "========================================" -ForegroundColor Magenta
    Write-Host "`nAI Fluency Framework Alignment:" -ForegroundColor White
    Write-Host "  - NEW: Full alignment with Anthropic's 4Ds Model" -ForegroundColor Green
    Write-Host "  - Delegation Check (Step 0.11) - Task appropriateness" -ForegroundColor Gray
    Write-Host "  - Post-Execution Evaluation (Step 0.7) - Feedback loop" -ForegroundColor Gray
    Write-Host "  - Diligence Reminders - Responsibility awareness" -ForegroundColor Gray
    Write-Host "  - Common Mistakes & AI Limitations awareness" -ForegroundColor Gray
    Write-Host "`nFrom v4.1: Skill Reflection System" -ForegroundColor White
    Write-Host "  - /reflect - Active skill improvement from feedback" -ForegroundColor Gray
    Write-Host "  - Signal detection and priority-coded proposals" -ForegroundColor Gray
    Write-Host "`nFrom v4.0: Predictive Intelligence System" -ForegroundColor White
    Write-Host "  - See 2 steps ahead with proactive guidance" -ForegroundColor Gray
    Write-Host "  - Journey stage detection and domain risk analysis" -ForegroundColor Gray
    Write-Host "`nFrom v3.0: Multi-Agent Research System" -ForegroundColor White
    Write-Host "  - /prompt-research (deep multi-agent analysis)" -ForegroundColor Gray
    Write-Host "`nSee .claude/docs/ for detailed release notes" -ForegroundColor Cyan
    Write-Host "========================================`n" -ForegroundColor Magenta

    Write-Host "`nNext Steps:" -ForegroundColor Cyan
    Write-Host "  1. Navigate to your project directory" -ForegroundColor Gray
    Write-Host "  2. Use Claude Code with your custom commands" -ForegroundColor Gray
    Write-Host "  3. Run this script again to update to the latest version" -ForegroundColor Gray

    Write-Host "`nAvailable Commands:" -ForegroundColor Cyan
    Write-Host "  /prompt           - Basic prompt perfection with AI Fluency (v4.2)" -ForegroundColor Gray
    Write-Host "  /prompt-hybrid    - Advanced with AI Fluency + predictive intelligence (v4.2)" -ForegroundColor Gray
    Write-Host "  /prompt-technical - Technical analysis with predictive intelligence" -ForegroundColor Gray
    Write-Host "  /prompt-research  - Deep multi-agent research with Delegation (v4.2)" -ForegroundColor Gray
    Write-Host "  /prompt-article   - Article creation wizard" -ForegroundColor Gray
    Write-Host "  /reflect          - Skill reflection and improvement (v4.1)" -ForegroundColor Gray
    Write-Host "  /session-start    - Load session context" -ForegroundColor Gray
    Write-Host "  /session-end      - Save session context with Diligence tracking (v4.2)" -ForegroundColor Gray

    Write-Host ""
}

# Cleanup temp directory
function Remove-TempFiles {
    param([string]$TempPath)

    if (Test-Path $TempPath) {
        try {
            Remove-Item -Path $TempPath -Recurse -Force -ErrorAction SilentlyContinue
            Write-Info "Temporary files cleaned up"
        } catch {
            Write-Warning "Could not remove temp directory: $TempPath"
        }
    }
}

# Main installation flow
function Install-ClaudeCommands {
    Write-Info "Starting installation process..."
    Write-Info "Install path: $InstallPath"

    # Check prerequisites
    Write-Info "Checking prerequisites..."

    if (-not (Test-GitInstalled)) {
        Write-Error "Git is not installed. Please install Git and try again."
        Write-Info "Download Git from: https://git-scm.com/download/win"
        return $false
    }
    Write-Success "Git is installed"

    if (-not (Test-GitHubAuth)) {
        Write-Error "GitHub authentication failed."
        Write-Info "This is a private repository. Please configure Git authentication:"
        Write-Info "  1. Generate Personal Access Token: https://github.com/settings/tokens"
        Write-Info "  2. Run: git config --global credential.helper wincred"
        Write-Info "  3. Try cloning the repo manually first: git clone $RepoUrl"
        return $false
    }
    Write-Success "GitHub authentication OK"

    # Check if already installed
    $targetClaudeDir = Join-Path $InstallPath $ClaudeDir
    $isUpdate = Test-Path $targetClaudeDir

    if ($isUpdate -and -not $Force) {
        Write-Info "Existing installation detected"
        $response = Read-Host "Update to latest version? (Y/n)"
        if ($response -and $response -ne 'Y' -and $response -ne 'y') {
            Write-Info "Installation cancelled by user"
            return $false
        }
    }

    # Create backup
    if ($isUpdate) {
        if (-not (Backup-ClaudeDirectory -SourcePath $targetClaudeDir)) {
            $response = Read-Host "Backup failed. Continue anyway? (y/N)"
            if ($response -ne 'y' -and $response -ne 'Y') {
                Write-Error "Installation cancelled due to backup failure"
                return $false
            }
        }
    }

    # Create temp directory
    if (Test-Path $TempDir) {
        Remove-Item -Path $TempDir -Recurse -Force
    }
    New-Item -ItemType Directory -Path $TempDir -Force | Out-Null

    # Clone/pull repository
    $repoPath = Get-Repository -TempPath $TempDir
    if (-not $repoPath) {
        Remove-TempFiles -TempPath $TempDir
        return $false
    }

    # Deploy files
    if (-not (Deploy-ClaudeDirectory -SourcePath $repoPath -TargetPath $InstallPath)) {
        Write-Error "Deployment failed"
        Remove-TempFiles -TempPath $TempDir
        return $false
    }

    # Verify installation
    if (-not (Test-Installation -TargetPath $InstallPath)) {
        Write-Error "Installation verification failed"
        Remove-TempFiles -TempPath $TempDir
        return $false
    }

    # Cleanup
    Remove-TempFiles -TempPath $TempDir

    # Show summary
    Show-Summary -TargetPath $InstallPath

    return $true
}

# Run installation
try {
    $result = Install-ClaudeCommands

    if ($result) {
        exit 0
    } else {
        Write-Error "`nInstallation failed. Please check errors above."
        exit 1
    }
} catch {
    Write-Error "Unexpected error: $_"
    Write-Error $_.ScriptStackTrace
    exit 1
}
