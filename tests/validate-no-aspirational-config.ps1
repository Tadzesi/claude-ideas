# No-Aspirational-Config Validation
# Version: 1.0 (2026-05-03)
# Purpose: For each top-level key in every .claude/config/*.json, verify
#          the key is referenced from at least one place in
#          .claude/skills/, .claude/library/, .claude/agents/, or
#          install-claude-commands.ps1. Orphan config keys = aspirational
#          and should be deleted.
#
# Some keys are documentary (version, description, _comment, metadata).
# These are exempt from the orphan check.

param(
    [string]$ConfigPath = ".\.claude\config",
    [string[]]$SearchPaths = @(".\.claude\skills", ".\.claude\library", ".\.claude\agents", ".\install-claude-commands.ps1"),
    [switch]$Verbose
)

Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "No-Aspirational-Config Validation v1.0" -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host ""

$exemptKeys = @("version", "description", "_comment", "metadata", "comment", "schema")

$failed = 0
$passed = 0
$skipped = 0

if (-not (Test-Path $ConfigPath)) {
    Write-Host "[FAIL]" -ForegroundColor Red -NoNewline
    Write-Host " Config directory not found: $ConfigPath"
    exit 1
}

$configFiles = Get-ChildItem -Path $ConfigPath -Filter "*.json"

foreach ($configFile in $configFiles) {
    Write-Host "`n[Config: $($configFile.Name)]" -ForegroundColor Cyan

    try {
        $json = Get-Content $configFile.FullName -Raw | ConvertFrom-Json
    } catch {
        Write-Host "[FAIL]" -ForegroundColor Red -NoNewline
        Write-Host " Cannot parse $($configFile.Name): $_"
        $failed++
        continue
    }

    $topLevelKeys = $json.PSObject.Properties.Name

    foreach ($key in $topLevelKeys) {
        if ($exemptKeys -contains $key) {
            if ($Verbose) {
                Write-Host "[SKIP]" -ForegroundColor DarkGray -NoNewline
                Write-Host " $key (documentary, exempt)"
            }
            $skipped++
            continue
        }

        # Search for the key in all search paths
        $found = $false
        foreach ($path in $SearchPaths) {
            if (-not (Test-Path $path)) { continue }

            if ((Get-Item $path).PSIsContainer) {
                $matches = Get-ChildItem -Path $path -Recurse -Include *.md, *.ps1 -ErrorAction SilentlyContinue |
                    Select-String -Pattern ([regex]::Escape($key)) -SimpleMatch -List
                if ($matches) {
                    $found = $true
                    break
                }
            } else {
                if (Select-String -Path $path -Pattern ([regex]::Escape($key)) -SimpleMatch -Quiet) {
                    $found = $true
                    break
                }
            }
        }

        if ($found) {
            Write-Host "[PASS]" -ForegroundColor Green -NoNewline
            Write-Host " $key referenced from at least one consumer"
            $passed++
        } else {
            Write-Host "[WARN]" -ForegroundColor Yellow -NoNewline
            Write-Host " $key has no live consumer (potential aspirational)"
            $failed++
        }
    }
}

Write-Host ""
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "Total checked: $($passed + $failed) | Linked: $passed | Orphan: $failed | Exempt: $skipped"
Write-Host "===============================================" -ForegroundColor Cyan

if ($failed -gt 0) {
    Write-Host "RESULT: WARNINGS - $failed orphan config key(s) found" -ForegroundColor Yellow
    Write-Host "These are not necessarily failures; review and either link them" -ForegroundColor Gray
    Write-Host "from a consumer or delete from the JSON." -ForegroundColor Gray
    # WARN-only: do not block CI on this advisory check
    exit 0
} else {
    Write-Host "RESULT: PASSED - all config keys have live consumers" -ForegroundColor Green
    exit 0
}
