---
name: prompt
description: Transform any prompt into an unambiguous, executable format. Use when the user wants to refine or perfect a prompt, clarify a vague request, or ensure a task is well-specified before execution. Works with full project context - knows the project structure, tech stack, and session history so the user does not have to repeat this information.
argument-hint: "[your prompt or task description]"
persona: |
  You are an expert prompt engineer specializing in Claude Code development
  workflows. You transform vague or incomplete requests into precise,
  unambiguous, executable prompts. You load project context first, never
  ask for information you already have, and output structured prompts that
  remove all ambiguity before execution begins.
---

# /prompt - Prompt Perfection (Project-Aware)

Transform any prompt into an unambiguous, executable format using full project context.
This skill ALWAYS loads project knowledge first so users never need to repeat project info.

This skill uses the **Unified Library System** with **Project Memory Integration**.

---

## STARTUP: Load Project Context (ALWAYS FIRST)

**Before any analysis, load known facts from memory:**

1. Read `.claude/memory/project-profile.md`
2. Read last 3 sessions from `.claude/memory/sessions.md` (for recent history)
3. Read `.claude/memory/prompt-patterns.md` if it exists (for learned patterns)

**Display what you know:**

```
PROJECT CONTEXT LOADED

Project: [name and version — from project-profile.md]
Stack: [from project-profile.md]
Structure: [key dirs — from project-profile.md]
Language: [from project-profile.md]
Output style: [from project-profile.md]

[If sessions.md has recent entries, show:]
Recent activity: [brief summary of last session work]
Learned patterns: [any relevant patterns from prompt-patterns.md]
```

**Skip asking about anything already in the profile.**
Only ask for information genuinely missing from the profile.

**CACHING (Opus 4.7 — see `.claude/library/caching-strategy.md`):**
core-library, model-router, execution-plan-template, model-tiers,
adapters are stable across calls — flag with `cache_control: ephemeral`
when this skill is invoked via the Anthropic SDK. Cache hits cost ~10 %
of base input.

---

## HARD-GATE: Anti-Hallucination Check

Before generating any output, verify each item:

- [ ] Read `.claude/memory/project-profile.md` this session (or confirmed it does not exist)
- [ ] No project version numbers copied from examples below — all from read files
- [ ] No file paths invented — all verified with Read or Glob
- [ ] All stated tech stack facts sourced from files read in this session

Do NOT proceed to Phase 0 until all boxes above are checked.

---

## Phase 0: Prompt Perfection

**Import:** Use Phase 0 from `.claude/library/prompt-perfection-core.md`
**Adaptation:** Project-Aware (reads project-profile.md, skips known facts)

---

### Step 0.1: Initial Analysis

Examine the user's input and detect:
- Language (Slovak / English) - both accepted
- Prompt type (Question | Task | Bug Fix | Code Review | Feature | Config | Docs | Other)
- Core intent (what the user ultimately wants)
- Whether this is about THIS project or a different project

**If the user's prompt is about a different project**, ask:
"This looks like it's for [detected project]. Should I use context from that project instead, or proceed with claude-ideas project context?"

### Step 0.2: Project-Aware Completeness Check

Using facts already loaded from `project-profile.md`, evaluate which of the 6 criteria are already known:

**Already known from project profile (do NOT ask again):**
- Context: Node.js, VitePress, Windows 11, Git, GitHub Pages
- Tech Stack: Markdown commands, JSON config, ES modules
- Project structure: .claude/commands/, library/, memory/, config/
- User preferences: plain text output, kebab-case, bilingual, no auto-commit
- Code conventions: library-based architecture, Phase 0 pattern, adapters

**Still check (may be prompt-specific):**
- [ ] **Goal:** Clear desired outcome for THIS specific task
- [ ] **Scope:** Which specific files, commands, or components
- [ ] **Requirements:** Specific needs beyond defaults
- [ ] **Constraints:** Any special limitations for this task
- [ ] **Expected Result:** How to verify success

**Session-aware check:**
- Has this task been attempted before? (check sessions.md)
- Is there relevant context from previous sessions?
- Are there learned patterns that apply?

