#!/bin/bash
# Fires before Claude Code compacts the conversation.
# Stdout is injected into Claude's context as an instruction before compaction.

PROJECT_DIR="${CLAUDE_PROJECT_DIRECTORY:-$PWD}"
TODAY=$(date +%Y-%m-%d)

cat <<EOF
Before compacting this conversation, create a session diary entry:

1. Run: mkdir -p "${PROJECT_DIR}/.claude/memory/diary"
2. Filename: ${TODAY}-session-N.md — if file exists increment N (session-2, session-3, ...)
3. Save to: ${PROJECT_DIR}/.claude/memory/diary/
4. Include these sections (be factual, capture the WHY behind decisions):
   - Task Summary (2-3 sentences: what was the user trying to accomplish?)
   - Work Done (bullet list of what was accomplished)
   - Design Decisions (key technical choices and WHY they were made)
   - Challenges Encountered (errors, failed approaches, user corrections)
   - Solutions Applied (how problems were resolved)
   - User Preferences Observed (code style, commit style, Slovak/English protocol, workflow preferences)
   - Context (project type, languages, frameworks used this session)

Project: ${PROJECT_DIR}
EOF
