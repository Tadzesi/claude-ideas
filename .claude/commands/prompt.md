## Phase 0: Prompt Perfection

Analyze, clarify, and perfect the user's prompt. Your goal: transform it into an unambiguous, executable prompt that requires ZERO guessing.

### Step 0.1: Initial Analysis
- Detect language (Slovak / English)
- Identify prompt type: [Question | Task | Bug Fix | Explanation | Code Review | Other]
- Extract the core intent: What does the user ultimately want to achieve?

### Step 0.2: Completeness Check
Verify the prompt contains:
- [ ] Clear goal/desired outcome
- [ ] Context (project, technology, environment)
- [ ] Scope (which files, components, areas)
- [ ] Constraints (if any: performance, security, compatibility)
- [ ] Success criteria (how to verify it's done)

Mark missing items and ASK about them.

### Step 0.3: Clarification (if needed)
- If anything is ambiguous or unclear, ASK before proceeding
- If multiple valid approaches exist:
  - List each option with pros/cons
  - Mark ⭐ recommended option with reasoning
  - Wait for user selection

### Step 0.4: Correction
- Fix grammar, spelling, sentence structure
- Preserve all technical terms, code references, variable names EXACTLY
- Keep original intent and tone
- Make it clear, specific, and actionable

### Step 0.5: Structure the Perfect Prompt
Transform into an executable format with:
1. **Goal** - One sentence stating the desired outcome
2. **Context** - Environment, technologies, relevant background
3. **Scope** - What specifically to work on
4. **Requirements** - Numbered list of specific requirements
5. **Constraints** - Any limitations or rules to follow
6. **Expected Result** - What success looks like

---

## Phase 0 Output Format

**Detected Language:** [Slovak / English]
**Prompt Type:** [Question | Task | Bug Fix | Explanation | Code Review | Other]

**Original:**
> $ARGUMENTS

**Completeness Check:**
- [x] Goal: [extracted or ❌ MISSING]
- [x] Context: [extracted or ❌ MISSING]
- [x] Scope: [extracted or ❌ MISSING]
- [ ] Constraints: [extracted or ❌ MISSING - optional]
- [x] Success Criteria: [extracted or ❌ MISSING]

**Questions (if any):**
> 1. [Question about missing/unclear information]
> 2. [Another question if needed]

**Options (if multiple approaches):**
> 1. [Option A] - [pros/cons]
> 2. [Option B] - [pros/cons]
> ⭐ **Recommended:** [Option X] - [reasoning]
>
> *Select option(s): e.g., "1" or "1,3"*

---

*After all questions answered and options selected:*

**Perfected Prompt:**
> **Goal:** [one clear sentence]
>
> **Context:** [environment, tech stack, background]
>
> **Scope:** [specific files, components, areas]
>
> **Requirements:**
> 1. [First specific requirement]
> 2. [Second specific requirement]
> 3. [...]
>
> **Constraints:** [any limitations, or "None"]
>
> **Expected Result:** [what success looks like]

**Changes Made:**
- [list of corrections and improvements]

---

## Good Prompt Tips (Reference)
1. **Be specific** - "Fix null reference in UserService.GetUser()" not "fix my code"
2. **Include context** - Technologies, frameworks, environment
3. **Specify output format** - How should the result be structured?
4. **Provide background** - Error messages, what you already tried
5. **Break down complexity** - Use numbered requirements

---

⏸️ **Waiting for your approval.** Reply with:
- `y` or `yes` — execute the perfected prompt
- `n` or `no` — cancel
- Or type modifications for adjustments
