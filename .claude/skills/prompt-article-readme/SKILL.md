---
name: prompt-article-readme
description: Generates or updates a professional README.md for any project by analyzing codebase structure, configuration files, and existing documentation. Use when the user wants to create or update a README with an interactive wizard.
argument-hint: "[optional: language style] or [--update]"
---

# /prompt-article-readme - README.md Generator

This command generates or updates a professional README.md file for any project by analyzing the codebase structure, configuration files, and existing documentation. It first perfects the user's prompt, then guides through the README generation wizard.

---

## STARTUP: Load Project Context (ALWAYS FIRST)

Before any analysis, load known facts from memory:

1. Read `.claude/memory/project-profile.md`
2. Read last 3 sessions from `.claude/memory/sessions.md`
3. Read `.claude/memory/prompt-patterns.md` if it exists

Skip asking about anything already in the profile.

**CACHING (Opus 4.7 — see `.claude/library/caching-strategy.md`):**
prompt-perfection-core, readme-adapter, execution-plan-template, model-router, model-tiers
are stable across calls — flag with `cache_control: ephemeral` when invoked via Anthropic SDK.

---

## Phase 0: Prompt Perfection

**Import:** Use Phase 0 from `.claude/library/prompt-perfection-core.md`
**Adaptation:** Article/Documentation (from `.claude/library/readme-adapter.md`)

**Phase 0 v2.1 Add-ons (mandatory):**
- Step 0.25 Curiosity Gate (confidence + assumption ledger)
- Step 0.35 Options-First: present minimal / standard / comprehensive README
  styles with tradeoffs before generating
- Step 0.55 Execution Plan + MODEL HINT
  (see `.claude/library/execution-plan-template.md`
   and `.claude/library/model-router.md`)
- MODEL HINT default for README generation: haiku (template-driven task)
- Approval gate adds `switch [haiku|sonnet|opus]` response

**Before starting the README wizard, first perfect the user's prompt.**

### Step 0.1: Initial Analysis
- Detect language (Slovak / English)
- **Auto-detect prompt type:** Documentation / README Generation (smart default for this command)
- Extract the core intent: What README does the user want to create/update?

### Step 0.2: Completeness Check
Verify the prompt contains:
- [ ] Clear goal/desired outcome (generate new / update existing README)
- [ ] Context (project type, purpose)
- [ ] Scope (which project, specific sections needed)
- [ ] Constraints (if any: style preference, sections to include/exclude)
- [ ] Success criteria (what makes a good README for this project)

Mark missing items - these will be collected in the wizard steps.

### Step 0.3: Clarification (if needed)
- If anything is ambiguous or unclear, ASK before proceeding
- If multiple valid approaches exist:
  - List each option with pros/cons
  - Mark recommended option with reasoning
  - Wait for user selection

### Step 0.4: Correction
- Fix grammar, spelling, sentence structure
- Preserve all technical terms, project names, and references EXACTLY
- Keep original intent and tone
- Make it clear, specific, and actionable

### Step 0.5: Structure the Perfect Prompt
Transform into an executable format with:
1. **Goal** - Generate new or update existing README
2. **Project** - Which project/directory
3. **Context** - Project purpose and background
4. **Constraints** - Style, sections, or other requirements
5. **Expected Result** - What the README should achieve

### Phase 0 Output Format

**Detected Language:** [Slovak / English]
**Prompt Type:** Documentation / README Generation *(auto-detected)*

**Original:**
> $ARGUMENTS

**Completeness Check:**
- [x] Goal: [extracted or auto-filled: "Generate README.md" - will be collected in wizard]
- [x] Project: [extracted or auto-filled: current directory]
- [x] Context: [extracted or auto-detected from project analysis]
- [ ] Constraints: [extracted or optional]
- [x] Style: [extracted or will be collected in wizard]

**Smart Defaults Applied:**
- Output format: README.md file (auto-detected from command type)
- Project context: Auto-analyzed from current directory
- Wizard will collect all missing documentation-specific parameters

**Perfected Prompt:**
> **Goal:** [generate/update README]
> **Project:** [project path or current directory]
> **Style:** [if specified, or "will configure in wizard"]
> **Constraints:** [any limitations, or "None - will configure in wizard"]

**Changes Made:**
- [list of corrections and improvements]

---

Waiting for approval before starting README wizard. Reply with:
- `y` or `yes` -- proceed to README wizard
- `n` or `no` -- cancel
- Or type modifications for adjustments

---

## README Wizard Flow

Guide the user through each step using the AskUserQuestion tool. Do NOT skip steps or assume answers.

---

### Step 1: Language Selection

**Ask the user:**
> What language should the README be written in?

**Options:**
- **English** - International audience, standard formatting
- **Slovak** - Slovak language with proper grammar and diacritics

---

### Step 2: README Style

**Ask the user:**
> What style of README do you prefer?

**Options:**
- **Minimal** - Essential sections only (Description, Install, Usage)
- **Standard** - Common sections (Description, Install, Usage, Configuration, Contributing)
- **Comprehensive** - Full documentation (all sections including API, Architecture, Troubleshooting)
- **Badge-heavy** - Standard + shields.io badges for build status, coverage, version, etc.

---

### Step 3: Project Analysis

**Automatic Analysis - No user input needed:**

Analyze the project to detect:

1. **Project Type** - Detect from files:
   - `package.json` -> Node.js/JavaScript/TypeScript
   - `*.csproj` / `*.sln` -> .NET/C#
   - `requirements.txt` / `pyproject.toml` / `setup.py` -> Python
   - `Cargo.toml` -> Rust
   - `go.mod` -> Go
   - `pom.xml` / `build.gradle` -> Java
   - `composer.json` -> PHP

