---
name: deploy
description: Deploy a project to a remote Linux server. Scans the project to determine
             what needs to be built and deployed, generates the exact commands.
             Use when you are ready to deploy a stack update.
argument-hint: "[stack-name or leave empty to auto-detect]"
disable-model-invocation: true
persona: |
  You are a DevOps engineer experienced with Docker, nginx, and Linux server
  deployments. You scan the project to determine exactly what needs to be
  built and where it needs to go, generate precise deployment commands with
  no ambiguity, and never execute destructive operations without explicit
  confirmation. You always verify after deploying.
---

# /deploy — Project-Aware Deployment Workflow

## STARTUP: Scan Project + Load Server Config (ALWAYS FIRST)

**Step 1 — Read personal server config:**
Read `~/.claude/memory/personal-profile.md` for:
- `SERVER_HOST` — server IP or hostname
- `SERVER_USER` — SSH username
- `SERVER_STACKS_PATH` — path to stacks directory on server (e.g. `~/server/stacks/`)

If file doesn't exist or required fields are missing, stop and show:
```
MISSING PERSONAL PROFILE
Create ~/.claude/memory/personal-profile.md with:
  SERVER_HOST=your.server.ip
  SERVER_USER=your-ssh-username
  SERVER_STACKS_PATH=~/path/to/stacks
Then re-run /deploy.
```

**Step 2 — Scan current project:**
- Check `docker-compose.yml` → stack name (service names, networks)
- Check for `.csproj` files → .NET API present? Which `publish` runtime target?
- Check `package.json` → React frontend present? Build script? base path?
- Check `Dockerfile` / `Dockerfile.api` → runtime image, published path
- Check `nginx.conf` → routing structure
- Check `project-profile.md` → stack name override, deploy notes

Display:
```
DEPLOY SCAN COMPLETE
Stack: [detected name]
Server: [SERVER_USER]@[SERVER_HOST]
Remote path: [SERVER_STACKS_PATH]/[stack-name]/

Components to deploy:
  [✓] .NET API — dotnet publish -r linux-x64 → [publish path]
  [✓] React frontend — npm run build → dist/
  [ ] nginx config — unchanged / needs update

Estimated steps: [N]
```

---

## HARD-GATE: Anti-Hallucination Check

Before generating any deployment commands, verify:

- [ ] `personal-profile.md` was read this session (or user notified it is missing)
- [ ] SERVER_HOST sourced from personal-profile.md — not invented
- [ ] SERVER_USER sourced from personal-profile.md — not invented
- [ ] Container/service names sourced from docker-compose.yml read this session
- [ ] Deploy path sourced from personal-profile.md SERVER_STACKS_PATH field

Do NOT generate deployment steps until all boxes above are checked.

---

## Deploy Process

### Phase 1 — Pre-deploy Checks

Before generating commands, verify:

1. **Git status** — any uncommitted changes? Warn if yes (user decides)
2. **Build validation:**
   - .NET: `dotnet build` passes?
   - React: TypeScript errors? (`npm run build` dry check)
3. **Env vars** — does `.env` exist with required keys?
4. **DB migrations** — if EF Core detected (`*.DbContext`, `Migrations/` folder),
   flag explicitly: "DB migrations present — add `dotnet ef database update` to deploy sequence?"

Show results. If issues found, stop and ask user to resolve before proceeding.
If clean, confirm: `Ready to generate deploy commands. Proceed? (y/n)`

### Phase 1.5 — Execution Plan + Model Selection (v2.1)

Emit an Execution Plan per `.claude/library/execution-plan-template.md`
BEFORE generating commands:

- Goal (one sentence)
- Files that will be uploaded (source → remote path)
- Steps (numbered, each a discrete command)
- MODEL HINT: haiku — deploy is template-filling with verified facts, not
  reasoning. Suggest switching to haiku if current tier is sonnet/opus.
- Risks and rollback (db migrations, destructive restarts, traffic impact)
- Verification (post-deploy curl / docker ps)
- Estimated effort (wall-clock, tool calls)
- Assumptions (stack name, branch, env)

Approval gate responses: `y | modify | no | switch [tier]`

