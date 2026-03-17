# Changelog

All notable changes to the Claude Commands Library.

## [4.5.0] - March 2026

### Removed

- **`/session-start` and `/session-end`** — deleted (both skills and old commands/ format)
  - Replaced by Claude Code's built-in auto-memory system (`~/.claude/projects/.../memory/`)
  - Auto-memory loads context into every conversation automatically without a command
  - `session-adapter.md` library file also removed (orphaned after deletion)

### Changed

- **Universal skills** — all project-specific hardcoded values removed from all skills
  - `/deploy` and `/new-stack`: removed `lab463-web`, `linkvault-internal`, `postgresql-db` hardcodes
  - All server config now read dynamically from `~/.claude/memory/personal-profile.md`
  - `personal-profile.md` now requires: `POSTGRES_CONTAINER`, `FRONTEND_NGINX_CONTAINER`
  - `/new-stack` Docker network references use `[POSTGRES_STACK]-internal` (dynamic)
  - `/new-stack` Dockerfile .NET version now detected from `.csproj` TargetFramework
  - `/prompt-hybrid` context display: reads from `project-profile.md`, no hardcoded project facts
  - `/prompt-hybrid` threshold corrected: Very High is 20+ (was 15+, mismatched CLAUDE.md)
  - `/prompt-dotnet` best practices header: version-agnostic (was ".NET 10")
  - `/prompt-dotnet` Quick Reference: version-agnostic (was ".NET 10 Quick Reference")

- **`/deploy`**: safer defaults
  - Default output is now `copy` (show script) — was ambiguous between copy and execute
  - Explicit guard: commands are NOT auto-executed without `run` confirmation
  - DB migrations detection added to Phase 1 pre-deploy checks (was a footnote)

- **`/reflect`**: scope and quality limits
  - Steps 2+3 merged (removed duplication)
  - Max 5 observations per session
  - Priority field added to each observation
  - Grouped approval (HIGH/MEDIUM) replaces per-item yes/no loop

### Fixed

- **`/prompt-dotnet`**: scan fallback when `.csproj` not found (3 options presented to user)
- **`/prompt-react`**: scan fallback when `package.json` not found; monorepo support
  (searches `frontend/`, `client/`, `web/`, `app/` subdirectories before failing)
- **`/session-start`**: removed hardcoded version `v4.2.0` and hardcoded stack info
- **`/session-end`**: context limit warning added; sessions.md trimmed to max 10 entries;
  pattern detection scoped to current session only (no cross-session inference)
- **Installer**: removed "private repository" error message (repo is public)
- **CLAUDE.md**: commands table updated — removed session commands, added `/deploy` and `/new-stack`

### Upgrade Guide (4.4 → 4.5)

`/session-start` and `/session-end` no longer exist. If you relied on them:
- Context is now auto-loaded via Claude Code's built-in memory system
- Historical `sessions.md` data is preserved (not deleted by installer)

```powershell
.\install-claude-commands.ps1
```

---

## [4.4.0] - March 2026

### Added

- **`/prompt-dotnet`** - .NET project-aware prompt perfection skill
  - Scans `.csproj`, `Program.cs`, `appsettings.json`, `Dockerfile`, `docker-compose.yml`
  - Auto-detects: TargetFramework, architecture (Minimal API vs Controllers), auth, ORM, DB, Docker
  - Applies .NET 10 best practices automatically based on detected stack (EF Core, PostgreSQL, JWT, CORS)
  - Presents recommendations consistent with existing project patterns
  - Related commands: `/prompt-react`, `/deploy`

- **`/prompt-react`** - React project-aware prompt perfection skill
  - Scans `package.json`, `vite.config.ts`, `tsconfig.json`, `src/` structure, `.env`
  - Auto-detects: React version, TypeScript strict mode, router, state management, data fetching, base path
  - Applies React best practices automatically (hooks, TS types, TanStack Query, Vite env vars, SPA subpath)
  - Presents recommendations consistent with existing project patterns
  - Related commands: `/prompt-dotnet`, `/deploy`

### Fixed

- **Installer critical bug** - `skills/` directory was listed in `$obsoleteDirs` and was deleted on every update
  - `skills/` removed from `$obsoleteDirs`, added to `$directoriesToDeploy`
  - All skills (prompt-dotnet, prompt-react, deploy, new-stack, etc.) now survive updates

### Upgrade Guide (4.3 → 4.4)

No breaking changes. Two new skills added.

```powershell
.\install-claude-commands.ps1
```

---

## [4.3.0] - March 2026

### Added

