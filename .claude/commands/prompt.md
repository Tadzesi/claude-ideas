# /prompt - Prompt Perfection

Transform any prompt into an unambiguous, executable format through systematic validation and clarification.

This command uses the **Unified Library System** for consistent Phase 0 prompt perfection.

---

## Phase 0: Prompt Perfection

**Import:** Use Phase 0 from `.claude/library/prompt-perfection-core.md`
**Adaptation:** None (universal criteria only)

**Process:**

### Step 0.1: Initial Analysis

Examine the user's input and detect:
- Language (Slovak / English)
- Prompt type (Question | Task | Bug Fix | Explanation | Code Review | Other)
- Core intent (what the user ultimately wants)

### Step 0.2: Completeness Check

Verify the prompt contains the **6 universal criteria:**
- [ ] **Goal:** Clear desired outcome
- [ ] **Context:** Project, technology, environment
- [ ] **Scope:** Which files, components, areas
- [ ] **Requirements:** Specific needs
- [ ] **Constraints:** Limitations, rules (optional)
- [ ] **Expected Result:** How to verify success

Mark missing items for clarification.

### Step 0.3: Clarification Questions

If anything is missing or unclear, ask questions with priority:

**🚨 Critical (must have):**
- Questions about Goal, Scope, or Expected Result
- Ambiguities that block execution

**⚠️ Important (should have):**
- Questions about Context or Requirements
- Information that improves quality

**💡 Optional (nice to have):**
- Questions about Constraints or optimizations

**If multiple valid approaches exist:**
- List each option with pros/cons
- Mark ⭐ recommended option with reasoning
- Wait for user selection

### Step 0.4-0.5: Correction & Output

Once all information gathered:
1. Fix grammar, spelling, sentence structure
2. Preserve technical terms EXACTLY
3. Make it clear, specific, actionable

Output the perfected prompt:

```markdown
**✨ Perfected Prompt:**

**Goal:** [One clear sentence stating desired outcome]

**Context:**
- Environment: [OS, platform]
- Tech Stack: [languages, frameworks]
- Background: [relevant context]

**Scope:**
- Files to modify: [list]
- Files to create: [list]
- Components affected: [list]

**Requirements:**
1. [First specific requirement]
2. [Second specific requirement]
...

**Constraints:**
- [Constraint 1]
- [Constraint 2]
Or: None

**Expected Result:**
[Clear description of what success looks like]

**Changes Made:**
- [List of corrections and improvements]
```

### Step 0.6: Approval Gate

Wait for user approval before proceeding:

```markdown
⏸️ **Perfected Prompt Ready - Awaiting Your Approval**

**Summary:**
- Type: [prompt type]
- Goal: [brief summary]
- Confidence: [High/Medium based on completeness]

**Reply with:**
- `y` or `yes` — Execute this perfected prompt
- `n` or `no` — Cancel
- `modify [description]` — Adjust the prompt
- `explain [component]` — Explain why I included something
```

**Handle responses:**
- `yes`/`y` → Proceed to execution
- `no`/`n` → Cancel
- `modify` → Apply changes, re-display, wait for approval
- `explain` → Provide explanation, re-prompt

---

## Execution

After user approves:

```markdown
✅ **Prompt Perfected and Approved**

You can now use this perfected prompt for your task.

**What would you like to do next?**
- If this was a question: I can answer it now with full context
- If this was a task: I can begin implementation
- If this was planning: I can create an implementation plan
```

---

## Good Prompt Tips

1. **Be specific** - "Fix null reference in UserService.GetUser()" not "fix my code"
2. **Include context** - Technologies, frameworks, environment
3. **Specify output format** - How should the result be structured?
4. **Provide background** - Error messages, what you tried
5. **Break down complexity** - Use numbered requirements

---

## Examples

### Example 1: Vague Prompt

**Input:**
```
/prompt help with my code
```

**Process:**
- Missing: Goal (what help?), Context (what code?), Scope (which files?)
- Questions asked for all missing info
- User provides: "Fix bug in login.js, NullPointerException on line 42"
- Result: Perfected prompt with clear goal, exact file, specific issue

### Example 2: Complete Prompt

**Input:**
```
/prompt Add email validation to UserService.Register() method in C#. Use regex pattern, return validation error if invalid. Should work with .NET 6.
```

**Process:**
- All criteria present
- Minor corrections: clarify regex pattern
- Result: Perfected prompt, ready for immediate execution

### Example 3: Multiple Approaches

**Input:**
```
/prompt Add caching to the API
```

**Process:**
- Missing: Which caching approach?
- Options presented:
  - Option 1: In-memory caching (fast, simple)
  - Option 2: Redis (distributed, scalable)
  - Option 3: Database caching (persistent)
- User selects Option 2
- Result: Perfected prompt with Redis implementation plan

---

## When to Use /prompt vs Other Commands

### Use `/prompt` when:
- ✅ Quick, simple prompts
- ✅ You provide all context
- ✅ Single-file or small scope
- ✅ No codebase analysis needed

### Use `/prompt-hybrid` when:
- ✅ Complex tasks needing codebase exploration
- ✅ Pattern detection required
- ✅ Multi-file scope
- ✅ Agent assistance helpful

### Use `/prompt-technical` when:
- ✅ Need technical implementation options
- ✅ Want code scaffolding
- ✅ Need best practices guidance
- ✅ Architecture decisions needed

### Use `/prompt-article` when:
- ✅ Writing articles or content
- ✅ Need multi-platform formatting
- ✅ Interactive wizard preferred

---

## Version History

**v2.0 (2024-12-19):**
- ✨ Migrated to unified library system
- ✨ References prompt-perfection-core.md
- ✨ Consistent with other prompt commands
- Maintains same user experience

**v1.0 (Previous):**
- Standalone Phase 0 implementation
- Basic prompt perfection

---

## Related Commands

- **More Complex:** `/prompt-hybrid` (with agent support)
- **Technical Focus:** `/prompt-technical` (implementation analysis)
- **Content Creation:** `/prompt-article` (article wizard)

---

## Library Integration

This command uses the **Unified Library System:**
- **Core:** `.claude/library/prompt-perfection-core.md` (universal Phase 0)
- **Adapter:** None (uses core only)
- **Benefits:** Consistent validation, proven flow, easy maintenance

For details on the library system, see: `doc/Unified_Library_System_Guide.md`

---

**Ready to perfect your prompt? Just type: `/prompt [your prompt]`**
