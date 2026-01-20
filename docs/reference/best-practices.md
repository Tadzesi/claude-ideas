# Best Practices

Guidelines for effective use of Claude Commands Library, based on official Claude Code best practices and real-world usage.

## General Tips

### 1. Be Specific with Prompts

Specificity dramatically improves success rates:

**Poor:** "add tests for foo.py"

**Good:** "write test case for foo.py covering logged-out user edge case; avoid mocks; use pytest fixtures from conftest.py"

### 2. Answer Clarifying Questions

When commands ask clarifying questions, provide detailed answers. The more context you give, the better the results.

### 3. Chain Commands for Complex Workflows

| Workflow | Commands |
|----------|----------|
| Research then implement | `/prompt-research` → `/prompt-technical` |
| Plan then execute | `/prompt-hybrid` → manual implementation |
| Document after building | Implementation → `/prompt-article-readme` |

### 4. Use Session Management

Start each session with `/session-start` to load previous context. End with `/session-end` to preserve your work.

### 5. Trust Complexity Detection

The hybrid system automatically detects when to spawn agents. Let it work - simple prompts stay fast, complex ones get proper analysis.

### 6. Leverage Caching

Repeated similar queries benefit from caching. The system automatically caches agent results for 10-20x speedup on subsequent calls.

## Workflow Patterns

### Explore → Plan → Code → Commit

Recommended for complex problems:

1. **Explore** - Have Claude read relevant files without writing code
2. **Plan** - Request a plan before implementation
3. **Code** - Request implementation only after plan approval
4. **Commit** - Have Claude commit changes

### Test-Driven Development

Particularly powerful for verifiable changes:

1. Write tests based on input/output pairs
2. Confirm tests fail initially
3. Commit tests
4. Implement code to pass tests
5. Commit working implementation

### Visual Iteration

For UI development:

1. Share visual mock as reference
2. Have Claude implement
3. Compare screenshot to mock
4. Iterate until aligned

## Command Selection

### Quick Reference

| Goal | Command | Time |
|------|---------|------|
| Quick cleanup | `/prompt` | ~2s |
| General perfection | `/prompt-hybrid` | 2-30s |
| Deep research | `/prompt-research` | 60-180s |
| Technical implementation | `/prompt-technical` | 5-30s |
| Article writing | `/prompt-article` | Interactive |
| README generation | `/prompt-article-readme` | ~30s |
| Skill improvement | `/reflect` | 5-15s |

### When to Use Each

**Use `/prompt` when:**
- Quick prompt cleanup needed
- Simple, single-focus request
- Speed is priority

**Use `/prompt-hybrid` when:**
- Uncertain about complexity
- Want automatic agent spawning
- Need predictive intelligence

**Use `/prompt-research` when:**
- Deep analysis required
- Multiple perspectives needed
- Security or architecture review

**Use `/prompt-technical` when:**
- Implementation planning
- Code scaffolding needed
- Technical options comparison

## Environment Configuration

### CLAUDE.md Files

Place `CLAUDE.md` files strategically:

- **Repository root** - Project-specific guidance
- **Parent directories** - Multi-project conventions
- **Child directories** - Component-specific rules
- **~/.claude/CLAUDE.md** - Global defaults

### Recommended Content Structure

```markdown
# Bash commands
- npm run build: Build the project
- npm run typecheck: Run the typechecker

# Core files
- src/utils/helpers.ts: Common utility functions

# Code style
- Use ES modules (import/export) syntax
- Prefer const over let

# Testing
- Run single tests with: npm test -- path/to/test.spec.ts
```

## Context Management

### Use /clear Between Tasks

During long sessions, context can fill with irrelevant conversation. Use `/clear` between distinct tasks for optimal performance.

### Checklists for Complex Tasks

For large migrations or multi-component implementations:

1. Have Claude create a Markdown checklist
2. Address each item sequentially
3. Verify completion before checking off

## Safety Practices

### Incremental Commits

Commit changes incrementally rather than in large batches. This enables:
- Easy rollback of AI mistakes
- Clear attribution for maintenance
- Bisection for debugging

### Multi-Instance Verification

For critical code, use multiple Claude instances:
1. One writes implementation
2. Another reviews and writes tests
3. Third incorporates feedback

### Permission Management

Use `/permissions` to allowlist specific domains and tools, avoiding repeated permission prompts while maintaining security.

## Further Reading

For a comprehensive analysis of Claude Code best practices from Anthropic's Code with Claude 2025 conference, see the [full analysis document](https://github.com/Tadzesi/claude-ideas/blob/main/docs-archive/Claude_Code_Best_Practices_Analysis.md).

This analysis covers:
- Environment customization strategies
- MCP integration patterns
- Headless automation and CI integration
- Multi-Claude workflows
- Git integration deep dive
- Economic and organizational implications
