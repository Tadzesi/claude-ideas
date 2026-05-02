# Commands Overview

The Claude Commands Library provides three slash commands.

## All Commands

| Command | Purpose | Time |
|---------|---------|------|
| `/prompt` | Prompt analysis and structured rewrite | ~2s |
| `/prompt-article-readme` | README generator from project scan | 10-30s |
| `/prompt-research` | Deep multi-agent codebase research | 60-180s |

## Command Details

### /prompt

Fast prompt perfection using Phase 0 validation.

- **Time:** ~2 seconds
- **Best for:** Quick clarification, single-file tasks, vague descriptions

[Learn more →](/guide/commands/prompt)

---

### /prompt-article-readme

Scans your project and generates or updates README.md.

- **Time:** 10-30 seconds
- **Best for:** Missing or outdated README, open source projects

---

### /prompt-research

Deep multi-agent research with iterative refinement.

- **Time:** 60-180 seconds
- **Best for:** Security audits, architecture analysis, unfamiliar codebases

[Learn more →](/guide/commands/prompt-research)

---

## Which Command Should I Use?

| Your Goal | Command |
|-----------|---------|
| My prompt is vague | `/prompt` |
| I need a README | `/prompt-article-readme` |
| I need deep analysis | `/prompt-research` |
| Security or architecture audit | `/prompt-research` |
| I'm new to this codebase | `/prompt-research` |

## Next Steps

- [Tutorial: Getting Best Results](/guide/tutorial-best-results)
- [Phase 0 architecture](/architecture/phase-0)
- [Configure research strategies](/reference/configuration)
