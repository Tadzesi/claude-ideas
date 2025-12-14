# Session Start - Load Memory

Load context from previous sessions to continue work seamlessly.

## Instructions

1. **Read memory file** - Load `.claude/memory/sessions.md`
2. **Summarize recent context** - Focus on last 2-3 sessions
3. **Highlight pending items** - Show uncompleted next steps
4. **Ready for work** - Ask what to focus on today

## Output Format

> **Previous Session Context Loaded**
>
> **Last Session:** [Date] - [Branch/Feature]
> [Brief context summary]
>
> **Pending Next Steps:**
> - [ ] [Item 1]
> - [ ] [Item 2]
>
> **Recent Decisions to Remember:**
> - [Key decision still relevant]
>
> ---
> What would you like to work on?

## Rules

- Focus on actionable context, not history
- Highlight unfinished work first
- Keep summary scannable (not a wall of text)
- If no memory file exists, note it and proceed normally
