# Commands Overview

Claude Commands Library provides 11 slash commands organized into five categories.

::: tip Version 4.6 - Anti-Hallucination Contract
- **HARD-GATE blocks** in all skills — pre-flight checklist before any output
- **NEVER rules** — explicit per-domain prohibitions (no invented paths, versions, or facts)
- **Chain-of-Thought REASONING block** required in every Step 0.1 output
- **`/deploy`** and **`/new-stack`** — universal config from `personal-profile.md`
- Session commands removed in v4.5 — replaced by Claude Code's built-in auto-memory
- [View Changelog →](/reference/changelog)
:::

## Quick Reference

| Command | Purpose | Speed | Version |
|---------|---------|-------|---------|
| [/prompt](/commands/prompt) | Basic prompt perfection | ~2s | v4.0 |
| [/prompt-hybrid](/commands/prompt-hybrid) | Intelligent with agents | 2-30s | v4.0 |
| [/prompt-technical](/commands/prompt-technical) | Implementation analysis | 5-30s | v4.0 |
| [/prompt-research](/commands/prompt-research) | Multi-agent research | 60-180s | v4.0 |
| [/prompt-dotnet](/commands/prompt-dotnet) | .NET project-aware perfection | ~3s | v2.0 |
| [/prompt-react](/commands/prompt-react) | React project-aware perfection | ~3s | v2.0 |
| [/prompt-article](/commands/prompt-article) | Article writing | Interactive | v2.0 |
| [/prompt-article-readme](/commands/prompt-article-readme) | README generation | ~30s | v2.0 |
| [/deploy](/commands/deploy) | Project-aware deployment | Interactive | v2.0 |
| [/new-stack](/commands/new-stack) | Docker stack scaffold | ~5s | v2.0 |
| [/reflect](/commands/reflect) | Improve skills | 5-15s | v2.0 |

## Categories

### Prompt Engineering

Commands for transforming ideas into precise, executable prompts.

**[/prompt](/commands/prompt)** - Fast prompt perfection
```bash
/prompt Fix the login bug showing null error
```
Best for: Quick fixes, simple questions, single-file changes.

**[/prompt-hybrid](/commands/prompt-hybrid)** - Intelligent prompt perfection
```bash
/prompt-hybrid Add authentication following existing patterns
```
Best for: Complex tasks, multi-file changes, pattern detection.

**[/prompt-technical](/commands/prompt-technical)** - Technical implementation
```bash
/prompt-technical Implement Redis caching for user queries
```
Best for: New features, refactoring, architecture decisions.

**[/prompt-research](/commands/prompt-research)** - Deep analysis
```bash
/prompt-research Perform security audit of payment system
```
Best for: Security audits, performance analysis, architecture review.

**`/prompt-dotnet`** - .NET project-aware prompt perfection
```bash
/prompt-dotnet Add JWT refresh token endpoint
```
Scans `.csproj`, `Program.cs`, `appsettings.json` — pre-fills framework, auth, ORM, Docker. Best for: C# APIs, EF Core migrations, middleware, .NET features.

**`/prompt-react`** - React project-aware prompt perfection
```bash
/prompt-react Add a paginated item list with TanStack Query
```
Scans `package.json`, `vite.config`, `tsconfig` — pre-fills React version, router, state, base path. Best for: Components, hooks, routing, state management, Vite config.

### Content Creation

Commands for generating written content.

**[/prompt-article](/commands/prompt-article)** - Article wizard
```bash
/prompt-article Write about CI/CD best practices
```
Interactive wizard for blog posts, Medium articles, LinkedIn content.

**[/prompt-article-readme](/commands/prompt-article-readme)** - README generator
```bash
/prompt-article-readme
```
Analyzes project and generates comprehensive README.

### Deployment & Infrastructure

Commands for deploying and scaffolding Docker stacks.

**[/deploy](/commands/deploy)** - Project-aware deployment
```bash
/deploy
/deploy my-app
```
Scans project, reads server config from `personal-profile.md`, generates complete deploy command sequence.

**[/new-stack](/commands/new-stack)** - Docker stack scaffold
```bash
/new-stack
/new-stack my-app
```
Generates `docker-compose.yml`, `nginx.conf`, `Dockerfile.api`, `.env`, `deploy.sh` for a new stack.

### Utility

Commands for system improvement.

