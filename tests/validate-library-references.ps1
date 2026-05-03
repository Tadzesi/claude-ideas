# Automated Test Script for Library References
# Version: 1.3 (2026-05-03)
# Purpose: Validate v5.2 skills + subagents follow shared library + Anthropic
#          subagent frontmatter contracts.
#
# Changelog:
#   v1.3: v5.2 -- adds .claude/agents/ subagent suite:
#         - Suite 6 verifies all 5 research subagents exist (research-explore,
#           research-pattern, research-security, research-performance,
#           research-citation)
#         - Suite 7 parses subagent frontmatter and asserts:
#           * required fields name + description present
#           * name is lowercase + hyphens, unique
#           * model in {haiku, sonnet, opus} (or "inherit" / full ID)
#           * tools comma-separated valid Anthropic tool names
#           * color in valid set
#         No longer expects research-agent-*.md or agent-roles.json
#         (deleted in v5.2 Phase C).
#   v1.2: Realigned with v5.0 reality
#   v1.1: Aligned with v4.9.0 reality
#   v1.0: Initial (2024-12-20)

param(
    [string]$SkillsPath = ".\.claude\skills",
    [string]$LibraryPath = ".\.claude\library",
    [string]$AgentsPath = ".\.claude\agents",
    [switch]$Verbose
)

Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "Library Reference Validation Test Suite v1.3" -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host ""

$testResults = @{
    Total = 0
    Passed = 0
    Failed = 0
    Warnings = 0
    Tests = @()
}

# Skills that intentionally do not import Phase 0 / prompt-perfection-core.
# reflect-diary is an analysis skill, not a prompt-rewriting skill.
$nonPhase0Skills = @("reflect-diary")

