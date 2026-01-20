# AI Fluency Framework

**Updated in v4.2** - Claude Commands Library is now **fully aligned** with Anthropic's official AI Fluency Framework, implementing all 4Ds across every command.

::: tip What's New in v4.2
- **Step 0.11:** Quick Delegation Check in all commands
- **Step 0.7:** Post-Execution Evaluation with feedback loop
- **Diligence Reminder:** Added to Approval Gate
- **Feedback Loop:** Describe → Evaluate → Refine pattern
- **Common Mistakes:** AI Fluency pitfalls documentation
- **AI Limitations:** Platform awareness for users
:::

## What is AI Fluency?

AI Fluency is the ability to work with AI systems in ways that are **effective, efficient, ethical, and safe**. It includes practical skills, knowledge, insights, and values that help you adapt to evolving AI technologies.

## The 4Ds

The framework defines four core competencies:

### 1. Delegation

Deciding what work should be done by humans, what work should be done by AI, and how to distribute tasks between them.

**Implementation in Claude Commands:**

- **Step 0.11: Quick Delegation Check** - Universal check in ALL commands (v4.2)
- **Step 0.13: Full Delegation Assessment** - Detailed assessment in `/prompt-hybrid`
- Three components:
  - **Problem Awareness** - Understanding goals before involving AI
  - **Platform Awareness** - Matching tasks to AI capabilities
  - **Task Delegation** - Distributing work thoughtfully

**Step 0.11: Quick Delegation Check (NEW in v4.2)**

Every command now includes a quick check before proceeding:

```
Quick Delegation Check:

1. Task Appropriateness:
   - Is this suitable for AI assistance?
   - Does it require human-only judgment?

2. AI Capability Match:
   - Does this match AI strengths?
   - Or exceed AI limitations?

3. Responsibility Awareness:
   - Does user understand they remain responsible?
   - Any safety/security implications?
```

**Decision Logic:**

```
IF task requires ONLY human judgment (ethics, policy):
    → Flag: "This requires human decision. I can help analyze, but you must decide."

IF task involves irreversible actions (delete, deploy, publish):
    → Flag: "⚠️ Irreversible action detected. Requires explicit confirmation."

IF task matches AI strengths AND user accepts responsibility:
    → Proceed to next step
```

**Full Delegation Assessment (prompt-hybrid):**

```
Delegation Assessment:

Problem Awareness:
- Goal: Clear
- Scope: Well-defined
- Success Criteria: Defined

Platform Capabilities:
- Code Analysis: Excellent (use Agent)
- Pattern Detection: Excellent (use Agent)
- Business Decisions: Limited (human must decide)

Recommended Delegation:
- AI Autonomous: Code exploration, pattern detection
- AI with Review: Implementation suggestions
- Human Only: Architecture decisions, security approvals
```

### 2. Description

Effectively communicating with AI systems through three types of description:

| Type | Purpose | Implementation |
|------|---------|----------------|
| **Product Description** | Define outputs, format, audience | Goal, Context, Scope, Requirements, Constraints, Expected Result |
| **Process Description** | Define how AI approaches request | Approach methodology, step-by-step instructions |
| **Performance Description** | Define AI behavior during collaboration | Interaction style, communication tone |

**Implementation:**

Phase 0 completeness check expanded from 6 to 9 criteria:

```
Completeness Check (9 criteria):

Product Description:
✓ Goal, Context, Scope, Requirements, Constraints, Expected Result

Process Description:
✓ Approach: Step-by-step methodology

Performance Description:
✓ Interaction Style: Detailed explanations
✓ Communication Tone: Technical, professional
```

### 3. Discernment

Thoughtfully evaluating AI outputs, processes, and behaviors:

| Type | Focus | Questions |
|------|-------|-----------|
| **Product Discernment** | Quality of output | Is it accurate? Appropriate? Relevant? |
| **Process Discernment** | Reasoning evaluation | Any logical errors? Attention lapses? |
| **Performance Discernment** | Communication style | Was it helpful? Clear? |

**Implementation:**

**Step 0.7: Post-Execution Evaluation (NEW in v4.2)**

