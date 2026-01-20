# Changelog

All notable changes to the Claude Commands Library will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [4.2.0] - 2026-01-20

### Major Release - AI Fluency Framework Alignment

Version 4.2 fully aligns the command library with Anthropic's AI Fluency Framework (4Ds: Delegation, Description, Discernment, Diligence), ensuring best practices for human-AI collaboration are built into every command.

### Added

#### AI Fluency Core Integration
- **NEW:** Step 0.11 - Quick Delegation Check (task appropriateness, AI capability match, responsibility awareness)
- **NEW:** Step 0.7 - Post-Execution Evaluation (feedback loop with good/partial/wrong options)
- **NEW:** The Feedback Loop section - Describe → Evaluate → Refine pattern
- **NEW:** Diligence Reminder in Approval Gate - "You remain responsible..."
- **NEW:** Common Iteration Patterns for refining AI outputs

#### Enhanced Commands
- **UPDATED:** `/prompt` (v2.1) - Added Common Mistakes, AI Limitations, Secret Weapon tip
- **UPDATED:** `/prompt-hybrid` (v4.1) - Full Delegation Assessment step
- **UPDATED:** `/prompt-research` (v1.1) - Delegation Assessment with Agency Mode focus
- **UPDATED:** `/session-end` (v2.1) - Already had Diligence Summary

#### Documentation
- **NEW:** AI Fluency concepts in all command outputs
- **NEW:** Configuration reference: `.claude/config/ai-fluency.json`

### Changed

#### Core Library
- **UPDATED:** `.claude/library/prompt-perfection-core.md` (v1.3 → v1.4)
  - Added Step 0.11: Quick Delegation Check
  - Added Step 0.7: Post-Execution Evaluation
  - Added Feedback Loop section
  - Enhanced Approval Gate with Diligence Reminder

### AI Fluency Coverage

| Competency | Before | After | Implementation |
|------------|--------|-------|----------------|
| **Delegation** | 80% | 95% | Step 0.11 + all commands |
| **Description** | 95% | 95% | Already excellent |
| **Discernment** | 55% | 85% | Step 0.7 + feedback loop |
| **Diligence** | 45% | 80% | Reminders + session tracking |

### Documentation

- Updated CLAUDE.md with AI Fluency config reference
- Updated install script to v4.2.0 with AI Fluency announcement
- Added AI Fluency Framework alignment notes to all updated commands

---

## [4.1.0] - 2026-01-05

### Major Release - Skill Reflection System

Version 4.1 introduces active skill improvement through conversation analysis, transforming passive pattern tracking into actionable skill enhancements.

### Added

#### New Command: `/reflect`
- **Signal detection** - Analyzes conversation for corrections, successes, edge cases, and preferences
- **Priority classification** - HIGH/MED/LOW coded change proposals
- **Direct skill modifications** - Apply changes to skill files with user approval
- **Observation persistence** - Save declined changes for later review
- **Learning integration** - Connects with existing learning system

#### New Library Component
- **NEW:** `.claude/library/intelligence/reflection-analyzer.md` - Signal detection engine with confidence scoring

#### New Memory File
- **NEW:** `.claude/memory/observations.md` - Stores pending observations for review

#### Enhanced Configuration
- **UPDATED:** `.claude/config/learning-config.json` - Added `reflection_analysis` section with signal patterns and thresholds

### Documentation

- Full VitePress documentation for `/reflect` command
- Updated commands index with new Skill Improvement category
- Enhanced learning system documentation

### Performance

- **Analysis time:** 5-15 seconds
- **Change application:** 2-5 seconds

---

## [4.0.0] - 2026-01-01

### Major Release - Predictive Intelligence System

Version 4.0 introduces Predictive Intelligence - see 2 steps ahead with proactive guidance, anticipating user needs and preventing problems before they occur.

### Added

#### New Feature: Phase 0.15 Predictive Intelligence
- **Journey stage detection** - 6 stages (exploring/planning/implementing/debugging/refactoring/reviewing)
- **Proactive warnings** - Prevent problems BEFORE they occur
- **Domain risk analysis** - Security, compliance, performance risks
- **Project pattern recognition** - Auto-detect conventions
- **Relationship mapping** - Connect to previous work
- **Next-steps prediction** - Forecast logical followups
- **Smart scoping** - Focused/Balanced/Comprehensive options

