# Troubleshooting

Common issues and solutions for the Claude Commands Library.

## Installation Issues

### Commands Not Found

**Symptom:** Running `/prompt` or other commands returns "command not found"

**Causes:**
1. Installation incomplete
2. Wrong directory
3. Files not deployed

**Solutions:**

```powershell
# Re-run installer
.\install-claude-commands.ps1

# Verify files exist
Test-Path .claude/commands/prompt.md
Test-Path .claude/library/prompt-perfection-core.md

# Check file permissions
Get-Acl .claude/commands/
```

### Installer Fails

**Symptom:** Installation script errors out

**Causes:**
1. Network issues
2. Permission denied
3. Path conflicts

**Solutions:**

```powershell
# Run as Administrator
Start-Process powershell -Verb RunAs

# Check execution policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Manual install
git clone https://github.com/Tadzesi/claude-ideas.git
Copy-Item -Recurse claude-ideas/.claude ./.claude
```

## Command Issues

### Phase 0 Not Running

**Symptom:** Commands skip directly to execution without asking questions

**Causes:**
1. Library file missing
2. Import syntax error
3. Corrupted command file

**Solutions:**

```powershell
# Check library exists
Test-Path .claude/library/prompt-perfection-core.md

# Verify command imports
Get-Content .claude/commands/prompt.md | Select-String "Import"

# Re-download command
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/.../prompt.md" -OutFile ".claude/commands/prompt.md"
```

### Agent Not Spawning

**Symptom:** Complex prompts don't trigger agent analysis

**Causes:**
1. Complexity score too low
2. Agent templates missing
3. Cache returning stale result

**Solutions:**

```powershell
# Force agent with flag
# /prompt-hybrid --agent Your prompt here

# Check complexity rules
Get-Content .claude/config/complexity-rules.json | ConvertFrom-Json

# Clear cache
Remove-Item .claude/cache/agent-results/* -Force
```

### Slow Performance

**Symptom:** Commands take much longer than expected

**Causes:**
1. Cache not working
2. Too many agents spawning
3. Large codebase scan

**Solutions:**

```powershell
# Check cache is enabled
(Get-Content .claude/config/cache-config.json | ConvertFrom-Json).enabled

# Reduce agent count
# Edit .claude/config/verification-config.json
# Set verification_agents.count to 2

# Use simpler command for quick tasks
# /prompt instead of /prompt-hybrid
```

## Configuration Issues

### Invalid JSON

**Symptom:** "Failed to parse configuration" errors

**Cause:** JSON syntax error

**Solution:**

```powershell
# Validate all config files
Get-ChildItem .claude/config/*.json | ForEach-Object {
    try {
        Get-Content $_.FullName | ConvertFrom-Json | Out-Null
        Write-Host "OK: $($_.Name)" -ForegroundColor Green
    } catch {
        Write-Host "ERROR: $($_.Name)" -ForegroundColor Red
        Write-Host $_.Exception.Message
    }
}
```

Common JSON errors:
- Trailing comma after last item
- Missing quotes around strings
- Single quotes instead of double quotes
- Unescaped backslashes in paths

### Settings Not Applied

**Symptom:** Changed configuration has no effect

**Causes:**
1. Cached old config
2. Wrong file edited
3. Syntax valid but semantically wrong

**Solutions:**

```powershell
# Clear cache
Remove-Item .claude/cache/* -Recurse -Force

# Verify you're editing the right file
# Project config: .claude/config/
# Global config: ~/.claude/config/

# Check JSON is valid
Get-Content .claude/config/complexity-rules.json | ConvertFrom-Json
```

## Statusline Issues

### Statusline Not Appearing

**Symptom:** No custom statusline at bottom of terminal

**Causes:**
1. Not configured in settings.json
2. Script path incorrect
3. Script execution blocked

**Solutions:**

```powershell
# Check settings
Get-Content "$env:USERPROFILE\.claude\settings.json"

# Verify script exists
Test-Path "$env:USERPROFILE\.claude\statusline.ps1"

# Check execution policy
Get-ExecutionPolicy

# Reinstall statusline
iwr -useb https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-statusline.ps1 | iex
```

