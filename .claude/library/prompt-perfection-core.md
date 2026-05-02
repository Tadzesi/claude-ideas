# Prompt Perfection Core Library

**Version:** 2.1
**Last Updated:** 2026-04-16
**Purpose:** Canonical Phase 0 implementation for all prompt commands
**AI Fluency:** Aligned with Anthropic's 4Ds Framework (Delegation, Description, Discernment, Diligence)

**Import Syntax:** Reference this file using @.claude/library/prompt-perfection-core.md

---

## Anti-Hallucination Contract

**HARD-GATE: These rules apply unconditionally to every skill using this library.**

### NEVER
- State the project version without reading `project-profile.md` in this session
- Assume a file exists without verifying with Read or Glob
- Invent file paths, class names, function names, or config keys
- State tech stack without reading `project-profile.md` or the project's manifest file
- Copy example values from instruction templates into actual output as if they were real facts

### ALWAYS
- Ground every stated fact: note which file you read it from in this session
- If a file does not exist: explicitly state "File not found — proceeding without it"
- If uncertain about any fact: ask the user, do not guess

### Grounding Protocol
Before any output containing project facts:
1. List files read in this session
2. Map each stated fact to its source file
3. Flag any fact without a source as "UNVERIFIED — asking user"

---

## Overview

This library defines the **universal Phase 0 flow** for transforming any user input into a perfect, unambiguous prompt that Claude Code can execute without guessing.

All prompt commands should use this library as their foundation, with optional domain-specific adaptations.

---

## Phase 0 Flow (text)

`Input → Anti-Hallucination → 0.1 Analysis → 0.11 Delegation → 0.12 Mode →
[0.15 Predictive if enabled] → 0.2a Memory → 0.2b Completeness →
0.25 Curiosity Gate → (>=90 skip / 70-89 one Q / <70 full 0.3) →
0.35 Options-First (if multi-path) → 0.4 Correction → 0.5 Perfect Prompt →
0.55 Execution Plan + MODEL HINT → 0.6 Approval Gate → Execute → 0.7 Eval`

**Fast Path (score < 5):** Anti-Hallucination → 0.1 → 0.5 → 0.6. Skip
Curiosity Gate, Options-First, full Execution Plan. See Fast Path section
below for the exact short-circuit.

---

## Fast Path (NEW v2.2 — for trivial prompts)

**Trigger:** ALL of:
- Complexity score < 5 (per `.claude/config/complexity-rules.json`)
- Single file affected (or zero — pure question)
- Goal stated unambiguously by user
- No security / credential / breaking-change keywords
- Memory pre-fill answers all 9 completeness criteria

**Short-circuit flow:** `0.1 → 0.5 (compact) → 0.6 (one-line approval)`

**Compact 0.5 output (max 6 lines):**
```
FAST PATH

Goal: [one sentence]
Files: [single path]
MODEL HINT: haiku — trivial single-file edit.
Approve? y / n / modify
```

**Skip:** 0.11, 0.12, 0.15, 0.2b, 0.25 (assumption ledger), 0.35 (options),
0.55 (full plan), 0.7. Save ~40 % of Phase 0 tokens on trivial prompts.

**Escalate out of Fast Path** when ANY arises mid-execution:
- New file dependency surfaces → emit full 0.55 plan
- User asks "why" or "options" → re-run from 0.35
- Security or destructive command needed → full plan + extra confirmation

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

**Required REASONING Block (output before proceeding to Step 0.11):**

```
REASONING
Prompt type selected: [type] — because [specific reason from input]
Facts from files read this session:
  - [fact 1] — source: [filename]
  - [fact 2] — source: [filename]
Facts I cannot determine without asking: [list or "none"]
```

---

### Step 0.11: Quick Delegation Check *(AI Fluency - NEW v1.4)*

**Purpose:** Verify this task is appropriate for AI before proceeding

**Based on Anthropic's AI Fluency Framework - Delegation Competency:**

**Quick Assessment (3 checks):**

1. **Task Appropriateness:**
   - Is this task suitable for AI assistance?
   - Does it require human-only judgment (ethics, policy, irreversible decisions)?

2. **AI Capability Match:**
   - Does this match AI strengths (code analysis, text generation, pattern detection)?
   - Or does it exceed AI limitations (recent events, complex math, personal decisions)?

3. **Responsibility Awareness:**
   - Does the user understand they remain responsible for the output?
   - Are there safety/security implications requiring human oversight?

