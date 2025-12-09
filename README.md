# Claude Prompt Commands

A collection of Claude Code slash commands for prompt engineering, refinement, and content generation. Transform vague ideas into precise, executable prompts.

## Features

- **Prompt Perfection** - Analyze and refine any prompt to be clear and unambiguous
- **Technical Analysis** - Deep dive into implementation options with code scaffolding
- **Article Generation** - Interactive wizard for multi-platform content creation
- **README Generation** - Auto-generate professional documentation from project analysis

## Prerequisites

- [Claude Code CLI](https://claude.ai/code) installed and configured
- Windows 11 (or compatible environment)

## Installation

1. Clone or copy the `.claude/commands/` folder to your project:

```powershell
git clone <repository-url>
cd claude_ideas
```

2. Verify commands are available:

```powershell
Test-Path .claude/commands/prompt.md
```

## Commands

### `/prompt`

**Purpose:** Analyze, clarify, and perfect any prompt into an unambiguous, executable format.

**What it does:**
1. Detects language (Slovak/English)
2. Identifies prompt type (Task, Question, Bug Fix, etc.)
3. Checks completeness (goal, context, scope, constraints)
4. Asks clarifying questions if needed
5. Outputs a structured, perfected prompt

**Usage:**
```
/prompt Fix the login bug in my app
```

**Output:** A structured prompt with Goal, Context, Scope, Requirements, Constraints, and Expected Result.

---

### `/prompt-technical`

**Purpose:** Provide deep technical analysis for programming tasks with implementation options.

**What it does:**
1. Scans project structure and tech stack
2. Identifies frameworks, patterns, and conventions
3. Generates 2-3 implementation options with pros/cons
4. Recommends best approach with reasoning
5. Provides ready-to-use code scaffolding

**Usage:**
```
/prompt-technical
```

Best used after `/prompt` to get detailed implementation analysis.

**Output:** Technical analysis report with project context, implementation options, best practices checklist, and code scaffolding.

---

### `/prompt-article`

**Purpose:** Interactive wizard for writing articles with multi-platform output.

**What it does:**
1. Guides through language, type, audience, and style selection
2. Collects topic and key points
3. Generates article in selected format
4. Creates platform-specific versions (LinkedIn, Jira, Medium, Dev.to, etc.)
5. Saves markdown file to specified location

**Usage:**
```
/prompt-article
```

**Article Types:** Blog Post, LinkedIn Post, Technical Article, Tutorial, How-to Guide, Case Study, News Article, Opinion Piece

**Output:** Full article with formatted versions for each selected platform.

---

### `/prompt-article-readme`

**Purpose:** Generate or update professional README.md files by analyzing your project.

**What it does:**
1. Analyzes project structure and configuration files
2. Detects tech stack, frameworks, and dependencies
3. Guides through style selection (Minimal, Standard, Comprehensive)
4. Generates README with appropriate sections
5. Handles existing README (replace, update, merge)

**Usage:**
```
/prompt-article-readme
/prompt-article-readme --update
```

**Output:** Professional README.md tailored to your project type.

---

## Project Structure

```
.claude/
  commands/
    prompt.md              # Prompt perfection command
    prompt-technical.md    # Technical analysis command
    prompt-article.md      # Article writing wizard
    prompt-article-readme.md  # README generator
```

## Workflow Example

1. **Start with a vague idea:**
   ```
   /prompt add user authentication to my app
   ```

2. **Get technical implementation details:**
   ```
   /prompt-technical
   ```

3. **Document your feature:**
   ```
   /prompt-article-readme --update
   ```

4. **Write about it:**
   ```
   /prompt-article
   ```

## Tips for Best Results

1. **Be specific** - Include context about your project and goals
2. **Answer questions** - The wizards ask clarifying questions for a reason
3. **Chain commands** - Use `/prompt` first, then `/prompt-technical` for implementation
4. **Iterate** - Use modification options after generation to refine output

## License

MIT
