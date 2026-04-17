# Execution Plan Template

**Version:** 1.0
**Last Updated:** 2026-04-16
**Purpose:** Make "what will be done and how" explicit BEFORE the approval
gate. User and Claude must share the same mental model of the work before
any file is touched.

Referenced by: `.claude/library/prompt-perfection-core.md` Step 0.55.

---

## When to Emit

Always, for any prompt classified as Task / Feature / Bug Fix / Refactor /
Config / Docs. Skip only for pure Question prompts (where the answer is the
deliverable and no files change).

---

## Template

```
EXECUTION PLAN

Goal (one sentence):
[What success looks like when this is done]

Files (exact paths — verified):
CREATE:
- path/to/new/file.ext — [purpose]
EDIT:
- path/to/existing/file.ext — [what section, what change]
READ (no change):
- path/to/reference.ext — [why needed]

Steps (numbered, in order):
1. [First concrete action — which tool, which file]
2. [Next action]
3. [...]

Tools to be used:
- Read / Edit / Write / Glob / Grep / Bash
- Agents: [Explore | Citation | Security | Performance | Pattern | none]

Model recommendation:
MODEL HINT: [one-line from model-router.md]

Risks and rollback:
- [Known risk]: [mitigation or rollback step]
- Reversibility: [easy | moderate | hard]

Verification after execution:
- [Command or check 1]
- [Command or check 2]

Estimated effort:
- Token cost tier: [low | medium | high]
- Wall-clock: [~Ns / ~Nm]
- Approximate tool calls: [N]

Assumptions I am making (correct me if wrong):
- [Assumption 1]
- [Assumption 2]
```

---

## Rules

1. **No placeholders in the final version.** Every `[bracketed]` slot must be
   filled with a concrete value before the approval gate opens.
2. **Paths must be verified.** Use Glob or Read to confirm files exist before
   listing them under EDIT or READ. If a path is a guess, mark it
   `(unverified — will Glob first)`.
3. **Steps map to tool calls.** A reader should be able to count tool calls
   from the steps list. Vague verbs ("improve", "enhance") are not steps.
4. **Assumptions are explicit.** Anything the user did not state must appear
   in the Assumptions block so they can correct before approval.
5. **Model hint is mandatory.** Always include the one-line MODEL HINT from
   `.claude/library/model-router.md`.
6. **Risk and rollback belong here, not after the fact.** If something is
   hard to undo (destructive, pushes to remote, modifies shared infra), say
   so in the Risks line and require explicit user approval in the gate.

---

## Example — Good

```
EXECUTION PLAN

Goal (one sentence):
Add MODEL HINT line to the /prompt skill so users see the recommended
Claude tier before each approval gate.

Files (exact paths — verified):
EDIT:
- .claude/skills/prompt/SKILL.md — add "Model Selection" subsection at end
  of Phase 0 block, referencing model-router.md
READ (no change):
- .claude/library/model-router.md — for the output-format snippet
- .claude/config/model-tiers.json — to confirm tier IDs

Steps (numbered, in order):
1. Read SKILL.md to locate the approval-gate section.
2. Edit SKILL.md: insert Model Selection block before "### Step 0.6".
3. Bump skill version to v4.1 in YAML frontmatter and version history.

Tools to be used:
- Read, Edit
- Agents: none

Model recommendation:
MODEL HINT: sonnet (multi-step single-file edit with precise wording).

Risks and rollback:
- Broken reference to model-router.md if file renamed: grep after edit.
- Reversibility: easy (single-file edit, git revert).

Verification after execution:
- .\tests\validate-library-references.ps1 -Verbose
- Grep SKILL.md for "MODEL HINT" to confirm insertion.

Estimated effort:
- Token cost tier: low
- Wall-clock: ~45s
- Approximate tool calls: 3 (Read, Edit, Grep)

Assumptions I am making (correct me if wrong):
- The "Model Selection" block should come before Step 0.6, not after.
- Version bump to v4.1 is appropriate (minor feature, not breaking).
```

---

## Example — Bad (do not do this)

```
EXECUTION PLAN

Goal: Improve the skill.

Files: Several skill files and the core library.

Steps:
1. Update code.
2. Test it.
3. Done.
```

Why wrong:
- Vague goal ("improve") with no success criterion.
- No verified paths.
- No tools, no model hint, no risks, no verification.
- Assumptions invisible — user cannot correct the plan before approval.
