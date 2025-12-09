# /prompt-technical - Technical Implementation Analysis

This command continues after `/prompt` clarifications to provide deep technical analysis for programming and development tasks.

---

## Step 1: Project Analysis

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

## Step 2: Technical Analysis Output

Based on the clarified prompt from `/prompt`, provide:

**Project Context:**
```
Tech Stack: [detected technologies]
Framework: [detected framework(s)]
Architecture: [detected patterns]
Relevant Files: [files that will be affected]
```

---

## Step 3: Implementation Options

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

## Step 4: Best Practices Checklist

Based on the detected tech stack, suggest:

- [ ] **Architecture:** [Relevant architectural best practice]
- [ ] **Error Handling:** [Error handling approach for this stack]
- [ ] **Testing:** [Testing strategy recommendation]
- [ ] **Security:** [Security considerations if applicable]
- [ ] **Performance:** [Performance considerations if applicable]
- [ ] **Documentation:** [Documentation suggestions]

---

## Step 5: Implementation Plan

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

## Step 6: Code Scaffolding

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

🔍 ANALYSIS OF: "[task summary from /prompt]"

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

1. **First**, scan the project directory for configuration files and structure
2. **Second**, identify the tech stack and existing patterns
3. **Third**, analyze the user's task (from previous `/prompt` conversation)
4. **Fourth**, generate 2-3 implementation options with code examples
5. **Fifth**, recommend the best option with reasoning
6. **Sixth**, provide actionable implementation steps with code scaffolding

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
