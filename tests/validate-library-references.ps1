# Automated Test Script for Library References
# Version: 1.0
# Purpose: Validate all commands follow v2.0 library system pattern

param(
    [string]$CommandsPath = ".\.claude\commands",
    [string]$LibraryPath = ".\.claude\library",
    [switch]$Verbose
)

Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "Library Reference Validation Test Suite v1.0" -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host ""

$testResults = @{
    Total = 0
    Passed = 0
    Failed = 0
    Warnings = 0
    Tests = @()
}

function Test-FileExists {
    param([string]$Path, [string]$Description)

    $testResults.Total++
    $test = @{
        Name = $Description
        Status = "Unknown"
        Details = ""
    }

    if (Test-Path $Path) {
        Write-Host "[PASS]" -ForegroundColor Green -NoNewline
        Write-Host " $Description"
        if ($Verbose) {
            Write-Host "       Path: $Path" -ForegroundColor Gray
        }
        $test.Status = "PASS"
        $testResults.Passed++
    } else {
        Write-Host "[FAIL]" -ForegroundColor Red -NoNewline
        Write-Host " $Description"
        Write-Host "       Path not found: $Path" -ForegroundColor Red
        $test.Status = "FAIL"
        $test.Details = "Path not found: $Path"
        $testResults.Failed++
    }

    $testResults.Tests += $test
}

function Test-CommandHasLibraryReference {
    param([string]$FilePath, [string]$CommandName)

    $testResults.Total++
    $test = @{
        Name = "Library reference in $CommandName"
        Status = "Unknown"
        Details = ""
    }

    $content = Get-Content $FilePath -Raw

    # Check for Phase 0 section
    if ($content -notmatch "## Phase 0:") {
        Write-Host "[FAIL]" -ForegroundColor Red -NoNewline
        Write-Host " $CommandName - Missing Phase 0 section"
        $test.Status = "FAIL"
        $test.Details = "Missing Phase 0 section"
        $testResults.Failed++
        $testResults.Tests += $test
        return
    }

    # Check for Import statement
    if ($content -match "\*\*Import:\*\*.*prompt-perfection-core\.md") {
        Write-Host "[PASS]" -ForegroundColor Green -NoNewline
        Write-Host " $CommandName - Has library reference"
        if ($Verbose) {
            # Extract the import line
            $importLine = ($content | Select-String -Pattern "\*\*Import:\*\*.*").Line
            Write-Host "       $importLine" -ForegroundColor Gray
        }
        $test.Status = "PASS"
        $testResults.Passed++
    } else {
        Write-Host "[WARN]" -ForegroundColor Yellow -NoNewline
        Write-Host " $CommandName - No explicit library import (may use inline Phase 0)"
        $test.Status = "WARN"
        $test.Details = "No explicit library import found"
        $testResults.Warnings++
    }

    $testResults.Tests += $test
}

function Test-CommandHasVersionHistory {
    param([string]$FilePath, [string]$CommandName)

    $testResults.Total++
    $test = @{
        Name = "Version history in $CommandName"
        Status = "Unknown"
        Details = ""
    }

    $content = Get-Content $FilePath -Raw

    if ($content -match "## Version History") {
        # Check for v2.0 entry
        if ($content -match "v2\.0.*2024-12-20") {
            Write-Host "[PASS]" -ForegroundColor Green -NoNewline
            Write-Host " $CommandName - Has v2.0 version history"
            $test.Status = "PASS"
            $testResults.Passed++
        } else {
            Write-Host "[WARN]" -ForegroundColor Yellow -NoNewline
            Write-Host " $CommandName - Has version history but no v2.0 entry"
            $test.Status = "WARN"
            $test.Details = "Missing v2.0 entry"
            $testResults.Warnings++
        }
    } else {
        Write-Host "[FAIL]" -ForegroundColor Red -NoNewline
        Write-Host " $CommandName - Missing version history section"
        $test.Status = "FAIL"
        $test.Details = "Missing version history section"
        $testResults.Failed++
    }

    $testResults.Tests += $test
}

function Test-CommandHasLibraryIntegration {
    param([string]$FilePath, [string]$CommandName)

    $testResults.Total++
    $test = @{
        Name = "Library integration section in $CommandName"
        Status = "Unknown"
        Details = ""
    }

    $content = Get-Content $FilePath -Raw

    if ($content -match "## Library Integration") {
        Write-Host "[PASS]" -ForegroundColor Green -NoNewline
        Write-Host " $CommandName - Has Library Integration section"
        $test.Status = "PASS"
        $testResults.Passed++
    } else {
        Write-Host "[WARN]" -ForegroundColor Yellow -NoNewline
        Write-Host " $CommandName - Missing Library Integration section (recommended)"
        $test.Status = "WARN"
        $test.Details = "Missing Library Integration section"
        $testResults.Warnings++
    }

    $testResults.Tests += $test
}

function Test-AdapterExists {
    param([string]$AdapterPath, [string]$AdapterName)

    $testResults.Total++
    $test = @{
        Name = "Adapter exists: $AdapterName"
        Status = "Unknown"
        Details = ""
    }

    if (Test-Path $AdapterPath) {
        Write-Host "[PASS]" -ForegroundColor Green -NoNewline
        Write-Host " Adapter exists: $AdapterName"
        $test.Status = "PASS"
        $testResults.Passed++
    } else {
        Write-Host "[FAIL]" -ForegroundColor Red -NoNewline
        Write-Host " Adapter missing: $AdapterName"
        Write-Host "       Expected at: $AdapterPath" -ForegroundColor Red
        $test.Status = "FAIL"
        $test.Details = "Adapter file not found"
        $testResults.Failed++
    }

    $testResults.Tests += $test
}