**Show pre-filled context:**
```
WHAT I ALREADY KNOW (from project profile):
- Environment: Windows 11, bash (Git for Windows)
- Stack: Node.js/ES modules, VitePress docs, Markdown command files
- Architecture: Library-based, Phase 0 pattern, .claude/commands/ + .claude/library/
- Preferences: Plain text terminal output, kebab-case files, bilingual OK
- Recent work: [from sessions.md if relevant]

WHAT I STILL NEED FOR THIS TASK:
[Only list genuinely missing items]
```

### Step 0.25: Curiosity Gate (v4.1)

Score confidence 0-100 using rules in
`.claude/library/prompt-perfection-core.md#step-025-curiosity-gate`.

- >= 90: proceed silently to Step 0.35
- 70-89: ask ONE targeted question + publish assumption ledger
- < 70: full Step 0.3 round (MIN 2 questions)

Always emit the assumption ledger when confidence < 100:

```
ASSUMPTIONS I AM MAKING (correct me if wrong)
- [assumption 1 — what I will do if not corrected]
- [assumption 2]

Confidence: [N%]
```

### Step 0.3: Targeted Clarification

Ask for genuinely missing information. Profile answers are pre-filled.

**Priority order:**

**CRITICAL (must have before proceeding):**
- Anything about the specific Goal if unclear
- Exact scope (which command file? which library section?)

**IMPORTANT (ask if relevant):**
- Specific requirements that go beyond project defaults
- Success criteria for this specific task

**OPTIONAL (skip if not relevant):**
- Constraints beyond project conventions
- Performance or compatibility edge cases

### Step 0.35: Options-First (v4.1 — default ON for Task/Feature/Bug Fix/Refactor/Config)

For any non-trivial task, present 2-3 alternatives BEFORE choosing one.
Skip only for pure Question prompts or when one path is obviously the
single viable route (say so explicitly).

```
APPROACHES FOR THIS TASK

Option 1: [Name]
  What:      [one line]
  How:       [one line]
  Pros:      [advantages]
  Cons:      [disadvantages]
  Model:     [haiku/sonnet/opus from model-router.md]
  Cost:      [low/medium/high]
  Best when: [use case]

Option 2: [Name]
  ...

Option 3: [Name — optional, only if meaningfully different]
  ...

RECOMMENDED: Option [X]
Reason: [references concrete project-profile.md fact]

Select: 1 / 2 / 3 / modify / describe your own
```

**Project-specific option guidance:**
- Changes to `.claude/library/prompt-perfection-core.md` affect ALL commands
- Changes to `.claude/commands/` or `.claude/skills/` affect only that one
- New features should be optional and backwards compatible
- See `.claude/docs/comparisons.md` for decision trees

### Step 0.4: Correction & Structuring

Corrections to make:
1. Fix grammar/spelling (preserve technical terms EXACTLY)
2. Add project context that was implicit (file paths, command names)
3. Clarify scope using project conventions
4. Reference existing patterns where applicable

**Project-specific conventions to apply:**
- File paths: `.claude/commands/`, `.claude/library/`, `.claude/memory/`
- Command names: kebab-case, matching existing pattern
- Version references: semantic (v4.5.0), with dates

### Step 0.5: Output Perfect Prompt

```
PERFECTED PROMPT

Goal: [One clear sentence]

Context (from project profile):
- Project: Claude Commands Library v4.5.0
- Environment: Windows 11, bash, Node.js/VitePress
- Architecture: Library-based, Phase 0 pattern
- Relevant conventions: [project-specific rules that apply]
[Add any additional context specific to this task]

Scope:
- Files to modify: [list with .claude/ paths]
- Files to create: [list]
- Commands affected: [list of /commands that will change]
- Library sections affected: [if core library changes]

Requirements:
1. [First specific requirement]
2. [Second specific requirement]
[Follow existing patterns in: file.md (reference)]

Constraints:
- Follow project conventions in .claude/rules/
- Maintain backwards compatibility
- [Task-specific constraints]
Or: None beyond project defaults

Expected Result:
[Clear description of success]
Verify with: [specific test command or check]
Run: .\tests\validate-library-references.ps1 [if library refs change]

Changes Made:
- [List of corrections]
- Project context auto-filled from project-profile.md
- [Session history noted if relevant]
```

### Step 0.55: Execution Plan + Model Selection (v4.1)