After task completion, the system prompts for feedback:

```
📊 Quick Evaluation (Discernment Check)

How was this output?

- `good` — Accurate, appropriate, useful ✅
- `partial` — Mostly good, needs minor adjustments ⚠️
- `wrong` — Significant issues, needs rework ❌
- `explain` — Show me your reasoning 🔍

Your feedback helps improve future interactions.
```

**Feedback Handling:**

| Response | Action |
|----------|--------|
| `good` | Record success, offer next steps |
| `partial` | Ask: "What needs adjustment?" → Apply changes |
| `wrong` | Ask: "What specifically was wrong?" → Record for learning |
| `explain` | Show reasoning/process, re-prompt |

**The Feedback Loop (NEW in v4.2)**

Effective AI use is iterative:

```
    DESCRIBE          EVALUATE
   (what you want) → (what you got)
         ↑               ↓
         └─── REFINE ←──┘
           (improve prompt)
```

**Useful follow-up phrases:**
- "Make it more [concise/detailed/formal/casual]"
- "Focus more on [specific aspect]"
- "Remove the section about [topic]"
- "This is wrong because [reason], please fix"

**Discernment Hints in Output:**

```
Discernment Hints:
- Product Evaluation: Verify implementation accuracy
- Process Evaluation: Check reasoning for logical errors
- Performance Evaluation: Was the communication style effective?
```

### 4. Diligence

Using AI responsibly and ethically:

| Component | Description | Implementation |
|-----------|-------------|----------------|
| **Creation Diligence** | Being thoughtful about AI usage | Interaction mode detection |
| **Transparency Diligence** | Being honest about AI's role | Track AI-generated content |
| **Deployment Diligence** | Taking responsibility for outputs | Verification checklists |

**Implementation:**

**Diligence Reminder in Approval Gate (NEW in v4.2)**

Every approval gate now includes a responsibility reminder:

```
⏸️ Perfected Prompt Ready - Awaiting Your Approval

...

⚖️ Diligence Reminder (AI Fluency):
You remain responsible for any output generated from this prompt.
- Verify key facts before deployment
- Review AI-generated code before committing
- Test thoroughly before production use

Reply with: y/yes, n/no, modify, explain, options
```

**Diligence Summary in `/session-end`:**

```
Diligence Summary:

AI-Assisted Content Requiring Verification:
- src/auth/login.ts - Generated authentication logic
- src/middleware/jwt.ts - Generated JWT validation

Transparency Notes:
- Authentication flow designed by AI
- Security patterns from existing codebase

Deployment Checklist:
- [ ] Review generated authentication code
- [ ] Test JWT validation edge cases
- [ ] Security audit before deployment
```

## Human-AI Interaction Modes

The framework defines three collaboration modes:

### Automation Mode

AI performs specific tasks based on specific human instructions.

- **Human defines:** WHAT needs to be done
- **AI executes:** The defined task
- **Best for:** Simple tasks, clear instructions
- **Indicators:** "Fix X", "Add Y to Z", "Change A to B"

### Augmentation Mode

Humans and AI collaborate as thinking partners.

- **Both contribute:** Iterative back-and-forth
- **Best for:** Complex analysis, design decisions
- **Indicators:** "Help me understand", "What's the best approach"

### Agency Mode

Human configures AI to work independently.

- **AI establishes:** Knowledge and behavior patterns
- **Best for:** Research, exploration, multi-agent work
- **Indicators:** "Research X", "Explore the codebase"

**Detection Logic:**

```
IF prompt contains direct commands AND clear scope:
    → Automation Mode
ELSE IF prompt requests collaboration OR decision-making:
    → Augmentation Mode
ELSE IF prompt requests independent research OR exploration:
    → Agency Mode
DEFAULT:
    → Augmentation Mode (most flexible)
```

## Configuration

AI Fluency settings in `.claude/config/ai-fluency.json`:

