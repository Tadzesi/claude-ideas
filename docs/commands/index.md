# Commands Overview

Claude Commands Library provides three slash commands.

## All Commands

| Command | Purpose |
|---------|---------|
| `/prompt` | Prompt analysis and structured rewrite |
| `/prompt-article-readme` | README generator from project scan |
| `/prompt-research` | Multi-agent codebase research (2-4 iterations) |

## Command Details

### /prompt — Prompt analysis and structured rewrite

Transforms any vague or incomplete task description into a structured executable prompt.

```bash
/prompt Refactor the UserService to use repository pattern
```

**Output structure:** Goal, Context, Scope, Requirements, Constraints, Expected Result.

**Features:**
- Phase 0 validation (detect, recall, check, ask, structure, approve)
- Bilingual support (Slovak / English)
- Memory recall — pre-fills known facts from `project-profile.md`

[Full guide →](/guide/commands/prompt)

---

### /prompt-article-readme — README generator

Scans your project and generates or updates `README.md` matched to the detected stack.

```bash
/prompt-article-readme
```

**What it scans:**
- `package.json`, `.csproj`, `Dockerfile`, `docker-compose.yml`
- Existing README (to update rather than overwrite)
- Git history for project age and contributors

**Features:**
- Detects framework, version, architecture
- Three style levels: Minimal, Standard, Comprehensive
- Handles updates to existing README

---

### /prompt-research — Multi-agent codebase research

Deep research workflow using 2-5 parallel specialist agents, with 2-4 iteration cycles.

```bash
/prompt-research Understand the payment processing flow and identify security risks
```

**Agent types:**
- **Explore Agent** — maps files, dependencies, entry points
- **Pattern Agent** — detects conventions and anti-patterns
- **Security Agent** — flags vulnerabilities
- **Performance Agent** — identifies bottlenecks
- **Citation Agent** — grounds every finding to a `file:line`

**Features:**
- Iterative refinement — gaps detected between rounds trigger another iteration
- Persistent knowledge graph in `.claude/memory/project-knowledge.md`
- Reports with `file:line` citations

[Full guide →](/guide/commands/prompt-research)

---

## Which Command Should I Use?

| Goal | Command |
|------|---------|
| My task description is vague | `/prompt` |
| I want a better prompt before asking Claude to code | `/prompt` |
| My README is missing or outdated | `/prompt-article-readme` |
| I'm joining an unfamiliar codebase | `/prompt-research` |
| Security or architecture audit | `/prompt-research` |
| Performance investigation | `/prompt-research` |

## Next Steps

- [Tutorial: Getting Best Results](/guide/tutorial-best-results)
- [Phase 0 architecture](/architecture/phase-0)
- [Multi-agent research system](/architecture/multi-agent)