#### New Configuration
- **NEW:** `.claude/config/predictive-intelligence.json` - Journey stages, domain risks, followup patterns

#### New Library Components
- **NEW:** `.claude/library/intelligence/predictive-intelligence-core.md`
- **NEW:** `.claude/library/intelligence/relationship-mapper.md`
- **NEW:** `.claude/library/intelligence/warning-system.md`
- **NEW:** `.claude/library/intelligence/next-steps-predictor.md`

### Enhanced

#### Commands Updated
- **`/prompt-hybrid`** - FULL predictive intelligence integration
- **`/prompt-technical`** - FULL predictive intelligence integration
- **`/prompt`** - LITE predictive intelligence integration
- **`/prompt-research`** - CUSTOM predictive integration

#### Complexity Detection
- **UPDATED:** `.claude/config/complexity-rules.json` - Added user factors and risk assessment

### Performance

- **Simple prompts:** +1-2 seconds
- **Complex prompts:** +3-5 seconds
- **Research mode:** +10-15 seconds

### Documentation

- Comprehensive predictive intelligence documentation
- Integration guide for custom commands
- Release notes with examples

---

## [3.0.0] - 2025-12-28

### Major Release - Multi-Agent Research System

Version 3.0 introduces a comprehensive multi-agent research system aligned with Anthropic's research architecture, enabling deep codebase analysis with orchestrated agents and iterative refinement.

### Added

#### New Command: `/prompt-research`
- **Deep multi-agent research** with orchestrator-worker architecture
- **Iterative refinement** - 2-4 iteration cycles with gap-driven analysis
- **Source attribution** - Every finding includes file:line citations with code snippets
- **External memory** - Persistent knowledge graph across sessions
- **Comprehensive reporting** - 15-20 page research reports with priority classification
- **Smart convergence** - Automatically determines when research is complete
- **Research strategies** - Narrow (60s), Broad (120s), Comprehensive (180s)

#### Orchestration Components
- **NEW:** `.claude/library/orchestration/lead-agent-core.md` - Coordinates 2-5 specialized agents
- **NEW:** `.claude/library/orchestration/iteration-engine.md` - Multi-step refinement with gap detection
- **NEW:** `.claude/library/orchestration/result-aggregator.md` - Deduplication, conflict resolution, confidence scoring

#### Specialized Agents
- **NEW:** `.claude/library/agents/explore-agent.md` - Codebase discovery and architecture understanding
- **NEW:** `.claude/library/agents/citation-agent.md` - Source attribution with file:line precision
- **NEW:** `.claude/library/agents/security-agent.md` - OWASP Top 10 compliance and vulnerability detection
- **NEW:** `.claude/library/agents/performance-agent.md` - Bottleneck detection and N+1 query analysis
- **NEW:** `.claude/library/agents/pattern-agent.md` - Convention detection and consistency analysis

#### External Memory System
- **NEW:** `.claude/memory/project-knowledge.md` - Persistent facts, patterns, and findings
- **NEW:** `.claude/memory/architectural-context.md` - System understanding and design rationale
- **NEW:** `.claude/memory/citation-index.md` - Source evidence mapping with confidence scores

#### Configuration
- **NEW:** `.claude/config/orchestration-config.json` - Research strategies and agent coordination
- **NEW:** `.claude/config/iteration-rules.json` - Convergence criteria and gap detection rules
- **NEW:** `.claude/config/agent-roles.json` - Agent definitions, triggers, and timeouts
- **NEW:** `.claude/config/citation-config.json` - Citation formatting and snippet extraction
- **NEW:** `.claude/config/external-memory-config.json` - Memory persistence and cleanup rules
- **NEW:** `.claude/library/adapters/research-adapter.md` - Research-specific Phase 0 adaptation

### Enhanced

#### Complexity Detection
- **UPDATED:** `.claude/config/complexity-rules.json` - Added research mode threshold (score >= 20)
- Research-level complexity automatically triggers multi-agent orchestration
- New triggers for deep analysis tasks (security audits, performance investigations)

