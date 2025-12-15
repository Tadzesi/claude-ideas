# Session Start - Load Memory

Load comprehensive context from previous sessions to continue work with full project knowledge.

This command presents ALL relevant context to resume work without information loss.

## Instructions

1. **Read memory file** - Load `.claude/memory/sessions.md`
2. **Analyze all sessions** - Extract comprehensive context across ALL sessions
3. **Present organized summary** - Show active work, decisions, preferences, and project state
4. **Highlight actionable items** - Focus on what needs attention now
5. **Ready for work** - Ask what to focus on today

## Enhanced Output Format

> **🔄 Session Context Loaded**
>
> ---
>
> ## 📌 Active Work In Progress
> **Current Task:** [What was in progress]
> **Files:** [Where work was happening]
> **Status:** [Blockers or ready to continue]
>
> ---
>
> ## ✅ Pending Next Steps
> - [ ] [High priority item with file path]
> - [ ] [Another actionable item]
> - [ ] [...]
>
> ---
>
> ## 🎯 Recent Session Summary
> **Last Session:** [Date] - [Branch/Feature]
> [2-3 sentence summary of what was accomplished]
>
> **Key Decisions to Remember:**
> - [Important architectural/technical decision]
> - [Another key decision]
>
> **Features Status:**
> - ✅ [Complete feature]
> - 🔨 [In progress feature]
> - ⏸️ [Blocked feature]
>
> ---
>
> ## 🏗️ Project Context
> **Tech Stack:** [Key technologies from Technical Stack & Architecture sections]
> **Architecture:** [Key patterns and structure notes]
>
> **Important Locations:**
> - [Key directory/file]: [Purpose]
> - [Another important path]: [Purpose]
>
> ---
>
> ## 💡 User Preferences & Patterns
> [Accumulated preferences from all sessions]
> - [Coding style preference]
> - [Workflow preference]
> - [Tool/approach preference]
>
> ---
>
> ## 📚 Key Insights Library
> [Most important insights accumulated across sessions]
> - [Critical codebase understanding]
> - [Performance insight]
> - [Best practice learned]
>
> ---
>
> ## 📊 Session History
> **Total sessions:** [count]
> **Current branch:** [branch name]
> **Last active:** [date]
>
> ---
>
> **What would you like to work on today?**

## Rules

- **Prioritize actionable context** - Show what needs to be done first
- **Aggregate cumulative sections** - Combine User Preferences, Project Structure, Tech Stack across ALL sessions
- **Show most recent WIP** - Active Work In Progress from the last session takes priority
- **Highlight blockers** - If anything was blocked, show it prominently
- **Keep it scannable** - Use clear sections and formatting
- **Combine pending next steps** - Show all uncompleted TODOs from all sessions
- **Smart filtering** - Only show insights and decisions still relevant to current work
- **If no memory file exists** - Note it and proceed normally with a fresh start message