**Decision Logic:**
```
IF task requires ONLY human judgment (ethics, policy, personal):
    → Flag: "This requires human decision. I can help analyze, but you must decide."
    → Proceed with advisory mode

IF task involves irreversible actions (delete, deploy, publish):
    → Flag: "⚠️ Irreversible action detected. Requires explicit confirmation."
    → Add extra confirmation step

IF task matches AI strengths AND user accepts responsibility:
    → Proceed to Step 0.12

IF uncertain about appropriateness:
    → Ask: "This task involves [X]. Should I proceed with AI assistance, or would you prefer to handle this yourself?"
```

**Output (only when flags triggered):**
```markdown
**⚠️ Delegation Check:**
- Task Type: [Type]
- AI Appropriate: [Yes / Partial / Advisory Only]
- Note: [Any flags or concerns]
- Proceed? [Waiting for confirmation if flagged]
```

**Note:** For most tasks, this check passes silently. Only surface when concerns exist.

---

### Step 0.12: Interaction Mode Detection *(AI Fluency - NEW v1.3)*

**Purpose:** Determine the optimal human-AI collaboration mode for this task

**Based on Anthropic's AI Fluency Framework, detect one of three modes:**

**Automation Mode:**
- AI performs specific tasks based on specific human instructions
- Human defines WHAT, AI executes
- Best for: Simple tasks, clear instructions, single-file changes
- Indicators: "Fix X", "Add Y to Z", "Change A to B"

**Augmentation Mode:**
- Human and AI collaborate as thinking partners
- Iterative back-and-forth where both contribute
- Best for: Complex analysis, design decisions, problem-solving
- Indicators: "Help me understand", "What's the best approach", "Let's figure out"

**Agency Mode:**
- Human configures AI to work independently
- AI establishes knowledge and behavior patterns
- Best for: Research tasks, codebase exploration, multi-agent work
- Indicators: "Research X", "Explore the codebase", "Find all instances"

**Detection Logic:**
```
IF prompt contains direct commands AND clear scope:
    → Automation Mode
ELSE IF prompt requests collaboration OR decision-making:
    → Augmentation Mode
ELSE IF prompt requests independent research OR exploration:
    → Agency Mode
DEFAULT:
    → Augmentation Mode (most flexible)
```

**Output Format:**
```markdown
**Interaction Mode:** [Automation / Augmentation / Agency]
**Rationale:** [Why this mode fits the task]
**Implications:**
- [How AI will approach the task in this mode]
```

**Mode-Specific Adjustments:**
- **Automation:** Skip optional questions, execute directly
- **Augmentation:** Engage in dialogue, offer options, iterate
- **Agency:** Spawn agents if needed, work independently, report back

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

**Purpose:** Identify missing critical information, pre-filling from project memory

**Step 0.2a: Memory Recall (v1.6 - ALWAYS LOAD FIRST)**

CRITICAL: Always read project memory before asking ANY questions.
This prevents the user from having to repeat information across sessions.

1. **Read** `.claude/memory/project-profile.md` (ALWAYS - before any analysis)
2. **Read** last 3 entries from `.claude/memory/sessions.md` (for recent activity)
3. **Read** `.claude/memory/prompt-patterns.md` (for learned patterns if exists)

**If profile exists and has content (expected state):**
   - Extract ALL facts matching the 9 completeness criteria
   - Pre-fill Context, Scope, Constraints, Preferences from profile
   - Show a brief "CONTEXT LOADED" summary so user knows what is pre-filled
   - Do NOT ask any questions already answered by the profile
   - Check sessions.md for relevant recent work to mention

**If profile does not exist or is empty:**
   - Show notice: "No project profile found. I can create one to remember your project details between sessions so you never need to repeat context."
   - Ask: "Create a project profile? (yes/no)"
   - If yes: create `.claude/memory/project-profile.md` with standard headers, gather facts during Step 0.3, save to profile after
   - If no: proceed without profile

**Context Loaded Output (brief - only when profile has data):**
```
CONTEXT LOADED FROM PROJECT PROFILE
Project: [name and version]
Stack: [tech stack - brief]
Platform: [OS/environment]
Preferences: [key preferences]
Recent: [one-line summary from sessions.md if relevant]
```

**Step 0.2b: Completeness Evaluation**

**Universal Criteria (9 Components):**

Check for presence of (including pre-filled facts from memory):