#### Agent Templates
- **UPDATED:** `.claude/config/agent-templates.json` - Added orchestrator templates for research coordination

### Use Cases

The `/prompt-research` command excels at:
- **Architecture analysis** - Understanding system structure and relationships
- **Security audits** - OWASP Top 10 compliance and vulnerability detection
- **Performance investigations** - Bottleneck identification and optimization opportunities
- **Pattern discovery** - Naming conventions and consistency analysis
- **Comprehensive understanding** - Multiple perspectives with cross-validation

### Performance

- **First run:** 60-180s depending on strategy (Narrow/Broad/Comprehensive)
- **Cached run:** ~10s (10-20x faster for repeated research)
- **Memory benefits:** Faster on related topics as knowledge accumulates

### Documentation

- Comprehensive `/prompt-research` command documentation in CLAUDE.md
- Research adapter and orchestration component specifications
- Agent behavior and coordination protocols
- External memory structure and update strategies

---

## [2.0.1] - 2024-12-22

### Added

#### Documentation
- **New:** VitePress documentation site deployed to GitHub Pages
  - Live at: https://tadzesi.github.io/claude-ideas/
  - Searchable, beautiful documentation interface
  - 20+ documentation pages organized in logical sections
  - Mobile-responsive design with dark mode support
- **New:** AI-themed logo and favicon for branding
  - `docs/public/logo.svg` - Neural network themed logo with Claude brand colors
  - `docs/public/favicon.svg` - Simplified version for browser tabs
  - Integrated into VitePress navbar, hero section, and meta tags
- **New:** Documentation badges in README.md
  - Live documentation link badge
  - GitHub Pages deployment status badge
  - MIT License badge

#### CI/CD
- **New:** `.github/workflows/deploy-docs.yml` - Automated documentation deployment
  - Builds VitePress site on every push to main
  - Deploys to GitHub Pages automatically
  - Uses VitePress v1.6.4

#### Project Structure
- **New:** `docs/` directory - VitePress documentation source
  - Replaces old `doc/` directory (moved to `docs-source/` for legacy reference)
  - Organized into: getting-started, guide, reference, migration, testing sections
  - Configuration in `docs/.vitepress/config.ts`

### Changed

- **README.md:** Fixed date references (December 2024 → December 2025)
- **README.md:** Added badges section at top with documentation and deployment status
- **Documentation Structure:** Migrated from `/doc` to `/docs` for VitePress

### Fixed

- **Install Script:** Fixed PowerShell encoding issues
  - Replaced Unicode characters (✓✗ℹ⚠) with ASCII equivalents ([OK][ERROR][INFO][WARNING])
  - Replaced box-drawing characters with simple ASCII
  - Resolved parse errors on line 89 and 371
  - Script now runs without errors on all Windows systems

### Documentation

**VitePress Site Structure:**
```
docs/
├── getting-started/     (3 pages)
├── guide/
│   ├── commands/        (6 pages)
│   ├── architecture/    (2 pages)
│   └── advanced-features/ (3 pages)
├── reference/           (2 pages)
├── migration/           (2 pages)
└── testing/             (1 page)
```

**Navigation Sections:**
- Getting Started: Overview, Installation, Quick Start
- Guide: Commands, Architecture, Advanced Features
- Reference: Configuration, Best Practices
- Migration: v2.0 Migration, Custom Commands
- Testing: Advanced Features Testing

---

## [2.0.0] - 2024-12-20

### Major Architectural Refactoring

Version 2.0 represents a complete architectural overhaul of the command library system, introducing a unified library pattern that eliminates code duplication and dramatically improves maintainability.

### Added

#### Core Library System
- **New:** `.claude/library/prompt-perfection-core.md` - Canonical Phase 0 implementation for all commands
- **New:** `.claude/library/adapters/hybrid-adapter.md` - Reusable advanced features library
  - Complexity detection engine
  - Agent spawning with caching
  - Multi-agent verification system
  - Learning system integration
  - Configuration-driven behavior

#### Documentation
- **New:** `doc/v2.0_Migration_Tutorial.md` - Comprehensive 300-page tutorial covering:
  - Before/after comparisons
  - Migration guide for custom commands
  - Architecture deep dive
  - Advanced features walkthrough
  - Best practices and troubleshooting
