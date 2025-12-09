# /prompt-technical - Technical Implementation Analysis

This command provides deep technical analysis for programming and development tasks. It first perfects the user's prompt, then performs comprehensive technical analysis.

---

## Phase 0: Prompt Perfection

**Before any technical analysis, first perfect the user's prompt.**

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

### Phase 0 Output Format

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

**Perfected Prompt:**
> **Goal:** [one clear sentence]
> **Context:** [environment, tech stack, background]
> **Scope:** [specific files, components, areas]
> **Requirements:** [numbered list]
> **Constraints:** [any limitations, or "None"]
> **Expected Result:** [what success looks like]

**Changes Made:**
- [list of corrections and improvements]

---

⏸️ **Waiting for approval before technical analysis.** Reply with:
- `y` or `yes` — proceed to technical analysis
- `n` or `no` — cancel
- Or type modifications for adjustments

---

## Phase 1: Project Analysis

Automatically detect and analyze:

### 1.1 Project Structure Detection
- Scan for project configuration files:
  - `package.json` (Node.js/JavaScript/TypeScript)
  - `requirements.txt`, `pyproject.toml`, `setup.py` (Python)
  - `Cargo.toml` (Rust)
  - `go.mod` (Go)
  - `pom.xml`, `build.gradle` (Java)
  - `*.csproj`, `*.sln` (C#/.NET)
  - `composer.json` (PHP)
- Map directory structure (src/, lib/, tests/, etc.)
- Identify entry points and main modules

### 1.2 Tech Stack Identification
- Frameworks (React, Vue, Angular, Django, FastAPI, Spring, etc.)
- Build tools (Webpack, Vite, esbuild, etc.)
- Testing frameworks (Jest, Pytest, JUnit, etc.)
- Database technologies (from config files or dependencies)
- CI/CD configuration (.github/workflows, .gitlab-ci.yml, etc.)

### 1.3 Existing Patterns Analysis
- Code style and conventions used in the project
- Common patterns (repository pattern, service layer, etc.)
- Existing utilities and helpers that can be reused
- Naming conventions and file organization

---

## Phase 2: Technical Analysis Output

Based on the perfected prompt from Phase 0, provide:

**Project Context:**
```
Tech Stack: [detected technologies]
Framework: [detected framework(s)]
Architecture: [detected patterns]
Relevant Files: [files that will be affected]
```

---

## Phase 3: Implementation Options

For each valid approach, provide:

### Option A: [Name]
**Description:** [What this approach does]

**Pros:**
- [Advantage 1]
- [Advantage 2]

**Cons:**
- [Disadvantage 1]
- [Disadvantage 2]

**Code Example:**
```[language]
// Scaffolding example for this approach
[code snippet]
```

**Files to Create/Modify:**
- `path/to/file.ext` - [what changes]

---

### Option B: [Name]
[Same structure as Option A]

---

### ⭐ Recommended Option: [X]
**Reasoning:** [Why this is the best choice for this project]

---

## Phase 4: Best Practices Checklist

Based on the detected tech stack, suggest:

- [ ] **Architecture:** [Relevant architectural best practice]
- [ ] **Error Handling:** [Error handling approach for this stack]
- [ ] **Testing:** [Testing strategy recommendation]
- [ ] **Security:** [Security considerations if applicable]
- [ ] **Performance:** [Performance considerations if applicable]
- [ ] **Documentation:** [Documentation suggestions]

---

## Phase 5: Implementation Plan

Provide numbered, actionable steps:

1. **[First step]**
   ```[language]
   // Code scaffolding
   ```

2. **[Second step]**
   ```[language]
   // Code scaffolding
   ```

3. [Continue as needed...]

---

## Phase 6: Code Scaffolding

Generate ready-to-use code templates:

### File: `[path/to/new/file.ext]`
```[language]
// Complete scaffolding code
[full implementation template]
```

### File: `[path/to/modified/file.ext]`
```[language]
// Changes to make (with context)
[code with modifications highlighted]
```

---

## Output Format

```
╔══════════════════════════════════════════════════════════════╗
║                 TECHNICAL ANALYSIS REPORT                     ║
╚══════════════════════════════════════════════════════════════╝

📁 PROJECT CONTEXT
├── Tech Stack: [list]
├── Framework: [name + version if detectable]
├── Architecture: [pattern]
└── Relevant Existing Code: [files/patterns]

🔍 ANALYSIS OF: "[task summary from Phase 0]"

📋 IMPLEMENTATION OPTIONS
┌─────────────────────────────────────────────────────────────┐
│ Option A: [name]                                            │
│ + [pro]                                                     │
│ - [con]                                                     │
├─────────────────────────────────────────────────────────────┤
│ Option B: [name]                                            │
│ + [pro]                                                     │
│ - [con]                                                     │
├─────────────────────────────────────────────────────────────┤
│ ⭐ RECOMMENDED: Option [X]                                   │
│ Reason: [why]                                               │
└─────────────────────────────────────────────────────────────┘

✅ BEST PRACTICES FOR [TECH STACK]
• [practice 1]
• [practice 2]
• [practice 3]

📝 IMPLEMENTATION STEPS
1. [step with code example]
2. [step with code example]
3. [...]

💻 CODE SCAFFOLDING
[Ready-to-use code blocks]
```

---

## Instructions for Claude

When this command is executed:

1. **Phase 0**: Perfect the user's prompt using the Prompt Perfection flow
   - Analyze, check completeness, clarify if needed, correct, structure
   - Display the perfected prompt and wait for user approval (`y`/`n`/modifications)
   - **Do NOT proceed to technical analysis until user approves**
2. **Phase 1**: Scan the project directory for configuration files and structure
3. **Phase 2**: Identify the tech stack and existing patterns
4. **Phase 3**: Generate 2-3 implementation options with code examples
5. **Phase 4**: Recommend the best option with reasoning
6. **Phase 5-6**: Provide actionable implementation steps with code scaffolding

Always include:
- Actual code examples (not pseudocode)
- File paths relative to project root
- Consideration of existing project patterns
- Security and performance notes where relevant

---

⏸️ **After analysis, wait for user confirmation:**
- `proceed` — implement the recommended option
- `option [A/B/C]` — implement specific option
- `modify` — adjust the analysis
- `cancel` — stop
