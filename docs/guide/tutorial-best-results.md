# Tutorial: Getting Best Results

How to use the three commands effectively.

## Prerequisites

- Claude Commands Library v5.0 installed
- Basic familiarity with Claude Code
- A project to work with

## Part 1: Understanding Phase 0

Every command begins with **Phase 0** — a shared validation layer that runs before any output.

```
Step 1: Analysis
  Detect language (English, Slovak, etc.)
  Identify prompt type (Task, Bug Fix, Question, etc.)
  Extract core intent

Step 2: Memory Recall
  Load known facts from project-profile.md
  Pre-fill tech stack, conventions, recent work

Step 3: Completeness Check
  Goal — what do you want to achieve?
  Context — project, technology, environment
  Scope — which files, components, areas
  Requirements — specific needs
  Constraints — limitations (optional)
  Expected Result — how to verify success

Step 4: Clarifying Questions
  Ask only what cannot be answered from memory
  Present options where multiple approaches exist

Step 5: Structured Output
  Goal / Context / Scope / Requirements / Constraints / Expected Result

Step 6: Approval Gate
  Wait for explicit approval before proceeding
```

The approval gate is mandatory — Claude never auto-executes after Phase 0.

## Part 2: Using /prompt Effectively

### The difference it makes

::: danger Before — vague prompt
```
/prompt Fix my code
```
Problems: no context, no scope, no expected result.
:::

::: tip After — complete prompt
```
/prompt Fix the NullReferenceException in UserService.GetUser()
when the user does not exist. Should return null instead of throwing.
Using .NET 8, Entity Framework Core.
```
Why it works: clear goal, specific scope, stated expected behaviour, tech stack provided.
:::

### The 6 criteria

Every prompt should answer:

1. **Goal** — what do you want to achieve?
2. **Context** — project, technology, environment
3. **Scope** — which files, components, areas
4. **Requirements** — specific needs
5. **Constraints** — limitations, rules (optional)
6. **Expected Result** — how to verify success

### Examples by task type

**Bug fix:**
```
/prompt Fix the authentication timeout in the React app.
Users are logged out after 5 minutes, expected 30 minutes.
Files: src/auth/AuthContext.tsx, src/api/client.ts
Stack: React 18, Axios, JWT
```

**New feature:**
```
/prompt Add dark mode toggle to the Settings page.
Should persist in localStorage and respect system preference on first load.
Stack: React, Tailwind CSS, shadcn/ui
```

**Refactor:**
```
/prompt Refactor UserService to use repository pattern.
Currently: direct DbContext calls in service layer.
Target: IUserRepository interface + concrete implementation.
Stack: .NET 8, EF Core
```

### When Phase 0 asks questions

Answer fully — each question prevents misimplementation. If Claude asks which auth method, saying "JWT" saves a full refactor.

## Part 3: Using /prompt-research Effectively

### Give a focused goal

Too broad produces shallow results:
```
/prompt-research Understand the codebase
```

Focused produces deep results:
```
/prompt-research Understand the payment processing flow
and identify potential race conditions in order creation
```

### What to expect

1. Claude spawns 2-5 agents in parallel (Explore, Pattern, Security, Performance, Citation)
2. First iteration maps the landscape — files, entry points, key paths
3. Subsequent iterations (2-4 total) drill into gaps from the previous round
4. Final report: structured findings with `file:line` citations

### Good research prompts

```
/prompt-research Map the authentication system and
identify any JWT validation gaps

/prompt-research Understand how database migrations work,
what the schema history is, and flag any missing rollbacks

/prompt-research Find all API endpoints that handle payment data
and check for OWASP Top 10 issues
```

### Using the output

The report cites every claim with a file path and line number. Use these to:
- Jump directly to the relevant code
- Verify findings before acting on them
- Create precise follow-up prompts with `/prompt`

## Part 4: Using /prompt-article-readme Effectively

### Run it from the project root

```bash
cd /my-project
/prompt-article-readme
```

Claude scans the directory it's running in. Running from a subdirectory produces a scoped README, not a top-level one.

### Choosing a style level

When prompted, choose based on audience:

- **Minimal** — personal projects, internal tools
- **Standard** — open source, team projects
- **Comprehensive** — public libraries, portfolio pieces

### Updating an existing README

If a README already exists, Claude reads it first and proposes targeted updates — it does not overwrite everything. Review the diff before approving.

## Part 5: Iterating on Output

### Feedback responses

After any command output, you can respond:

| Response | What happens |
|----------|-------------|
| `y` / `yes` | Approve and proceed |
| `partial` | Output was mostly right, needs adjustment — Claude asks what to fix |
| `wrong` | Output missed the mark — Claude asks what specifically was wrong |
| `explain` | Claude explains its reasoning before you decide |
| `options` | Claude presents alternative approaches |

### Refining a result

```
User: partial

Claude: What needs adjustment?

User: The session duration logic is right, but you modified
AuthContext.tsx — the actual timeout is handled in api/client.ts

Claude: [corrects the target file]
```

## Part 6: Common Mistakes

**Too vague:**
```
# Wrong
/prompt Fix the bug

# Right
/prompt Fix the login button not responding on mobile Safari.
React 18, Tailwind CSS.
```

**Not providing tech stack:** Claude has to guess or ask. Include `Stack: ...` in any prompt that touches code.

**Accepting 80% output:** Use `partial` and refine. Getting to 100% takes less time than fixing broken code.

**Over-trusting output:** Always review generated code, test before deploying, verify facts. You remain responsible.

**Too broad a research goal:** `/prompt-research` with "understand everything" spreads agents thin. Narrow the scope.

## Part 7: Pro Tips

**Meta-prompting** — if unsure how to phrase something:
```
/prompt Help me write a prompt for implementing
OAuth2 authentication in a .NET 8 minimal API
```

**Use examples** — show the expected input/output shape:
```
/prompt Create a validation function.
Input: { name: "", age: -1 }
Output: { valid: false, errors: ["name required", "age must be positive"] }
```

**Chain commands** — use `/prompt` to structure a task, then hand the output to Claude for implementation. Use `/prompt-research` first when you don't know the codebase well.

**Specify output format:**
```
/prompt Explain the Observer pattern.
Output as: 1-sentence summary, when to use (3 bullets), TypeScript example, pitfalls.
```

---

## Related

- [AI Fluency Framework](/architecture/ai-fluency)
- [Phase 0 Flow](/architecture/phase-0)
- [Multi-Agent Research](/architecture/multi-agent)
- [Commands Reference](/commands/)
