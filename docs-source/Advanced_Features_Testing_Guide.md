# Advanced Features Testing Guide

**Purpose:** Comprehensive testing scenarios for the hybrid prompt system's advanced features: caching, multi-agent verification, and learning system.

**Last Updated:** 2025-12-18

---

## Testing Prerequisites

**Before testing, ensure:**
1. ✅ All configuration files exist:
   - `.claude/config/cache-config.json`
   - `.claude/config/verification-config.json`
   - `.claude/config/learning-config.json`
2. ✅ Memory directory exists: `.claude/memory/`
3. ✅ Cache directory will be created: `.claude/cache/agent-results/`
4. ✅ All advanced features are enabled in configs

**Quick Setup Check:**
```bash
# Windows PowerShell
Test-Path .claude/config/cache-config.json
Test-Path .claude/config/verification-config.json
Test-Path .claude/config/learning-config.json
Test-Path .claude/memory/prompt-patterns.md
```

---

## Test Suite 1: Agent Result Caching ⚡

### Test 1.1: First Run (Cache Miss)

**Objective:** Verify agent analysis works and results are cached.

**Input:**
```
/prompt-hybrid Add authentication following existing patterns in the codebase
```

**Expected Behavior:**
1. ✅ Complexity score calculated (should be 10+: pattern detection=6 + cross-cutting=4)
2. ✅ Message: "💾 No valid cache found - Running fresh analysis"
3. ✅ Agent spawns (Explore with "detect_patterns_and_conventions")
4. ✅ Agent explores codebase (10-30 seconds)
5. ✅ Agent returns findings
6. ✅ Message: "💾 Saving agent results to cache for future use..."
7. ✅ Perfected prompt displayed with agent insights

**Validation:**
- Check `.claude/cache/agent-results/` directory was created
- Verify cache file exists (file name includes prompt hash)
- Time recorded: ~20 seconds

---

### Test 1.2: Cache Hit (Same Prompt)

**Objective:** Verify cached results are used.

**Input:** (Same as Test 1.1, run within 24 hours)
```
/prompt-hybrid Add authentication following existing patterns in the codebase
```

**Expected Behavior:**
1. ✅ Complexity score calculated (same as before)
2. ✅ Message: "⚡ Cache Hit - Using Previous Analysis"
3. ✅ Shows cache metadata:
   - Cached from: [timestamp] ([X] hours ago)
   - Agent type: Explore
   - Files analyzed: [count]
   - Branch: main
4. ✅ Message: "Loading cached results... ✅"
5. ✅ Perfected prompt displayed with cached agent insights
6. ✅ NO agent spawned

**Validation:**
- Time recorded: ~2 seconds (10-20x faster!)
- No new agent execution
- Same findings as Test 1.1

**Performance Check:**
```
Time (Test 1.1): ~20s
Time (Test 1.2): ~2s
Speedup: ~10x ✅
```

---

### Test 1.3: Cache Invalidation (File Change)

**Objective:** Verify cache invalidates when files change.

**Setup:**
1. Run Test 1.2 to ensure cache exists
2. Modify a relevant file (e.g., create `src/auth/NewAuthService.cs`)

**Input:** (Same prompt as before)
```
/prompt-hybrid Add authentication following existing patterns in the codebase
```

**Expected Behavior:**
1. ✅ Message: "💾 No valid cache found - Running fresh analysis"
2. ✅ Reason shown: "Files changed"
3. ✅ Agent spawns again
4. ✅ New cache created with updated file hashes

**Validation:**
- Agent runs again (not cached)
- New findings may include the newly created file
- New cache file created

---

### Test 1.4: Cache Invalidation (Branch Change)

**Objective:** Verify cache invalidates when git branch changes.

**Setup:**
1. Ensure cache exists from previous test
2. Create and switch to new branch: `git checkout -b feature/test-cache`

**Input:** (Same prompt)
```
/prompt-hybrid Add authentication following existing patterns in the codebase
```

**Expected Behavior:**
1. ✅ Message: "💾 No valid cache found - Running fresh analysis"
2. ✅ Reason shown: "Branch changed"
3. ✅ Agent spawns
4. ✅ New cache created for the new branch

