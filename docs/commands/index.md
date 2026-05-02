# Commands Overview

Claude Commands Library provides three slash commands for Claude Code.

::: tip v5.0 — Honest 3-command scope
Reduced from eleven commands to three that are actually maintained and tested.
[See what was removed →](/reference/changelog#500-may-2026)
:::

## Quick Reference

| Command | Purpose |
|---------|---------|
| [/prompt](/commands/prompt) | Prompt analysis and structured rewrite |
| [/prompt-article-readme](/commands/prompt-article-readme) | README generator from project scan |
| [/prompt-research](/commands/prompt-research) | Multi-agent codebase research |

## Commands

### /prompt

Analyses any prompt, asks targeted clarifying questions, and rewrites it into a structured executable form.

```bash
/prompt Fix the authentication bug returning null for expired tokens
```

**Output structure:** Goal, Context, Scope, Requirements, Constraints, Expected Result.

**When to use:** Any time a task description is vague, incomplete, or likely to produce the wrong result on the first attempt.

[Full documentation →](/commands/prompt)

---

### /prompt-article-readme

Scans your project's structure and config files, then generates or updates a `README.md` matched to the detected stack and conventions.

```bash
/prompt-article-readme
```

**What it scans:** `package.json`, `.csproj`, `Dockerfile`, `docker-compose.yml`, git history, existing README.

**When to use:** New project without a README, stale README after a major refactor, or project handed off to a new team.

[Full documentation →](/commands/prompt-article-readme)

---

### /prompt-research

Multi-step research workflow for unfamiliar codebases. Spawns parallel exploration agents, iterates on findings, and produces a single consolidated report.

```bash
/prompt-research Understand the payment processing flow and identify risks
```

**What it does:** 2–4 iteration cycles using 5 specialist agents (Explore, Pattern, Security, Performance, Citation). Each iteration refines the previous findings and resolves gaps.

**When to use:** Unfamiliar codebase, architecture audit, security review, performance investigation — any situation where you need thorough understanding with source citations.

[Full documentation →](/commands/prompt-research)

---

## How All Commands Work

### Phase 0: Shared Foundation

Every command begins with Phase 0 — a shared validation layer:

1. **Recall** — load known facts from project memory
2. **Detect** — language, type, and intent
3. **Check** — completeness criteria, pre-filling from memory
4. **Ask** — only genuinely unknown information
5. **Structure** — transform into executable format
6. **Approve** — wait for confirmation before proceeding

[Phase 0 architecture →](/architecture/phase-0)

### Plan-First Execution

Before any file edit, build, test, or commit, Claude will:
1. Summarise its understanding of the task
2. Present 2–3 implementation options for non-trivial work
3. Show an execution plan (files, steps, risks, verification)
4. Wait for explicit approval

This is enforced globally via `CLAUDE.md` — not just inside slash commands.

[Interaction Protocol →](/guide/interaction-protocol)

## Next Steps

- [Tutorial: Getting Best Results](/guide/tutorial-best-results)
- [Architecture Overview](/architecture/)
- [Installation](/getting-started/installation)
