# Claude Code Status Line Script (Enhanced with Icons & Colors)
# Displays: Folder, Git Branch, Progress Bar, Tokens, Global API Duration
# API Duration: Cumulative across all sessions with delta indicator (+last call)
#
# NOTE: Context percentage is an approximation. Claude Code's statusline JSON
# provides cumulative session tokens, not actual context window usage.
# The /context command shows accurate values. See:
# https://github.com/anthropics/claude-code/issues/13783

# Read JSON from stdin
$jsonInput = [Console]::In.ReadToEnd()
$data = $jsonInput | ConvertFrom-Json

# --- ANSI Color Codes (Professional Palette) ---
$esc = [char]27
$reset = "$esc[0m"
$bold = "$esc[1m"
$dim = "$esc[2m"

# Colors
$cyan = "$esc[38;2;86;182;194m"      # Folder - soft cyan
$green = "$esc[38;2;152;195;121m"    # Git branch - soft green
$yellow = "$esc[38;2;229;192;123m"   # Warning/API - soft amber
$orange = "$esc[38;2;209;154;102m"   # API duration - soft orange
$gray = "$esc[38;2;150;150;150m"     # Dimmed text
$white = "$esc[38;2;220;220;220m"    # Normal text

# Context bar colors (gradient based on usage)
$barGreen = "$esc[38;2;152;195;121m"   # 0-50%
$barYellow = "$esc[38;2;229;192;123m"  # 50-75%
$barOrange = "$esc[38;2;209;154;102m"  # 75-90%
$barRed = "$esc[38;2;224;108;117m"     # 90%+

# --- Icons (Unicode) ---
$iconFolder = [char]0xF07B    # Folder icon (nerd font) or fallback
$iconBranch = [char]0xE725    # Git branch icon (nerd font) or fallback
$iconContext = [char]0xF200   # Chart icon or fallback
$iconTokens = [char]0xF15C    # Document icon or fallback
$iconApi = [char]0xF253       # Hourglass/timer icon or fallback

# Fallback to simpler icons if nerd fonts not available
# Using more universal Unicode symbols
$iconFolder = [char]0x25A0    # Small square
$iconBranch = [char]0x2387    # Branch symbol alternative
$iconContext = [char]0x25CF   # Filled circle
$iconTokens = [char]0x25B6    # Triangle
$iconApi = [char]0x25C6       # Diamond

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
# Note: Claude Code statusline JSON provides message tokens, not full context.
# Full context includes: system prompt, tools, MCP tools, memory files, and messages.
# We estimate total context by adding typical overhead to message tokens.
$contextSize = $data.context_window.context_window_size
$percentUsed = 0
$contextTokens = 0
$hasContextData = $false

# Autocompact buffer percentage (context reserved, not usable)
# Opus: 22.5%, Sonnet: ~20%, Haiku: ~15%
$autocompactBuffer = 0.225

# Note: The input_tokens from current_usage already includes message history
# but does NOT include system prompt, tools, MCP tools, memory files.
# We don't add overhead here because it would double-count.
# The percentage is calculated against usable context to match Claude's warnings.

# Try to get context from current_usage first
if ($data.context_window.current_usage) {
    $inputTokens = if ($data.context_window.current_usage.input_tokens) {
        $data.context_window.current_usage.input_tokens
    } else { 0 }
    $cacheCreation = if ($data.context_window.current_usage.cache_creation_input_tokens) {
        $data.context_window.current_usage.cache_creation_input_tokens
    } else { 0 }
    $cacheRead = if ($data.context_window.current_usage.cache_read_input_tokens) {
        $data.context_window.current_usage.cache_read_input_tokens
    } else { 0 }

    # Message tokens from last API call
    $messageTokens = $inputTokens + $cacheCreation + $cacheRead

    if ($messageTokens -gt 0) {
        $hasContextData = $true
        $contextTokens = $messageTokens

        if ($contextSize -gt 0) {
            # Calculate usable context (total minus autocompact buffer)
            $usableContext = $contextSize * (1 - $autocompactBuffer)

            # Calculate percentage of usable context to match Claude's warnings
            $percentUsed = [math]::Round(($contextTokens / $usableContext) * 100, 1)

            # Cap at 100% to avoid confusion
            if ($percentUsed -gt 100) { $percentUsed = 100 }
        }
    }
}

# Fallback: use total_input_tokens if current_usage is empty (first load)
if (-not $hasContextData -and $data.context_window.total_input_tokens) {
    $contextTokens = $data.context_window.total_input_tokens

    if ($contextTokens -gt 0 -and $contextSize -gt 0) {
        $hasContextData = $true
        $usableContext = $contextSize * (1 - $autocompactBuffer)
        $percentUsed = [math]::Round(($contextTokens / $usableContext) * 100, 1)
        if ($percentUsed -gt 100) { $percentUsed = 100 }
    }
}

# --- Cumulative Totals ---
$totalInput = if ($data.context_window.total_input_tokens) { $data.context_window.total_input_tokens } else { 0 }
$totalOutput = if ($data.context_window.total_output_tokens) { $data.context_window.total_output_tokens } else { 0 }

# --- API Duration (global cumulative with delta indicator) ---
$stateFile = Join-Path $env:USERPROFILE ".claude\.statusline-state.json"
$globalTotalMs = 0
$lastCallMs = 0
$hasValidDelta = $false

