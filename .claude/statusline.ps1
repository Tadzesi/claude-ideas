# Claude Code Status Line Script (Enhanced)
# Displays: Folder, Git Branch, Progress Bar, Tokens, Global API Duration
# API Duration: Cumulative across all sessions with delta indicator (+last call)

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

# --- API Duration (global cumulative with delta indicator) ---
$stateFile = "$env:USERPROFILE\.claude\.statusline-state.json"
$apiDuration = ""

if ($data.cost -and $data.cost.total_api_duration_ms) {
    $currentSessionTotal = $data.cost.total_api_duration_ms

    # Default state
    $state = @{
        global_cumulative_ms = 0
        last_session_total_ms = 0
        last_call_ms = 0
    }

    # Read previous state from JSON file
    if (Test-Path $stateFile) {
        try {
            $state = Get-Content $stateFile -Raw | ConvertFrom-Json -AsHashtable
        } catch { }
    }

    # Calculate last call duration (difference within session)
    $lastCallMs = $currentSessionTotal - $state.last_session_total_ms

    # Detect new session (current total < previous session total)
    if ($lastCallMs -lt 0) {
        # New session started - add previous session to global
        $state.global_cumulative_ms += $state.last_session_total_ms
        $lastCallMs = $currentSessionTotal
    }

    # Update state
    $state.last_session_total_ms = $currentSessionTotal
    $state.last_call_ms = $lastCallMs

    # Calculate display values
    $globalTotalMs = $state.global_cumulative_ms + $currentSessionTotal

    # Save state
    $state | ConvertTo-Json | Out-File $stateFile -Force

    # Format duration helper
    function Format-Duration($ms) {
        if ($ms -ge 60000) {
            return "{0:N1}m" -f ($ms / 60000)
        }
        if ($ms -ge 1000) {
            return "{0:N1}s" -f ($ms / 1000)
        }
        return "{0}ms" -f $ms
    }

    # Format: "API:45.2s (+1.2s)"
    $globalFormatted = Format-Duration $globalTotalMs
    $deltaFormatted = Format-Duration $lastCallMs
    $apiDuration = "${globalFormatted} (+${deltaFormatted})"
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
