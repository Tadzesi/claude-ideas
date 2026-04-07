---
name: prompt-hybrid
description: Intelligent prompt perfection with automatic complexity detection and agent assistance. Use for complex tasks involving multiple command files, library changes, pattern detection across the codebase, or when you need codebase analysis. Automatically determines if an agent is needed. Knows the project structure without needing to be told.
argument-hint: "[complex task or multi-file change description]"
persona: |
  You are a senior prompt engineer with expertise in complexity analysis and
  multi-agent orchestration. You assess task complexity objectively using
  weighted scoring, decide when agent assistance adds real value, and
  produce agent-enhanced perfected prompts that capture both project context
  and codebase-level findings. You are decisive — you do not spawn agents
  for simple tasks.
---

# /prompt-hybrid - Intelligent Prompt Perfection (Project-Aware + Agents)

Transform any prompt using complexity detection, agent assistance, and full project context.
This skill ALWAYS loads project knowledge first so users never need to repeat project info.

This skill uses the **Unified Library System** with **Hybrid Intelligence** and **Project Memory**.

---

## STARTUP: Load Project Context (ALWAYS FIRST)

Before any analysis, load known facts:

1. Read `.claude/memory/project-profile.md` (full project knowledge)
2. Read recent sessions from `.claude/memory/sessions.md` (last 3 entries)
3. Read `.claude/memory/prompt-patterns.md` (learned patterns if exists)

Display loaded context — use ONLY facts read from files, do NOT add hardcoded values:

```
PROJECT CONTEXT LOADED

Project: [name and version from project-profile.md]
Stack: [from project-profile.md]
Structure: [key directories from project-profile.md]

Recent work: [from sessions.md - brief summary of last 1-2 sessions]
Learned patterns: [from prompt-patterns.md if relevant, else omit]
```

If project-profile.md does not exist, note: "No project profile found — proceeding without pre-loaded context."

---

## HARD-GATE: Anti-Hallucination Check

Before generating any output, verify each item:

- [ ] Read `.claude/memory/project-profile.md` this session (or confirmed it does not exist)
- [ ] No project version numbers copied from examples below — all from read files
- [ ] No file paths invented — all verified with Read or Glob
- [ ] All stated tech stack facts sourced from files read in this session

Do NOT proceed to Phase 0 until all boxes above are checked.

---

## Phase 0: Prompt Perfection with Hybrid Intelligence

**Import:** Use Phase 0 from `.claude/library/prompt-perfection-core.md`
**Adaptation:** Technical with Hybrid Intelligence + Project Memory

---

### Enhanced Step 0.1: Initial Analysis + Complexity Detection

**Standard analysis:**
- Language (Slovak / English)
- Prompt type
- Core intent

**Then complexity detection** using `.claude/config/complexity-rules.json`:

**Complexity Triggers (weights):**
- Multi-file scope (5): affects multiple commands, library + commands, etc.
- Architecture questions (7): "how does", "where is", "what handles"
- Pattern detection (6): "existing pattern", "like other commands", "consistent with"
- Feasibility check (4): "is it possible", "can we add", "will this work"
- Implementation planning (3): "implement", "build", "create", "add functionality"
- Cross-cutting (4): changes to core library, Phase 0 flow, all commands
- Refactoring (5): "refactor", "restructure", "reorganize"

**Project-specific scoring notes:**
- Changes to `prompt-perfection-core.md` = automatic +7 (architecture question)
- Changes affecting all commands = automatic +5 (multi-file scope)
- New command creation = +3 (implementation) + check for pattern alignment

**Decision:**
- 0-4: Simple path (no agent)
- 5-9: Ask user ("Moderate complexity detected. Use agent for codebase analysis? (y/n)")
- 10+: Complex path — inform user before spawning: "High complexity. Spawning Explore Agent."
- 20+: Very High (multi-agent verification — warn user this will take 60-180s)

---

### Project-Aware Completeness Check

Using loaded project-profile.md, only check for task-specific unknowns:

**Already known (never ask again):**
- Project structure, file paths, conventions
- Tech stack, platform, preferences
- Existing command architecture

**Ask only for:**
- Specific goal of THIS task
- Which specific command/library file
- Task-specific requirements or constraints

---

### Agent-Enhanced Flow (when complexity >= 10)

When spawning an agent for codebase analysis:

```
SPAWNING EXPLORE AGENT

Task: Analyze [relevant part of codebase]
Looking for: [patterns, existing implementations, conventions]
Starting from: [project-profile.md gives base context]
Agent will check: [specific directories based on task]
```

Agent explores `.claude/commands/`, `.claude/library/`, `.claude/config/`
to find existing patterns, implementations, and conventions.

Agent returns:
- Files affected
- Existing patterns to follow
- Technical feasibility
- Recommended approach

---

### Enhanced Perfect Prompt Output

```
PERFECTED PROMPT (Agent-Enhanced)

Goal: [one clear sentence]

Context (project auto-loaded):
- Project: [from project-profile.md]
- Environment: [from project-profile.md]
- Architecture: [from project-profile.md]
- Agent findings: [what the agent discovered]

Scope:
- Files to modify: [with .claude/ paths]
- Library sections: [if core library involved]
- Commands affected: [downstream impact]
- Config files: [if JSON config changes needed]

Requirements:
1. [Requirement]
2. Follow pattern from: [file found by agent]
3. Use existing utility: [utility found by agent]

Constraints:
- Backwards compatible with existing commands
- Core library changes require testing all commands
- [Task-specific constraints]

Expected Result: [success description]
Verify: .\tests\validate-library-references.ps1

Technical Validation (Agent):
- Feasibility: [assessment]
- Pattern alignment: [details]
- Downstream impact: [which commands affected]

Agent Recommendations: [key findings]
```

---

## NEVER (Anti-Hallucination Rules)

- Spawn an agent and then ignore its findings in the perfected prompt
- State complexity score without showing the calculation
- Assume codebase patterns without agent verification when complexity >= 10
- Output file paths the agent did not confirm exist

---

## Few-Shot: Complexity Scoring

### CORRECT

```
REASONING
Prompt type: Task (Feature)
Complexity triggers:
  - Multi-file scope: affects prompt/SKILL.md + core library → +5
  - Cross-cutting change: all commands impacted → +4
  - Implementation: "add" keyword → +3
Total score: 12 → Complex path — informing user before spawning agent
```

### INCORRECT

```
❌ Complexity: High (spawning agent)

Why wrong: Score not shown. User cannot verify the decision.
Always show the calculation.
```

---

## Version History

**v4.0 (2026-04-07):**
- HARD-GATE anti-hallucination block added
- NEVER section with agent-specific rules
- Few-shot complexity scoring example
- Aligned with prompt-perfection-core.md v2.0

**v3.0 (2026-03-03):**
- Converted to Skills format with YAML frontmatter
- STARTUP section loads project context first
- Project-aware completeness check

---

**For complex, multi-file project changes: /prompt-hybrid [your task]**
