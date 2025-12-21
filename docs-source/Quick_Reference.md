# Claude Commands - Quick Reference

**⚡ Quick lookup guide for all commands**

---

## Command Cheat Sheet

```bash
# Prompt Engineering
/prompt [prompt]                    # Simple prompt perfection (~2s)
/prompt-hybrid [prompt]             # Intelligent with agent support (2-50s)

# Technical Analysis
/prompt-technical [task]            # Implementation analysis with hybrid intelligence (5-30s)

# Content Creation
/prompt-article [topic]             # Interactive article wizard (2-5min)
/prompt-article-readme              # README generator (10-30s)

# Session Management
/session-start                      # Load context from previous sessions (2-5s)
/session-end                        # Save current session context (5-10s)
```

---

## When to Use Which Command

### "I have a vague idea..."
→ **`/prompt`** (simple) or **`/prompt-hybrid`** (complex)

### "How should I implement this?"
→ **`/prompt-technical`**

### "I need to write an article..."
→ **`/prompt-article`**

### "I need a README..."
→ **`/prompt-article-readme`**

### "Starting a new session..."
→ **`/session-start`**

### "Ending work for today..."
→ **`/session-end`**

---

## Decision Tree

```
What do you need?
│
├─ Fix/improve a prompt
│  │
│  ├─ Simple, quick → /prompt
│  └─ Complex, needs analysis → /prompt-hybrid
│
├─ Technical implementation help
│  └─ /prompt-technical
│
├─ Write content
│  │
│  ├─ Article/blog post → /prompt-article
│  └─ README file → /prompt-article-readme
│
└─ Manage sessions
   │
   ├─ Starting work → /session-start
   └─ Ending work → /session-end
```

---

## Complexity Quick Reference

### `/prompt-hybrid` Complexity Scores

| Score | Category | What Happens | Time |
|-------|----------|--------------|------|
| 0-4 | Simple | Inline validation only | ~2s |
| 5-9 | Moderate | Ask if you want agent | ~2s or ~20s |
| 10-14 | Complex | Auto-spawn 1 agent | ~20s (first) / ~2s (cached) |
| 15+ | Critical | Multi-agent verification (3 agents) | ~50s (first) / ~2s (cached) |

**Triggers:**
- Multi-file (+5), Architecture (+7), Patterns (+6)
- Feasibility (+4), Implementation (+3), Cross-cutting (+4)
- Refactoring (+5), Critical keywords like "payment" (+10)

---

## Phase 0 Quick Guide

**All commands use Phase 0 - here's what to expect:**

1. **Analysis** - Language, type, intent detection
2. **Validation** - Checks for: Goal, Context, Scope, Requirements, Constraints, Expected Result
3. **Clarification** - Asks questions about missing info
4. **Correction** - Fixes grammar, preserves tech terms
5. **Structure** - Outputs perfected prompt
6. **Approval** - You review and approve (`y`/`n`/`modify`)

**Approval Options:**
- `y` or `yes` → Execute
- `n` or `no` → Cancel
- `modify [changes]` → Adjust and re-review
- `explain` → Get more details

---

## Advanced Features Quick Ref ⚡🔍📚

### Agent Caching ⚡ (`/prompt-hybrid` only)

**What:** Saves agent results for 24h
**Benefit:** 10-20x faster for repeated/similar prompts
**Location:** `.claude/cache/agent-results/`
**Clear cache:** `rm -r .claude/cache/agent-results/`

### Multi-Agent Verification 🔍 (`/prompt-hybrid` only)

**What:** 3 agents verify critical operations in parallel
**Triggers:** Score ≥15, critical keywords (payment, security, auth)
**Time:** ~50s (first run), ~2s (cached)
**Manual:** Add `--verify` flag

### Learning System 📚 (`/prompt-hybrid` only)

**What:** Tracks patterns, suggests smart defaults
**Threshold:** 3+ occurrences → smart default
**Location:** `.claude/memory/prompt-patterns.md`
**Example:** "payment" → auto-suggest security checklist