**[/reflect](/commands/reflect)** - Skill improvement
```bash
/reflect prompt-technical
```
Analyzes session and proposes improvements based on corrections and preferences.

## How Commands Work

### Phase 0: Every Command Starts Here

All prompt commands run Phase 0 validation (AI Fluency aligned):

```
Step 0.1: Initial Analysis
- Detect language (English, Slovak, etc.)
- Identify prompt type (Task, Question, Bug Fix, etc.)
- Extract core intent

Step 0.11: Quick Delegation Check
- Task Appropriateness: Is this suitable for AI?
- AI Capability Match: Does this match AI strengths?
- Responsibility Awareness: User remains responsible

Step 0.12: Interaction Mode Detection
- Automation Mode: "Fix X", "Add Y"
- Augmentation Mode: "Help me understand", "What's best"
- Agency Mode: "Research X", "Explore"

Step 0.2: Completeness Check (9 criteria)
- Recall known facts from project profile (v4.2)
- Product: Goal, Context (pre-filled), Scope, Requirements, Constraints (pre-filled), Expected Result
- Process: Approach methodology
- Performance: Interaction style, Communication tone

Step 0.3: Clarification Questions
- Skip questions answered by project profile
- Ask only genuinely unknown information
- Present options where needed
- Prioritize by criticality

Step 0.4-0.5: Perfect the Prompt
- Structure into clear format
- Add detected context
- Include constraints

Step 0.6: Approval Gate
- Show perfected prompt
- Diligence Reminder: "You remain responsible..."
- Wait for user confirmation

Step 0.7: Post-Execution Evaluation (NEW v4.2)
- Prompt: "How was this output? good/partial/wrong"
- Feedback loop for iteration
```

### Complexity Detection

Commands with hybrid intelligence score your prompt:

| Score | Category | What Happens |
|-------|----------|--------------|
| 0-4 | Simple | Fast inline validation only |
| 5-9 | Moderate | Claude asks if you want agent help |
| 10-19 | Complex | Agent spawns automatically |
| 20+ | Research | Multi-agent deep analysis |

### Agent Types

When complexity warrants, specialized agents help:

- **Explore Agent** (Haiku, 30s) - Scans codebase for patterns
- **Plan Agent** (Sonnet, 60s) - Creates implementation strategies
- **Security Agent** (Sonnet, 45s) - Checks for vulnerabilities
- **Performance Agent** (Sonnet, 45s) - Identifies bottlenecks
- **Pattern Agent** (Haiku, 30s) - Ensures consistency

## Choosing the Right Command

### Decision Flow

```
┌─────────────────────────────────────────┐
│ What do you need?                       │
└─────────────────────────────────────────┘
          │
    ┌─────┴─────┐
    ▼           ▼
┌───────┐   ┌─────────┐
│ Code  │   │ Content │
└───────┘   └─────────┘
    │           │
    │      ┌────┴────┐
    │      ▼         ▼
    │  ┌───────┐ ┌────────┐
    │  │Article│ │ README │
    │  └───────┘ └────────┘
    │      │         │
    │      ▼         ▼
    │  /prompt   /prompt-
    │  -article  article-
    │            readme
    │
    ├─── Simple fix? ───────► /prompt
    │
    ├─── Need codebase ─────► /prompt-hybrid
    │    context?
    │
    ├─── Implementation ────► /prompt-technical
    │    planning?
    │
    └─── Deep analysis? ────► /prompt-research
```

### By Use Case

| Use Case | Command |
|----------|---------|
| Fix a bug | `/prompt` |
| Add a small feature | `/prompt` or `/prompt-hybrid` |
| Add a complex feature | `/prompt-technical` |
| Refactor code | `/prompt-technical` |
| Security audit | `/prompt-research` |
| Performance optimization | `/prompt-research` |
| Architecture review | `/prompt-research` |
| Write documentation | `/prompt-article` |
| Generate README | `/prompt-article-readme` |
| Deploy to server | `/deploy` |
| Scaffold Docker stack | `/new-stack` |
| Improve a command | `/reflect` |

## Next Steps

- [Tutorial: Getting Best Results](/guide/tutorial-best-results) - Complete guide
- [Learn /prompt](/commands/prompt) - The foundation
- [Learn /prompt-technical](/commands/prompt-technical) - For implementation
- [AI Fluency Framework](/architecture/ai-fluency) - The 4Ds explained
- [Understand the architecture](/architecture/) - How it all works