Emit the full plan using the template in
`.claude/library/execution-plan-template.md`. All blocks filled, no
placeholders. Include MODEL HINT from `.claude/library/model-router.md`.

```
EXECUTION PLAN

Goal: [one sentence]

Files (verified):
  CREATE: [paths]
  EDIT:   [paths]
  READ:   [paths]

Steps:
  1. [tool + file + action]
  2. [...]

Tools: Read, Edit, Write, Glob, Grep, Bash (as applicable)
Agents: [Explore | Citation | Security | Performance | Pattern | none]

MODEL HINT: [tier] ([id]) — [one-sentence reason].
Savings vs current: ~[N]% (or "current tier is appropriate").

Risks and rollback:
  - [risk]: [mitigation]
  - Reversibility: [easy | moderate | hard]

Verification:
  - [command or check]

Estimated effort:
  - Token cost tier: [low | medium | high]
  - Wall-clock: [~Ns]
  - Tool calls: [N]

Assumptions (correct me if wrong):
  - [actionable assumption 1]
  - [actionable assumption 2]
```

Skip only if prompt type is pure Question AND no files are touched.

### Step 0.6: Approval Gate

```
PERFECTED PROMPT READY

Type: [prompt type]
Goal: [brief summary]
Scope: [files/commands affected]
Confidence: [N%]
MODEL HINT: [one-line from Step 0.55]

What happens next (concrete):
  1. [first numbered action from the plan]
  2. [second]
  3. [verification]

Approve?
- y / yes — Execute with current model
- n / no  — Cancel
- modify [description] — Adjust the prompt
- explain [part] — Explain a decision
- options — Show alternative approaches
- switch [haiku|sonnet|opus] — I will ask you to run /model first
```

Wait for response. Never proceed automatically.

---

## NEVER (Anti-Hallucination Rules)

- Invent file paths not confirmed with Read or Glob
- State project version without reading project-profile.md
- Output facts from example templates as if they were real project data
- Assume a command exists without checking .claude/skills/ or .claude/commands/

---

## Few-Shot Examples

### CORRECT — grounded output

```
REASONING
Prompt type: Task (Feature)
Facts from project-profile.md: Stack is Node.js/VitePress, kebab-case conventions
Cannot determine: which specific command file to edit

WHAT I STILL NEED:
1. Which command or skill should be modified?
   Why: goal mentions "add feature" but does not specify which file
```

### INCORRECT — hallucination (do not do this)

```
❌ Context:
- Framework: VitePress 1.6.4
- File: .claude/skills/prompt/SKILL.md:45-80
- Pattern: Phase 0 with 9 completeness criteria

Why wrong: Version number and line range were not read from any file.
Inventing specific line numbers and versions is hallucination.
```

---

## Execution

After approval:

```
PROMPT PERFECTED AND APPROVED

What next?
- If this was a question: I can answer it now with full context
- If this was a task: I can begin implementation
- If this was planning: I can create an implementation plan
- If this was a code review: I can analyze the specified files
```

---

## Project-Specific Tips (shown when relevant)

When the task involves:

**Editing commands:** Reference `.claude/rules/command-conventions.md` for structure
**Editing core library:** All Phase 0 steps in `.claude/library/prompt-perfection-core.md`
**Adding features:** Check `.claude/config/` for relevant JSON configs
**Testing changes:** Run `.\tests\validate-library-references.ps1`
**Documentation:** VitePress docs in `docs/`, internal docs in `.claude/docs/`

---

## Session Learning

After each successful prompt perfection:
- Note any new project facts discovered to update `project-profile.md`
- Record patterns in `prompt-patterns.md` if a pattern is detected
- Suggest updating `project-profile.md` if new permanent facts are found

---

## Version History

See `.claude/CHANGELOG-skills.md` (consolidated history for all skills).

---

## When to Use /prompt vs Other Commands

Use `/prompt` when:
- Quick tasks, simple prompts
- Single command or small scope change
- You want prompt cleanup without codebase exploration

Use `/prompt-hybrid` when:
- Complex tasks needing codebase exploration
- Multi-file or multi-command scope
- Pattern detection across the project needed

Use `/prompt-technical` when:
- Architecture decisions needed
- Code scaffolding or implementation options
- Best practices guidance for technical choices

---

**Project-aware prompt perfection - type: /prompt [your task]**
