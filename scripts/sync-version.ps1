# sync-version.ps1
# Propagates the version from package.json into all known sites.
#
# package.json is the single source of truth (Proposal 2.1, Variant A).
# Run this script after bumping package.json. It is idempotent: if every
# target file already matches the source, no files are written.
#
# Targets:
#   - install-claude-commands.ps1 : header comment, banner, VERSION-file
#                                   write, "WHAT'S IN VERSION X.Y" header
#   - CLAUDE.md                   : project-overview line ("**claude-ideas** (vX.Y.Z)")
#
# Usage:
#   pwsh ./scripts/sync-version.ps1            # apply changes
#   pwsh ./scripts/sync-version.ps1 -Check     # exit 1 if any target is stale (CI)
#   pwsh ./scripts/sync-version.ps1 -DryRun    # print intended changes, write nothing

[CmdletBinding()]
param(
    [switch]$Check,
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot

function Get-PackageVersion {
    $packageJson = Join-Path $repoRoot 'package.json'
    if (-not (Test-Path $packageJson)) {
        throw "package.json not found at $packageJson"
    }
    $json = Get-Content $packageJson -Raw | ConvertFrom-Json
    if (-not $json.version) {
        throw "package.json has no 'version' field"
    }
    return [string]$json.version
}

function Update-FileContent {
    param(
        [string]$Path,
        [string]$Description,
        [hashtable[]]$Replacements
    )
    if (-not (Test-Path $Path)) {
        Write-Warning "Skipping (not found): $Path"
        return $false
    }
    $original = Get-Content $Path -Raw
    $updated = $original
    foreach ($r in $Replacements) {
        $updated = [regex]::Replace($updated, $r.Pattern, $r.Replacement)
    }
    if ($updated -eq $original) {
        Write-Host "  [ok]   $Description (already in sync)"
        return $false
    }
    if ($DryRun -or $Check) {
        Write-Host "  [drift] $Description" -ForegroundColor Yellow
        return $true
    }
    # Preserve original line endings: write back as UTF8 without BOM.
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($updated)
    [System.IO.File]::WriteAllBytes($Path, $bytes)
    Write-Host "  [write] $Description" -ForegroundColor Green
    return $true
}

$version = Get-PackageVersion
$majorMinor = ($version -split '\.')[0..1] -join '.'

Write-Host "Source version (package.json): $version"
Write-Host "Major.Minor: $majorMinor"
Write-Host ""

$installer = Join-Path $repoRoot 'install-claude-commands.ps1'
$claudeMd = Join-Path $repoRoot 'CLAUDE.md'

$installerReplacements = @(
    @{ Pattern = '(?m)^# Version: \d+\.\d+\.\d+';                Replacement = "# Version: $version" },
    @{ Pattern = 'Claude Commands Library Installer v\d+\.\d+\.\d+'; Replacement = "Claude Commands Library Installer v$version" },
    @{ Pattern = '"\d+\.\d+\.\d+" \| Out-File -FilePath \$versionFile'; Replacement = "`"$version`" | Out-File -FilePath `$versionFile" },
    @{ Pattern = 'Version file created \(v\d+\.\d+\.\d+\)';      Replacement = "Version file created (v$version)" },
    @{ Pattern = "WHAT'S IN VERSION \d+\.\d+";                   Replacement = "WHAT'S IN VERSION $majorMinor" }
)
$claudeMdReplacements = @(
    @{ Pattern = '\*\*claude-ideas\*\* \(v\d+\.\d+\.\d+\)';      Replacement = "**claude-ideas** (v$version)" }
)

$drift = $false
$drift = (Update-FileContent -Path $installer -Description 'install-claude-commands.ps1' -Replacements $installerReplacements) -or $drift
$drift = (Update-FileContent -Path $claudeMd  -Description 'CLAUDE.md project header'    -Replacements $claudeMdReplacements) -or $drift

Write-Host ""
if ($Check) {
    if ($drift) {
        Write-Host "FAIL: version drift detected. Run scripts/sync-version.ps1 to fix." -ForegroundColor Red
        exit 1
    }
    Write-Host "OK: all targets match package.json version $version" -ForegroundColor Green
    exit 0
}
if ($DryRun) {
    Write-Host "(dry-run; no files were modified)"
    exit 0
}
if ($drift) {
    Write-Host "Version sync complete." -ForegroundColor Green
} else {
    Write-Host "All targets already in sync; nothing to do."
}