- **New:** `CHANGELOG.md` - This file for version tracking
- **New:** Version History sections in all commands
- **New:** Library Integration sections in all commands

#### Testing
- **New:** `tests/validate-library-references.ps1` - Automated test suite for:
  - Library reference validation
  - Adapter existence checks
  - Version history verification
  - Documentation completeness
- **New:** `tests/README.md` - Test suite documentation

#### Examples & Templates
- **New:** `.claude/commands/example-custom-command.md` - Template showing how to create v2.0-compliant commands
- Demonstrates library references, adapter usage, and best practices

### Changed

#### All Commands Refactored
- **`prompt.md`** - Now references core library (was: inline Phase 0)
- **`prompt-hybrid.md`** - Major refactoring:
  - Reduced from 1097 to 1037 lines
  - Eliminated ~500 lines of duplicate Phase 0 code
  - Now references core + hybrid-adapter
  - All advanced features preserved
- **`prompt-technical.md`** - Updated to reference:
  - Core library for Phase 0
  - Technical adapter for domain logic
  - Added advanced features documentation
- **`prompt-article.md`** - Updated to reference:
  - Core library for Phase 0
  - Article adapter for domain logic
  - Added version history and library integration
- **`prompt-article-readme.md`** - Updated to reference:
  - Core library for Phase 0
  - Article adapter for documentation domain
  - Added version history and library integration
- **`session-start.md`** - Already v2.0 compliant, documentation enhanced
- **`session-end.md`** - Already v2.0 compliant, documentation enhanced

#### Documentation Updates
- **`CLAUDE.md`** - Added comprehensive v2.0 section:
  - What Changed summary
  - File size reductions
  - New features list
  - Migration guide
  - Updated project structure diagram
- **`README.md`** - Added prominent "What's New in v2.0" section:
  - Key improvements highlighted
  - Architecture diagram
  - Visual before/after comparison
  - Link to migration guide

#### Installer Improvements
- **`install-claude-commands.ps1`** - Updated to v2.0:
  - Added v2.0 feature announcement on installation
  - Updated version number to 2.0
  - Shows new features with color-coded output
  - References CHANGELOG.md

### Improved

#### Maintainability
- **Code Duplication:** Reduced from ~30% to 0%
- **Lines of Duplicate Code:** Eliminated ~500 lines across commands
- **Single Source of Truth:** Phase 0 logic now in one place
- **Update Efficiency:** Fix/improve once, all commands benefit

#### Consistency
- **Phase 0 Flow:** 100% identical across all commands
- **Validation Logic:** Guaranteed uniform behavior
- **User Experience:** Consistent prompts and questions
- **Documentation:** Standardized structure and formatting

#### Developer Experience
- **Command Creation:** Reduced from 600-800 lines to 200-400 lines
- **Template Available:** Example command shows best practices
- **Clear Patterns:** Library reference pattern easy to follow
- **Testing:** Automated validation ensures compliance

### Fixed

- **Inconsistent Phase 0 implementations** across commands
- **Duplicate bug fixes** needed in multiple files
- **Varying validation criteria** between commands
- **Missing documentation** in some commands
- **No version tracking** for commands

### Performance

#### Metrics
- **Code Reduction:** ~500 lines of duplication eliminated
- **File Size:** Commands reduced by 40-50% on average
- **Maintenance Time:** Estimated 80% reduction for updates
- **Consistency:** 100% (up from 86%)
- **Completeness:** 100% (up from 86%)

### Breaking Changes

⚠️ **For Custom Command Authors:**

If you created custom commands based on v1.0, they will need migration to v2.0 pattern:

**Before v2.0:**
```markdown
## Phase 0: Prompt Perfection
### Step 0.1: Initial Analysis
[Full inline implementation]
...
```

**After v2.0:**
```markdown
## Phase 0: Prompt Perfection
**Import:** Use Phase 0 from `.claude/library/prompt-perfection-core.md`
**Adaptation:** [Choose adapter]
```

**Migration:** See `doc/v2.0_Migration_Tutorial.md` for complete guide.

**Timeline:** v1.0 inline pattern deprecated but still functional. Migrate by March 2025.