# Test 1: Core library exists
Write-Host "`n[Test Suite 1: Core Library Files]" -ForegroundColor Cyan
Write-Host "-----------------------------------" -ForegroundColor Cyan
Test-FileExists "$LibraryPath\prompt-perfection-core.md" "Core library (prompt-perfection-core.md) exists"

# Test 2: Adapters exist
Write-Host "`n[Test Suite 2: Adapter Files]" -ForegroundColor Cyan
Write-Host "------------------------------" -ForegroundColor Cyan
Test-AdapterExists "$LibraryPath\adapters\technical-adapter.md" "technical-adapter.md"
Test-AdapterExists "$LibraryPath\adapters\article-adapter.md" "article-adapter.md"
Test-AdapterExists "$LibraryPath\adapters\session-adapter.md" "session-adapter.md"
Test-AdapterExists "$LibraryPath\adapters\hybrid-adapter.md" "hybrid-adapter.md (v2.0)"

# Test 3: Commands have library references
Write-Host "`n[Test Suite 3: Command Library References]" -ForegroundColor Cyan
Write-Host "------------------------------------------" -ForegroundColor Cyan

$commands = Get-ChildItem -Path $CommandsPath -Filter "*.md" | Where-Object { $_.Name -ne "example-custom-command.md" }

foreach ($command in $commands) {
    $commandName = $command.BaseName
    Test-CommandHasLibraryReference $command.FullName $commandName
}

# Test 4: Commands have version history
Write-Host "`n[Test Suite 4: Version History]" -ForegroundColor Cyan
Write-Host "--------------------------------" -ForegroundColor Cyan

foreach ($command in $commands) {
    $commandName = $command.BaseName
    Test-CommandHasVersionHistory $command.FullName $commandName
}

# Test 5: Commands have Library Integration section
Write-Host "`n[Test Suite 5: Library Integration Sections]" -ForegroundColor Cyan
Write-Host "---------------------------------------------" -ForegroundColor Cyan

foreach ($command in $commands) {
    $commandName = $command.BaseName
    Test-CommandHasLibraryIntegration $command.FullName $commandName
}

# Test 6: Check for proper adapter references in commands
Write-Host "`n[Test Suite 6: Adapter References in Commands]" -ForegroundColor Cyan
Write-Host "-----------------------------------------------" -ForegroundColor Cyan

$adapterMappings = @{
    "prompt-technical" = "technical-adapter.md"
    "prompt-hybrid" = "hybrid-adapter.md"
    "prompt-article" = "article-adapter.md"
    "prompt-article-readme" = "article-adapter.md"
    "session-start" = "session-adapter.md"
    "session-end" = "session-adapter.md"
}

foreach ($command in $commands) {
    $commandName = $command.BaseName

    if ($adapterMappings.ContainsKey($commandName)) {
        $testResults.Total++
        $expectedAdapter = $adapterMappings[$commandName]
        $content = Get-Content $command.FullName -Raw

        $test = @{
            Name = "Adapter reference in $commandName"
            Status = "Unknown"
            Details = ""
        }

        if ($content -match [regex]::Escape($expectedAdapter)) {
            Write-Host "[PASS]" -ForegroundColor Green -NoNewline
            Write-Host " $commandName references $expectedAdapter"
            $test.Status = "PASS"
            $testResults.Passed++
        } else {
            Write-Host "[WARN]" -ForegroundColor Yellow -NoNewline
            Write-Host " $commandName - Expected reference to $expectedAdapter"
            $test.Status = "WARN"
            $test.Details = "Expected reference to $expectedAdapter"
            $testResults.Warnings++
        }

        $testResults.Tests += $test
    }
}

# Summary
Write-Host "`n===============================================" -ForegroundColor Cyan
Write-Host "Test Results Summary" -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Total Tests:  " -NoNewline
Write-Host $testResults.Total -ForegroundColor White
Write-Host "Passed:       " -NoNewline
Write-Host $testResults.Passed -ForegroundColor Green
Write-Host "Failed:       " -NoNewline
Write-Host $testResults.Failed -ForegroundColor Red
Write-Host "Warnings:     " -NoNewline
Write-Host $testResults.Warnings -ForegroundColor Yellow
Write-Host ""

# Calculate success rate
$successRate = if ($testResults.Total -gt 0) {
    [math]::Round(($testResults.Passed / $testResults.Total) * 100, 2)
} else { 0 }

Write-Host "Success Rate: " -NoNewline
if ($successRate -ge 90) {
    Write-Host "$successRate%" -ForegroundColor Green
} elseif ($successRate -ge 70) {
    Write-Host "$successRate%" -ForegroundColor Yellow
} else {
    Write-Host "$successRate%" -ForegroundColor Red
}

Write-Host ""

# Exit code
if ($testResults.Failed -gt 0) {
    Write-Host "RESULT: FAILED - Some tests failed" -ForegroundColor Red
    exit 1
} elseif ($testResults.Warnings -gt 5) {
    Write-Host "RESULT: WARNING - Many warnings detected" -ForegroundColor Yellow
    exit 0
} else {
    Write-Host "RESULT: PASSED - All tests passed!" -ForegroundColor Green
    exit 0
}
