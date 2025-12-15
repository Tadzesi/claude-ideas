# Session End - Memory Capture

Generate a session summary and append it to `.claude/memory/sessions.md`.

## Instructions

1. **Analyze the current session** - Review what was discussed and accomplished
2. **Generate summary** using the format below
3. **Append to memory file** - Add to `.claude/memory/sessions.md` (create if doesn't exist)
4. **Confirm completion** - Show brief confirmation with key points saved

## Summary Format

```markdown
---

## Session: [DATE] | [BRANCH/FEATURE]

### Decisions Made
- [Decision]: [Rationale]

### Code Changes
- [File/Component]: [What changed and why]

### Problems Solved
- [Problem]: [Solution applied]

### Key Insights
- [Important discovery or pattern worth remembering]

### Next Steps
- [ ] [Actionable TODO for next session]

### Context for Next Session
[1-2 sentences: What was I working on? What state is it in?]

---
```

## Rules

- Be concise but include enough context to understand later
- Focus on decisions and reasoning, not just what happened
- Prioritize information useful for resuming work
- Skip sections if nothing relevant (don't leave empty sections)
- Always include "Context for Next Session" - this is critical for continuity

## After Saving

Respond with:
> **Session saved to memory.**
> - Decisions: [count]
> - Changes: [count]
> - Next steps: [count]
>
> Run `/session-start` next time to load context.
