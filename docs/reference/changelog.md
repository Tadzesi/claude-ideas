# Changelog

All notable changes to the Claude Commands Library.

## [4.1.0] - January 2026

### Added

- **AI Fluency Framework Integration** (Anthropic's 4Ds Model)
  - **Delegation Assessment** - Explicit human vs AI task distribution
    - Problem Awareness (goal clarity, scope definition, success criteria)
    - Platform Awareness (AI capabilities matching)
    - Task Delegation (autonomous, review, collaborative, human-only modes)
  - **Interaction Mode Detection** - Automation, Augmentation, or Agency modes
  - **Performance Description** - AI behavior preferences (concise/detailed, formal/casual)
  - **Discernment Hints** - Product, Process, and Performance evaluation criteria
  - **Diligence Summary** - Track AI-generated content requiring verification
  - New configuration: `.claude/config/ai-fluency.json`

- **Skill Reflection System** (`/reflect`)
  - Analyze conversations and propose skill improvements
  - Signal detection: corrections, successes, edge cases, preferences
  - Priority-coded change proposals (HIGH/MED/LOW)
  - Direct skill file modifications with user approval
  - Observation persistence for later review
  - Integration with learning system

### Improved

- Phase 0 completeness check expanded from 6 to 9 criteria
- Learning system now tracks reflection signals
- Better integration between commands
- `/session-end` now includes Diligence Summary section

---

## [4.0.0] - January 2026

### Added

- **Predictive Intelligence** (Phase 0.15)
  - Journey stage detection (6 stages)
  - Proactive domain warnings
  - Pattern recognition
  - Relationship mapping to previous work
  - Next-steps prediction with scope options
  - Smart scoping (Focused/Balanced/Comprehensive)

- **Configuration files**
  - `predictive-intelligence.json` for Phase 0.15
  - Enhanced `learning-config.json`

### Changed

- `/prompt` now includes LITE predictive intelligence
- `/prompt-hybrid` includes FULL predictive intelligence
- Improved complexity detection accuracy

### Documentation

- VitePress documentation site launched
- Comprehensive architecture documentation
- Full configuration reference

---

## [3.0.0] - December 2025

### Added

- **Multi-Agent Research System** (`/prompt-research`)
  - 2-5 specialized agents working in parallel
  - 2-4 iteration cycles with gap-driven refinement
  - Lead agent orchestration
  - Consensus analysis and conflict resolution

- **External Memory**
  - Persistent knowledge graph
  - Research history tracking
  - Cross-session relationship mapping

- **New Configuration Files**
  - `orchestration-config.json` - Research strategies
  - `iteration-rules.json` - Convergence criteria
  - `agent-roles.json` - Agent definitions
  - `citation-config.json` - Citation formatting
  - `external-memory-config.json` - Memory persistence

### Changed

- Agent result caching now includes iteration checkpoints
- Learning system tracks agent effectiveness
- Improved multi-agent verification

---

## [2.0.0] - November 2025

### Added

- **Hybrid Intelligence System**
  - Automatic complexity detection
  - Intelligent agent spawning
  - Configurable thresholds

- **Agent Types**
  - Explore Agent (Haiku, 30s)
  - Plan Agent (Sonnet, 60s)
  - Security Agent (Sonnet, 45s)
  - Performance Agent (Sonnet, 45s)
  - Pattern Agent (Haiku, 30s)

- **Caching System**
  - Content-based cache keys
  - Automatic invalidation
  - 10-20x speedup on cache hits

- **Learning System**
  - Pattern tracking
  - User preference detection
  - Smart defaults after 3+ occurrences

- **Multi-Agent Verification**
  - 2-3 agents parallel verification
  - Consensus analysis
  - Conflict detection

- **Configuration Files**
  - `complexity-rules.json`
  - `agent-templates.json`
  - `cache-config.json`
  - `verification-config.json`
  - `learning-config.json`

### Changed

- All commands now use library system
- `/prompt-hybrid` replaces manual complexity selection
- `/prompt-technical` auto-spawns agents for complex tasks

---

## [1.0.0] - October 2025

### Added

- **Core Commands**
  - `/prompt` - Basic prompt perfection
  - `/prompt-technical` - Technical implementation focus
  - `/prompt-article` - Article writing wizard
  - `/prompt-article-readme` - README generator
  - `/session-start` - Load session context
  - `/session-end` - Save session context

- **Library Architecture**
  - `prompt-perfection-core.md` - Canonical Phase 0
  - Adapter system for domain customization
  - Centralized library for consistency

- **Phase 0 System**
  - 6-step prompt perfection flow
  - Completeness check (6 criteria)
  - Clarification questions
  - Approval gate

- **Session Management**
  - Session persistence in `.claude/memory/`
  - Context aggregation
  - Cross-session continuity

---

## Version History Summary

| Version | Date | Highlight |
|---------|------|-----------|
| 4.1 | Jan 2026 | Skill Reflection System |
| 4.0 | Jan 2026 | Predictive Intelligence |
| 3.0 | Dec 2025 | Multi-Agent Research |
| 2.0 | Nov 2025 | Hybrid Intelligence |
| 1.0 | Oct 2025 | Initial Release |

---

## Upgrade Guide

### From 3.x to 4.x

1. Update library files:
   ```powershell
   .\install-claude-commands.ps1 -Update
   ```

2. Add new config file:
   - Copy `predictive-intelligence.json` to `.claude/config/`

3. Existing commands work unchanged

### From 2.x to 3.x

1. Re-run installer:
   ```powershell
   .\install-claude-commands.ps1
   ```

2. Add new config files:
   - `orchestration-config.json`
   - `iteration-rules.json`
   - `agent-roles.json`
   - `citation-config.json`
   - `external-memory-config.json`

3. Create memory directories:
   ```powershell
   New-Item -ItemType Directory -Path .claude/memory -Force
   ```

### From 1.x to 2.x

1. Back up memory files:
   ```powershell
   Copy-Item .claude/memory/* ./memory-backup/
   ```

2. Re-run installer:
   ```powershell
   .\install-claude-commands.ps1
   ```

3. Add configuration files from defaults

4. Restore memory:
   ```powershell
   Copy-Item ./memory-backup/* .claude/memory/
   ```

---

## Backward Compatibility

All versions maintain backward compatibility:
- v1.0 commands work in v4.1
- Configuration is additive (new files, not breaking changes)
- Memory files persist across upgrades

## Deprecation Notices

### Planned for v5.0

- None currently planned

### Removed in v4.0

- None (all features maintained)

---

## Related

- [Installation](/getting-started/installation) - Latest install instructions
- [Configuration](/reference/configuration) - All config options
- [Troubleshooting](/reference/troubleshooting) - Common issues