**Validation:**
- Separate cache for `main` and `feature/test-cache` branches
- Switching back to `main` should hit cache again

---

### Test 1.5: Cache Expiration (24h)

**Objective:** Verify cache expires after configured time.

**Setup:**
This test requires waiting 24 hours OR manually editing cache config:
```json
// .claude/config/cache-config.json
"max_cache_age_hours": 0.01  // 36 seconds for testing
```

**Input:** (After expiration time)
```
/prompt-hybrid Add authentication following existing patterns in the codebase
```

**Expected Behavior:**
1. ✅ Message: "💾 No valid cache found - Running fresh analysis"
2. ✅ Reason shown: "Expired"
3. ✅ Agent runs fresh analysis

**Cleanup:**
Reset `max_cache_age_hours` back to 24 after testing.

---

## Test Suite 2: Multi-Agent Verification 🔍

### Test 2.1: Critical Keyword Trigger

**Objective:** Verify multi-agent verification triggers for critical keywords.

**Input:**
```
/prompt-hybrid Implement payment processing with credit card handling
```

**Expected Behavior:**
1. ✅ Complexity score >= 10 (implementation=3 + critical keyword "payment"=trigger)
2. ✅ Message: "🔍 Multi-Agent Verification Initiated"
3. ✅ Verification reason: "Critical operation detected (payment)"
4. ✅ Shows: "Spawning [2-3] additional agents with different strategies..."
5. ✅ Lists strategies:
   - Breadth-First Exploration (Haiku, 30s)
   - Depth-First Analysis (Sonnet, 45s)
   - Pattern-Focused Verification (Haiku, 30s)
6. ✅ Message: "Running agents in parallel... ⏳"
7. ✅ All agents complete
8. ✅ Consensus analysis displayed:
   - Agreement Level: High/Medium/Low
   - Unanimous Findings
   - Majority Findings
   - Disagreements (if any)
   - Aggregated Recommendations

**Validation:**
- 2-3 agents spawned (check parallel execution)
- Time: ~50 seconds (not 90s, because parallel)
- Consensus analysis shows agreement percentage
- User can review all perspectives

---

### Test 2.2: High Complexity Score Trigger

**Objective:** Verify verification triggers for complexity >= 15.

**Input:**
```
/prompt-hybrid Refactor the entire authentication system across all files to use OAuth following existing patterns
```

**Expected Behavior:**
1. ✅ Complexity score calculated:
   - "refactor" = 5
   - "entire" + "across all files" = 5 (multi-file)
   - "authentication" = 4 (cross-cutting)
   - "following existing patterns" = 6 (pattern detection)
   - **Total: 20** (triggers multi-agent verification)
2. ✅ Verification initiated
3. ✅ Multiple agents spawn
4. ✅ Consensus analysis provided

---

### Test 2.3: Consensus Analysis (High Agreement)

**Objective:** Verify consensus when agents agree.

**Input:** Use same as Test 2.1

**Expected Output Example:**
```
✅ Multi-Agent Verification Complete

### Consensus Analysis:

**Agreement Level:** High (85%)

**Unanimous Findings:**
- Use existing PaymentService pattern
- Integrate with Stripe API
- Store transactions in PaymentTransactions table

**Majority Findings (2/3 agents):**
- Implement PCI DSS compliance checklist
- Add fraud detection middleware

**Disagreements:**
(None)

**Confidence Assessment:**
- Pattern Detection: High
- Feasibility: High
- Recommended Approach: High
```

**Validation:**
- Agreement level >= 80%
- Most findings are unanimous
- Clear recommendations

---

### Test 2.4: Consensus Analysis (Disagreements)

**Objective:** Verify handling when agents disagree.

**Input:**
```
/prompt-hybrid Add real-time notifications using WebSockets or SignalR or Server-Sent Events
```