function Test-FileExists {
    param([string]$Path, [string]$Description)

    $testResults.Total++
    $test = @{ Name = $Description; Status = "Unknown"; Details = "" }

    if (Test-Path $Path) {
        Write-Host "[PASS]" -ForegroundColor Green -NoNewline
        Write-Host " $Description"
        if ($Verbose) { Write-Host "       Path: $Path" -ForegroundColor Gray }
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

function Test-SkillHasLibraryReference {
    param([string]$FilePath, [string]$SkillName)

    if ($nonPhase0Skills -contains $SkillName) {
        $testResults.Total++
        Write-Host "[SKIP]" -ForegroundColor DarkGray -NoNewline
        Write-Host " $SkillName - Non-Phase-0 skill (analysis flow), library import not required"
        $testResults.Tests += @{
            Name = "Library reference in $SkillName"
            Status = "SKIP"
            Details = "Non-Phase-0 skill"
        }
        $testResults.Passed++
        return
    }

    $testResults.Total++
    $test = @{ Name = "Library reference in $SkillName"; Status = "Unknown"; Details = "" }
    $content = Get-Content $FilePath -Raw

    # v1.2: accept skill-style "@.claude/library/prompt-perfection-core.md"
    # OR legacy "**Import:** ... prompt-perfection-core.md"
    $skillStyle  = $content -match "@\.claude/library/prompt-perfection-core\.md"
    $legacyStyle = $content -match "\*\*Import:\*\*.*prompt-perfection-core\.md"

    if ($skillStyle -or $legacyStyle) {
        Write-Host "[PASS]" -ForegroundColor Green -NoNewline
        Write-Host " $SkillName - Has core library reference"
        $test.Status = "PASS"
        $testResults.Passed++
    } else {
        Write-Host "[WARN]" -ForegroundColor Yellow -NoNewline
        Write-Host " $SkillName - No prompt-perfection-core import found (may use inline Phase 0)"
        $test.Status = "WARN"
        $test.Details = "No core library import"
        $testResults.Warnings++
    }

    $testResults.Tests += $test
}

function Test-SkillHasFrontmatter {
    param([string]$FilePath, [string]$SkillName)

    $testResults.Total++
    $test = @{ Name = "YAML frontmatter in $SkillName"; Status = "Unknown"; Details = "" }
    $content = Get-Content $FilePath -Raw

    # Skills must start with --- ... --- containing name + description (Anthropic format)
    if ($content -match "(?s)^---\s*\r?\n.*?name:\s*\S+.*?description:\s*\S+.*?\r?\n---") {
        Write-Host "[PASS]" -ForegroundColor Green -NoNewline
        Write-Host " $SkillName - Has YAML frontmatter (name + description)"
        $test.Status = "PASS"
        $testResults.Passed++
    } else {
        Write-Host "[FAIL]" -ForegroundColor Red -NoNewline
        Write-Host " $SkillName - Missing or malformed YAML frontmatter"
        $test.Status = "FAIL"
        $test.Details = "Frontmatter must contain name + description"
        $testResults.Failed++
    }

    $testResults.Tests += $test
}

# Test 1: Core library exists
Write-Host "`n[Test Suite 1: Core Library Files]" -ForegroundColor Cyan
Write-Host "-----------------------------------" -ForegroundColor Cyan
Test-FileExists "$LibraryPath\prompt-perfection-core.md" "Core library (prompt-perfection-core.md) exists"
Test-FileExists "$LibraryPath\model-router.md"           "model-router.md exists"
Test-FileExists "$LibraryPath\execution-plan-template.md" "execution-plan-template.md exists"
Test-FileExists "$LibraryPath\caching-strategy.md"        "caching-strategy.md exists"

# Test 2: Adapter files (flat in library/, not in adapters/ subdir per v5.0)
Write-Host "`n[Test Suite 2: Adapter Files (flat in library/)]" -ForegroundColor Cyan
Write-Host "-------------------------------------------------" -ForegroundColor Cyan
Test-FileExists "$LibraryPath\readme-adapter.md"   "readme-adapter.md exists"
Test-FileExists "$LibraryPath\research-adapter.md" "research-adapter.md exists"

# Test 3: All active skills have YAML frontmatter
Write-Host "`n[Test Suite 3: Skill Frontmatter]" -ForegroundColor Cyan
Write-Host "----------------------------------" -ForegroundColor Cyan

$skillDirs = Get-ChildItem -Path $SkillsPath -Directory -ErrorAction SilentlyContinue
foreach ($dir in $skillDirs) {
    $skillFile = Join-Path $dir.FullName "SKILL.md"
    if (Test-Path $skillFile) {
        Test-SkillHasFrontmatter $skillFile $dir.Name
    }
}

# Test 4: Skills (except non-Phase-0 ones) reference prompt-perfection-core
Write-Host "`n[Test Suite 4: Phase 0 Library Import]" -ForegroundColor Cyan
Write-Host "---------------------------------------" -ForegroundColor Cyan

foreach ($dir in $skillDirs) {
    $skillFile = Join-Path $dir.FullName "SKILL.md"
    if (Test-Path $skillFile) {
        Test-SkillHasLibraryReference $skillFile $dir.Name
    }
}

# Test 5: Adapter usage by domain skills
Write-Host "`n[Test Suite 5: Adapter Usage by Domain Skills]" -ForegroundColor Cyan
Write-Host "-----------------------------------------------" -ForegroundColor Cyan

# v1.2: Mappings reflect v5.0 skill names. prompt + reflect-diary do not
# need a domain adapter (prompt is generic; reflect-diary is non-Phase-0).
$adapterMappings = @{
    "prompt-article-readme" = "readme-adapter.md"
    "prompt-research"       = "research-adapter.md"
}

foreach ($dir in $skillDirs) {
    $skillName = $dir.Name
    if (-not $adapterMappings.ContainsKey($skillName)) { continue }

    $skillFile = Join-Path $dir.FullName "SKILL.md"
    if (-not (Test-Path $skillFile)) { continue }

    $testResults.Total++
    $expected = $adapterMappings[$skillName]
    $content = Get-Content $skillFile -Raw

    $test = @{ Name = "Adapter reference in $skillName"; Status = "Unknown"; Details = "" }

    if ($content -match [regex]::Escape($expected)) {
        Write-Host "[PASS]" -ForegroundColor Green -NoNewline
        Write-Host " $skillName references $expected"
        $test.Status = "PASS"
        $testResults.Passed++
    } else {
        Write-Host "[WARN]" -ForegroundColor Yellow -NoNewline
        Write-Host " $skillName - Expected reference to $expected"
        $test.Status = "WARN"
        $test.Details = "Expected reference to $expected"
        $testResults.Warnings++
    }

    $testResults.Tests += $test
}

# Test 6: All 5 research subagents present in .claude/agents/
Write-Host "`n[Test Suite 6: Research Subagents Existence (v5.2+)]" -ForegroundColor Cyan
Write-Host "-----------------------------------------------------" -ForegroundColor Cyan

$expectedAgents = @(
    "research-explore", "research-pattern", "research-security",
    "research-performance", "research-citation"
)

foreach ($agentName in $expectedAgents) {
    $agentFile = Join-Path $AgentsPath "$agentName.md"
    Test-FileExists $agentFile "Subagent $agentName exists"
}

# Test 7: Subagent frontmatter validation
Write-Host "`n[Test Suite 7: Subagent Frontmatter (Anthropic spec)]" -ForegroundColor Cyan
Write-Host "------------------------------------------------------" -ForegroundColor Cyan

$validModels = @("haiku", "sonnet", "opus", "inherit")
$validColors = @("red", "blue", "green", "yellow", "orange", "purple", "pink", "cyan", "magenta")
# Anthropic internal tools allowlist (subset relevant for research subagents)
$validTools = @("Read", "Grep", "Glob", "Bash", "Edit", "Write", "WebFetch", "WebSearch", "Task", "NotebookEdit", "TodoWrite")

$seenNames = @{}

if (Test-Path $AgentsPath) {
    Get-ChildItem -Path $AgentsPath -Filter "*.md" | ForEach-Object {
        $agentFile = $_
        $content = Get-Content $agentFile.FullName -Raw

        # Extract frontmatter block
        if ($content -match "(?ms)^---\s*\r?\n(.*?)\r?\n---") {
            $fm = $Matches[1]

            # Parse simple key: value pairs
            $fmMap = @{}
            foreach ($line in $fm -split "\r?\n") {
                if ($line -match "^(\w+):\s*(.*)$") {
                    $fmMap[$Matches[1]] = $Matches[2].Trim()
                }
            }

            # Required: name
            $testResults.Total++
            $name = $fmMap["name"]
            if ($name -and $name -match "^[a-z][a-z0-9-]*$") {
                if ($seenNames.ContainsKey($name)) {
                    Write-Host "[FAIL]" -ForegroundColor Red -NoNewline
                    Write-Host " $($agentFile.Name) - duplicate name: $name"
                    $testResults.Failed++
                } else {
                    Write-Host "[PASS]" -ForegroundColor Green -NoNewline
                    Write-Host " $($agentFile.Name) - name '$name' valid + unique"
                    $seenNames[$name] = $true
                    $testResults.Passed++
                }
            } else {
                Write-Host "[FAIL]" -ForegroundColor Red -NoNewline
                Write-Host " $($agentFile.Name) - name missing or invalid (must be lowercase + hyphens): '$name'"
                $testResults.Failed++
            }

            # Required: description
            $testResults.Total++
            if ($fmMap["description"] -and $fmMap["description"].Length -gt 30) {
                Write-Host "[PASS]" -ForegroundColor Green -NoNewline
                Write-Host " $($agentFile.Name) - description present (length OK)"
                $testResults.Passed++
            } else {
                Write-Host "[FAIL]" -ForegroundColor Red -NoNewline
                Write-Host " $($agentFile.Name) - description missing or too short"
                $testResults.Failed++
            }

            # Optional but expected: model
            if ($fmMap.ContainsKey("model")) {
                $testResults.Total++
                $model = $fmMap["model"]
                # Accept enum value OR full claude-* model ID
                if (($validModels -contains $model) -or ($model -match "^claude-")) {
                    Write-Host "[PASS]" -ForegroundColor Green -NoNewline
                    Write-Host " $($agentFile.Name) - model '$model' valid"
                    $testResults.Passed++
                } else {
                    Write-Host "[FAIL]" -ForegroundColor Red -NoNewline
                    Write-Host " $($agentFile.Name) - model '$model' not in valid set"
                    $testResults.Failed++
                }
            }

            # Optional: tools (comma-separated)
            if ($fmMap.ContainsKey("tools")) {
                $testResults.Total++
                $toolList = $fmMap["tools"] -split "\s*,\s*"
                $invalidTools = $toolList | Where-Object { $validTools -notcontains $_ }
                if ($invalidTools.Count -eq 0) {
                    Write-Host "[PASS]" -ForegroundColor Green -NoNewline
                    Write-Host " $($agentFile.Name) - tools $($toolList -join ',') all valid"
                    $testResults.Passed++
                } else {
                    Write-Host "[FAIL]" -ForegroundColor Red -NoNewline
                    Write-Host " $($agentFile.Name) - invalid tools: $($invalidTools -join ',')"
                    $testResults.Failed++
                }
            }

            # Optional: color
            if ($fmMap.ContainsKey("color")) {
                $testResults.Total++
                $color = $fmMap["color"]
                if ($validColors -contains $color) {
                    Write-Host "[PASS]" -ForegroundColor Green -NoNewline
                    Write-Host " $($agentFile.Name) - color '$color' valid"
                    $testResults.Passed++
                } else {
                    Write-Host "[WARN]" -ForegroundColor Yellow -NoNewline
                    Write-Host " $($agentFile.Name) - color '$color' not in common set"
                    $testResults.Warnings++
                }
            }
        } else {
            $testResults.Total++
            Write-Host "[FAIL]" -ForegroundColor Red -NoNewline
            Write-Host " $($agentFile.Name) - no YAML frontmatter found"
            $testResults.Failed++
        }
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
