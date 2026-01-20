# AI Fluency Framework

**New in v4.1** - Claude Commands Library is now aligned with Anthropic's official AI Fluency Framework.

## What is AI Fluency?

AI Fluency is the ability to work with AI systems in ways that are **effective, efficient, ethical, and safe**. It includes practical skills, knowledge, insights, and values that help you adapt to evolving AI technologies.

## The 4Ds

The framework defines four core competencies:

### 1. Delegation

Deciding what work should be done by humans, what work should be done by AI, and how to distribute tasks between them.

**Implementation in Claude Commands:**

- **Step 0.13: Delegation Assessment** in `/prompt-hybrid`
- Three components:
  - **Problem Awareness** - Understanding goals before involving AI
  - **Platform Awareness** - Matching tasks to AI capabilities
  - **Task Delegation** - Distributing work thoughtfully

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

Discernment Hints in perfected prompt output:

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

Diligence Summary in `/session-end`:

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

## Integration Points

### `/prompt` Command

- Interaction Mode Detection
- Expanded 9-criteria completeness check
- Discernment Hints in output

### `/prompt-hybrid` Command

- Full Delegation Assessment (Step 0.13)
- Platform Awareness for agent spawning
- Task Delegation recommendations

### `/session-end` Command

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