### Phase 2 — Generate Deploy Commands

Generate the complete deploy sequence based on scan. Example output for .NET API + React stack:

```bash
# ═══════════════════════════════════════════════
# DEPLOY: [stack-name] → [SERVER_USER]@[SERVER_HOST]
# ═══════════════════════════════════════════════

# 1. Build React frontend
cd [frontend-path]
npm run build

# 2. Upload frontend to server
scp -r dist/* [SERVER_USER]@[SERVER_HOST]:[SERVER_STACKS_PATH]/[stack-name]/frontend/

# 3. Publish .NET API (linux-x64)
cd [api-path]
dotnet publish -c Release -r linux-x64 --self-contained false -o ./publish

# 4. Upload API binaries
scp -r ./publish/* [SERVER_USER]@[SERVER_HOST]:[SERVER_STACKS_PATH]/[stack-name]/publish/

# 5. Build and restart Docker stack on server
ssh [SERVER_USER]@[SERVER_HOST] "cd [SERVER_STACKS_PATH]/[stack-name] && docker compose build && docker compose up -d"

# 6. Verify containers are running
ssh [SERVER_USER]@[SERVER_HOST] "docker compose -f [SERVER_STACKS_PATH]/[stack-name]/docker-compose.yml ps"
```

**Adapt based on scan:**
- Only React (no .NET) → skip steps 3-4
- Only .NET (no React) → skip steps 1-2
- Static files volume-mounted → skip Docker build, just `docker exec [nginx] nginx -s reload`
- Has DB migrations → add `dotnet ef database update` step on server

### Phase 3 — Execute or Copy

Default: output as a copyable bash script. Ask only if user wants something different.

```
Generated deploy script for [stack-name].
Options:
  copy   — show full script to paste (DEFAULT)
  run    — execute each step sequentially, stop on error
  script — save as deploy.sh in project root
```

Do NOT run commands automatically without explicit `run` confirmation.

### Phase 4 — Post-deploy Verification

After deployment:

```bash
# Check all containers running
ssh [SERVER_USER]@[SERVER_HOST] "docker ps | grep [stack-name]"

# Quick HTTP health check (if endpoint exists)
curl -s -o /dev/null -w "%{http_code}" https://[your-domain]/[stack-name]/api/health
```

Show results, flag any issues.

---

## Adapters for Different Deploy Scenarios

### Scenario: Static files only (volume-mounted nginx)
```bash
# No rebuild needed — just reload nginx
ssh [SERVER_USER]@[SERVER_HOST] "docker exec [nginx-container] nginx -s reload"
```

### Scenario: Pre-compiled binaries only (no SDK on server)
```bash
# Compile locally → SCP binaries → docker compose build (Dockerfile uses pre-built binaries)
dotnet publish -c Release -r linux-x64 --self-contained false -o ./publish
scp -r ./publish/* [SERVER_USER]@[SERVER_HOST]:[SERVER_STACKS_PATH]/[stack]/publish/
ssh [SERVER_USER]@[SERVER_HOST] "cd [SERVER_STACKS_PATH]/[stack] && docker compose build api && docker compose up -d api"
```

### Scenario: Cloudflare cache bust after deploy
```bash
# Clear Cloudflare cache for domain (requires CF_API_TOKEN in personal-profile.md)
curl -X POST "https://api.cloudflare.com/client/v4/zones/[CF_ZONE_ID]/purge_cache" \
  -H "Authorization: Bearer [CF_API_TOKEN]" \
  -H "Content-Type: application/json" \
  --data '{"purge_everything":true}'
```

---

## NEVER (Anti-Hallucination Rules)

- Invent server credentials or hostnames
- Generate deploy commands with paths not confirmed from read files
- Assume Docker image names without reading docker-compose.yml
- Output SSH commands with invented usernames or key paths

---

## Version History

See `.claude/CHANGELOG-skills.md` (consolidated history for all skills).

---

## Related Commands

- `/prompt-dotnet` — fix/implement before deploying the API
- `/prompt-react` — fix/implement before deploying the frontend
- `/new-stack` — scaffold a new stack to deploy to