**Expected Output Example:**
```
✅ Multi-Agent Verification Complete

### Consensus Analysis:

**Agreement Level:** Medium (70%)

**Unanimous Findings:**
- Real-time communication needed
- Client-server bidirectional connection

**Disagreements:**
⚠️ Agent 1 found: WebSockets recommended (full-duplex, mature)
⚠️ Agent 2 found: SignalR recommended (ASP.NET integration, fallback)
⚠️ Agent 3 found: Server-Sent Events recommended (simpler, one-way)

**Multiple perspectives detected. Which approach do you prefer?**
- Option 1: SignalR (2 agents recommend)
- Option 2: WebSockets (1 agent recommends)
- Explain: Show detailed reasoning from each agent
```

**Validation:**
- Disagreements clearly shown
- User prompted to choose
- All perspectives preserved

---

### Test 2.5: Manual Verification Trigger

**Objective:** Verify user can manually request verification.

**Input:**
```
/prompt-hybrid Add simple logging to UserService --verify
```

**Expected Behavior:**
1. ✅ Complexity score low (< 15)
2. ✅ Verification triggered anyway due to `--verify` flag
3. ✅ Multi-agent verification runs
4. ✅ Consensus provided even for simple task

**Note:** The `--verify` flag may need to be implemented in the actual command logic.

---

## Test Suite 3: Learning System 📚

### Test 3.1: First Pattern Occurrence

**Objective:** Track first occurrence of a pattern.

**Input:**
```
/prompt-hybrid Add user registration with email validation
```

**Expected Behavior:**
1. ✅ Normal prompt perfection flow
2. ✅ After approval: "📚 Recording prompt pattern for learning..."
3. ✅ Entry added to `.claude/memory/prompt-patterns.md`

**Validation:**
Open `.claude/memory/prompt-patterns.md` and verify:
```markdown
### 2025-12-18 - Implementation - Complexity: 7

**Original Prompt:**
Add user registration with email validation

**Complexity Score:** 7 (Simple/Moderate/Complex)
**Triggered Rules:** [implementation_planning, cross_cutting_concerns]
**Agent Used:** No
**Cache Hit:** No
**Multi-Agent Verification:** No

**Missing Information Detected:**
- Database context unclear
- UI requirements missing

**Questions Asked:**
1. Which database table to use?
2. Where should the registration form be?

**Perfected Prompt:**
[The perfected version]

**User Modifications:** None
**Approval Status:** Approved

**Learning Insights:**
- Pattern: User registration prompts often miss database context
- Smart Default Opportunity: Auto-suggest database table selection
- Complexity Score Accuracy: correct
```

**Statistics Updated:**
- Total prompts processed: 1
- Agent-assisted: 0
- Cache hit rate: 0%
- User approval rate: 100%

---

### Test 3.2: Second Pattern Occurrence

**Objective:** Track second occurrence, no smart default yet.

**Input:**
```
/prompt-hybrid Add password reset functionality
```

**Expected Behavior:**
1. ✅ Pattern recorded
2. ✅ Counter incremented for "authentication" or similar pattern
3. ✅ NO smart default suggested (threshold is 3)

**Validation:**
- Check prompt-patterns.md shows 2 entries
- No learning insight message yet

---

### Test 3.3: Third Occurrence - Smart Default Triggered

**Objective:** Verify smart defaults suggested after 3 occurrences.

**Input:**
```
/prompt-hybrid Add two-factor authentication
```

**Expected Behavior:**
1. ✅ Pattern detected: "authentication" mentioned 3+ times
2. ✅ Message: "💡 Learning Insight Detected"
3. ✅ Shows:
   ```
   Pattern: Authentication prompts are missing security requirements
   Occurrences: 3

   **Suggested Smart Default:**
   When prompt contains "authentication", auto-suggest:
   - Security scanning with OWASP guidelines
   - Password hashing method (BCrypt)
   - Token expiration strategy
   - Existing AuthService pattern from src/auth/

   Would you like to apply this smart default in future prompts? (yes/no)
   ```
4. ✅ User responds "yes"
5. ✅ Smart default applied to current prompt
6. ✅ Future "authentication" prompts auto-include these suggestions

**Validation:**
- Learning insight message shown
- Smart defaults applied
- Recorded in prompt-patterns.md

---

### Test 3.4: Complexity Score Accuracy Feedback

