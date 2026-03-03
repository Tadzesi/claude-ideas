# Skills Format (v4.3)

Claude Commands Library now uses the native **Claude Code Skills format** alongside the original `.claude/commands/` format. Both work — Skills add powerful new capabilities.

## What Changed

::: info Backward Compatible
Your existing `.claude/commands/*.md` files work unchanged. Skills are an addition, not a replacement.
:::

| Format | Location | Auto-invoke | YAML frontmatter | Supporting files |
|--------|----------|-------------|------------------|-----------------|
| Commands (old) | `.claude/commands/name.md` | No | No | No |
| Skills (new) | `.claude/skills/name/SKILL.md` | Yes | Yes | Yes |

Both create the same `/name` slash command. Skills have more features.

## YAML Frontmatter

Skills use YAML frontmatter to configure behavior:

```yaml
---
name: prompt
description: Transform any prompt into an unambiguous, executable format.
             Use when the user wants to refine or clarify a task.
argument-hint: "[your prompt or task description]"
disable-model-invocation: false
---

# Skill content starts here...
```

### Frontmatter Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | No | Skill name (defaults to directory name) |
| `description` | Recommended | When to use this skill — Claude uses this for auto-invocation |
| `argument-hint` | No | Shown in autocomplete (e.g. `[issue-number]`) |
| `disable-model-invocation` | No | `true` = only user can invoke (not Claude) |
| `allowed-tools` | No | Tools available without permission prompt |
| `model` | No | Override model for this skill |
| `context` | No | `fork` = run in isolated subagent |

## Auto-Invocation

The `description` field enables Claude to suggest or auto-invoke a skill when relevant:

```yaml
description: Transform any prompt into an unambiguous, executable format.
             Use when the user wants to refine or perfect a prompt, clarify
             a vague request, or ensure a task is well-specified.
```

When you write something like "can you help me make this task description clearer?", Claude sees the description and activates `/prompt` automatically — no manual invocation needed.

### Controlling Who Invokes

```yaml
# Default: both user and Claude can invoke
disable-model-invocation: false

# Only user can invoke (Claude won't auto-trigger)
disable-model-invocation: true
```

Use `disable-model-invocation: true` for workflow commands with side effects:

```yaml
---
name: session-end
description: Save session context to memory files
disable-model-invocation: true  # Don't auto-save, user must decide when
---
```

## Project-Aware STARTUP Section

All prompt skills in this library include a STARTUP section that loads project context before any analysis:

```markdown
## STARTUP: Load Project Context (ALWAYS FIRST)

Before any analysis, load known facts:
1. Read `.claude/memory/project-profile.md`
2. Read last 3 sessions from `.claude/memory/sessions.md`
3. Read `.claude/memory/prompt-patterns.md` if exists

Display:
CONTEXT LOADED FROM PROJECT PROFILE
Project: [name and version]
Stack: [tech stack]
Preferences: [key preferences]
Recent: [one-line summary from sessions.md]
```

This pattern ensures users **never need to repeat project context**.

## Skills Directory Structure

```
.claude/
├── commands/              # Old format (still works)
│   ├── prompt.md
│   └── prompt-hybrid.md
└── skills/                # New Skills format
    ├── prompt/
    │   └── SKILL.md       # /prompt with YAML frontmatter
    ├── prompt-hybrid/
    │   └── SKILL.md       # /prompt-hybrid
    ├── session-start/
    │   └── SKILL.md       # /session-start
    ├── session-end/
    │   └── SKILL.md       # /session-end
    └── reflect/
        └── SKILL.md       # /reflect
```

Skills in this library are in `.claude/skills/`. They add YAML frontmatter and STARTUP sections to the existing command logic.

## Supporting Files

Skills can include additional files in their directory:

```
.claude/skills/my-skill/
├── SKILL.md              # Main instructions (required)
├── examples.md           # Usage examples
├── reference.md          # Detailed API reference
└── scripts/
    └── helper.py         # Scripts Claude can run
```

Reference them from SKILL.md:

```markdown
For detailed API reference, see [reference.md](reference.md).
For examples, see [examples.md](examples.md).
```

This keeps SKILL.md focused while letting Claude access details on demand.

## Dynamic Context Injection

Skills support `!`command`` syntax to inject real-time data:

```yaml
---
name: pr-review
description: Review a pull request
context: fork
allowed-tools: Bash(gh *)
---

## PR Context
- Diff: !`gh pr diff`
- Comments: !`gh pr view --comments`
- Files: !`gh pr diff --name-only`

Review this PR for quality issues...
```

The shell commands run before Claude sees anything. Output replaces the placeholder.

## Subagent Execution

Add `context: fork` to run a skill in an isolated subagent:

```yaml
---
name: deep-research
description: Research a topic without polluting main context
context: fork
agent: Explore
---

Research $ARGUMENTS:
1. Find relevant files using Glob and Grep
2. Read and analyze
3. Return summary with file references
```

This is ideal for codebase exploration — keeps your main conversation clean.

## Arguments

Pass arguments to skills with `$ARGUMENTS`:

```yaml
---
name: fix-issue
description: Fix a GitHub issue
disable-model-invocation: true
---

Fix GitHub issue $ARGUMENTS following our coding standards.

1. Read the issue: gh issue view $ARGUMENTS
2. Understand the problem
3. Implement the fix
4. Write tests
5. Create a commit
```

Run: `/fix-issue 1234`

Positional access: `$ARGUMENTS[0]`, `$ARGUMENTS[1]`, or shorthand `$0`, `$1`.

## Where Skills Live

| Location | Path | Scope |
|----------|------|-------|
| Personal | `~/.claude/skills/name/SKILL.md` | All your projects |
| Project | `.claude/skills/name/SKILL.md` | This project only |
| Enterprise | Managed settings | All users in org |

## Migrating from Commands

Commands automatically work as skills — no migration required. To get Skills features:

1. Create `.claude/skills/your-command/` directory
2. Add `SKILL.md` with YAML frontmatter
3. Copy content from your command file
4. Add `description` for auto-invocation
5. Add STARTUP section for project awareness

Both files can coexist. When names conflict, skills take precedence.

## Example: Converting a Command to a Skill

**Before** (`.claude/commands/deploy.md`):
```markdown
# /deploy - Deploy to staging

Run the deployment process:
1. Run tests
2. Build
3. Push to staging
```

**After** (`.claude/skills/deploy/SKILL.md`):
```yaml
---
name: deploy
description: Deploy the application to staging or production
disable-model-invocation: true
argument-hint: "[staging|production]"
allowed-tools: Bash(git *), Bash(npm *)
---

# /deploy - Deploy to $ARGUMENTS

## STARTUP: Load Project Context

Read `.claude/memory/project-profile.md` for:
- Deployment targets and URLs
- Required pre-deploy checks
- Environment-specific commands

## Deploy Process

1. Run: `npm test` (verify all pass)
2. Build: `npm run build`
3. Push to $ARGUMENTS

...
```

## Related

- [Phase 0 Flow](/architecture/phase-0) - Memory recall and completeness check
- [Library System](/architecture/library-system) - How commands share core logic
- [Commands Overview](/commands/) - All available commands
- [Changelog](/reference/changelog) - v4.3 release notes
