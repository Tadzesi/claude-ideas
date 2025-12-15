# Session End - Memory Capture

Generate a comprehensive session summary and append it to `.claude/memory/sessions.md`.

This command captures ALL relevant context to ensure zero information loss between sessions.

## Instructions

1. **Analyze the current session** - Review everything discussed, implemented, and learned
2. **Generate comprehensive summary** using the enhanced format below
3. **Append to memory file** - Add to `.claude/memory/sessions.md` (create if doesn't exist)
4. **Confirm completion** - Show summary of what was saved

## Enhanced Summary Format

```markdown
---

## Session: [DATE] | [BRANCH/FEATURE]

### Decisions Made
- **[Decision]**: [Rationale and trade-offs considered]

### Code Changes
- **[File/Component]**: [What changed and why]
- Include: new files, modified files, deleted files

### Features Implemented
- **[Feature Name]**: [Status: Complete/In Progress/Blocked] - [Brief description]
- Track what was accomplished vs what remains

### Problems Solved
- **[Problem]**: [Root cause] → [Solution applied]

### Technical Stack & Architecture
- **[Technology/Pattern]**: [Why chosen, how used in project]
- Include: frameworks, libraries, design patterns, architecture decisions
- Only include items added/decided/learned in this session

### Key Insights
- **[Insight]**: [Why this matters for the project]
- Include: codebase understanding, performance discoveries, best practices learned

### User Preferences & Patterns
- **[Preference/Pattern]**: [Description]
- Include: coding style, preferred approaches, workflow preferences
- Only add new preferences discovered this session

### Active Work In Progress
- **Current task**: [What you're in the middle of]
- **Uncommitted changes**: [Files with pending changes]
- **Current file location**: [Where you left off - file path, line number if relevant]
- **Blockers**: [Anything preventing progress]

### Project Structure Notes
- **[Component/Directory]**: [Purpose and organization]
- Include: important file locations, architecture layout
- Only add items that are new or clarified this session

### Next Steps
- [ ] [Actionable TODO for next session - be specific]
- [ ] [Include file paths and methods if applicable]

### Context for Next Session
[2-3 sentences: What was I working on? What state is it in? What should I focus on next?]

---
```

## Rules

- **Be comprehensive but concise** - Include all relevant context, but avoid unnecessary verbosity
- **Focus on WHY, not just WHAT** - Capture reasoning behind decisions and changes
- **Prioritize resumability** - Information should help you quickly get back to work
- **Skip empty sections** - If a section has nothing relevant, omit it entirely
- **Always include these critical sections:**
  - Context for Next Session (mandatory)
  - Next Steps (if any work remains)
  - Active Work In Progress (if something is incomplete)
- **Update cumulative sections** - User Preferences, Project Structure Notes accumulate over time
- **Be specific with paths** - Include file paths, line numbers, component names where helpful

## After Saving

Respond with a comprehensive summary:

> **✅ Session saved to memory.**
>
> **Captured:**
> - Decisions: [count]
> - Code Changes: [count] files
> - Features: [count] ([X] complete, [Y] in progress)
> - Problems Solved: [count]
> - Technical Notes: [count]
> - Insights: [count]
> - Preferences: [count] new patterns
> - WIP: [status description]
> - Next Steps: [count] pending
>
> **Session State:** [Brief one-liner about overall progress]
>
> ---
> Run `/session-start` next time to load full context.