```json
{
  "framework": {
    "name": "AI Fluency",
    "core_competencies": ["Delegation", "Description", "Discernment", "Diligence"]
  },
  "delegation": {
    "enabled": true,
    "components": {
      "problem_awareness": { ... },
      "platform_awareness": { ... },
      "task_delegation": { ... }
    }
  },
  "description": {
    "enabled": true,
    "components": {
      "product_description": { "criteria": ["goal", "context", "scope", ...] },
      "process_description": { "criteria": ["approach", "methodology"] },
      "performance_description": { "criteria": ["interaction_style", "tone"] }
    }
  },
  "discernment": {
    "enabled": true,
    "include_hints_in_output": true
  },
  "diligence": {
    "enabled": true,
    "track_in_session_end": true
  },
  "interaction_modes": {
    "automation": { "indicators": ["fix", "add", "change"] },
    "augmentation": { "indicators": ["help", "understand", "approach"] },
    "agency": { "indicators": ["research", "explore", "find all"] }
  }
}
```

## Common Mistakes to Avoid

Based on AI Fluency research, these are the most common pitfalls:

| Mistake | Problem | Solution |
|---------|---------|----------|
| **Being too vague** | "Help me with this" | Be specific about what you need |
| **Not providing context** | AI can't read your mind | Include technologies, frameworks, environment |
| **Accepting first output** | Missing improvements | Iterate! Use feedback to refine |
| **Not verifying facts** | AI can hallucinate | Always verify critical information |
| **Over-trusting AI** | Errors slip through | You're responsible for the output |
| **Under-using AI** | Wasting time | Let AI handle repetitive tasks |
| **Sharing sensitive data** | Privacy risk | Be mindful of what you include |
| **Not disclosing AI use** | Policy violation | Follow organization's policies |

## AI Limitations Awareness

Know what AI can and cannot do well:

**AI Strengths (Good For):**
- ✅ Versatile language tasks (writing, editing, summarizing)
- ✅ Code analysis, generation, and debugging
- ✅ Pattern detection and consistency checking
- ✅ Learning from examples you provide
- ✅ Explaining complex concepts

**AI Limitations (Be Careful):**
- ⚠️ **Knowledge cutoff** - May not know recent events
- ⚠️ **Hallucinations** - Can confidently state incorrect info
- ⚠️ **Context window limits** - Can only consider so much at once
- ⚠️ **Complex reasoning** - Multi-step logic can have errors
- ⚠️ **Personal decisions** - Cannot make ethical judgments for you

::: tip Secret Weapon
If your prompt still feels incomplete, ask:

*"Can you help me craft a more effective prompt for [goal]?"*

AI can help improve your prompts! This meta-approach often yields better results.
:::

## Integration Points

### `/prompt` Command (v2.1)

- Step 0.11: Quick Delegation Check
- Interaction Mode Detection
- Expanded 9-criteria completeness check
- Step 0.7: Post-Execution Evaluation
- Common Mistakes section
- AI Limitations awareness
- Secret Weapon tip

### `/prompt-hybrid` Command

- Step 0.11: Quick Delegation Check
- Full Delegation Assessment (Step 0.13)
- Platform Awareness for agent spawning
- Task Delegation recommendations
- Diligence Reminder in Approval Gate

### `/prompt-research` Command (v1.1)

- Step 0.11: Delegation Assessment
- Agency Mode focus for research tasks
- Recommended delegation for AI vs human tasks

### `/session-end` Command (v2.1)

- Diligence Summary section
- AI-generated content tracking
- Deployment verification checklist

## Benefits

1. **Explicit Collaboration** - Clear understanding of human vs AI roles
2. **Better Outputs** - Process and Performance descriptions improve quality
3. **Quality Assurance** - Discernment hints guide evaluation
4. **Accountability** - Diligence tracking ensures responsible use
5. **Flexibility** - Three interaction modes for different tasks

## Reference

Based on Anthropic's AI Fluency Framework:
- [AI Fluency Key Terminology Cheat Sheet](https://www.anthropic.com)
- The 4Ds: Delegation, Description, Discernment, Diligence
- Human-AI Interaction Modes: Automation, Augmentation, Agency

## Related

- [Phase 0](/architecture/phase-0) - Prompt perfection flow
- [Hybrid Intelligence](/architecture/hybrid-intelligence) - Complexity detection
- [Learning System](/architecture/learning) - Pattern tracking
