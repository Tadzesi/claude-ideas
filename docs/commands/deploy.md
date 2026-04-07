# /deploy

Project-aware deployment workflow. Scans your project to detect components, reads server config from `personal-profile.md`, and generates the complete deploy command sequence.

::: tip Updated in v4.6
- **HARD-GATE** — verifies `personal-profile.md` was read and all server values sourced before generating any commands
- **Universal config** — reads server details from `~/.claude/memory/personal-profile.md`, no hardcoded values
- **Auto-detection** — detects .NET API, React frontend, Docker stack from project files
- **Safer defaults** — confirms before executing, generates copyable script by default
:::

## Overview

| Aspect | Details |
|--------|---------|
| **Speed** | Interactive |
| **Version** | v2.0 |
| **Format** | `.claude/skills/deploy/SKILL.md` |
| **Best For** | Deploying .NET + React + Docker stacks to a Linux server |
| **Related** | `/new-stack` to scaffold, `/prompt-dotnet` and `/prompt-react` to implement |

## Prerequisites

Create `~/.claude/memory/personal-profile.md` with your server details:

```bash
SERVER_HOST=your.server.ip
SERVER_USER=your-ssh-username
SERVER_STACKS_PATH=~/path/to/stacks
```

If this file is missing or incomplete, `/deploy` stops and shows exactly what to add.

## Usage

```bash
/deploy                    # auto-detects stack from current directory
/deploy my-app             # specify stack name explicitly
```

## How It Works

### Step 1 — Load Server Config

Reads `~/.claude/memory/personal-profile.md` for `SERVER_HOST`, `SERVER_USER`, `SERVER_STACKS_PATH`. Stops with a clear error if any are missing.

### Step 2 — Scan Project

Detects what needs to be built and deployed:

| File checked | What it detects |
|---|---|
| `docker-compose.yml` | stack name, services |
| `.csproj` | .NET API present, runtime target |
| `package.json` | React frontend, build script |
| `Dockerfile` / `Dockerfile.api` | runtime image, published path |
| `nginx.conf` | routing structure |
| `project-profile.md` | stack name override, deploy notes |

Output after scan:

```
DEPLOY SCAN COMPLETE
Stack: my-app
Server: user@192.168.1.100
Remote path: ~/stacks/my-app/

Components to deploy:
  [✓] .NET API — dotnet publish -r linux-x64 → ./publish
  [✓] React frontend — npm run build → dist/
  [ ] nginx config — unchanged
```

### Step 3 — Pre-deploy Checks

Before generating commands, verifies:

- **Git status** — warns if uncommitted changes
- **.NET build** — `dotnet build` passes?
- **React build** — TypeScript errors?
- **Env vars** — `.env` exists with required keys?
- **DB migrations** — if EF Core detected, flags explicitly

Stops on issues and asks you to resolve before proceeding.

### Step 4 — Generate Deploy Commands

Generates a complete bash script adapted to what was detected:

```bash
# ═══════════════════════════════════════════════
# DEPLOY: my-app → user@192.168.1.100
# ═══════════════════════════════════════════════

# 1. Build React frontend
cd frontend-src && npm run build

# 2. Upload frontend
scp -r dist/* user@192.168.1.100:~/stacks/my-app/frontend/

# 3. Publish .NET API
cd src/MyApp.Api && dotnet publish -c Release -r linux-x64 --self-contained false -o ./publish

# 4. Upload API binaries
scp -r ./publish/* user@192.168.1.100:~/stacks/my-app/publish/

# 5. Rebuild and restart on server
ssh user@192.168.1.100 "cd ~/stacks/my-app && docker compose build && docker compose up -d"

# 6. Verify containers
ssh user@192.168.1.100 "docker compose -f ~/stacks/my-app/docker-compose.yml ps"
```

**Adapts automatically:**
- Only React (no .NET) → skips API steps
- Only .NET (no React) → skips frontend steps
- DB migrations present → adds `dotnet ef database update` step
- Static files volume-mounted → skips Docker build, just `nginx -s reload`

### Step 5 — Execute or Copy

Default: outputs a copyable script. Options:

```
copy   — show full script to paste (DEFAULT)
run    — execute each step sequentially, stop on error
script — save as deploy.sh in project root
```

Does NOT execute automatically without explicit `run` confirmation.

## Deploy Scenarios

### Static files only (volume-mounted nginx)

```bash
ssh user@server "docker exec nginx-container nginx -s reload"
```

### Pre-compiled binaries only (no SDK on server)

```bash
dotnet publish -c Release -r linux-x64 --self-contained false -o ./publish
scp -r ./publish/* user@server:~/stacks/my-app/publish/
ssh user@server "cd ~/stacks/my-app && docker compose build api && docker compose up -d api"
```

### Cloudflare cache bust after deploy

If `CF_API_TOKEN` and `CF_ZONE_ID` are in `personal-profile.md`, adds cache purge step automatically.

## Related Commands

- [/new-stack](/commands/new-stack) — scaffold a new stack before deploying
- [/prompt-dotnet](/commands/prompt-dotnet) — implement the .NET API
- [/prompt-react](/commands/prompt-react) — implement the React frontend