**Product Description (WHAT):**
- [ ] **Goal:** Clear desired outcome (What should happen?)
- [ ] **Context:** Environment, technology, background (Where/when/why?)
- [ ] **Scope:** Specific files, components, areas (What exactly to touch?)
- [ ] **Requirements:** Specific needs or features (What must be included?)
- [ ] **Constraints:** Limitations, rules, compatibility (What to avoid/respect?)
- [ ] **Expected Result:** Success criteria (How to verify it's done?)

**Process Description (HOW):** *(AI Fluency - NEW)*
- [ ] **Approach:** Step-by-step instructions or methodology (How should AI work?)

**Performance Description (AI BEHAVIOR):** *(AI Fluency - NEW)*
- [ ] **Interaction Style:** Concise/detailed, challenging/supportive, autonomous/collaborative
- [ ] **Communication Tone:** Technical/casual, formal/conversational

**Output Format:**
```markdown
**Completeness Check:**

✅ **Present:**
- Goal: [extracted from user input]
- Context: [extracted from user input]

✅ **Present (from project profile):**
- Context: Tech stack is Node.js + PostgreSQL
- Constraints: Prefers TypeScript strict mode

❌ **Missing:**
- Scope: Need to know which files/components
- Expected Result: Need to know how to verify success

⚠️ **Optional (but recommended):**
- Constraints: [None specified]
```

**Decision Point:**
- Always proceed to **Step 0.25 (Curiosity Gate)** — it decides whether to ask
  questions, jump to Step 0.4, or first offer options.

---

### Step 0.25: Curiosity Gate *(NEW v2.1)*

**Purpose:** Force explicit uncertainty accounting before skipping ahead.
Replaces the old "ask only when missing" default — memory pre-fill is not a
licence to guess.

**Confidence scoring (0-100):**

Start at 100. Subtract for each uncertainty:
- Goal is vague (no measurable outcome) → -25
- Scope lists no concrete files → -20
- Expected Result unspecified → -15
- Requirements implicit only → -10
- Technology choice ambiguous → -10
- Constraints unknown → -5 each (cap -15)
- User-level disagreement with profile facts → -20

**Decision Logic:**
```
confidence >= 90  → proceed to Step 0.4 silently
confidence 70-89  → ask ONE targeted question + list assumptions (Step 0.3 lite)
confidence < 70   → full Step 0.3 clarification round (MIN 2 questions)
```

**Assumption Ledger (mandatory output when confidence < 100):**

```
ASSUMPTIONS I AM MAKING (correct me if wrong)
- [Assumption 1 — what I will do if you do not correct this]
- [Assumption 2]
- [Assumption 3]

Confidence: [N%]
```

**Rule:** Every assumption must be actionable — the user must be able to say
"no, do X instead" and know exactly what changes.

---

### Step 0.3: Clarification Questions

**Purpose:** Gather missing information without guessing, skipping what the profile already knows

**Rules:**
1. **Never assume** - Always ask when uncertain
2. **Skip known facts** - Do not ask questions already answered by the project profile
3. **Prioritize questions** - Critical first, then important, then optional
4. **Provide context** - Explain why you're asking
5. **Offer options** - When multiple valid approaches exist
6. **One round preferred** - Ask all questions together when possible

**Memory-Aware Filtering (v1.3):**
- Before asking, check if the project profile already provides the answer
- If a fact is in the profile, show it as pre-filled rather than asking
- Only ask for genuinely unknown information
- If the user opted in to a new profile (Step 0.2a), save new answers to the profile after this step

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

**Wait for User Response:**
- Process all answers
- If new questions arise, ask them
- Repeat until all required information gathered

---

### Step 0.35: Options-First *(NEW v2.1 — default ON for Task/Feature/Bug Fix/Refactor)*

**Purpose:** Present 2-3 alternative approaches BEFORE committing to one.
Makes tradeoffs explicit so the user picks, not Claude.

**When to run:**
- Prompt type is Task, Feature, Bug Fix, Refactor, or Config AND
- More than one valid implementation path exists

**When to SKIP:**
- Pure Question (no implementation)
- User already specified the approach ("use X library", "write it as a hook")
- Only one viable path exists — say so explicitly: "One-path task, no options."

**Output Format:**

```
APPROACHES FOR THIS TASK

Option 1: [Short name]
  What:  [One line — what changes]
  How:   [One line — method]
  Pros:  [Advantages]
  Cons:  [Disadvantages]
  Model: [haiku/sonnet/opus — from model-router.md]
  Cost:  [low/medium/high tokens]
  Best when: [use case]

Option 2: [Short name]
  What:  [...]
  How:   [...]
  Pros:  [...]
  Cons:  [...]
  Model: [...]
  Cost:  [...]
  Best when: [...]

Option 3: [Short name — optional, if a meaningfully different third exists]
  ...

RECOMMENDED: Option [X]
Reason: [one sentence — why this fits the facts from memory + scope]

Select: 1 / 2 / 3 / modify / describe your own
```

**Rules:**
1. Options must be meaningfully different — not cosmetic variants.
2. Each option gets a model tier from `.claude/library/model-router.md`.
3. Recommendation must reference concrete facts from project profile.
4. Wait for selection before moving to Step 0.4.

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

**Discernment Hints:** *(AI Fluency - Optional)*
- **Product Evaluation:** [How to evaluate output quality - accuracy, appropriateness]
- **Process Evaluation:** [How to verify reasoning - check for logical errors]
- **Performance Evaluation:** [Communication style feedback - was it helpful?]

**Changes Made:**
- [List of corrections and improvements for transparency]
```

---

### Step 0.55: Execution Plan + Model Selection *(NEW v2.1 — mandatory for all non-Question prompts)*

**Purpose:** Before the approval gate, make "what will be done and how"
unambiguous. User and Claude must share the same mental model. Also surface
the recommended Claude tier so the user can switch models before spending
tokens.

**Import:** Use template from `.claude/library/execution-plan-template.md`

**Model routing:** Apply rules from `.claude/library/model-router.md` using
config in `.claude/config/model-tiers.json`.

**Skip only when:**
- Prompt type is pure Question AND no files will be touched.

**Mandatory blocks (in order):**

1. Goal (one sentence)
2. Files — CREATE / EDIT / READ (paths verified with Glob/Read)
3. Steps — numbered, each mapping to a concrete tool call
4. Tools — which of Read/Edit/Write/Glob/Grep/Bash/Agent will be used
5. MODEL HINT — one line from `model-router.md`
6. Risks and rollback — reversibility + mitigations
7. Verification — commands or checks to run after
8. Estimated effort — token tier (low/medium/high) + wall-clock + tool-call count
9. Assumptions — actionable list the user can override

**Rules:**
- No `[placeholders]` in final output. Every slot filled with a concrete value.
- Paths unverified? Mark them `(unverified — will Glob first)` and run the Glob BEFORE the approval gate closes.
- Steps must be countable. Vague verbs ("improve", "enhance") are not steps.
- MODEL HINT is mandatory — even "keep current" is explicit communication.

**Example output:** see `.claude/library/execution-plan-template.md` (Good
Example section). Do not duplicate the example here — keep one source of
truth.

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
- Confidence: [N% from Step 0.25]
- MODEL HINT: [one-line recommendation from Step 0.55]

**What happens next (concrete):**
1. [First action, which file, which tool]
2. [Second action]
3. [Verification step]

(Full Execution Plan above in Step 0.55 — user and Claude are aligned.)

**⚖️ Diligence Reminder (AI Fluency):**
You remain responsible for any output generated from this prompt.
- Verify key facts before deployment
- Review AI-generated code before committing
- Test thoroughly before production use

**Reply with:**
- `y` or `yes` — Execute this perfected prompt with current model
- `n` or `no` — Cancel
- `modify [description]` — Adjust the prompt (tell me what to change)
- `explain [component]` — Explain why I included/changed something
- `options` — Show me alternative approaches (if applicable)
- `switch [haiku|sonnet|opus]` — I will remind you to run /model before approving
```

**Handle User Responses:**

| Response | Action |
|----------|--------|
| `yes` / `y` | Proceed to Phase 1 (command-specific execution) |
| `no` / `n` | Cancel and inform user: "Prompt perfection cancelled." |
| `modify [X]` | Apply changes, re-display perfected prompt, wait for approval |
| `explain [X]` | Provide detailed explanation, re-prompt for approval |
| `options` | Show alternative approaches if multiple exist, wait for selection |
| `switch [tier]` | Remind user: "Run `/model [tier]` then reply `y` to proceed." Wait. |

---

## Step 0.7: Post-Execution Evaluation *(AI Fluency - NEW v1.4)*

**Purpose:** Close the feedback loop by evaluating output quality

**Based on Anthropic's AI Fluency Framework - Discernment Competency:**

After task execution completes, prompt for evaluation:

**Quick Evaluation Prompt:**
```markdown
---

**📊 Quick Evaluation (Discernment Check)**

How was this output?

- `good` — Accurate, appropriate, useful ✅
- `partial` — Mostly good, needs minor adjustments ⚠️
- `wrong` — Significant issues, needs rework ❌
- `explain` — Show me your reasoning 🔍

*Your feedback helps improve future interactions.*
```

**Handle Responses:**

| Response | Action |
|----------|--------|
| `good` | Record success, offer next steps |
| `partial` | Ask: "What needs adjustment?" → Apply changes |
| `wrong` | Ask: "What specifically was wrong?" → Record for learning, offer retry |
| `explain` | Show reasoning/process, re-prompt for evaluation |

**If `partial` or `wrong`:**
1. Identify what went wrong (Product/Process/Performance Discernment)
2. Record observation in `.claude/memory/observations.md`
3. Suggest: "Consider running `/reflect` to capture this learning"

**Discernment Types (AI Fluency):**
- **Product Discernment:** Is the output accurate, appropriate, coherent, relevant?
- **Process Discernment:** Was the reasoning sound? Any logical errors?
- **Performance Discernment:** Was the communication style effective?

**Note:** This step is optional for quick tasks. Always offer for complex tasks or when output quality is uncertain.

---

## The Feedback Loop *(AI Fluency Pattern)*

**The core AI Fluency workflow:**

```
    DESCRIBE          EVALUATE
   (what you want) → (what you got)
         ↑               ↓
         └─── REFINE ←──┘
           (improve prompt)
```

**Effective AI use is iterative.** Don't expect perfection on the first try. The skill is in the conversation, not the single prompt.

**After any output, consider:**
1. **Evaluate:** Does this meet the goal?
2. **If not:** Identify what's wrong (accuracy? relevance? style?)
3. **Refine:** Adjust your request with specific feedback
4. **Repeat:** Until satisfied

**Useful follow-up phrases:**
- "Make it more [concise/detailed/formal/casual]"
- "Focus more on [specific aspect]"
- "Remove the section about [topic]"
- "Add examples for [concept]"
- "Explain this for [audience type]"
- "This is wrong because [reason], please fix"

**Common Iteration Patterns:**
- Too long → "Make it more concise, focus on [key points]"
- Too vague → "Be more specific about [aspect]"
- Wrong tone → "Use a more [formal/casual/technical] tone"
- Missing context → "Also consider [additional context]"
- Incorrect facts → "Check [specific claim], I believe it should be [correction]"

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
File: `.claude/library/readme-adapter.md`

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

**v2.2 (2026-04-22):** Fast Path for trivial prompts; Mermaid flowchart
replaced with text; inline Step 0.55 example removed (canonical lives in
execution-plan-template.md). See `.claude/CHANGELOG-skills.md` for full
history of all skills/library files.

**v2.1 (2026-04-16):** Curiosity Gate, Options-First, Execution Plan + MODEL HINT.
**v2.0 (2026-04-07):** Anti-Hallucination Contract, REASONING block.
**v1.x (2026-01 → 2026-03):** AI Fluency 4Ds, memory recall, predictive intelligence.
**v1.0 (2025-11-01):** Initial Phase 0.

---

## Related Files

**Core Library (@ import syntax):**
- @.claude/library/prompt-perfection-core.md (this file)
- @.claude/library/adapters/technical-adapter.md
- @.claude/library/readme-adapter.md
- @.claude/library/adapters/session-adapter.md

**Memory (v1.3):**
- @.claude/memory/project-profile.md

**Configuration:**
- @.claude/config/complexity-rules.json
- @.claude/config/agent-templates.json
- @.claude/config/ai-fluency.json *(AI Fluency Framework - NEW v1.3)*
- @.claude/config/model-tiers.json *(NEW v2.1 — model routing)*

**Phase 0 Support (v2.1):**
- @.claude/library/model-router.md
- @.claude/library/execution-plan-template.md

**Caching + Memory (v2.2 / Opus 4.7 optimisation):**
- @.claude/library/caching-strategy.md (prompt caching breakpoints)
- @.claude/library/adapters/memory-tool-adapter.md (native memory_20250818)
- @.claude/library/adapters/context-editing-adapter.md (clear_tool_uses for /research)

**Path-Specific Rules (v1.2):**
- @.claude/rules/technical-patterns.md
- @.claude/rules/command-conventions.md
- @.claude/rules/library-standards.md
- @.claude/rules/config-validation.md

**Predictive Intelligence (v1.1):**
- @.claude/library/intelligence/predictive-intelligence-core.md
- @.claude/library/intelligence/relationship-mapper.md
- @.claude/library/intelligence/warning-system.md
- @.claude/library/intelligence/next-steps-predictor.md
- @.claude/config/predictive-intelligence.json

---

**This is the foundation of zero-ambiguity prompt engineering in Claude Code.**