**Objective:** Verify learning system tracks complexity score accuracy.

**Setup:**
Create a prompt that should be simple but is scored as complex.

**Input:**
```
/prompt-hybrid Fix typo in README.md line 42 following existing style
```

**Expected Behavior:**
1. ✅ Complexity score: 6 (pattern detection=6 for "following existing style")
2. ✅ Categorized as "Moderate" (5-9)
3. ✅ User asked if agent assistance wanted
4. ✅ User selects "no" (because it's actually simple)
5. ✅ After approval, learning system records:
   ```
   📊 Complexity Score Feedback

   This prompt was scored as Moderate but should have been Simple.

   **Suggested weight adjustments:**
   - pattern_detection: 6 → 3 (for trivial pattern matching)

   Feedback recorded for future calibration.
   ```

**Validation:**
- Feedback recorded in prompt-patterns.md
- Suggestion shown to user
- Pattern accuracy tracked

---

### Test 3.5: User Preference Learning

**Objective:** Track user modification patterns.

**Input:**
```
/prompt-hybrid Create a new user profile page
```

**Expected Behavior:**
1. ✅ Prompt perfected
2. ✅ User uses `modify` command: "Add React TypeScript component"
3. ✅ Learning system records:
   - User prefers TypeScript
   - User prefers explicit component type

**After 3 similar modifications:**
4. ✅ Smart default suggested: "Auto-include TypeScript specification"

**Validation:**
- User modifications tracked
- Preferences learned
- Smart defaults offered

---

### Test 3.6: Agent Effectiveness Metrics

**Objective:** Track agent performance over time.

**Setup:** Run multiple complex prompts that spawn agents.

**Expected Behavior:**
After 5+ agent-assisted prompts, check `.claude/memory/prompt-patterns.md`:

```markdown
## 5. Agent Effectiveness

**Agent Type:** Explore
**Template:** detect_patterns_and_conventions
**Usage Count:** 5

**Effectiveness Metrics:**
- Relevant findings: 90%
- User satisfaction: 80%
- Time to complete: 22s (average)
- Cache hit rate: 40%

**Common Findings:**
- Pattern detection: 5 times
- Similar implementations found: 4 times
- Feasibility validated: 5 times

**Improvement Suggestions:**
- Template could include more examples
- Consider adding framework-specific patterns
```

**Validation:**
- Metrics calculated correctly
- Average time tracked
- Common findings identified
- Improvement suggestions generated

---

## Test Suite 4: Integration Testing

### Test 4.1: Caching + Learning

**Objective:** Verify caching and learning work together.

**Test Steps:**
1. Run complex prompt (Test 1.1) - Cache miss, learning tracked
2. Run same prompt (Test 1.2) - Cache hit, learning updated with cache performance
3. Check prompt-patterns.md - Should show cache hit recorded

**Expected Entry:**
```markdown
**Agent Findings (if applicable):**
- Relevant Files: 15
- Patterns Found: JWT authentication in src/auth/
- Feasibility: Feasible
- Cache Performance: hit, 18s saved
```

---

### Test 4.2: Multi-Agent + Learning

**Objective:** Verify multi-agent verification findings are learned.

**Test Steps:**
1. Run Test 2.1 (payment processing)
2. Run Test 2.1 again (different payment prompt)
3. Run Test 2.1 third time

**Expected Behavior:**
- Third occurrence triggers smart default: "payment processing"
- Smart default includes security checklist from multi-agent consensus
- Future payment prompts auto-include PCI DSS compliance

---

### Test 4.3: Cache + Multi-Agent

**Objective:** Verify cached multi-agent results are used.

**Test Steps:**
1. Run Test 2.1 - Multi-agent verification runs (~50s)
2. Run Test 2.1 again (same prompt, within 24h)

**Expected Behavior:**
1. ✅ Cache hit for multi-agent results
2. ✅ Shows: "Loading cached verification results..."
3. ✅ Consensus analysis displayed from cache
4. ✅ Time: ~2s (not 50s!)

---

### Test 4.4: All Features Together

**Objective:** Full integration test.

**Input:** (First time)
```
/prompt-hybrid Implement secure payment processing with Stripe integration following existing patterns
```

**Expected Behavior:**
1. ✅ Complexity: 17 (implementation=3 + cross-cutting=4 + pattern=6 + critical "payment"=trigger)
2. ✅ Multi-agent verification triggered
3. ✅ 3 agents run in parallel
4. ✅ Consensus analysis provided
5. ✅ Results cached
6. ✅ Pattern learned
7. ✅ Time: ~50s

**Second Run (Same prompt):**
1. ✅ Cache hit
2. ✅ Multi-agent results from cache
3. ✅ Pattern occurrence count incremented
4. ✅ Time: ~2s

**Third Run (Similar prompt: "Add payment for subscriptions"):**
1. ✅ Cache miss (different prompt)
2. ✅ Smart default suggested! (payment pattern >= 3)
3. ✅ Auto-includes: Security checklist, PCI DSS, Stripe pattern
4. ✅ Agent spawned with enhanced context
5. ✅ Results cached
6. ✅ Time: ~20s

---

## Test Suite 5: Configuration & Edge Cases

### Test 5.1: Disable Caching

**Setup:**
```json
// .claude/config/cache-config.json
"cache_settings": {
  "enabled": false,
  ...
}
```

**Input:** Any complex prompt

**Expected Behavior:**
- ✅ No cache check
- ✅ Agent always runs fresh
- ✅ No cache save

---

### Test 5.2: Disable Verification

**Setup:**
```json
// .claude/config/verification-config.json
"verification_settings": {
  "enabled": false,
  ...
}
```

**Input:** Payment processing prompt

**Expected Behavior:**
- ✅ No multi-agent verification
- ✅ Single agent only (normal flow)

---

### Test 5.3: Disable Learning

**Setup:**
```json
// .claude/config/learning-config.json
"learning_settings": {
  "enabled": false,
  ...
}
```

**Input:** Any prompt

**Expected Behavior:**
- ✅ No pattern recording
- ✅ No smart defaults
- ✅ prompt-patterns.md not updated

---

### Test 5.4: Adjust Learning Threshold

**Setup:**
```json
// .claude/config/learning-config.json
"learning_settings": {
  "learning_threshold": 2,  // Trigger at 2 instead of 3
  ...
}
```

**Input:** Second occurrence of a pattern

**Expected Behavior:**
- ✅ Smart default offered after 2 occurrences
- ✅ Earlier learning activation

---

### Test 5.5: Cache Size Limit

**Setup:**
Fill cache with many prompts until approaching 50MB limit.

**Expected Behavior:**
- ✅ Oldest cache entries auto-deleted
- ✅ Total cache size stays below `max_cache_size_mb`
- ✅ Most recent entries preserved

---

## Test Suite 6: Error Handling

### Test 6.1: Agent Timeout (Cache Fallback)

**Setup:**
Temporarily edit agent template to include slow operation, or set very low timeout:
```json
// .claude/config/cache-config.json
"agent_config": {
  "explore": {
    "timeout": 1000  // 1 second (too short)
  }
}
```

**Expected Behavior:**
- ✅ Agent times out
- ✅ Falls back to simple path with warning
- ✅ No cache created (incomplete results)

**Cleanup:** Reset timeout to 30000.

---

### Test 6.2: Corrupted Cache File

**Setup:**
1. Create cache entry
2. Manually corrupt the cache file (edit with invalid JSON)

**Expected Behavior:**
- ✅ Cache validation fails
- ✅ Message: "💾 No valid cache found - Running fresh analysis"
- ✅ Reason: "Cache corrupted"
- ✅ Agent runs fresh

---

### Test 6.3: Missing Config File

**Setup:**
Temporarily rename `.claude/config/cache-config.json`

**Expected Behavior:**
- ✅ Default to cache disabled
- ✅ Warning message about missing config
- ✅ Continue with normal flow

**Cleanup:** Restore config file.

---

## Performance Benchmarks

### Benchmark 1: Cache Performance

**Metric:** Time saved with caching

| Test Case | First Run (No Cache) | Cached Run | Speedup |
|-----------|---------------------|------------|---------|
| Complex prompt (Explore) | ~20s | ~2s | 10x |
| Complex prompt (Plan) | ~35s | ~2s | 17.5x |
| Multi-agent (3 agents) | ~50s | ~2s | 25x |

**Target:** >= 10x speedup

---

### Benchmark 2: Multi-Agent Parallel Execution

**Metric:** Time for multi-agent verification

| Execution Mode | Time |
|---------------|------|
| 3 Agents Sequential | ~90s (30s + 30s + 30s) |
| 3 Agents Parallel | ~50s (max of all) |

**Efficiency:** ~44% time saved

---

### Benchmark 3: Learning System Overhead

**Metric:** Time added by learning tracking

| Operation | Time |
|-----------|------|
| Pattern recording | < 500ms |
| Smart default lookup | < 100ms |
| Statistics update | < 200ms |

**Total Overhead:** < 1s (negligible)

---

## Success Criteria

**All features pass when:**

### Agent Caching ⚡
- ✅ Cache miss runs agent normally
- ✅ Cache hit returns in ~2s (10-20x faster)
- ✅ Cache invalidates on file changes
- ✅ Cache invalidates on branch changes
- ✅ Cache expires after configured time
- ✅ Cache auto-cleans at size limit

### Multi-Agent Verification 🔍
- ✅ Triggers for complexity >= 15
- ✅ Triggers for critical keywords
- ✅ 2-3 agents run in parallel
- ✅ Consensus analysis shows agreement level
- ✅ Unanimous and majority findings separated
- ✅ Disagreements clearly shown
- ✅ User can choose approach when agents disagree

### Learning System 📚
- ✅ Patterns tracked after each prompt
- ✅ Smart defaults offered after 3+ occurrences
- ✅ Complexity score accuracy feedback
- ✅ User preferences learned
- ✅ Agent effectiveness metrics calculated
- ✅ Statistics updated correctly

### Integration
- ✅ Caching + Learning work together
- ✅ Multi-Agent + Learning work together
- ✅ Multi-Agent results can be cached
- ✅ All features together work seamlessly

### Configuration
- ✅ Can disable each feature independently
- ✅ Thresholds configurable
- ✅ Defaults sensible

### Error Handling
- ✅ Agent timeout handled gracefully
- ✅ Corrupted cache handled
- ✅ Missing configs handled

---

## Testing Checklist

**Before Release:**

- [ ] Run all tests in Test Suite 1 (Caching)
- [ ] Run all tests in Test Suite 2 (Multi-Agent)
- [ ] Run all tests in Test Suite 3 (Learning)
- [ ] Run all tests in Test Suite 4 (Integration)
- [ ] Run all tests in Test Suite 5 (Configuration)
- [ ] Run all tests in Test Suite 6 (Error Handling)
- [ ] Verify all performance benchmarks
- [ ] Confirm all success criteria met
- [ ] Test on clean installation
- [ ] Test with default configs
- [ ] Test with custom configs
- [ ] Document any known issues

---

## Troubleshooting Test Failures

**If cache not working:**
1. Check `.claude/config/cache-config.json` exists and `"enabled": true`
2. Verify `.claude/cache/agent-results/` directory created
3. Check file permissions
4. Review logs for cache validation errors

**If multi-agent not triggering:**
1. Check `.claude/config/verification-config.json` exists and `"enabled": true`
2. Verify complexity score >= 15 OR critical keyword present
3. Check `verification_triggers` in config
4. Review complexity calculation

**If learning not tracking:**
1. Check `.claude/config/learning-config.json` exists and `"enabled": true`
2. Verify `.claude/memory/prompt-patterns.md` exists and writable
3. Check `learning_threshold` setting
4. Review pattern matching logic

**General debugging:**
- Enable verbose logging in configs
- Check all config files for JSON syntax errors
- Verify file permissions for all directories
- Review error messages carefully

---

**Testing Status:** Ready for execution
**Last Updated:** 2025-12-18
**Tested By:** [To be filled during testing]
**Test Results:** [To be filled during testing]
