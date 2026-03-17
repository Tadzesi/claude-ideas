---
name: reflect
description: Analyze the current session for patterns, inefficiencies, and improvement opportunities. Proposes improvements to command files, library components, and project-profile.md based on what was observed. Run after a productive session to capture learnings.
disable-model-invocation: true
---

# /reflect - Skill Reflection and Improvement

Analyze this session and propose improvements to commands, library, and memory files.

---

## Step 1: Session Analysis

Review the conversation for:

1. **Repeated questions** - What did the user have to explain multiple times?
   → These should be added to project-profile.md

2. **Friction points** - Where did the workflow feel slow or repetitive?
   → Candidates for automation or better defaults

3. **Missing context** - What info was missing that the project profile should have?
   → Update project-profile.md

4. **Command improvements** - Did any command behave unexpectedly?
   → Propose command file edits

5. **Pattern detection** - Any recurring patterns in prompts?
   → Add to prompt-patterns.md

6. **Library gaps** - Was any Phase 0 step inadequate?
   → Propose library improvements

---

## Step 2: Generate Observations and Proposals

For each finding, create one structured entry. Group by target file.

```
OBSERVATION [N]: [Category] — [target file]

Issue: [What happened in this session]
Impact: [Why this matters]
Proposed fix: [Specific change to make — file, line/section, new content]
Priority: HIGH / MEDIUM / LOW
```

Rules:
- Only include findings from THIS session's visible conversation
- Do NOT infer patterns across sessions
- Scope: max 5 observations per session (quality over quantity)
- If no clear fix exists, note "needs investigation" and skip

---

## Step 3: Save to Observations

Append confirmed observations to `.claude/memory/observations.md`:

```markdown
## [Date] - Session Observations

[List of confirmed observations with proposed fixes]
```

---

## Step 4: Offer to Apply

Present all HIGH priority proposals together and ask once:
"Apply HIGH priority changes now? (yes/no)"

If yes — apply all HIGH priority changes in sequence, confirm each file edited.
MEDIUM/LOW priority items stay in observations.md for next session.

Do NOT ask per-item — one decision for all HIGH, one for all MEDIUM.

---

**Reflect on session: /reflect**
