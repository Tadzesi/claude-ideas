# Prompt Perfection Core Library

**Version:** 1.0
**Last Updated:** 2024-12-19
**Purpose:** Canonical Phase 0 implementation for all prompt commands

---

## Overview

This library defines the **universal Phase 0 flow** for transforming any user input into a perfect, unambiguous prompt that Claude Code can execute without guessing.

All prompt commands should use this library as their foundation, with optional domain-specific adaptations.

---

## How to Use This Library

### In Your Slash Command

Add this reference at the beginning of your command file:

```markdown
## Phase 0: Prompt Perfection

**Import:** Use the canonical Phase 0 flow from `.claude/library/prompt-perfection-core.md`

**Adaptation:** [None | Technical | Article | Session | Custom]

**Domain-Specific Criteria:** [If applicable, list additional criteria]
```

When Claude reads your command, it will:
1. Load this library's Phase 0 definition
2. Apply any domain-specific adaptations you specify
3. Execute the perfected flow consistently

---

## The Canonical Phase 0 Flow

### Step 0.1: Initial Analysis

**Purpose:** Understand what the user wants

**Actions:**
1. **Detect language:** Slovak / English / Other
2. **Identify prompt type:**
   - Task (implementation work)
   - Question (information request)
   - Bug Fix (problem resolution)
   - Explanation (understanding codebase)
   - Code Review (quality assessment)
   - Refactoring (code improvement)
   - Content Creation (writing/documentation)
   - Session Management (context saving/loading)
   - Other (specify)
3. **Extract core intent:** What does the user ultimately want to achieve?

**Output Format:**
```markdown
**Phase 0: Prompt Perfection**

**Detected Language:** [language]
**Prompt Type:** [type]
**Core Intent:** [one sentence summary]

**Original Input:**
> [user's exact words]
```

---

### Step 0.15: Predictive Intelligence (OPTIONAL - NEW v4.0)

**Purpose:** Provide proactive guidance and anticipate user needs BEFORE asking for missing information

**When to use:** When predictive intelligence is enabled in configuration

**Import:** Use Predictive Intelligence from `.claude/library/intelligence/predictive-intelligence-core.md`

**Configuration:** Check `.claude/config/predictive-intelligence.json` → `enabled`

**Process:**

IF predictive_intelligence.enabled == true:
  1. **Journey Stage Detection** - Understand where user is (exploring/implementing/debugging)
  2. **Domain Risk Analysis** - Identify security/compliance risks specific to domain
  3. **Project Pattern Recognition** - Detect existing project conventions
  4. **Relationship Mapping** - Connect to previous work and related areas
  5. **Proactive Warning System** - Warn about problems BEFORE user makes mistakes
  6. **Next-Steps Prediction** - Forecast logical followup tasks

**Output:**
```markdown
## 🔮 PREDICTIVE INTELLIGENCE ANALYSIS

[Comprehensive proactive guidance - see predictive-intelligence-core.md for full template]

**Journey Stage:** [Stage] - [Guidance]
**Domain Risks:** [Warnings and mitigations]
**Project Patterns:** [Detected conventions]
**Related Work:** [Connections to previous work]
**Proactive Warnings:** [Problems to avoid]
**Next Steps:** [Recommended followups]

---
```

**After Predictive Intelligence, continue with Step 0.2** (now enhanced with predictive context)

**Note:** This step is OPTIONAL and can be disabled in configuration. When disabled, proceed directly to Step 0.2.

---

### Step 0.2: Completeness Check

**Purpose:** Identify missing critical information

**Universal Criteria (6 Components):**

