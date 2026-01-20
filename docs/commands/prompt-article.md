# /prompt-article

Interactive wizard for writing articles, blog posts, and documentation.

## Overview

| Aspect | Details |
|--------|---------|
| **Speed** | Interactive (2-5 minutes) |
| **Complexity** | Medium |
| **Best For** | Blog posts, Medium articles, LinkedIn content |

## Usage

```bash
/prompt-article [topic]
```

## Examples

### Blog Post

```bash
/prompt-article Write about CI/CD best practices for small teams
```

**Interactive Flow:**

```
Article Wizard

Topic: CI/CD best practices for small teams
Detected: Technical tutorial

Questions:

1. Target audience?
   - Beginners (explain basics)
   - Intermediate (some CI/CD experience)
   - Advanced (optimization focus)

2. Article length?
   - Short (800-1200 words)
   - Medium (1500-2500 words)
   - Long (3000+ words)

3. Platform?
   - Personal blog (markdown)
   - Medium (formatted)
   - LinkedIn (professional tone)
   - Dev.to (developer community)

4. Include code examples?
   - Yes, with explanations
   - Yes, minimal
   - No code

5. Save location?
   - ./articles/cicd-best-practices.md
   - Custom path

[Your answers: 2, Medium, Dev.to, Yes with explanations, default]

Generating outline...

Article Outline:

# CI/CD Best Practices for Small Teams

## Introduction (150 words)
- Why CI/CD matters for small teams
- What we'll cover

## Section 1: Start Simple (400 words)
- GitHub Actions for beginners
- Your first pipeline
- [Code: basic workflow]

## Section 2: Essential Stages (500 words)
- Build → Test → Deploy
- [Code: multi-stage pipeline]

## Section 3: Common Mistakes (400 words)
- Overcomplicating early
- Skipping tests
- Manual steps in pipeline

## Section 4: Scaling Up (400 words)
- When to add complexity
- Caching and optimization
- [Code: optimized pipeline]

## Conclusion (150 words)
- Start today
- Resources

Proceed with this outline? [Yes / Modify]
```

### LinkedIn Article

```bash
/prompt-article Why every developer should learn SQL
```

### Medium Post

```bash
/prompt-article My journey from junior to senior developer
```

## How It Works

### Phase 1: Topic Analysis

Claude analyzes:
- Subject matter
- Likely audience
- Content type (tutorial, opinion, case study)
- Appropriate length

### Phase 2: Interactive Questions

Questions about:
- Target audience level
- Desired length
- Platform optimization
- Code examples
- Tone and style

### Phase 3: Outline Generation

Creates structured outline:
- Introduction hook
- Main sections with word counts
- Code example placements
- Conclusion and CTA

### Phase 4: Content Generation

Writes section by section:
- Maintains consistent tone
- Includes requested examples
- Optimizes for platform

### Phase 5: Review & Save

- Shows complete article
- Allows modifications
- Saves to specified location

## Platform Optimization

| Platform | Tone | Format |
|----------|------|--------|
| Personal Blog | Authentic | Markdown |
| Medium | Engaging | Rich formatting |
| LinkedIn | Professional | Business-focused |
| Dev.to | Technical | Code-heavy |

## Output Locations

Articles saved to:
- `./articles/[topic-slug].md` (default)
- Custom path you specify
- Clipboard for immediate paste

## Tips

### Provide Context

```bash
# Less effective
/prompt-article Write about testing

# More effective
/prompt-article Write about integration testing for React apps,
focusing on React Testing Library
```

### Specify Your Voice

```bash
/prompt-article Write about remote work. Use conversational tone,
first person, include personal anecdotes.
```

### Request Specific Structure

```bash
/prompt-article Write about Docker for beginners.
Include: problem statement, 3 main sections, practical exercise,
resources list.
```

## Related Commands

- [/prompt-article-readme](/commands/prompt-article-readme) - For README files
- [/prompt](/commands/prompt) - For quick content questions
