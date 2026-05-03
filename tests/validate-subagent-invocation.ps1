# Subagent Invocation Validation
# Version: 1.0 (2026-05-03)
# Purpose: Verify every @research-* mention in prompt-research/SKILL.md
#          maps to an existing subagent file in .claude/agents/, and
#          every subagent file is mentioned at least once in the skill
#          (or explicitly documented as out-of-default-cohort).

param(
    [string]$SkillFile = ".\.claude\skills\prompt-research\SKILL.md",
    [string]$AgentsPath = ".\.claude\agents",
    [switch]$Verbose
)

Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "Subagent Invocation Validation v1.0" -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host ""

$failed = 0
$passed = 0

if (-not (Test-Path $SkillFile)) {
    Write-Host "[FAIL]" -ForegroundColor Red -NoNewline
    Write-Host " SKILL file not found: $SkillFile"
    exit 1
}

if (-not (Test-Path $AgentsPath)) {
    Write-Host "[FAIL]" -ForegroundColor Red -NoNewline
    Write-Host " Agents directory not found: $AgentsPath"
    exit 1
}

$skillContent = Get-Content $SkillFile -Raw

# Find @research-<name> mentions OR Task subagent_type: "research-<name>"
# Exclude bare "research-<word>" matches — those produce false positives
# from file references (research-adapter.md) and prose ("research-specific").
$atMentions = [regex]::Matches($skillContent, '@(research-[a-z]+)') |
    ForEach-Object { $_.Groups[1].Value }
$taskMentions = [regex]::Matches($skillContent, 'subagent_type:\s*"(research-[a-z]+)"') |
    ForEach-Object { $_.Groups[1].Value }

$mentions = ($atMentions + $taskMentions) | Sort-Object -Unique

Write-Host "[Suite 1: SKILL mentions resolve to agent files]" -ForegroundColor Cyan
foreach ($mention in $mentions) {
    $expectedFile = Join-Path $AgentsPath "$mention.md"
    if (Test-Path $expectedFile) {
        Write-Host "[PASS]" -ForegroundColor Green -NoNewline
        Write-Host " SKILL references $mention -> $expectedFile exists"
        $passed++
    } else {
        Write-Host "[FAIL]" -ForegroundColor Red -NoNewline
        Write-Host " SKILL references $mention but $expectedFile is missing"
        $failed++
    }
}

# Find all agent files and verify each is mentioned in SKILL
$agentFiles = Get-ChildItem -Path $AgentsPath -Filter "research-*.md"

Write-Host "`n[Suite 2: Agent files referenced in SKILL]" -ForegroundColor Cyan
foreach ($agentFile in $agentFiles) {
    $agentName = $agentFile.BaseName
    if ($skillContent -match [regex]::Escape($agentName)) {
        Write-Host "[PASS]" -ForegroundColor Green -NoNewline
        Write-Host " Agent $agentName is referenced in SKILL"
        $passed++
    } else {
        Write-Host "[FAIL]" -ForegroundColor Red -NoNewline
        Write-Host " Agent $agentName is orphan (not mentioned in SKILL)"
        $failed++
    }
}

Write-Host ""
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "Total: $($passed + $failed) | Passed: $passed | Failed: $failed"
Write-Host "===============================================" -ForegroundColor Cyan

if ($failed -gt 0) {
    Write-Host "RESULT: FAILED" -ForegroundColor Red
    exit 1
} else {
    Write-Host "RESULT: PASSED" -ForegroundColor Green
    exit 0
}
