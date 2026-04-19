# Interaction Protocol (v4.8)

Starting with **v4.8.0**, every session in this repository is governed by a global **Interaction Protocol** defined in `CLAUDE.md`. The protocol promotes the discipline previously confined to `/prompt*` slash commands into a universal rule that applies to ALL interactions.

## Why

Before v4.8, Phase 0 discipline (Curiosity Gate, Options-First, Execution Plan, Approval Gate) lived only inside `/prompt*` skills. Normal conversation bypassed these rules, which led to:

- Claude silently executing file edits without summarising understanding first
- Token waste when Claude guessed wrong and the user had to re-steer mid-execution
- `git commit` / install scripts running before the user was ready
- Language inconsistency (user writes Slovak, Claude drifts into English responses)

v4.8 fixes this at the root: `CLAUDE.md` is loaded automatically into every session, so the same discipline applies everywhere — inside `/prompt`, inside free-form chat, inside agent dispatches.

## The Four Rules

### 1. Language

- User píše po slovensky → Claude odpovedá po slovensky
- Internal reasoning, tool calls, commit messages, code, documentation → English
- Technical terms (file paths, command names, API identifiers) preserved verbatim regardless of surrounding language

**Why bilingual?** The user thinks faster in Slovak. Claude parses English more reliably (better training data coverage, fewer ambiguities in technical jargon). Keeping tool invocations and commit history in English also makes the repository accessible to non-Slovak collaborators.

### 2. Plan-First Execution

Before any file change, build run, test run, or commit, Claude MUST:

1. **Summarise understanding** in 1-2 sentences (Slovak, user-facing)
2. **Present 2-3 options** for non-trivial work — edit >1 file, new feature, refactor, config change
3. **Emit an execution plan** listing:
   - Files to CREATE / EDIT / READ
   - Numbered steps
   - Risks and rollback
   - Verification commands
4. **Wait for explicit approval** — `y` / `yes` / `schvaľujem`. Never assume consent.

**Exceptions (plan not required):**

- Pure read-only questions (_"What does this file do?"_, _"What version is this?"_)
- Trivial one-shot actions explicitly requested (_"Fix this typo on line 42"_)

### 3. Proactive Option-Finding

Claude is NOT a passive executor. When Claude sees a better path than what the user proposed, it must:

- State the observation BEFORE executing
- Name the concrete tradeoff (token cost, maintainability, correctness)
- Make a recommendation with reasoning
- Leave the final decision to the user

**Example:**

> User: _"Add a new config file for logging settings."_
>
> Claude: _"Projekt už má `.claude/config/` pattern pre všetky configy — pridať `logging-config.json` tam by bolo konzistentné. Alternatíva: použiť existujúce `predictive-intelligence.json`, ktoré má podobný scope. Odporúčam option 1 (samostatný súbor) — logging bude rásť, nechcem to miešať s prediction config. Ideme?"_

### 4. Never Auto-Execute

Claude NEVER runs the following without explicit user approval:

- `git commit`, `git push`, `git reset --hard`, force-push
- `npm install`, `npm publish`
- `install-claude-commands.ps1`
- Any command that mutates shared state (deploys, database migrations, API calls to production)

Both sides — AI and user — must understand:

- **WHAT** is about to happen
- **WHY** this specific action
- **HOW** to verify the result

## Worked Example

**User (Slovak):** _"Uprav readme, dokumentáciu vygeneruj, doplň a aktualizuj. Publishni novú verziu projektu a dokumentácie na git."_

**Claude (Slovak summary + English internals):**

```
POROZUMENIE
Chceš: aktualizovať README, doplniť docs (VitePress), bump verzie, commit + push.

OTVORENÉ OTÁZKY
1. Verzia: v4.7.1 (patch) alebo v4.8.0 (minor, nové správanie)?
2. Scope docs: VitePress alebo aj interné?
3. Git: jeden commit alebo rozdelené?

APPROACHES
Option 1: Patch release v4.7.1 (doc-only) ...
Option 2: Minor release v4.8.0 "Interaction Protocol" ...
Option 3: Dva commity ...

RECOMMENDED: Option 2 — dopad si zaslúži minor bump.

EXECUTION PLAN
Files: README.md, CHANGELOG.md, docs/index.md, docs/guide/interaction-protocol.md, ...
Steps: 1. Edit README ... 7. git push

Approve? y / y1 / y3 / modify
```

The user replies `option 2, yes`. **Only then** Claude starts editing.

## Interaction With Existing Skills

The protocol **complements** existing Phase 0 skills — it does not replace them:

- Inside `/prompt`, `/prompt-hybrid`, etc. — full Phase 0 (Steps 0.1–0.6) runs as before
- Outside slash commands — the protocol enforces a lightweight version: understanding + plan + approval

The result: consistent behaviour everywhere, with no new commands to learn.

## For Contributors

When submitting skills or commands:

- Do not add logic that auto-executes git/install/build operations
- Inherit from `.claude/library/prompt-perfection-core.md` v2.1 if you need full Phase 0
- Keep user-facing output in the session's active language (default Slovak for this user)
- Keep internal tool invocations and commit messages in English

## See Also

- [`CLAUDE.md` in the repo root](https://github.com/Tadzesi/claude-ideas/blob/main/CLAUDE.md)
- [Phase 0 Flow](/architecture/phase-0)
- [Changelog — v4.8.0](/reference/changelog#480-april-2026)