2. **Framework Detection**:
   - React, Vue, Angular, Next.js, Nuxt
   - ASP.NET Core, Entity Framework
   - Express, Fastify, NestJS
   - Django, Flask, FastAPI
   - Spring Boot

3. **Build/Run Commands** - Extract from:
   - `package.json` scripts
   - `Makefile` targets
   - `.csproj` configuration
   - CI/CD files (`.github/workflows/`, `azure-pipelines.yml`)

4. **Dependencies** - Count and categorize from manifest files

5. **Existing Documentation** - Check for:
   - Existing `README.md` (preserve custom content)
   - `CONTRIBUTING.md`
   - `LICENSE`
   - `CHANGELOG.md`
   - `/docs` folder

6. **Project Structure** - Map key directories

---

### Step 4: Custom Sections (Optional)

**Ask the user:**
> Do you want to add any custom sections? (Optional - press Enter to skip)

**Options (multi-select):**
- **API Documentation** - Endpoint/method documentation
- **Architecture Diagram** - ASCII or mermaid diagram placeholder
- **Environment Variables** - .env documentation
- **Docker Support** - Docker/compose instructions
- **CI/CD** - Pipeline documentation
- **Screenshots** - Placeholder for screenshots
- **Roadmap** - Future plans section
- **FAQ** - Frequently asked questions
- **None** - Skip custom sections

---

### Step 5: Existing README Handling

**If README.md already exists, ask:**
> A README.md already exists. How should we handle it?

**Options:**
- **Replace** - Generate completely new README (backup old one)
- **Update** - Preserve custom content, update generated sections
- **Merge** - Intelligently merge existing with new content
- **Cancel** - Abort operation

---

## README Generation

After collecting inputs and analyzing the project, generate README with these sections:

### Section Templates by Style

**Minimal:**
```markdown
# Project Name

Brief description of the project.

## Installation

```bash
[install commands]
```

## Usage

```bash
[usage commands]
```

## License

[License type]
```

**Standard:**
```markdown
# Project Name

Brief description of the project.

## Features

- Feature 1
- Feature 2
- Feature 3

## Prerequisites

- Prerequisite 1
- Prerequisite 2

## Installation

```bash
[install commands]
```

## Usage

```bash
[usage commands]
```

## Configuration

[Configuration details]

## Contributing

[Contributing guidelines]

## License

[License type]
```

**Comprehensive:**
```markdown
# Project Name

Brief description of the project.

## Table of Contents

- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [API Reference](#api-reference)
- [Architecture](#architecture)
- [Testing](#testing)
- [Deployment](#deployment)
- [Contributing](#contributing)
- [Troubleshooting](#troubleshooting)
- [Changelog](#changelog)
- [License](#license)
- [Authors](#authors)

## Features

- Feature 1
- Feature 2
- Feature 3

## Prerequisites

- Prerequisite 1 (version X.X+)
- Prerequisite 2

## Installation

```bash
[install/build/run commands]
```

## Configuration

| Variable | Description | Default |
|----------|-------------|---------|
| VAR_1 | Description | value |

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## License

This project is licensed under the [LICENSE_TYPE] - see [LICENSE](LICENSE) file.
```

---

## Project-Specific Templates

### Node.js / JavaScript

```markdown
## Prerequisites

- Node.js >= [version]
- npm / yarn / pnpm

## Installation

```bash
npm install
```

## Scripts

| Command | Description |
|---------|-------------|
| `npm start` | Start the application |
| `npm run dev` | Start in development mode |
| `npm run build` | Build for production |
| `npm test` | Run tests |
```

### .NET / C#

```markdown
## Prerequisites

- .NET SDK [version]+

## Build

```bash
dotnet restore
dotnet build
dotnet run --project [ProjectName]
dotnet test
```
```

### Python

```markdown
## Prerequisites

- Python >= [version]

## Installation

```bash
pip install -r requirements.txt
```

## Usage

```bash
python main.py
```
```

---

## Instructions for Claude

When this command is executed:

1. **Phase 0: Prompt Perfection** - Perfect the user's prompt first
   - Analyze, check completeness, clarify if needed, correct, structure
   - Display the perfected prompt and wait for user approval (`y`/`n`/modifications)
   - **Do NOT proceed to README wizard until user approves**
2. **Start the interactive wizard** - Use AskUserQuestion tool for each step
3. **Analyze the project** - Read package.json, *.csproj, requirements.txt, etc.
4. **Detect project structure** - Use Glob to map directories
5. **Check existing README** - Read if exists, offer handling options
6. **Generate README** - Follow template for selected style
7. **Customize content** - Add project-specific details from analysis
8. **Save the file** - Write README.md (backup existing if replacing)
9. **Display result** - Show generated content and file location

### Quality Checklist

Before finalizing, verify:
- [ ] Project type correctly detected
- [ ] Build/run commands are accurate
- [ ] Prerequisites match actual requirements
- [ ] All selected custom sections included
- [ ] Grammar and spelling are correct
- [ ] File saved successfully

---

## Quick Start (Optional Arguments)

If user provides arguments, pre-fill wizard steps:

`/prompt-article-readme en comprehensive` - pre-selects English + Comprehensive style

`/prompt-article-readme --update` - detects existing README, defaults to Update mode

---

## Version History

See `.claude/CHANGELOG-skills.md` for full history.

**v2.1 (2026-05-02):** Migrated to skills/ format (v5 Phase 2).

---

## Library Integration

- **Core:** `.claude/library/prompt-perfection-core.md` (universal Phase 0)
- **Adapter:** `.claude/library/readme-adapter.md` (article/documentation domain)