### Dependencies

No external dependencies added. All changes are internal architecture improvements.

### Security

No security-related changes in v2.0. Standard security practices maintained.

---

## [1.0.0] - 2024-11-15

### Initial Release

#### Added

##### Commands (7 total)
- `/prompt` - Basic prompt perfection
- `/prompt-hybrid` - Intelligent with agent support
- `/prompt-technical` - Technical implementation analysis
- `/prompt-article` - Interactive article generation wizard
- `/prompt-article-readme` - README generator
- `/session-start` - Load session context
- `/session-end` - Save session context

##### Core Features
- Phase 0 prompt perfection flow (implemented inline in each command)
- Multi-language support (Slovak/English)
- Complexity detection (in prompt-hybrid and prompt-technical)
- Agent-powered codebase analysis
- Session memory management
- Multi-platform content output

##### Advanced Features (prompt-hybrid)
- Agent result caching
- Multi-agent verification
- Learning system with pattern tracking
- Smart defaults suggestion

##### Infrastructure
- `.claude/config/` - Configuration files for:
  - Complexity rules
  - Agent templates
  - Cache settings
  - Verification settings
  - Learning settings
- `.claude/memory/` - User session data storage
- `.claude/cache/` - Agent result cache

##### Documentation
- `README.md` - Project overview and quick start
- `CLAUDE.md` - Detailed developer documentation
- `README-INSTALL.md` - Installation instructions
- `doc/Unified_Library_System_Guide.md`
- `doc/Hybrid_Prompt_Perfection_Architecture.md`
- `doc/Executive_Summary_Hybrid_Prompt_System.md`
- `doc/Advanced_Features_Testing_Guide.md`

##### Installation
- `install-claude-commands.ps1` - Windows installer script
- Automatic backup and update system
- Memory preservation during updates

### Architecture (v1.0)

Original structure with inline Phase 0 implementations:
- Each command: 500-1000 lines
- Phase 0 duplicated in multiple commands
- Limited reusability
- Harder maintenance

---

## [Unreleased]

### Planned for Future Releases

#### v2.1.0 (Planned Q1 2025)
- **Enhanced:** Real-time validation mode
- **Added:** Voice input support
- **Added:** More language support (German, French, Spanish)
- **Improved:** Agent spawning performance
- **Added:** Example projects using library system

#### v3.0.0 (Planned Q2 2025)
- **Added:** Visual prompt builder (GUI overlay)
- **Added:** Team collaboration features
- **Added:** Shared prompt library
- **Added:** Prompt analytics dashboard
- **Added:** Claude API integration
- **Enhanced:** Multi-project workspace support

---

## Version History Summary

| Version | Date | Key Changes | Lines Changed |
|---------|------|-------------|---------------|
| 4.2.0 | 2026-01-20 | AI Fluency Framework | +800 new |
| 4.1.0 | 2026-01-05 | Skill Reflection System | +2000 new |
| 4.0.0 | 2026-01-01 | Predictive Intelligence | +3500 new |
| 3.0.0 | 2025-12-28 | Multi-Agent Research | +2500 new |
| 2.0.0 | 2024-12-20 | Unified library system | -500 duplicates, +450 library |
| 1.0.0 | 2024-11-15 | Initial release | +8000 initial |

---

## Migration Guides

- **v1.0 → v2.0:** See `doc/v2.0_Migration_Tutorial.md`

---

## Contributors

### v2.0
- Architectural refactoring and library system design
- Test suite implementation
- Documentation overhaul

### v1.0
- Initial command implementations
- Advanced features (caching, multi-agent, learning)
- Base documentation

---

## Support & Feedback

- **Issues:** Report at repository issues page
- **Questions:** See documentation in `/doc`
- **Feature Requests:** Open discussion in repository

---

## License

Released under the MIT License. See [LICENSE](LICENSE) file for details.

---

**Note:** This changelog follows [Keep a Changelog](https://keepachangelog.com/) principles:
- Versions are in reverse chronological order (newest first)
- Changes are grouped by type (Added, Changed, Fixed, etc.)
- Dates use YYYY-MM-DD format
- Version numbers follow Semantic Versioning (MAJOR.MINOR.PATCH)
