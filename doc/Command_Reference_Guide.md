# Claude Commands - Complete Reference Guide

**Version:** 2.0 (December 2025)
**Repository:** Claude Ideas - Command Library

This guide provides comprehensive documentation for all Claude Code slash commands, including detailed example flows, architecture diagrams, and best practices.

---

## Table of Contents

1. [Command Overview](#command-overview)
2. [Command Categories](#command-categories)
3. [Quick Start Guide](#quick-start-guide)
4. [Detailed Command Reference](#detailed-command-reference)
5. [Example Workflows](#example-workflows)
6. [Architecture & Flow Diagrams](#architecture--flow-diagrams)
7. [Best Practices](#best-practices)
8. [Troubleshooting](#troubleshooting)

---

## Command Overview

### Available Commands (7 Total)

| Command | Category | Purpose | Complexity |
|---------|----------|---------|------------|
| `/prompt` | Prompt Engineering | Basic prompt perfection | Simple |
| `/prompt-hybrid` | Prompt Engineering | Intelligent prompt perfection with agents | Advanced |
| `/prompt-technical` | Technical Analysis | Implementation planning with hybrid intelligence | Advanced |
| `/prompt-article` | Content Creation | Interactive article wizard | Medium |
| `/prompt-article-readme` | Content Creation | README generator | Medium |
| `/session-start` | Session Management | Load session context | Simple |
| `/session-end` | Session Management | Save session context | Simple |

---

## Command Categories

### 🎯 Prompt Engineering

Commands that transform vague ideas into precise, executable prompts:

- **`/prompt`** - Fast, simple prompt perfection (~2s)
- **`/prompt-hybrid`** - Intelligent with agent support when needed (~2-50s)

### 🔧 Technical Analysis

Commands that provide deep technical implementation guidance:

- **`/prompt-technical`** - Analyzes codebase, generates implementation options

### 📝 Content Creation

Commands for documentation and article writing:

- **`/prompt-article`** - Multi-platform article generation wizard
- **`/prompt-article-readme`** - Auto-generates professional READMEs

### 💾 Session Management

Commands for context persistence across sessions:

- **`/session-start`** - Load previous work context
- **`/session-end`** - Save current work context

---

## Quick Start Guide

### First-Time Setup

```powershell
# Clone repository
git clone <repository-url>
cd claude-ideas

# Verify commands are available
ls .claude\commands\
```

### Basic Usage Pattern

All prompt commands follow this flow:

```
User Input
    ↓
Phase 0: Prompt Perfection
    ↓
User Approval (y/n/modify)
    ↓
Command Execution
    ↓
Output
```

### Your First Command

```bash
# Example 1: Simple prompt perfection
/prompt Fix the login bug in my app

# Example 2: Technical analysis
/prompt-technical Add caching to the API

# Example 3: Save your session
/session-end
```

---

## Detailed Command Reference

### 1. `/prompt` - Basic Prompt Perfection

**Category:** Prompt Engineering
**Complexity:** Simple
**Execution Time:** ~2 seconds

#### Purpose

Transform any prompt into a clear, unambiguous, executable format through systematic validation and clarification.

#### What It Does

1. **Detects** language (Slovak/English) and prompt type
2. **Validates** completeness (goal, context, scope, constraints)
3. **Asks** clarifying questions if needed
4. **Corrects** grammar and structure
5. **Outputs** structured, perfected prompt

#### Usage

```bash
/prompt [your prompt]
```

#### Example Flow

**Input:**
```
/prompt help with my code
```

**Phase 0 Analysis:**
```
Detected Language: English
Prompt Type: Question

Completeness Check:
✗ Goal: What help? (unclear)
✗ Context: Which code? What language?
✗ Scope: Specific file or entire project?

Questions:
1. What specific help do you need?
2. Which programming language and framework?
3. Which file or component?
```

**User Answers:**
```
1. Fix NullReferenceException
2. C# ASP.NET Core
3. UserService.cs, line 42
```

**Perfected Prompt:**
```
Goal: Fix NullReferenceException in UserService.cs at line 42

Context:
- Environment: ASP.NET Core
- Language: C#
- File: UserService.cs

Scope:
- Fix null reference at line 42
- Ensure proper null handling

Requirements:
1. Add null check for user object
2. Return appropriate error response
3. Add logging for debugging

Constraints: None

Expected Result:
Method handles null users gracefully without throwing exception
```

#### When to Use

- ✅ Quick, simple prompts
- ✅ You provide all context yourself
- ✅ Single-file or small scope
- ✅ No codebase analysis needed

#### Architecture

```
┌─────────────────────────────────────────────┐
│            /prompt Command Flow             │
└─────────────────────────────────────────────┘

User Input
    ↓
┌──────────────────┐
│ Initial Analysis │ → Language Detection
│                  │ → Type Detection
│                  │ → Intent Extraction
└──────────────────┘
    ↓
┌──────────────────┐
│ Completeness     │ → Check 6 Criteria:
│ Check            │   - Goal
│                  │   - Context
│                  │   - Scope
│                  │   - Requirements
│                  │   - Constraints
│                  │   - Expected Result
└──────────────────┘
    ↓
┌──────────────────┐
│ Clarification    │ → Ask Questions
│ (if needed)      │ → Present Options
│                  │ → Wait for Answers
└──────────────────┘
    ↓
┌──────────────────┐
│ Correction &     │ → Fix Grammar
│ Structuring      │ → Preserve Tech Terms
│                  │ → Format Output
└──────────────────┘
    ↓
┌──────────────────┐
│ Approval Gate    │ → Show Perfected Prompt
│                  │ → Wait for y/n/modify
└──────────────────┘
    ↓
Execution
```

---

### 2. `/prompt-hybrid` - Intelligent Prompt Perfection ⚡🔍📚

**Category:** Prompt Engineering
**Complexity:** Advanced
**Execution Time:** 2s (simple) to 50s (complex with multi-agent)

#### Purpose

Transform any prompt into an unambiguous, executable format using intelligent complexity detection, autonomous agent assistance, caching, and learning.

#### What It Does

1. **Analyzes** your prompt and detects complexity automatically
2. **Spawns agents** when needed for deep codebase analysis
3. **Validates** completeness with dual-layer checking
4. **Asks** clarifying questions (never guesses)
5. **Perfects** the prompt with all required details

**Advanced Features (NEW):**
- ⚡ **Agent Result Caching** - 10-20x faster for repeated prompts
- 🔍 **Multi-Agent Verification** - 2-3 agents verify critical operations
- 📚 **Learning System** - Tracks patterns, suggests smart defaults

#### Usage

```bash
/prompt-hybrid [your prompt]
/prompt-hybrid [prompt] --verify  # Force multi-agent verification
```

#### Complexity Detection

**Automatic Scoring (0-20+):**

| Score | Category | Behavior | Time |
|-------|----------|----------|------|
| 0-4 | Simple | Inline validation | ~2s |
| 5-9 | Moderate | Ask user if agent needed | ~2s or ~20s |
| 10+ | Complex | Auto-spawn agent | ~20s first time, ~2s cached |
| 15+ | Critical | Multi-agent verification | ~50s (3 agents parallel) |

**Complexity Triggers:**
- Multi-file scope (+5)
- Architecture questions (+7)
- Pattern detection (+6)
- Feasibility checks (+4)
- Implementation planning (+3)
- Cross-cutting concerns (+4)
- Refactoring tasks (+5)

#### Example Flow: Simple Prompt

**Input:**
```
/prompt-hybrid Fix typo in README.md line 42
```

**Execution:**
```
Complexity Analysis:
Score: 0 (single file, clear scope)
Path: Simple (inline validation)

Perfected Prompt:
Goal: Fix typo in README.md at line 42
Context: Documentation file
Scope: Single line edit
Expected Result: Corrected typo

Time: ~2 seconds
```

#### Example Flow: Complex Prompt with Caching

**Input (First Time):**
```
/prompt-hybrid Implement payment processing with security best practices
```

**Execution:**
```
Complexity Analysis:
Score: 17 (implementation=3 + cross-cutting=4 + critical="payment"=10)
Matched Triggers:
- Implementation planning (3)
- Cross-cutting concern: payment (4)
- Critical keyword: payment (10)

Path: Complex + Multi-Agent Verification

🔍 Multi-Agent Verification Initiated
Reason: Critical operation detected (payment processing)
Spawning 3 agents with different strategies...

Verification Strategies:
1. Breadth-First (Haiku, 30s) - Wide codebase coverage
2. Depth-First (Sonnet, 45s) - Detailed security analysis
3. Pattern-Focused (Haiku, 30s) - Convention validation

Running agents in parallel... ⏳

✅ Multi-Agent Verification Complete (50s)

Consensus Analysis:
Agreement Level: High (85%)

Unanimous Findings:
- Use Stripe API with webhook validation
- Existing PaymentService pattern in src/services/
- PCI DSS compliance required
- Environment variables for API keys

Disagreements:
⚠️ Agent 1: Additional fraud detection layer recommended
⚠️ Agent 2: Real-time transaction monitoring suggested

Perfected Prompt:
Goal: Implement secure payment processing using Stripe API
Context:
- Tech Stack: ASP.NET Core (detected)
- Pattern: Follow PaymentService in src/services/
- Security: PCI DSS compliance required
Scope:
- Create PaymentController.cs
- Integrate Stripe SDK
- Add webhook handlers
Requirements:
1. Use environment variables for API keys
2. Implement webhook validation
3. Add fraud detection (recommended by verification)
4. Follow existing service patterns
Constraints:
- PCI DSS compliance mandatory
- No credit card storage in database
Expected Result:
Secure, production-ready payment processing

💾 Saving agent results to cache...
Cache key: payment-processing-stripe-20241219
Expiry: 24 hours

📚 Recording pattern for learning...
Pattern: "payment" keyword → security requirements + PCI compliance

Time: ~50 seconds (first run)
```

**Input (Same Prompt, 2 Hours Later):**
```
/prompt-hybrid Implement payment processing with security best practices
```

**Execution:**
```
⚡ Cache Hit - Using Previous Analysis

Cached from: 2 hours ago
Agent type: Multi-Agent Verification (3 agents)
Files analyzed: 15 (no changes detected)
Branch: main (same)

Loading cached verification results... ✅

Consensus Analysis: High agreement (85%) [from cache]
[Same findings as before]

💡 Learning Insight Detected
Pattern "payment" occurred 3+ times

Suggested Smart Default:
When prompt contains "payment", auto-include:
- Security scanning checklist
- PCI DSS compliance requirements
- API key environment variables
- Fraud detection considerations

Apply smart defaults? (yes/no)

Time: ~2 seconds (25x faster!)
```

#### Advanced Features Guide

**Agent Result Caching ⚡**

How it works:
- Results cached for 24 hours (configurable)
- Cache key: prompt + file hashes + git branch + agent template
- Auto-invalidates on file changes or branch switch
- 10-20x performance improvement

Benefits:
- Repeated prompts use cached analysis
- Saves agent costs (no re-runs)
- Consistent results for same context

**Multi-Agent Verification 🔍**

Triggers:
- Complexity score >= 15
- Critical keywords: payment, security, auth, migration
- User explicitly requests with `--verify`

How it works:
- Spawns 2-3 agents in parallel with different strategies
- Aggregates findings, identifies consensus
- Shows agreements and disagreements
- User chooses approach when agents differ

Benefits:
- Cross-validation reduces errors
- Multiple perspectives on complex tasks
- Higher confidence for critical operations

**Learning System 📚**

What it learns:
- Successful prompt transformations
- Common missing information patterns
- User modification preferences
- Complexity score accuracy

Smart Defaults:
- After 3+ pattern occurrences, auto-suggest context
- Example: "authentication" → security checklist
- Example: "React component" → component structure

Benefits:
- Faster over time
- Learns user preferences
- Improves complexity detection

#### Configuration

Files:
- `.claude/config/complexity-rules.json` - Triggers and weights
- `.claude/config/agent-templates.json` - Agent behaviors
- `.claude/config/cache-config.json` - Caching settings ⚡
- `.claude/config/verification-config.json` - Multi-agent verification 🔍
- `.claude/config/learning-config.json` - Learning system 📚

Memory/Storage:
- `.claude/memory/prompt-patterns.md` - Pattern tracking 📚
- `.claude/cache/agent-results/` - Cached analysis ⚡

#### When to Use

- ✅ Complex tasks needing codebase analysis
- ✅ Pattern detection required
- ✅ Multi-file scope
- ✅ Unsure what information is needed
- ✅ Want caching for repeated/similar prompts
- ✅ Critical operations need verification

#### Performance Metrics

| Path | First Run | Cached |
|------|-----------|--------|
| Simple | ~2s | ~2s |
| Moderate | ~20s | ~2s |
| Complex | ~20s | ~2s |
| Critical (multi-agent) | ~50s | ~2s |

**Cache Hit Rate:** Typically 40-60% for active development

#### Architecture

```
┌────────────────────────────────────────────────────────────┐
│         /prompt-hybrid Command Flow (Advanced)             │
└────────────────────────────────────────────────────────────┘

User Input
    ↓
┌──────────────────┐
│ Initial Analysis │ → Language, Type, Intent
└──────────────────┘
    ↓
┌──────────────────┐
│ Complexity       │ → Score: 0-20+
│ Detection        │ → Triggers: 7 rules
│                  │ → Category: Simple/Moderate/Complex/Critical
└──────────────────┘
    ↓
    ├─────────┬─────────┬─────────┐
    ↓         ↓         ↓         ↓
 Simple   Moderate  Complex   Critical
 (0-4)     (5-9)    (10-14)   (15+)
    ↓         ↓         ↓         ↓
Inline    Ask      Check     Multi-Agent
Validate  User     Cache     Verification
    ↓         ↓         ↓         ↓
    │         │      Cache?      │
    │         │       / \        │
    │         │     Hit Miss     │
    │         │      ↓   ↓       ↓
    │         │     Use Spawn   Spawn
    │         │    Cache Agent  3 Agents
    │         │      ↓    ↓      ↓
    │         │      │  Save   Verify
    │         │      │  Cache  & Agree
    └─────────┴──────┴────┴─────┘
                     ↓
              ┌──────────────┐
              │ Learning     │ → Track Pattern
              │ System       │ → Count Occurrence
              │              │ → Suggest Defaults
              └──────────────┘
                     ↓
              Perfected Prompt
                     ↓
              Approval Gate
```

---

### 3. `/prompt-technical` - Technical Implementation Analysis

**Category:** Technical Analysis
**Complexity:** Advanced
**Execution Time:** 5s (manual scan) to 30s (agent-powered)

#### Purpose

Provide deep technical analysis for programming tasks with automatic hybrid intelligence - combining Phase 0 perfection with agent-powered codebase exploration.

#### What It Does

1. **Detects complexity** automatically (simple/moderate/complex)
2. **Scans project** (manual for simple, agent for complex)
3. **Identifies** frameworks, patterns, conventions
4. **Validates** technical feasibility
5. **Generates** 2-3 implementation options with pros/cons
6. **Recommends** best approach with reasoning
7. **Provides** ready-to-use code scaffolding

#### Hybrid Intelligence

| Complexity | Score | Method | Time |
|------------|-------|--------|------|
| Simple | 0-4 | Manual scan | ~5s |
| Moderate | 5-9 | Ask user | ~5s or ~20s |
| Complex | 10+ | Agent-powered | ~20s |

#### Usage

```bash
/prompt-technical [your technical task]
```

#### Example Flow: Simple Task (Manual Scan)

**Input:**
```
/prompt-technical Add input validation to the login form
```

**Execution:**
```
Complexity Analysis:
Score: 0 (single component, clear scope)
Method: Manual Scan

📁 Project Context (Auto-Detected):
Tech Stack: React 18, TypeScript
Framework: Next.js 14
Validation: Existing pattern with Yup in src/validation/

Technical Analysis Report:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Implementation Options:

Option A: Yup Schema Validation (Recommended)
Pros:
- Matches existing pattern in UserForm.tsx
- Type-safe with TypeScript
- Reusable schema
Cons:
- Additional dependency (already present)

Code Scaffolding:
```typescript
// src/validation/loginSchema.ts
import * as yup from 'yup';

export const loginSchema = yup.object({
  email: yup.string().email().required(),
  password: yup.string().min(8).required()
});
```

Best Practices:
✓ Follow pattern from src/validation/userSchema.ts
✓ Add error messages for accessibility
✓ Test with React Testing Library

Time: ~5 seconds
```

#### Example Flow: Complex Task (Agent-Powered)

**Input:**
```
/prompt-technical Implement caching layer following existing patterns
```

**Execution:**
```
Complexity Analysis:
Score: 10 (pattern detection=6 + cross-cutting=4)
Method: Agent-Powered

🤖 Spawning Explore agent for codebase analysis...
This will take 15-30 seconds...

✅ Agent Analysis Complete

Agent Findings:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Relevant Files Found:
- src/services/cache/RedisCache.ts - Existing Redis implementation
- src/services/cache/CacheService.ts - Service interface
- appsettings.json - Redis connection config

Patterns Detected:
- Naming: [Name]CacheService pattern
- Structure: Service layer with interface
- Organization: src/services/cache/

Similar Implementations:
- UserCacheService.cs - Caches user lookups
- ProductCacheService.cs - Caches product catalog

Technical Feasibility: ✅ Feasible
- Redis already configured
- Cache pattern established
- Dependencies present

Agent Recommendations:
1. Follow CacheService interface pattern
2. Use existing Redis connection from config
3. Implement same expiration strategy (24h default)

Technical Analysis Report:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Implementation Options:

Option A: Redis Cache Service (Recommended)
Pros:
- Matches existing architecture
- Redis already configured
- Pattern-aligned implementation
Cons:
- Redis dependency required (already present)

Code Scaffolding:
```csharp
// src/services/cache/OrderCacheService.cs
public class OrderCacheService : ICacheService<Order>
{
    private readonly IRedisCache _cache;

    public OrderCacheService(IRedisCache cache)
    {
        _cache = cache;
    }

    public async Task<Order> GetOrSet(string key, Func<Task<Order>> factory)
    {
        var cached = await _cache.GetAsync<Order>(key);
        if (cached != null) return cached;

        var value = await factory();
        await _cache.SetAsync(key, value, TimeSpan.FromHours(24));
        return value;
    }
}
```

Following pattern from: UserCacheService.cs:47

Best Practices:
✓ Implement ICacheService<T> interface
✓ Use dependency injection
✓ Set appropriate TTL based on data freshness needs
✓ Add cache invalidation on updates

Time: ~20 seconds
```

#### When to Use

- ✅ Need technical implementation options
- ✅ Want code scaffolding
- ✅ Codebase pattern detection helpful
- ✅ Architecture decisions needed

#### Architecture

```
┌────────────────────────────────────────────────────┐
│      /prompt-technical Hybrid Flow                 │
└────────────────────────────────────────────────────┘

User Input
    ↓
Phase 0: Prompt Perfection
    ↓
Complexity Detection
    ↓
    ├──────────┬──────────┬──────────┐
    ↓          ↓          ↓          ↓
 Simple    Moderate   Complex
 (0-4)      (5-9)     (10+)
    ↓          ↓          ↓
Manual     Ask User   Agent
 Scan       Choice    Powered
    ↓          ↓          ↓
    │          │      Explore
    │          │      Agent
    │          │          ↓
    │          │      Find Files
    │          │      Detect Patterns
    │          │      Validate
    └──────────┴──────────┘
               ↓
    Technical Analysis
               ↓
    Implementation Options (2-3)
               ↓
    Code Scaffolding
               ↓
    Best Practices
```

---

### 4. `/prompt-article` - Interactive Article Wizard

**Category:** Content Creation
**Complexity:** Medium
**Execution Time:** 2-5 minutes (interactive)

#### Purpose

Interactive wizard for writing articles in Slovak or English, with configurable types, audiences, styles, and multi-platform output.

#### What It Does

1. **Perfects** your prompt with Phase 0
2. **Guides** through interactive wizard (language, type, audience, style)
3. **Collects** topic and key points
4. **Generates** article in selected format
5. **Creates** platform-specific versions (LinkedIn, Jira, Medium, Dev.to, etc.)
6. **Saves** markdown file to specified location

#### Article Types

- Blog Post
- LinkedIn Post
- Technical Article
- Tutorial
- How-to Guide
- Case Study
- News Article
- Opinion Piece

#### Platform Outputs

- Markdown File (always)
- LinkedIn (character limit applied)
- Jira (wiki markup)
- Medium (with frontmatter)
- Dev.to (with frontmatter)
- Confluence (wiki compatible)
- Email Newsletter

#### Usage

```bash
/prompt-article [optional: topic]

# Quick syntax (pre-fill wizard):
/prompt-article sk linkedin "AI in Healthcare"
```

#### Example Flow

**Input:**
```
/prompt-article Write about implementing CI/CD pipelines
```

**Phase 0 Perfection:**
```
Detected Language: English
Prompt Type: Article / Content Creation

Perfected Prompt:
Goal: Create an article about implementing CI/CD pipelines
Topic: CI/CD implementation
Constraints: Will configure in wizard

Ready to start wizard? (y/n)
```

**User:** `y`

**Wizard Steps:**

```
Step 1: Language Selection
> English

Step 2: Article Type
> Technical Article

Step 3: Target Audience
> Developers

Step 4: Writing Style
> Professional

Step 5: Topic/Title
> Implementing CI/CD Pipelines with GitHub Actions

Step 6: Key Points (optional)
> - Setting up workflows
> - Docker integration
> - Automated testing

Step 7: Article Length
> Medium (500-1000 words)

Step 8: Output Destinations
> [x] Markdown File
> [x] LinkedIn
> [x] Dev.to

Step 9: Output File Location
> ./articles/2024-12-19-cicd-pipelines.md
```

**Output:**
```
╔══════════════════════════════════════════════════════════╗
║              ARTICLE GENERATION WIZARD                    ║
╚══════════════════════════════════════════════════════════╝

📝 CONFIGURATION SUMMARY
├── Language: English
├── Type: Technical Article
├── Audience: Developers
├── Style: Professional
├── Length: 500-1000 words
└── Destinations: Markdown, LinkedIn, Dev.to

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📄 MAIN ARTICLE (Markdown)

# Implementing CI/CD Pipelines with GitHub Actions

## Overview
Continuous Integration and Continuous Deployment (CI/CD) has become...

[Full article content...]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📱 LINKEDIN VERSION

🚀 Want to streamline your deployment process?

CI/CD pipelines with GitHub Actions can transform how you ship code...

[LinkedIn-optimized content - 1500 characters]

#DevOps #CICD #GitHubActions

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 DEV.TO VERSION

---
title: "Implementing CI/CD Pipelines with GitHub Actions"
published: false
description: "A practical guide to setting up automated pipelines"
tags: devops, ci, cd, github
---

[Dev.to-optimized content...]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💾 FILE SAVED: ./articles/2024-12-19-cicd-pipelines.md
```

#### When to Use

- ✅ Writing articles or blog posts
- ✅ Need multi-platform formatting
- ✅ Want interactive guidance
- ✅ Creating technical documentation

---

### 5. `/prompt-article-readme` - README Generator

**Category:** Content Creation
**Complexity:** Medium
**Execution Time:** 10-30 seconds

#### Purpose

Generate or update professional README.md files by analyzing your project structure, configuration files, and existing documentation.

#### What It Does

1. **Perfects** your prompt with Phase 0
2. **Analyzes** project structure automatically
3. **Detects** tech stack, frameworks, dependencies
4. **Guides** through style selection (Minimal, Standard, Comprehensive)
5. **Generates** README with appropriate sections
6. **Handles** existing README (replace, update, merge)

#### README Styles

- **Minimal** - Essential sections only (Description, Install, Usage)
- **Standard** - Common sections + Contributing
- **Comprehensive** - Full documentation with API, Architecture, Troubleshooting
- **Badge-heavy** - Standard + shields.io badges

#### Usage

```bash
/prompt-article-readme
/prompt-article-readme --update
/prompt-article-readme en comprehensive
```

#### Example Flow

**Input:**
```
/prompt-article-readme Generate README for my React project
```

**Phase 0 + Auto-Analysis:**
```
Detected Language: English
Prompt Type: Documentation / README Generation

📊 PROJECT ANALYSIS
├── Type: Node.js / React
├── Framework: Next.js 14
├── Package Manager: npm
├── Build Command: npm run build
├── Test Command: npm test
├── Dependencies: 42 production, 18 dev
└── Existing README: Yes

Perfected Prompt:
Goal: Generate new README.md
Project: Current directory (React/Next.js project)
Style: Will configure in wizard

Proceed to wizard? (y/n)
```

**Wizard:**
```
Step 1: Language
> English

Step 2: README Style
> Standard

Step 3: Custom Sections
> [x] Environment Variables
> [x] Docker Support

Step 4: Existing README Handling
> Update (preserve custom content)
```

**Output:**
```
╔══════════════════════════════════════════════════════════╗
║                README GENERATOR WIZARD                    ║
╚══════════════════════════════════════════════════════════╝

📊 PROJECT ANALYSIS
├── Type: Node.js / React
├── Framework: Next.js 14
├── Build: npm run build
├── Test: npm test
└── Style: Standard

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📄 GENERATED README.md

# Project Name

Brief description of your Next.js application.

## Features

- Feature 1
- Feature 2
- Feature 3

## Prerequisites

- Node.js >= 18.0.0
- npm / yarn / pnpm

## Installation

```bash
npm install
```

## Usage

```bash
# Development
npm run dev

# Production build
npm run build
npm start

# Testing
npm test
```

## Environment Variables

Create a `.env.local` file:

```env
NEXT_PUBLIC_API_URL=your_api_url
DATABASE_URL=your_database_url
```

## Docker Support

```bash
# Build image
docker build -t myapp .

# Run container
docker run -p 3000:3000 myapp
```

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## License

This project is licensed under the MIT License - see [LICENSE](LICENSE).

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💾 FILE SAVED: ./README.md
📦 BACKUP: ./README.md.backup
```

#### When to Use

- ✅ Starting new project
- ✅ Updating outdated README
- ✅ Standardizing documentation
- ✅ Auto-detecting tech stack

---

### 6. `/session-start` - Load Session Context

**Category:** Session Management
**Complexity:** Simple
**Execution Time:** 2-5 seconds

#### Purpose

Load comprehensive context from previous sessions to continue work with full project knowledge.

#### What It Does (with Phase 0)

1. **Asks** what you're working on (Phase 0 perfection)
2. **Reads** sessions from `.claude/memory/sessions.md`
3. **Filters** by scope (recent/feature/all/minimal)
4. **Aggregates** cumulative context
5. **Highlights** active work and pending items
6. **Presents** organized summary

#### Load Scopes

1. **Resume Recent** - Last session only (fast)
2. **Switch Context** - Specific feature/branch
3. **Full Review** - All sessions (comprehensive)
4. **Fresh Start** - Minimal context

#### Usage

```bash
/session-start
```

#### Example Flow

**Input:**
```
/session-start
```

**Phase 0 Questions:**
```
Session Start - What Are You Working On?

Choose scope:
1. Resume Recent (last session)
2. Switch Context (specific feature)
3. Full Review (all sessions)
4. Fresh Start (minimal)

Select: 1, 2, 3, or 4
```

**User:** `1`

```
What's your focus today?
- Pending tasks
- Blocked items
- Recent decisions
- New implementation
```

**User:** `Pending tasks`

**Output:**
```
🔄 Session Context Loaded

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 📌 Active Work In Progress

Current Task: Implementing payment processing
Files: PaymentController.cs, PaymentService.cs
Last Location: PaymentController.cs:87
Status: Ready to continue

⚠️ Blockers:
- Stripe API keys need to be added to appsettings.json

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## ✅ Pending Next Steps

High Priority:
- [ ] Add Stripe API keys to appsettings.json
- [ ] Implement webhook validation in PaymentController.cs:95

Normal Priority:
- [ ] Add unit tests for PaymentService
- [ ] Update README with payment setup instructions

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🎯 Recent Session Summary

Last Session: 2024-12-18 - feature/payment-integration

Key Decisions:
- Using Stripe for payment processing
- Webhook validation with HMAC signature
- Store transaction IDs only, no credit card data

Features Status:
- 🔨 Payment processing (in progress)
- ✅ User authentication (complete)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🏗️ Project Context

Tech Stack: ASP.NET Core 6.0, SQL Server, React 18
Architecture: Clean Architecture with CQRS

Important Locations:
- Controllers: src/API/Controllers/
- Services: src/Application/Services/
- Config: appsettings.json

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

What would you like to work on today?
```

#### When to Use

- ✅ Starting a new session
- ✅ Resuming work after break
- ✅ Switching between features
- ✅ Need context refresh

---

### 7. `/session-end` - Save Session Context

**Category:** Session Management
**Complexity:** Simple
**Execution Time:** 5-10 seconds

#### Purpose

Capture comprehensive session context to ensure zero information loss between sessions.

#### What It Does (with Phase 0)

1. **Asks** what to capture (Phase 0 perfection)
2. **Analyzes** current session
3. **Captures** 10 comprehensive sections
4. **Appends** to `.claude/memory/sessions.md`
5. **Shows** confirmation

#### Capture Scopes

1. **Full Session** - Everything (recommended)
2. **Feature Focus** - Specific feature only
3. **Key Decisions Only** - Planning sessions
4. **Minimal** - Just next steps

#### 10 Comprehensive Sections

1. Decisions Made (with rationale)
2. Code Changes (files modified/created/deleted)
3. Features Implemented (status)
4. Problems Solved (root cause → solution)
5. Technical Stack & Architecture
6. Key Insights
7. User Preferences & Patterns
8. Active Work In Progress
9. Project Structure Notes
10. Next Steps

#### Usage

```bash
/session-end
```

#### Example Flow

**Input:**
```
/session-end
```

**Phase 0 Questions:**
```
Session End - What Should I Capture?

Choose scope:
1. Full Session (recommended)
2. Feature Focus
3. Key Decisions Only
4. Minimal

Select: 1, 2, 3, or 4
```

**User:** `1`

```
What's the most important thing to remember for next session?
```

**User:** `Stripe API keys must be environment variables, never hardcoded`

**Output:**
```
✅ Session Saved to Memory

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Captured:
- Decisions: 4 (including Stripe integration approach)
- Code Changes: 7 files (PaymentController, PaymentService, models)
- Features: 2 (1 complete: auth, 1 in progress: payments)
- Problems Solved: 2 (CORS issue, dependency injection)
- Technical Notes: 3 (Stripe SDK, webhook setup, PCI compliance)
- Insights: 2 (Clean Architecture benefits, testing strategies)
- Preferences: 1 new pattern (async/await consistency)
- WIP: Payment processing 60% complete
- Next Steps: 4 pending (API keys, webhooks, tests, docs)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Priority Item: ⭐ Stripe API keys in environment variables

Session Scope: Full
Session State: Payment integration in progress, auth complete

File: .claude/memory/sessions.md

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Run /session-start next time to load full context.
```

#### When to Use

- ✅ Ending a work session
- ✅ Before long break
- ✅ After major milestone
- ✅ Context checkpoint needed

---

## Example Workflows

### Workflow 1: From Idea to Implementation

**Scenario:** You have a vague idea and want to implement it properly.

```bash
# Step 1: Perfect the prompt
/prompt Add user authentication to my app

# → Phase 0 asks clarifying questions
# → You provide: JWT-based, ASP.NET Core, database users
# → Output: Perfected prompt with all details

# Step 2: Get technical analysis
/prompt-technical

# → Auto-detects: ASP.NET Core 6.0, SQL Server
# → Spawns agent (complexity = 12)
# → Finds: Existing auth patterns
# → Output: 3 implementation options with code scaffolding

# Step 3: Implement
# [You write code based on recommendations]

# Step 4: Save session
/session-end

# → Captures: Decisions, code changes, next steps
# → Priority: JWT token expiration set to 24h
```

### Workflow 2: Complex Task with Caching

**Scenario:** Implementing a complex feature across multiple sessions.

```bash
# Session 1 (Day 1)
/prompt-hybrid Implement payment processing with security

# → Complexity: 17 (critical)
# → Spawns 3 agents (50s)
# → Finds: PCI compliance needed, Stripe recommended
# → Saves to cache

/session-end
# → Saves: Payment integration decisions

# Session 2 (Day 2)
/session-start
# → Loads: Payment context from yesterday

/prompt-hybrid Add fraud detection to payment flow

# → Complexity: 15
# → Cache hit! Uses yesterday's payment analysis (2s)
# → Adds fraud detection requirements
# → Time saved: 48s

/session-end
```

### Workflow 3: Documentation Sprint

**Scenario:** Creating comprehensive documentation.

```bash
# Generate README
/prompt-article-readme

# → Analyzes: Project structure
# → Detects: Tech stack, dependencies
# → Generates: Comprehensive README

# Write technical article
/prompt-article

# → Wizard: Technical Article, Developers, Professional
# → Topic: "How We Built Our Payment System"
# → Platforms: LinkedIn, Dev.to, Medium
# → Generates: Multi-platform content

# Save session
/session-end
# → Scope: Key Decisions Only (documentation session)
```

### Workflow 4: Feature Branch Development

**Scenario:** Working on a feature branch with context switching.

```bash
# Start feature work
git checkout -b feature/notifications
/session-start
# → Choice: Fresh Start (new feature)

# Plan the feature
/prompt-hybrid Add real-time notifications using SignalR

# → Complexity: 13
# → Agent explores SignalR patterns
# → Recommends: Hub-based architecture

# Implement and save
# [code implementation]
/session-end
# → Scope: Feature Focus (notifications)

# Next day - switch to different feature
git checkout feature/search
/session-start
# → Branch mismatch detected
# → Choice: Load sessions for feature/search

# Resume search feature work
# [continue work]
```

---

## Architecture & Flow Diagrams

### Overall Command System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│            Claude Commands Library Architecture             │
└─────────────────────────────────────────────────────────────┘

                    User Input
                        ↓
        ┌───────────────────────────────┐
        │   Command Router              │
        │   (/prompt, /session-*, etc)  │
        └───────────────────────────────┘
                        ↓
        ┌───────────────────────────────┐
        │   Phase 0: Prompt Perfection  │ ← Unified Library
        │   - Analyze                   │   .claude/library/
        │   - Validate                  │   prompt-perfection-core.md
        │   - Clarify                   │
        │   - Correct                   │
        │   - Structure                 │
        └───────────────────────────────┘
                        ↓
              ┌─────────┴─────────┐
              ↓                   ↓
     ┌────────────────┐  ┌────────────────┐
     │ Simple Path    │  │ Complex Path   │
     │ (Inline)       │  │ (Agent)        │
     └────────────────┘  └────────────────┘
              │                   ↓
              │          ┌─────────────────┐
              │          │ Complexity      │
              │          │ Detection       │
              │          │ .claude/config/ │
              │          │ complexity-     │
              │          │ rules.json      │
              │          └─────────────────┘
              │                   ↓
              │          ┌─────────────────┐
              │          │ Agent           │
              │          │ Management      │
              │          │ - Cache Check   │⚡
              │          │ - Spawn Agent   │
              │          │ - Verify (3x)   │🔍
              │          │ - Learn         │📚
              │          └─────────────────┘
              │                   ↓
              └───────────┬───────┘
                          ↓
              ┌───────────────────┐
              │ Command-Specific  │
              │ Execution         │
              │ - Technical       │
              │ - Article         │
              │ - README          │
              │ - Session         │
              └───────────────────┘
                          ↓
              ┌───────────────────┐
              │ Output Generation │
              │ - Formatted       │
              │ - Multi-platform  │
              │ - Saved to file   │
              └───────────────────┘
                          ↓
              ┌───────────────────┐
              │ Learning System   │📚
              │ - Track Pattern   │
              │ - Update Cache    │⚡
              │ - Save Memory     │💾
              └───────────────────┘
```

### Phase 0: Prompt Perfection Flow (Universal)

```
┌─────────────────────────────────────────────────────────────┐
│        Phase 0: Prompt Perfection (All Commands)            │
└─────────────────────────────────────────────────────────────┘

User Input: "Fix bug"
    ↓
┌──────────────────────────────────────┐
│ Step 0.1: Initial Analysis           │
│ • Language: English                  │
│ • Type: Bug Fix                      │
│ • Intent: Fix software defect        │
└──────────────────────────────────────┘
    ↓
┌──────────────────────────────────────┐
│ Step 0.2: Completeness Check         │
│                                      │
│ Check 6 Universal Criteria:          │
│ ✗ Goal: "Fix bug" (too vague)       │
│ ✗ Context: No tech stack mentioned  │
│ ✗ Scope: Which file/component?      │
│ ✗ Requirements: What's the fix?     │
│ ✗ Constraints: None specified       │
│ ✗ Expected Result: How to verify?   │
│                                      │
│ Missing: 6/6 items                   │
└──────────────────────────────────────┘
    ↓
┌──────────────────────────────────────┐
│ Step 0.3: Clarification              │
│                                      │
│ 🚨 Critical Questions:               │
│ 1. What error/bug occurs?            │
│ 2. Which technology stack?           │
│ 3. Which file has the bug?           │
│                                      │
│ ⚠️ Important Questions:              │
│ 4. What triggers the bug?            │
│ 5. Any error messages?               │
│                                      │
│ → Wait for user answers              │
└──────────────────────────────────────┘
    ↓
User Answers:
"NullReferenceException in
 UserService.cs line 42,
 ASP.NET Core app"
    ↓
┌──────────────────────────────────────┐
│ Step 0.4: Correction                 │
│ • Fix grammar: ✓                     │
│ • Preserve "UserService.cs": ✓      │
│ • Clarify "line 42": ✓              │
└──────────────────────────────────────┘
    ↓
┌──────────────────────────────────────┐
│ Step 0.5: Structure Perfect Prompt   │
│                                      │
│ ✨ Perfected Prompt:                 │
│                                      │
│ Goal: Fix NullReferenceException     │
│                                      │
│ Context:                             │
│ - Tech: ASP.NET Core                 │
│ - File: UserService.cs               │
│ - Line: 42                           │
│                                      │
│ Scope: Single method fix             │
│                                      │
│ Requirements:                        │
│ 1. Add null check                    │
│ 2. Handle gracefully                 │
│ 3. Log error                         │
│                                      │
│ Expected Result:                     │
│ No exception on null users           │
└──────────────────────────────────────┘
    ↓
┌──────────────────────────────────────┐
│ Step 0.6: Approval Gate              │
│                                      │
│ ⏸️ Awaiting Approval                 │
│                                      │
│ Reply:                               │
│ • y/yes → Execute                    │
│ • n/no → Cancel                      │
│ • modify [...] → Adjust              │
└──────────────────────────────────────┘
    ↓
User: "y"
    ↓
✅ Proceed to Command Execution
```

### Hybrid Intelligence Decision Tree

```
┌─────────────────────────────────────────────────────────────┐
│        Hybrid Intelligence: Manual vs Agent Decision        │
└─────────────────────────────────────────────────────────────┘

User Prompt
    ↓
Calculate Complexity Score
    ↓
    ├─────────────┬─────────────┬─────────────┐
    ↓             ↓             ↓             ↓
Score 0-4     Score 5-9    Score 10-14   Score 15+
(Simple)      (Moderate)   (Complex)     (Critical)
    ↓             ↓             ↓             ↓
┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────────┐
│ Manual  │ │ Ask     │ │ Agent   │ │ Multi-Agent │
│ Scan    │ │ User    │ │ Powered │ │ Verify      │
└─────────┘ └─────────┘ └─────────┘ └─────────────┘
    ↓             ↓             ↓             ↓
    │         User says         │         Spawn 3
    │         yes/no            │         agents
    │             ↓             │             ↓
    │      ┌──────┴──────┐      │      Agent 1: Breadth
    │      ↓             ↓      │      Agent 2: Depth
    │    Agent        Manual    │      Agent 3: Pattern
    │                           │             ↓
    └───────────┬───────────────┴──────→ Consensus
                ↓                        Analysis
         Check Cache ⚡                       ↓
                ↓                        User chooses
           Cache Hit?                     approach
            /     \                           ↓
         Yes      No                     Perfected
          ↓        ↓                      Prompt
    Use Cached  Spawn
    Results     Agent
          ↓        ↓
          └────┬───┘
               ↓
        Perfected Prompt

Triggers:
• Multi-file scope → +5
• Architecture question → +7
• Pattern detection → +6
• Feasibility check → +4
• Implementation → +3
• Cross-cutting → +4
• Refactoring → +5
• Critical keywords → +10
  (payment, security, auth)
```

### Agent Result Caching Flow ⚡

```
┌─────────────────────────────────────────────────────────────┐
│              Agent Result Caching System ⚡                  │
└─────────────────────────────────────────────────────────────┘

Complex Prompt Detected
    ↓
┌──────────────────────────────────────┐
│ Generate Cache Key                   │
│ • Normalized prompt                  │
│ • Git branch                         │
│ • File hashes (.cs, .js, etc)       │
│ • Agent template ID                  │
└──────────────────────────────────────┘
    ↓
┌──────────────────────────────────────┐
│ Check Cache Directory                │
│ .claude/cache/agent-results/         │
└──────────────────────────────────────┘
    ↓
┌──────────────────────────────────────┐
│ Validate Cached Result               │
│ • Timestamp < 24h?                   │
│ • Files unchanged?                   │
│ • Same git branch?                   │
│ • Same agent template?               │
└──────────────────────────────────────┘
    ↓
    ├────────────────┬────────────────┐
    ↓                ↓                ↓
Valid Cache      Invalid          No Cache
    ↓                ↓                ↓
┌─────────┐    ┌─────────┐    ┌─────────┐
│ Cache   │    │ Reason: │    │ Fresh   │
│ Hit! ⚡ │    │ • Expired│    │ Analysis│
│         │    │ • Files │    │ Needed  │
│ Load    │    │   changed│    │         │
│ Results │    │ • Branch│    │ Spawn   │
│         │    │   switch│    │ Agent   │
│ Time:   │    │         │    │         │
│ ~2s     │    └─────────┘    │ Time:   │
└─────────┘         ↓         │ ~20s    │
    ↓               ↓         └─────────┘
    │               │              ↓
    │               │         ┌─────────┐
    │               │         │ Save to │
    │               │         │ Cache   │
    │               │         │ Expiry: │
    │               │         │ 24h     │
    │               │         └─────────┘
    │               │              ↓
    └───────────────┴──────────────┘
                    ↓
            Return Results
                    ↓
         Update Statistics 📚
         • Cache hit rate
         • Time saved
         • File: prompt-patterns.md

Performance Impact:
• First run: ~20s
• Cached run: ~2s
• Speedup: 10x
• Cost savings: ~90%
```

### Learning System Flow 📚

```
┌─────────────────────────────────────────────────────────────┐
│              Learning System Flow 📚                         │
└─────────────────────────────────────────────────────────────┘

User Approves Perfected Prompt
    ↓
┌──────────────────────────────────────┐
│ Track Transformation                 │
│ • Original prompt                    │
│ • Perfected prompt                   │
│ • Missing information detected       │
│ • Questions asked                    │
│ • User modifications                 │
│ • Complexity score                   │
│ • Agent used (yes/no)                │
│ • Cache hit (yes/no)                 │
└──────────────────────────────────────┘
    ↓
┌──────────────────────────────────────┐
│ Append to Memory                     │
│ File: .claude/memory/                │
│       prompt-patterns.md             │
│                                      │
│ Record:                              │
│ ### [Date] - [Type] - Score: [X]    │
│ Original: [...]                      │
│ Missing: [...]                       │
│ Questions: [...]                     │
│ Perfected: [...]                     │
│ Pattern: [detected pattern]          │
└──────────────────────────────────────┘
    ↓
┌──────────────────────────────────────┐
│ Analyze for Patterns                 │
│ • Count occurrences of keywords      │
│ • Track missing info patterns        │
│ • Monitor complexity accuracy        │
│ • Learn user preferences             │
└──────────────────────────────────────┘
    ↓
    ├──────────────────┬───────────────┐
    ↓                  ↓               ↓
Pattern Count     Complexity      User Pref
>= 3 times       Mismatch        Detected
    ↓                  ↓               ↓
┌─────────┐      ┌─────────┐    ┌─────────┐
│ Smart   │      │ Suggest │    │ Apply   │
│ Default │      │ Weight  │    │ Auto    │
│ Trigger │      │ Adjust  │    │ Context │
└─────────┘      └─────────┘    └─────────┘
    ↓                  ↓               ↓
┌──────────────────────────────────────┐
│ Next Prompt Uses Learning            │
│ • "payment" → auto-suggest security  │
│ • "React" → auto-suggest component   │
│ • "auth" → auto-suggest JWT/OAuth    │
└──────────────────────────────────────┘
    ↓
┌──────────────────────────────────────┐
│ Update Statistics                    │
│ • Total prompts: +1                  │
│ • Cache hit rate: recalculate        │
│ • Approval rate: update              │
│ • Agent effectiveness: track         │
└──────────────────────────────────────┘

Example Smart Default:

Pattern: "authentication" (5 occurrences)
Missing Info: Security requirements (4/5 times)

💡 Smart Default Triggered:
When prompt contains "authentication", auto-suggest:
- Password hashing method (bcrypt/argon2)
- Token expiration strategy
- Session management approach
- Two-factor authentication consideration

Apply? (yes/no) → User accepts → Saved as preference
```

### Session Management Architecture

```
┌─────────────────────────────────────────────────────────────┐
│          Session Management: End → Storage → Start          │
└─────────────────────────────────────────────────────────────┘

                    /session-end
                         ↓
            ┌────────────────────────┐
            │ Phase 0: Perfection    │
            │ • Capture scope        │
            │ • Priority item        │
            │ • Exclusions           │
            └────────────────────────┘
                         ↓
            ┌────────────────────────┐
            │ Analyze Current Session│
            │ • Decisions made       │
            │ • Code changes         │
            │ • Features status      │
            │ • Problems solved      │
            │ • Tech insights        │
            │ • User preferences     │
            │ • Work in progress     │
            │ • Project structure    │
            │ • Next steps           │
            └────────────────────────┘
                         ↓
            ┌────────────────────────┐
            │ Generate Summary       │
            │ • 10 sections          │
            │ • Apply scope filter   │
            │ • Highlight priority   │
            └────────────────────────┘
                         ↓
            ┌────────────────────────┐
            │ Append to Memory       │
            │ .claude/memory/        │
            │ sessions.md            │
            │ • Date timestamp       │
            │ • Branch tag           │
            │ • Session data         │
            └────────────────────────┘
                         ↓
                 ✅ Saved!

    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    [Time passes - work on other things]
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

                    /session-start
                         ↓
            ┌────────────────────────┐
            │ Phase 0: Perfection    │
            │ • Load scope           │
            │ • Work focus           │
            │ • Filter criteria      │
            └────────────────────────┘
                         ↓
            ┌────────────────────────┐
            │ Auto-Detect Git Context│
            │ • Current branch       │
            │ • Compare with sessions│
            │ • Mismatch warning     │
            └────────────────────────┘
                         ↓
            ┌────────────────────────┐
            │ Read & Filter Sessions │
            │ • Load from sessions.md│
            │ • Apply scope filter   │
            │   - Resume Recent (1)  │
            │   - Feature X (N)      │
            │   - Full Review (all)  │
            │   - Fresh Start (min)  │
            └────────────────────────┘
                         ↓
            ┌────────────────────────┐
            │ Aggregate Context      │
            │ • Combine preferences  │
            │ • Merge project notes  │
            │ • Build tech stack     │
            │ • Collect insights     │
            └────────────────────────┘
                         ↓
            ┌────────────────────────┐
            │ Present Summary        │
            │ • Active WIP (top)     │
            │ • Pending steps        │
            │ • Recent session       │
            │ • Project context      │
            │ • User preferences     │
            │ • Key insights         │
            │ • Session history      │
            └────────────────────────┘
                         ↓
                 🔄 Context Loaded!
                         ↓
          "What would you like to work on?"

Session File Structure:
.claude/memory/sessions.md
───────────────────────────
## Session: 2024-12-18 | feature/payment
Decisions Made: [...]
Code Changes: [...]
Features: [...]
[10 sections total]
───────────────────────────
## Session: 2024-12-19 | main
[...]
```

---

## Best Practices

### General Best Practices

1. **Always Use Phase 0**
   - Let commands perfect your prompt
   - Answer clarifying questions honestly
   - Review perfected prompt before approval

2. **Trust Complexity Detection**
   - Don't override unless necessary
   - Let hybrid systems decide manual vs agent
   - Use caching for repeated tasks

3. **Provide Context Early**
   - More context = better results
   - Tech stack, file names, error messages
   - Existing patterns and conventions

4. **Use Session Management**
   - Always `/session-end` before long breaks
   - Start with `/session-start` for context
   - Specify priority items when saving

### Command-Specific Best Practices

#### `/prompt` and `/prompt-hybrid`

✅ **Do:**
- Be specific about goal and scope
- Include error messages and stack traces
- Mention existing files and patterns
- Use `/prompt` for simple, `/prompt-hybrid` for complex

❌ **Don't:**
- Assume the command knows your project
- Skip clarifying questions
- Reject perfected prompt without reviewing

#### `/prompt-technical`

✅ **Do:**
- Let it auto-detect your tech stack
- Review all implementation options
- Use provided code scaffolding as templates
- Apply best practices checklist

❌ **Don't:**
- Override complexity detection arbitrarily
- Ignore agent findings
- Skip feasibility validation

#### `/prompt-article` and `/prompt-article-readme`

✅ **Do:**
- Use interactive wizard fully
- Select appropriate target audience
- Choose multiple platform outputs
- Review and revise generated content

❌ **Don't:**
- Skip wizard steps (use quick syntax if needed)
- Ignore platform-specific formatting
- Forget to save generated files

#### `/session-start` and `/session-end`

✅ **Do:**
- Capture full sessions (scope: full)
- Specify priority item for next session
- Use load filters (resume recent vs full review)
- Review pending steps when loading

❌ **Don't:**
- Skip session-end (context loss!)
- Save empty sessions
- Load all sessions unnecessarily (use filters)

---

## Troubleshooting

### Common Issues

#### "Command not found" or "Command doesn't work"

**Solution:**
```powershell
# Verify commands exist
ls .claude\commands\*.md

# Check command syntax
# Correct: /prompt Fix bug
# Incorrect: /prompt-fix bug (wrong command name)
```

#### "Phase 0 asks too many questions"

**Solution:**
- Provide more context in initial prompt
- Use smart defaults (learning system)
- For simple prompts, use `/prompt` instead of `/prompt-hybrid`

#### "Agent taking too long"

**Solution:**
- Check complexity score (maybe too high)
- Use manual scan for simple tasks
- Check if cache can help (repeated prompts)
- Agent timeouts: Explore 30s, Plan 60s

#### "Cache not working"

**Solution:**
```powershell
# Verify cache config
cat .claude\config\cache-config.json

# Check cache directory
ls .claude\cache\agent-results\

# Clear cache if needed
rm -r .claude\cache\agent-results\
```

#### "Complexity score seems wrong"

**Solution:**
- Edit `.claude/config/complexity-rules.json`
- Adjust trigger weights
- System learns from feedback (learning system)

#### "Session context not loading"

**Solution:**
```powershell
# Check sessions file exists
Test-Path .claude\memory\sessions.md

# Verify content
cat .claude\memory\sessions.md

# If empty or missing, start fresh
/session-end  # Save current work first
```

#### "Multi-agent verification not triggering"

**Solution:**
- Check `.claude/config/verification-config.json`
- Ensure `enabled: true`
- Verify complexity >= 15 or critical keywords present
- Manually trigger with `--verify` flag

### Performance Issues

#### "Commands running slower than expected"

**Diagnosis:**
```powershell
# Check file sizes
ls -lh .claude\memory\*.md
ls -lh .claude\cache\agent-results\

# Cache should auto-clean at 50MB
# Sessions file can grow large
```

**Solutions:**
- Archive old sessions periodically
- Clear cache: `rm -r .claude\cache\agent-results\`
- Reduce `max_cache_age_hours` in config
- Use load filters in `/session-start`

#### "Learning system not improving results"

**Solution:**
- Needs 3+ pattern occurrences
- Check `.claude/memory/prompt-patterns.md`
- Ensure `enabled: true` in learning-config.json
- Accept smart defaults when suggested

### Error Messages

#### "File not found: .claude/library/prompt-perfection-core.md"

**Solution:**
```powershell
# Verify library structure
ls .claude\library\*.md
ls .claude\library\adapters\*.md

# Re-clone repository if missing
```

#### "JSON parse error in config file"

**Solution:**
```powershell
# Validate JSON syntax
Get-Content .claude\config\complexity-rules.json | ConvertFrom-Json

# Fix JSON syntax errors
# Common: missing commas, trailing commas, unquoted strings
```

---

## Configuration Files Reference

### `.claude/config/complexity-rules.json`

```json
{
  "rules": [
    {
      "id": "multi_file_scope",
      "name": "Multi-file Scope",
      "triggers": ["multiple files", "across files", "entire codebase"],
      "weight": 5,
      "agent": "Explore"
    },
    {
      "id": "architecture_question",
      "name": "Architecture Questions",
      "triggers": ["how does", "where is", "what handles"],
      "weight": 7,
      "agent": "Explore"
    }
  ],
  "thresholds": {
    "simple": { "max": 4 },
    "moderate": { "min": 5, "max": 9 },
    "complex": { "min": 10 }
  }
}
```

### `.claude/config/cache-config.json` ⚡

```json
{
  "enabled": true,
  "max_cache_age_hours": 24,
  "max_cache_size_mb": 50,
  "cache_directory": ".claude/cache/agent-results",
  "invalidation_triggers": [
    "file_changes",
    "branch_switch",
    "expiration"
  ]
}
```

### `.claude/config/verification-config.json` 🔍

```json
{
  "enabled": true,
  "verification_threshold": 15,
  "critical_keywords": [
    "payment",
    "security",
    "authentication",
    "authorization",
    "migration"
  ],
  "agent_count": 3,
  "strategies": [
    "breadth_first",
    "depth_first",
    "pattern_focused"
  ],
  "consensus_threshold": 0.66
}
```

### `.claude/config/learning-config.json` 📚

```json
{
  "enabled": true,
  "learning_threshold": 3,
  "auto_suggest_improvements": true,
  "track_metrics": [
    "prompt_transformations",
    "cache_hit_rate",
    "approval_rate",
    "complexity_accuracy"
  ],
  "memory_file": ".claude/memory/prompt-patterns.md"
}
```

---

## Appendix: Command Comparison Matrix

| Feature | `/prompt` | `/prompt-hybrid` | `/prompt-technical` | `/prompt-article` | `/prompt-article-readme` | `/session-start` | `/session-end` |
|---------|-----------|------------------|---------------------|-------------------|--------------------------|------------------|----------------|
| **Phase 0** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Complexity Detection** | ❌ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| **Agent Support** | ❌ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| **Caching** ⚡ | ❌ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| **Multi-Agent Verification** 🔍 | ❌ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| **Learning System** 📚 | ❌ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| **Code Scaffolding** | ❌ | ❌ | ✅ | ❌ | ❌ | ❌ | ❌ |
| **Multi-Platform Output** | ❌ | ❌ | ❌ | ✅ | ❌ | ❌ | ❌ |
| **Project Analysis** | ❌ | ❌ | ✅ | ❌ | ✅ | ❌ | ❌ |
| **Context Persistence** | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | ✅ |
| **Execution Time** | ~2s | 2-50s | 5-30s | 2-5min | 10-30s | 2-5s | 5-10s |
| **Use Case** | Simple prompts | Complex tasks | Technical impl | Content | Documentation | Resume work | Save work |

---

## Version History

**v2.0 (December 2025):**
- ✨ Advanced features: Caching, Multi-Agent Verification, Learning System
- ✨ Unified Library System for Phase 0
- ✨ Hybrid Intelligence (manual vs agent)
- ✨ Session management with Phase 0 filtering
- 📚 Comprehensive documentation with flows and diagrams

**v1.0 (Previous):**
- Basic prompt perfection commands
- Simple technical analysis
- Article and README generators
- Basic session management

---

**Last Updated:** December 19, 2024
**Maintained By:** Claude Ideas Project
**License:** MIT
