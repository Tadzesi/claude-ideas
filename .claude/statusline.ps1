# Claude Code Status Line Script (Enhanced)
# Displays: Folder, Git Branch, Progress Bar, Tokens, API Duration

# Read JSON from stdin
$jsonInput = [Console]::In.ReadToEnd()
$data = $jsonInput | ConvertFrom-Json

# --- Folder Name ---
$cwd = $data.cwd
$folderName = if ($cwd) { Split-Path -Leaf $cwd } else { "~" }

# --- Git Branch ---
$gitBranch = ""
if ($cwd -and (Test-Path $cwd)) {
    Push-Location $cwd
    try {
        $branch = git rev-parse --abbrev-ref HEAD 2>$null
        if ($LASTEXITCODE -eq 0 -and $branch) {
            $gitBranch = $branch
        }
    } catch {}
    Pop-Location
}

# --- Context Usage ---
$contextSize = $data.context_window.context_window_size
$currentInput = 0
$currentOutput = 0
$percentUsed = 0

if ($data.context_window.current_usage) {
    $currentInput = $data.context_window.current_usage.input_tokens
    $currentOutput = $data.context_window.current_usage.output_tokens
    $cacheCreation = if ($data.context_window.current_usage.cache_creation_input_tokens) {
        $data.context_window.current_usage.cache_creation_input_tokens
    } else { 0 }
    $cacheRead = if ($data.context_window.current_usage.cache_read_input_tokens) {
        $data.context_window.current_usage.cache_read_input_tokens
    } else { 0 }

    $totalCurrentTokens = $currentInput + $cacheCreation + $cacheRead
    if ($contextSize -gt 0) {
        $percentUsed = [math]::Round(($totalCurrentTokens / $contextSize) * 100, 1)
    }
}

# --- Cumulative Totals ---
$totalInput = if ($data.context_window.total_input_tokens) { $data.context_window.total_input_tokens } else { 0 }
$totalOutput = if ($data.context_window.total_output_tokens) { $data.context_window.total_output_tokens } else { 0 }

# --- API Duration (last call only, calculated from difference) ---
$stateFile = "$env:USERPROFILE\.claude\.statusline-state"
$apiDuration = ""

if ($data.cost -and $data.cost.total_api_duration_ms) {
    $currentTotal = $data.cost.total_api_duration_ms
    $previousTotal = 0

    # Read previous total from state file
    if (Test-Path $stateFile) {
        try {
            $previousTotal = [long](Get-Content $stateFile -Raw)
        } catch { $previousTotal = 0 }
    }

    # Calculate last call duration (difference)
    $lastDurationMs = $currentTotal - $previousTotal

    # If negative or zero, this is first call or session reset
    if ($lastDurationMs -le 0) {
        $lastDurationMs = $currentTotal
    }

    # Save current total for next time
    $currentTotal | Out-File $stateFile -Force -NoNewline

    # Format duration
    if ($lastDurationMs -ge 1000) {
        $apiDuration = "{0:N1}s" -f ($lastDurationMs / 1000)
    } else {
        $apiDuration = "{0}ms" -f $lastDurationMs
    }
}

# --- Helper Functions ---
function Format-Tokens($count) {
    if ($count -ge 1000000) {
        return "{0:N1}M" -f ($count / 1000000)
    }
    if ($count -ge 1000) {
        return "{0:N1}k" -f ($count / 1000)
    }
    return $count.ToString()
}

function Get-ProgressBar($percent, $width) {
    $filled = [math]::Floor(($percent / 100) * $width)
    $empty = $width - $filled
    $bar = ([char]0x2588).ToString() * $filled + ([char]0x2591).ToString() * $empty
    return $bar
}

# --- Build Status Line ---
$progressBar = Get-ProgressBar $percentUsed 10

$fmtCurrentIn = Format-Tokens $currentInput
$fmtCurrentOut = Format-Tokens $currentOutput
$fmtTotalIn = Format-Tokens $totalInput
$fmtTotalOut = Format-Tokens $totalOutput

$parts = @()
$parts += $folderName                                 # Current folder
if ($gitBranch) { $parts += "[$gitBranch]" }         # Git branch
$parts += "$progressBar ${percentUsed}%"             # Context usage
$parts += "In:$fmtCurrentIn Out:$fmtCurrentOut"      # Current tokens
$parts += "Total:$fmtTotalIn/$fmtTotalOut"           # Cumulative tokens
if ($apiDuration) { $parts += "API:$apiDuration" }   # API call duration

$status = $parts -join " | "

Write-Host $status