Check for presence of:
- [ ] **Goal:** Clear desired outcome (What should happen?)
- [ ] **Context:** Environment, technology, background (Where/when/why?)
- [ ] **Scope:** Specific files, components, areas (What exactly to touch?)
- [ ] **Requirements:** Specific needs or features (What must be included?)
- [ ] **Constraints:** Limitations, rules, compatibility (What to avoid/respect?)
- [ ] **Expected Result:** Success criteria (How to verify it's done?)

**Output Format:**
```markdown
**Completeness Check:**

✅ **Present:**
- Goal: [extracted from user input]
- Context: [extracted from user input]

❌ **Missing:**
- Scope: Need to know which files/components
- Expected Result: Need to know how to verify success

⚠️ **Optional (but recommended):**
- Constraints: [None specified]
```

**Decision Point:**
- If ALL required components present → **Go to Step 0.4 (Correction)**
- If ANY required components missing → **Go to Step 0.3 (Clarification)**

---

### Step 0.3: Clarification Questions

**Purpose:** Gather missing information without guessing

**Rules:**
1. **Never assume** - Always ask when uncertain
2. **Prioritize questions** - Critical first, then important, then optional
3. **Provide context** - Explain why you're asking
4. **Offer options** - When multiple valid approaches exist
5. **One round preferred** - Ask all questions together when possible

**Question Priority Levels:**

**🚨 Critical (MUST have):**
- Questions about missing Goal, Scope, or Expected Result
- Ambiguities that block execution entirely
- Safety concerns (security, data loss, breaking changes)

**⚠️ Important (SHOULD have):**
- Questions about Context that affects approach
- Missing Requirements that impact quality
- Technical feasibility concerns

**💡 Optional (NICE to have):**
- Constraints that could optimize solution
- Preferences that improve user experience
- Additional features that add value

**Output Format:**
```markdown
**Missing Information - Need Your Input:**

🚨 **Critical:**
1. [Question about essential missing component]
   - Why I'm asking: [explanation]
   - Example: [concrete example if helpful]

⚠️ **Important:**
2. [Question about helpful context]
   - Why I'm asking: [explanation]

💡 **Optional:**
3. [Question about optimizations]
   - Why I'm asking: [explanation]
   - You can skip this if not applicable
```

**Multiple Approaches Pattern:**

When multiple valid solutions exist:

```markdown
**Multiple Approaches Detected:**

I can solve this in different ways. Which approach fits your needs?

**Option 1: [Name]**
- **Description:** [What this does]
- **Pros:** [Advantages]
- **Cons:** [Disadvantages]
- **Best for:** [Use case]

**Option 2: [Name]**
- **Description:** [What this does]
- **Pros:** [Advantages]
- **Cons:** [Disadvantages]
- **Best for:** [Use case]

⭐ **Recommended:** Option [X]
**Reasoning:** [Why this is best based on context]

*Please select: 1, 2, or describe your preference*
```

**Wait for User Response:**
- Process all answers
- If new questions arise, ask them
- Repeat until all required information gathered

---

### Step 0.4: Correction & Structuring

**Purpose:** Fix errors and transform into clear, executable format

**Correction Rules:**
1. **Fix grammar and spelling** - Make it professional
2. **Preserve technical terms** - Keep code, variable names, paths EXACTLY
3. **Clarify ambiguity** - Make vague statements specific
4. **Remove redundancy** - Eliminate duplicate information
5. **Maintain intent** - Keep user's original goal and tone

**Structuring Rules:**
1. **Use active voice** - "Create a function" not "A function should be created"
2. **Be specific** - "Add validation to UserService.Login()" not "Add validation"
3. **Number requirements** - Makes them easy to reference
4. **Separate concerns** - Goal ≠ Requirements ≠ Constraints
5. **Make it actionable** - Every requirement should be testable

**Track Changes:**
Keep a list of what you changed for transparency:
```markdown
**Changes Made:**
- Fixed typo: "impliment" → "implement"
- Clarified scope: "the code" → "src/services/UserService.cs"
- Added specificity: "validation" → "email format and password strength validation"
- Removed redundancy: Combined duplicate requirement about error handling
```

---

### Step 0.5: Output Perfect Prompt

**Purpose:** Present the perfected, executable prompt

**Universal Output Format:**

```markdown
**✨ Perfected Prompt:**

**Goal:** [One clear sentence stating the desired outcome]

**Context:**
- Environment: [OS, platform, runtime]
- Technology Stack: [languages, frameworks, libraries]
- Project Background: [relevant context about the project]
- Current State: [what exists now, if relevant]

**Scope:**
- Files to modify: [list with paths]
- Files to create: [list with paths]
- Components affected: [list]
- Areas impacted: [list]

**Requirements:**
1. [First specific, testable requirement]
2. [Second specific, testable requirement]
3. [Third specific, testable requirement]
[...continue as needed]

**Constraints:**
- [Constraint 1: performance, security, compatibility]
- [Constraint 2: coding standards, patterns to follow]
- [Constraint 3: limitations to respect]
Or: *None specified*

**Expected Result:**
[Clear description of what success looks like]
- How to verify: [specific test/check]
- How to measure: [metrics if applicable]

**Changes Made:**
- [List of corrections and improvements for transparency]
```

---

### Step 0.6: Approval Gate

**Purpose:** Get user confirmation before proceeding

**Always wait for user approval.** Never proceed automatically.

**Output Format:**
```markdown
---

⏸️ **Perfected Prompt Ready - Awaiting Your Approval**

**Summary:**
- Type: [prompt type]
- Goal: [brief goal summary]
- Scope: [scope summary]
- Confidence: [High/Medium/Low - based on completeness]

**What happens next:**
After you approve, I will [execute task / answer question / generate content / etc.]

**Reply with:**
- `y` or `yes` — Execute this perfected prompt
- `n` or `no` — Cancel
- `modify [description]` — Adjust the prompt (tell me what to change)
- `explain [component]` — Explain why I included/changed something
- `options` — Show me alternative approaches (if applicable)
```

**Handle User Responses:**

| Response | Action |
|----------|--------|
| `yes` / `y` | Proceed to Phase 1 (command-specific execution) |
| `no` / `n` | Cancel and inform user: "Prompt perfection cancelled." |
| `modify [X]` | Apply changes, re-display perfected prompt, wait for approval |
| `explain [X]` | Provide detailed explanation, re-prompt for approval |
| `options` | Show alternative approaches if multiple exist, wait for selection |

---

## Domain-Specific Adaptations

### When to Use Adaptations

Use the core flow above, but adapt the **Completeness Check** criteria for specific domains.

### Available Adaptations

#### Technical Adaptation
File: `.claude/library/adapters/technical-adapter.md`

**Additional Criteria:**
- [ ] **Technical Stack:** Frameworks, libraries, versions
- [ ] **Architecture:** Patterns, conventions, structure
- [ ] **Code Location:** Specific files, classes, methods
- [ ] **Testing Strategy:** Unit tests, integration tests

**Enhanced Validation:**
- Can spawn agents for codebase exploration (if using hybrid)
- Validates technical feasibility
- Detects existing patterns

---

#### Article Adaptation
File: `.claude/library/adapters/article-adapter.md`

**Additional Criteria:**
- [ ] **Topic:** Main subject matter
- [ ] **Audience:** Target readers (technical/business/general)
- [ ] **Style:** Writing tone (formal/conversational/educational)
- [ ] **Length:** Word count target
- [ ] **Platform:** Publishing destination

**Enhanced Validation:**
- Interactive wizard for comprehensive input
- Multi-platform output formatting
- Language-specific guidelines

---

#### Session Adaptation
File: `.claude/library/adapters/session-adapter.md`

**Additional Criteria:**
- [ ] **Session Action:** Save context / Load context
- [ ] **Scope Filter:** What to capture/load (all/specific feature/decisions)
- [ ] **Priority:** What matters most
- [ ] **Focus:** Where to concentrate effort

**Enhanced Validation:**
- Git branch awareness
- File change tracking
- Decision/WIP separation

---

## Integration Examples

### Example 1: Simple Command Using Core Library

```markdown
# /simple-command

## Phase 0: Prompt Perfection

**Import:** Use Phase 0 from `.claude/library/prompt-perfection-core.md`
**Adaptation:** None (use universal criteria only)

[Claude reads this, loads the core library, executes Phase 0 as defined]

## Phase 1: Execute Command

[Command-specific logic starts here after approval]
```

---

### Example 2: Command with Domain Adapter

```markdown
# /technical-command

## Phase 0: Prompt Perfection

**Import:** Use Phase 0 from `.claude/library/prompt-perfection-core.md`
**Adaptation:** Technical (from `.claude/library/adapters/technical-adapter.md`)

**Additional Criteria:**
- Technical Stack (auto-detect or ask)
- Code Location (required)
- Testing Strategy (recommended)

[Claude combines core Phase 0 + technical adapter]

## Phase 1: Technical Analysis

[Command-specific logic]
```

---

### Example 3: Hybrid Command with Agent Support

```markdown
# /hybrid-command

## Phase 0: Prompt Perfection

**Import:** Use Phase 0 from `.claude/library/prompt-perfection-core.md`
**Adaptation:** Technical with Complexity Detection

**Enhanced Flow:**
1. Run Step 0.1 (Initial Analysis)
2. Run Step 0.2 (Completeness Check)
3. **NEW:** Run Complexity Detection
   - Score < 5: Continue with Step 0.3 (inline)
   - Score >= 10: Spawn agent for context gathering
4. Continue with Step 0.3-0.6 (enhanced with agent findings if used)

[Phase 0 extended with hybrid intelligence]

## Phase 1: Implementation

[Command-specific logic with optional agent support]
```

---

## Benefits of Library System

### For Command Authors

✅ **Consistency:** All commands follow same Phase 0 pattern
✅ **Less Code:** Reference library instead of copy-paste
✅ **Maintainability:** Update library once, all commands benefit
✅ **Clarity:** Focus command files on domain-specific logic
✅ **Reusability:** Adapters can be shared across commands

### For Users

✅ **Predictability:** Same experience across all commands
✅ **Quality:** Proven Phase 0 flow every time
✅ **Trust:** Consistent validation and clarification
✅ **Efficiency:** Faster command development = more features

### For the Project

✅ **Architecture:** Clean separation of concerns
✅ **Testing:** Test library once, confidence everywhere
✅ **Evolution:** Enhance Phase 0 centrally
✅ **Documentation:** Single source of truth for prompt perfection

---

## Version History

**v1.1 (2026-01-01):**
- ✨ Added Phase 0.15: Predictive Intelligence (OPTIONAL)
- ✨ Proactive guidance system
- ✨ Journey stage detection
- ✨ Domain risk analysis
- ✨ Project pattern recognition
- ✨ Relationship mapping
- ✨ Proactive warnings
- ✨ Next-steps prediction
- Backward compatible (can be disabled)

**v1.0 (2024-12-19):**
- Initial release
- Core Phase 0 flow (Steps 0.1-0.6)
- Universal 6-criteria completeness check
- Approval gate pattern
- Integration examples

---

## Related Files

- **Core Library:** `.claude/library/prompt-perfection-core.md` (this file)
- **Technical Adapter:** `.claude/library/adapters/technical-adapter.md`
- **Article Adapter:** `.claude/library/adapters/article-adapter.md`
- **Session Adapter:** `.claude/library/adapters/session-adapter.md`
- **Complexity Detection:** `.claude/config/complexity-rules.json`
- **Agent Templates:** `.claude/config/agent-templates.json`

**NEW - Predictive Intelligence (v1.1):**
- **Predictive Intelligence Core:** `.claude/library/intelligence/predictive-intelligence-core.md`
- **Relationship Mapper:** `.claude/library/intelligence/relationship-mapper.md`
- **Warning System:** `.claude/library/intelligence/warning-system.md`
- **Next-Steps Predictor:** `.claude/library/intelligence/next-steps-predictor.md`
- **Configuration:** `.claude/config/predictive-intelligence.json`

---

**This is the foundation of zero-ambiguity prompt engineering in Claude Code.**