---

## Configuration Files

```bash
# Complexity detection rules
.claude/config/complexity-rules.json

# Agent templates
.claude/config/agent-templates.json

# Caching settings ⚡
.claude/config/cache-config.json

# Multi-agent verification 🔍
.claude/config/verification-config.json

# Learning system 📚
.claude/config/learning-config.json
```

---

## Memory Files

```bash
# Session history
.claude/memory/sessions.md

# Pattern learning database 📚
.claude/memory/prompt-patterns.md
```

---

## Common Workflows

### Workflow 1: Idea → Implementation

```bash
/prompt-hybrid [your idea]           # Perfect the prompt
/prompt-technical                    # Get technical analysis
# [implement the code]
/session-end                         # Save your work
```

### Workflow 2: Documentation Sprint

```bash
/prompt-article-readme               # Generate README
/prompt-article                      # Write article about the feature
/session-end                         # Save documentation session
```

### Workflow 3: Daily Development

```bash
/session-start                       # Load yesterday's context
# [work on tasks]
/prompt-hybrid [new feature idea]    # When you need help
/session-end                         # Save today's work
```

---

## Troubleshooting Quick Fixes

| Problem | Quick Fix |
|---------|-----------|
| "Too many questions" | Provide more context initially |
| "Agent too slow" | Use `/prompt` for simple tasks |
| "Cache not working" | Check `.claude/config/cache-config.json`, ensure `enabled: true` |
| "Complexity wrong" | Edit `.claude/config/complexity-rules.json` |
| "Session not loading" | Check `.claude/memory/sessions.md` exists |
| "Command not found" | Verify `.claude/commands/*.md` files exist |

---

## Performance Tips

✅ **Do:**
- Use caching for repeated prompts (huge speedup)
- Apply smart defaults when suggested
- Filter sessions when loading (don't load all)
- Save sessions regularly

❌ **Don't:**
- Use `/prompt-hybrid` for trivial prompts (use `/prompt`)
- Skip Phase 0 approval without reviewing
- Load all sessions unnecessarily (use filters)
- Forget to `/session-end` before long breaks

---

## Keyboard Shortcuts (Approval Phase)

```
y / yes     → Approve and execute
n / no      → Cancel operation
modify [X]  → Adjust and re-review
explain     → Get more details
retry       → Re-run with different approach (hybrid commands)
agent       → Force agent analysis (technical)
manual      → Force manual scan (technical)
```

---

## Example Inputs

### Good Prompts (Specific)

```bash
✅ /prompt Fix NullReferenceException in UserService.cs line 42, ASP.NET Core

✅ /prompt-hybrid Add caching following existing patterns in src/cache/

✅ /prompt-technical Implement JWT authentication matching UserController pattern

✅ /prompt-article Write technical article about CI/CD for developers
```

### Vague Prompts (Will ask questions)

```bash
⚠️ /prompt Fix bug
→ Asks: What bug? Which file? What tech stack?

⚠️ /prompt-hybrid Add feature
→ Asks: What feature? Where? What requirements?

⚠️ /prompt-technical Improve performance
→ Asks: Which component? What metrics? What constraints?
```

---

## File Locations Quick Reference

```
claude-ideas/
├── .claude/
│   ├── commands/           # 7 command files
│   ├── library/            # Phase 0 core + adapters
│   ├── config/             # 5 configuration files
│   ├── memory/             # sessions.md, prompt-patterns.md
│   └── cache/              # agent-results/ (auto-managed)
├── doc/                    # Documentation
└── README.md               # Main documentation
```

---

## Help & Documentation

- **Full guide:** `doc/Command_Reference_Guide.md`
- **Installation:** `README-INSTALL.md`
- **Project overview:** `CLAUDE.md`
- **Repository:** `README.md`

---

**Last Updated:** December 19, 2024
**Quick Reference v2.0**