### Shows "---%"

**Symptom:** Statusline shows dashes instead of values

**Cause:** Normal before first API call

**Solution:** Send a message to Claude Code; values populate after first response

### Wrong Path in Settings

**Symptom:** Statusline configured but not working

**Cause:** Path uses wrong format

**Solution:**

```json
{
  "statusLine": {
    "type": "command",
    "command": "powershell.exe -NoProfile -ExecutionPolicy Bypass -File C:\\Users\\YOUR_USERNAME\\.claude\\statusline.ps1"
  }
}
```

Note: Use double backslashes `\\` in JSON paths.

## Memory/Session Issues

### Session Not Saving

**Symptom:** `/session-end` doesn't persist data

**Causes:**
1. Memory directory missing
2. File permissions
3. Disk full

**Solutions:**

```powershell
# Create memory directory
New-Item -ItemType Directory -Path .claude/memory -Force

# Check permissions
Get-Acl .claude/memory

# Check disk space
Get-PSDrive C
```

### Session Not Loading

**Symptom:** `/session-start` shows no previous context

**Causes:**
1. No previous sessions
2. Memory files empty
3. Different project directory

**Solutions:**

```powershell
# Check session file exists
Test-Path .claude/memory/sessions.md

# View contents
Get-Content .claude/memory/sessions.md

# Ensure you're in correct project
Get-Location
```

## Cache Issues

### Cache Growing Too Large

**Symptom:** `.claude/cache/` consuming significant disk space

**Solution:**

```powershell
# Check size
(Get-ChildItem .claude/cache -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB

# Clear cache
Remove-Item .claude/cache/* -Recurse -Force

# Reduce max size in config
# Edit .claude/config/cache-config.json
# Set storage.max_size_mb to 25
```

### Stale Cache Results

**Symptom:** Analysis returns outdated information

**Causes:**
1. File changes not detected
2. Cache TTL too long
3. Manual file edits bypassed tracking

**Solution:**

```powershell
# Clear agent cache
Remove-Item .claude/cache/agent-results/* -Force

# Or use --no-cache flag
# /prompt-hybrid --no-cache Your prompt
```

## Learning System Issues

### Patterns Not Detected

**Symptom:** System doesn't suggest smart defaults

**Causes:**
1. Learning disabled
2. Threshold not met (need 3+ occurrences)
3. Pattern file missing

**Solutions:**

```powershell
# Check learning is enabled
(Get-Content .claude/config/learning-config.json | ConvertFrom-Json).enabled

# Check pattern file
Test-Path .claude/memory/prompt-patterns.md

# View recorded patterns
Get-Content .claude/memory/prompt-patterns.md
```

### Wrong Suggestions

**Symptom:** Smart defaults don't match preferences

**Solution:**

```powershell
# Reset patterns
Remove-Item .claude/memory/prompt-patterns.md

# Or edit to remove specific patterns
notepad .claude/memory/prompt-patterns.md
```

## Getting Help

### Debug Mode

Enable verbose output:

```bash
/prompt-hybrid --verbose Your prompt
```

### Check Versions

```powershell
# Check library version
Select-String "Version:" .claude/library/prompt-perfection-core.md

# Check command versions
Get-ChildItem .claude/commands/*.md | ForEach-Object {
    $version = Select-String "Version:" $_.FullName
    Write-Host "$($_.Name): $version"
}
```

### Report Issues

If problems persist:

1. Gather information:
   - Claude Code version
   - Library version
   - Error messages
   - Steps to reproduce

2. Report at: https://github.com/Tadzesi/claude-ideas/issues

## Quick Reference

| Issue | Quick Fix |
|-------|-----------|
| Commands not found | Re-run installer |
| Agent not spawning | Use `--agent` flag |
| Slow performance | Clear cache |
| Invalid config | Validate JSON syntax |
| Statusline missing | Check settings.json path |
| Session not saving | Create `.claude/memory/` |
| Cache too large | Delete `.claude/cache/*` |