- **Skills Format** - Commands migrated to new `.claude/skills/` format
  - YAML frontmatter: `name`, `description`, `disable-model-invocation`, `argument-hint`
  - `description` field enables Claude to auto-invoke skills when contextually relevant
  - `disable-model-invocation: true` on workflow commands (session-start, session-end, reflect)
  - New skills: `prompt/SKILL.md`, `prompt-hybrid/SKILL.md`, `session-start/SKILL.md`,
    `session-end/SKILL.md`, `reflect/SKILL.md`
  - Old `.claude/commands/` files still work unchanged (backward compatible)

- **STARTUP Section in all prompt skills** - Project context loaded before any analysis
  - Reads `project-profile.md`, `sessions.md`, `prompt-patterns.md` on every invocation
  - Shows "CONTEXT LOADED" summary so user sees what is pre-filled
  - Eliminates repeated context questions across sessions

- **project-profile.md v2.0** - Populated with real project data
  - Previously contained only empty section headers
  - Now includes: project identity, full tech stack, infrastructure, project structure,
    command list, architecture overview, user preferences, workflows, known gotchas
  - All Phase 0 commands immediately benefit via Step 0.2a Memory Recall

- **Auto Memory** (`~/.claude/projects/.../memory/MEMORY.md`)
  - Created MEMORY.md with project key facts for new session bootstrapping
  - Follows Claude Code native auto-memory format (first 200 lines loaded per session)

### Changed

- **prompt-perfection-core.md → v1.6**
  - Step 0.2a renamed to "ALWAYS LOAD FIRST" with stronger emphasis
  - Now reads three memory sources: project-profile.md + sessions.md + prompt-patterns.md
  - Shows "CONTEXT LOADED" brief summary on every invocation
  - Backward compatible: still works without any memory files

- **CLAUDE.md** - Memory Recall section updated
  - References now-populated project-profile.md v2.0
  - Lists all three memory files to check before asking questions
  - Documents `.claude/skills/` as new preferred format

- **session-end skill** - Now includes check for project-profile.md updates
  - After each session, checks if new permanent facts should be added to profile
  - Ensures project-profile.md stays current with project evolution

### Improved

- Commands no longer ask for project context the user has already provided
- Skills with `description` field are suggested by Claude when contextually relevant
- Session continuity improved through richer memory loading at startup

### Upgrade Guide (4.2 → 4.3)

No breaking changes. New `.claude/skills/` directory works alongside existing `.claude/commands/`.

```powershell
# Optional: re-run installer to get latest files
.\install-claude-commands.ps1
```

---

## [4.2.0] - February 2026

### Added

- **Memory Recall System**
  - New `.claude/memory/project-profile.md` structured fact store
  - Phase 0 Step 0.2a reads profile before completeness check
  - Pre-fills known facts with "(from project profile)" attribution
  - Step 0.3 skips questions already answered by profile
  - First-use opt-in prompt for profile creation

- **Profile Extraction in `/session-end`** (v3.0)
  - New Step 1.5 extracts structured facts from session
  - Categories: Infrastructure, Tech Stack, Deployment, Project Structure, User Preferences, Workflows
  - Merges without duplicating existing facts
  - Shows extraction summary

- **Memory Recall in CLAUDE.md**
  - Root CLAUDE.md instructs Claude to check profile for all interactions
  - Works outside slash commands too

### Changed

- `project-knowledge.md` slimmed from 440 to ~40 lines (headers only, grows on use)
- `architectural-context.md` slimmed from 653 to ~45 lines (headers only, grows on use)
- Installer (v4.2.0) now deploys new memory files on update without overwriting existing ones
- Installer deploys all memory templates on fresh install

### Improved

- All Phase 0 commands gain memory recall automatically (no individual command changes needed)
- Fewer repeat questions across sessions

---

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
| 4.4 | Mar 2026 | .NET + React Project-Aware Skills |
| 4.3 | Mar 2026 | Skills Format + Project-Aware Commands |
| 4.2 | Feb 2026 | Memory Recall System |
| 4.1 | Jan 2026 | Skill Reflection System |
| 4.0 | Jan 2026 | Predictive Intelligence |
| 3.0 | Dec 2025 | Multi-Agent Research |
| 2.0 | Nov 2025 | Hybrid Intelligence |
| 1.0 | Oct 2025 | Initial Release |

---

## Upgrade Guide

### From 4.1 to 4.2

1. Re-run installer:
   ```powershell
   .\install-claude-commands.ps1
   ```

2. The installer automatically adds new `project-profile.md` to your memory directory

3. All existing commands work unchanged - memory recall activates on first use

### From 3.x to 4.x

1. Update library files:
   ```powershell
   .\install-claude-commands.ps1
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
- v1.0 commands work in v4.2
- Configuration is additive (new files, not breaking changes)
- Memory files persist across upgrades
- Project profile is opt-in (commands work without it)

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