if ($data.cost -and $data.cost.total_api_duration_ms) {
    $currentSessionTotal = $data.cost.total_api_duration_ms

    # Default state
    $state = @{
        global_cumulative_ms = 0
        last_session_total_ms = 0
        last_call_ms = 0
        session_id = ""
    }

    # Read previous state from JSON file
    if (Test-Path $stateFile) {
        try {
            $content = Get-Content $stateFile -Raw -ErrorAction Stop
            if ($content) {
                $parsed = $content | ConvertFrom-Json -ErrorAction Stop
                # Convert PSObject to hashtable manually for compatibility
                $state = @{
                    global_cumulative_ms = if ($parsed.global_cumulative_ms) { [long]$parsed.global_cumulative_ms } else { 0 }
                    last_session_total_ms = if ($parsed.last_session_total_ms) { [long]$parsed.last_session_total_ms } else { 0 }
                    last_call_ms = if ($parsed.last_call_ms) { [long]$parsed.last_call_ms } else { 0 }
                    session_id = if ($parsed.session_id) { $parsed.session_id } else { "" }
                }
            }
        } catch {
            # State file corrupted or unreadable, use defaults
        }
    }

    # Get current session ID to detect session changes
    $currentSessionId = if ($data.session_id) { $data.session_id } else { "" }

    # Detect new session by session_id change or time going backwards
    $isNewSession = ($currentSessionId -ne $state.session_id -and $state.session_id -ne "") -or
                    ($currentSessionTotal -lt $state.last_session_total_ms)

    if ($isNewSession) {
        # New session started - add previous session to global
        $state.global_cumulative_ms += $state.last_session_total_ms
        $state.last_session_total_ms = 0
        $state.session_id = $currentSessionId
    }

    # Calculate last call duration (difference since last statusline update)
    $lastCallMs = $currentSessionTotal - $state.last_session_total_ms

    # Only show delta if we have a meaningful previous value (not first call)
    $hasValidDelta = ($state.last_session_total_ms -gt 0) -and ($lastCallMs -gt 0) -and ($lastCallMs -lt $currentSessionTotal)

    # Update state for next call
    $state.last_session_total_ms = $currentSessionTotal
    $state.last_call_ms = $lastCallMs
    $state.session_id = $currentSessionId

    # Calculate display values
    $globalTotalMs = $state.global_cumulative_ms + $currentSessionTotal

    # Save state with proper encoding
    try {
        $stateJson = $state | ConvertTo-Json -Compress
        [System.IO.File]::WriteAllText($stateFile, $stateJson, [System.Text.UTF8Encoding]::new($false))
    } catch {
        # Silently fail if we can't write state
    }
}

# --- Helper Functions ---
function Format-Duration($ms) {
    if ($ms -ge 60000) {
        return "{0:N1}m" -f ($ms / 60000)
    }
    if ($ms -ge 1000) {
        return "{0:N1}s" -f ($ms / 1000)
    }
    return "{0}ms" -f $ms
}

function Format-Tokens($count) {
    if ($count -ge 1000000) {
        return "{0:N1}M" -f ($count / 1000000)
    }
    if ($count -ge 1000) {
        return "{0:N1}k" -f ($count / 1000)
    }
    return $count.ToString()
}

function Get-ProgressBarColor($percent) {
    if ($percent -ge 90) { return $barRed }
    if ($percent -ge 75) { return $barOrange }
    if ($percent -ge 50) { return $barYellow }
    return $barGreen
}

function Get-ProgressBar($percent, $width) {
    $filled = [math]::Floor(($percent / 100) * $width)
    $empty = $width - $filled
    $filledChar = [char]0x2588  # Full block
    $emptyChar = [char]0x2591   # Light shade

    $barColor = Get-ProgressBarColor $percent
    $filledPart = "$barColor" + ($filledChar.ToString() * $filled)
    $emptyPart = "$gray" + ($emptyChar.ToString() * $empty)

    return "$filledPart$emptyPart$reset"
}

# --- Build Status Line ---
# Calculate usable context for display (total minus autocompact buffer)
$usableContextSize = [math]::Round($contextSize * (1 - $autocompactBuffer))
$fmtUsableSize = Format-Tokens $usableContextSize
$fmtTotalIn = Format-Tokens $totalInput
$fmtTotalOut = Format-Tokens $totalOutput

# Build colored parts
$parts = @()

# Folder with icon
$parts += "$cyan$iconFolder $folderName$reset"

# Git branch with icon (if available)
if ($gitBranch) {
    $parts += "$green$iconBranch $gitBranch$reset"
}

# Context usage with colored bar (or placeholder if no data yet)
if ($hasContextData) {
    $progressBar = Get-ProgressBar $percentUsed 10
    $barColor = Get-ProgressBarColor $percentUsed
    $fmtContextTokens = Format-Tokens $contextTokens
    # Show context vs usable context (not total)
    $parts += "$progressBar $barColor${percentUsed}%$reset"
    $parts += "$gray$iconContext$reset $white$fmtContextTokens$gray/$fmtUsableSize$reset"
} else {
    # No data yet - show waiting indicator
    $emptyBar = "$gray" + ([char]0x2591).ToString() * 10 + "$reset"
    $parts += "$emptyBar ${gray}---%$reset"
    $parts += "$gray$iconContext$reset ${gray}---/$fmtUsableSize$reset"
}

# Cumulative tokens
$parts += "$gray$iconTokens$reset $white$fmtTotalIn$gray/$fmtTotalOut$reset"

# API duration with icon
if ($globalTotalMs -gt 0) {
    $globalFormatted = Format-Duration $globalTotalMs
    if ($hasValidDelta) {
        # Show delta only if we have a meaningful value
        $deltaFormatted = Format-Duration $lastCallMs
        $parts += "$orange$iconApi$reset $yellow$globalFormatted$reset $gray(+$deltaFormatted)$reset"
    } else {
        # First call or invalid delta - just show total
        $parts += "$orange$iconApi$reset $yellow$globalFormatted$reset"
    }
}

# Join with separator
$separator = " $gray|$reset "
$status = $parts -join $separator

Write-Host $status
