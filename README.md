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

## Recent Improvements (December 2024)

### Phase 0: Prompt Perfection Framework

All prompt commands now include a standardized **Phase 0: Prompt Perfection** flow that ensures every prompt is analyzed, clarified, and perfected before execution.

**The Phase 0 Flow:**

1. **Step 0.1: Initial Analysis**
   - Detects language (Slovak/English)
   - Identifies prompt type (Task, Question, Bug Fix, etc.)
   - Extracts core intent

2. **Step 0.2: Completeness Check**
   - Verifies goal, context, scope, constraints, and success criteria
   - Marks missing items for clarification

3. **Step 0.3: Clarification**
   - Asks questions about ambiguous items
   - Presents multiple implementation options when applicable
   - Marks recommended approach with reasoning

4. **Step 0.4: Correction**
   - Fixes grammar, spelling, and structure
   - Preserves technical terms exactly as written
   - Makes prompts clear and actionable

5. **Step 0.5: Structure the Perfect Prompt**
   - Transforms into executable format
   - Outputs: Goal, Context, Scope, Requirements, Constraints, Expected Result

**Example: Before Phase 0**
```
/prompt Fix bug in user login
```

**After Phase 0 Analysis:**
```
Detected Language: English
Prompt Type: Bug Fix

Completeness Check:
✓ Goal: Fix login bug
✗ Context: Which framework? ASP.NET? React?
✗ Scope: Frontend validation or backend authentication?
✗ Success Criteria: How to verify fix?

Questions:
1. What login framework are you using?
2. What specific error occurs?
3. Which layer needs fixing (UI, API, database)?

Perfected Prompt:
Goal: Fix null reference exception in ASP.NET Core login API
Context: ASP.NET Core 6.0, SQL Server, JWT authentication
Scope: UserController.Login() method, line 47
Requirements:
1. Handle null email input
2. Add proper error logging
3. Return appropriate HTTP status codes
Constraints: Maintain existing JWT token structure
Expected Result: Login API handles invalid input gracefully
```

### Smart Defaults

Specialized commands now auto-detect context to reduce repetitive questions:

- **`/prompt-article`** - Auto-detects "Article/Content Creation" as prompt type
- **`/prompt-article-readme`** - Auto-detects current directory and project type from configuration files
- **`/prompt-technical`** - Auto-analyzes project structure, tech stack, and existing patterns

**Example: Smart Defaults in Action**

```
/prompt-article Write about AI in healthcare

Phase 0 Output:
✓ Goal: Auto-filled: "Write an article"
✓ Context: Auto-filled: "article content"
✓ Output Format: Auto-detected: "Article"

Smart Defaults Applied:
- Output format: Article (auto-detected from command type)
- Wizard will collect: topic, audience, style, platform
```

### Consistency Across All Commands

All four prompt commands now follow the same pattern:

```
Phase 0 (Analyze → Clarify → Correct → Structure)
    ↓
Wait for User Approval (y/n/modifications)
    ↓
Execute Command-Specific Logic (wizard/analysis/generation)
```

This ensures:
- ✅ No ambiguous prompts slip through
- ✅ Users see exactly what will be executed
- ✅ Context-aware smart defaults reduce friction
- ✅ Consistent user experience across all commands

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

## Future Enhancements

The prompt command system can be further improved with these enhancements:

### High Priority

1. **Example Library**
   - Add interactive examples to each command
   - Show before/after transformations
   - Include domain-specific examples (web dev, data science, DevOps)

2. **Validation & Error Handling**
   - Add validation for common input mistakes
   - Detect and warn about overly vague prompts
   - Suggest corrections for typical errors

3. **Quick Syntax Support**
   - Enable shortcuts like `/prompt-article sk linkedin "topic"`
   - Support inline parameters to skip wizard steps
   - Add flags for common options (e.g., `--update`, `--comprehensive`)

### Medium Priority

4. **Prompt Templates**
   - Pre-built templates for common scenarios
   - Save custom templates for reuse
   - Share templates across projects

5. **History & Learning**
   - Track frequently used prompts
   - Suggest improvements based on patterns
   - Learn from user modifications

6. **Multi-language Enhancements**
   - Expand beyond Slovak/English
   - Language-specific style guides
   - Cultural context awareness

### Low Priority

7. **Integration Features**
   - Export prompts to external tools
   - Integration with project management systems
   - API for programmatic access

8. **Advanced Smart Defaults**
   - ML-based context prediction
   - Project-specific learning
   - Auto-detection of coding patterns and preferences

9. **Collaborative Features**
   - Share perfected prompts with team
   - Prompt review workflow
   - Team-specific templates and conventions

### Experimental

10. **Prompt Analytics**
    - Measure prompt quality improvements
    - Track success rates
    - Identify common clarification needs

11. **Voice Input Support**
    - Transcribe spoken prompts
    - Real-time clarification dialogue
    - Voice-optimized wizards

12. **Visual Prompt Builder**
    - Drag-and-drop prompt construction
    - Visual completeness indicators
    - Interactive decision trees

---

**Want to contribute?** These enhancements are tracked in the project backlog. PRs welcome!

## License

MIT
