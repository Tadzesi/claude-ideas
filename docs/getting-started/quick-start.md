# Quick Start

Get up and running with Claude Commands Library in minutes.

## Command Cheat Sheet

```bash
# Prompt Engineering
/prompt [prompt]                    # Simple prompt perfection (~2s)
/prompt-hybrid [prompt]             # Intelligent with agent support (2-50s)

# Technical Analysis
/prompt-technical [task]            # Implementation analysis (5-30s)

# Content Creation
/prompt-article [topic]             # Interactive article wizard (2-5min)
/prompt-article-readme              # README generator (10-30s)

# Session Management
/session-start                      # Load previous context (2-5s)
/session-end                        # Save current context (5-10s)
```

## Your First Command

### Example 1: Simple Prompt Perfection

```bash
/prompt Fix the login bug in my app
```

**What happens:**
1. Detects language (English)
2. Identifies type (Bug Fix)
3. Checks completeness
4. Asks clarifying questions if needed
5. Outputs perfected prompt

### Example 2: Intelligent Analysis

```bash
/prompt-hybrid Add user authentication following existing patterns
```

**What happens:**
1. Analyzes complexity (score: 13)
2. Spawns Explore agent automatically
3. Agent finds JWT pattern in codebase
4. Returns enhanced prompt with recommendations
5. Caches results for future use

### Example 3: Technical Implementation

```bash
/prompt-technical Add caching layer with Redis
```

**What happens:**
1. Scans project structure
2. Detects tech stack and patterns
3. Provides 2-3 implementation options
4. Recommends best approach
5. Generates code scaffolding

## Decision Tree

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

## Common Workflows

### Workflow 1: From Idea to Implementation

```bash
# 1. Perfect the prompt
/prompt-hybrid "Add feature X"

# 2. Get technical analysis
/prompt-technical

# 3. Implement (Claude executes the plan)

# 4. Save session
/session-end
```

### Workflow 2: Article Writing

```bash
# 1. Generate article
/prompt-article "Write about topic X"

# 2. Follow interactive wizard

# 3. Save session
/session-end
```

### Workflow 3: Documentation

```bash
# 1. Generate README
/prompt-article-readme

# 2. Review and customize

# 3. Save session
/session-end
```

## Understanding Complexity

### Simple Tasks (0-4 points)
- Single file changes
- Clear scope
- No pattern matching needed
- **Path:** Fast inline validation (~2s)

### Moderate Tasks (5-9 points)
- Multi-file changes OR pattern detection needed
- **Path:** Ask user if agent assistance wanted

### Complex Tasks (10+ points)
- Multi-file scope + pattern detection
- Architecture questions
- Cross-cutting concerns
- **Path:** Automatically spawn agent (~20s)

### Very High Complexity (15+ points)
- Critical operations (payment, security)
- **Path:** Multi-agent verification (~50s)

## Tips for Best Results

1. **Be specific** - Include context about your project
2. **Answer questions** - The wizards ask for a reason
3. **Chain commands** - Use `/prompt` first, then `/prompt-technical`
4. **Iterate** - Use `modify` to refine output
5. **Use session management** - `/session-end` before breaks
6. **Trust complexity detection** - Let hybrid commands decide
7. **Leverage caching** - Repeated prompts are 10-20x faster

## Advanced Features

### Agent Caching ⚡
- Results cached for 24 hours
- 10-20x faster for repeated prompts
- Auto-invalidates on file/branch changes

### Multi-Agent Verification 🔍
- Triggers for critical operations
- 2-3 agents cross-validate
- Shows consensus analysis

### Learning System 📚
- Tracks patterns after 3+ occurrences
- Suggests smart defaults
- Improves over time

## What's Next?

- [Explore all commands](/guide/commands/)
- [Learn about architecture](/guide/architecture/library-system)
- [Configure advanced features](/reference/configuration)
- [Read best practices](/reference/best-practices)
