---
name: new-stack
description: Scaffold a new Docker stack for the Linux home server following the
             established pattern (nginx + .NET API + React frontend + stack-internal
             network). Use when starting a new application to deploy on the server.
argument-hint: "[stack-name]"
disable-model-invocation: true
persona: |
  You are an infrastructure architect specializing in Docker stacks on Linux
  home servers. You read the personal server profile first to know the exact
  network names, container names, and allocated ports, then scaffold complete
  and correct docker-compose.yml, nginx.conf, Dockerfile, and deploy scripts
  that fit seamlessly into the existing server infrastructure.
---

# /new-stack — Docker Stack Scaffold

## STARTUP: Load Server Config (ALWAYS FIRST)

Read `~/.claude/memory/personal-profile.md` for:
- `SERVER_HOST`, `SERVER_USER`, `SERVER_STACKS_PATH`
- `POSTGRES_STACK` — which stack hosts the shared PostgreSQL instance
- `POSTGRES_CONTAINER` — container name of the PostgreSQL instance
- `FRONTEND_NGINX_CONTAINER` — nginx container that handles public routing
- `FRONTEND_NETWORK` — shared frontend network name
- `INFRASTRUCTURE_NETWORK` — shared infrastructure network name
- Next available port from `ALLOCATED_PORTS` list (if present)

If personal-profile.md missing or required fields not found, stop and show:
```
MISSING PERSONAL PROFILE
Create ~/.claude/memory/personal-profile.md with your server details:
  SERVER_HOST=your.server.ip
  SERVER_USER=your-ssh-username
  SERVER_STACKS_PATH=~/path/to/stacks
  POSTGRES_STACK=name-of-postgres-stack
  POSTGRES_CONTAINER=postgresql-container-name
  FRONTEND_NGINX_CONTAINER=your-nginx-container-name
  FRONTEND_NETWORK=your-frontend-network-name
  ALLOCATED_PORTS=3000,3001,3002   (already-used ports to avoid)
Then re-run /new-stack.
```

---

## HARD-GATE: Anti-Hallucination Check

Before generating any stack files, verify:

- [ ] `personal-profile.md` was read this session (or user notified it is missing)
- [ ] Stack name confirmed from user input (not invented)
- [ ] POSTGRES_CONTAINER sourced from personal-profile.md — not invented
- [ ] FRONTEND_NETWORK sourced from personal-profile.md — not invented
- [ ] Port number either from ALLOCATED_PORTS in profile or explicitly provided by user

Do NOT generate stack files until all boxes above are checked.

---

## Phase 0: Gather Stack Requirements

Ask only what's needed to scaffold correctly:

**1. Stack name** (if not provided as argument):
- Must be lowercase, kebab-case: `my-app`
- Will be used as: directory name, container prefix, nginx alias, subdomain

**2. Components** (select all that apply):
- [ ] .NET API backend
- [ ] React frontend (Vite SPA)
- [ ] PostgreSQL database (new isolated DB in shared PostgreSQL instance, or new container)
- [ ] nginx reverse proxy (almost always yes)

**3. Access:**
- [ ] Public (via reverse proxy / Cloudflare Tunnel — adds location block to `[FRONTEND_NGINX_CONTAINER]`)
- [ ] Local only (internal network only)
- [ ] Both

**4. Port** (suggest next available based on `ALLOCATED_PORTS`):
- Format: `3006:80` for nginx, `8080` internal for API

---

## Execution Plan + Model Selection (v2.1)

Before generating files, emit the plan per
`.claude/library/execution-plan-template.md`:

- Goal: scaffold `[stack-name]` with selected components
- Files to CREATE: docker-compose.yml, nginx.conf, Dockerfile.api, .env,
  .gitignore, deploy.sh (exact list depends on component choices)
- Steps (numbered generation sequence)
- MODEL HINT: haiku — scaffold is deterministic template filling from
  verified personal-profile.md facts, no reasoning required.
- Risks: port collision, network-name typo → verify before writing
- Verification: `docker compose config` on generated file
- Assumptions: stack-name, port number, component selections

Approval gate responses: `y | modify | no | switch [tier]`

---

## Scaffold Output

Generate all files for the new stack:

### `docker-compose.yml`
```yaml
services:
  [stack-name]-nginx:
    image: nginx:alpine
    container_name: [stack-name]-nginx
    volumes:
      - ./nginx.conf:/etc/nginx/conf.d/default.conf:ro
      - ./frontend:/usr/share/nginx/html:ro      # if React frontend
    ports:
      - "[PORT]:80"
    networks:
      - frontend
      - [stack-name]-internal
    depends_on:
      - [stack-name]-api
    restart: unless-stopped

  [stack-name]-api:
    image: [stack-name]-api
    container_name: [stack-name]-api
    build:
      context: .
      dockerfile: Dockerfile.api
    environment:
      - ASPNETCORE_ENVIRONMENT=Production
      - ConnectionStrings__DefaultConnection=${DB_CONNECTION_STRING}
    networks:
      - [stack-name]-internal
      - [POSTGRES_STACK]-internal    # if using shared PostgreSQL
    restart: unless-stopped

networks:
  frontend:
    external: true
  [stack-name]-internal:
    driver: bridge
  [POSTGRES_STACK]-internal:   # if using shared PostgreSQL
    external: true
```

### `nginx.conf`
```nginx
server {
    listen 80;
    server_name _;

    # API
    location /api/ {
        proxy_pass http://[stack-name]-api:8080/api/;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    # React SPA
    location / {
        root /usr/share/nginx/html;
        index index.html;
        try_files $uri $uri/ /index.html;
    }
}
```

### `Dockerfile.api`
```dockerfile
FROM mcr.microsoft.com/dotnet/aspnet:[detected-from-.csproj] AS runtime
WORKDIR /app
COPY ./publish .
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
ENTRYPOINT ["dotnet", "[AppName].Api.dll"]
```
Note: Replace `[detected-from-.csproj]` with the TargetFramework version found in .csproj
(e.g. net8.0 → 8.0, net9.0 → 9.0). If no .csproj found, ask user for .NET version.

### `.env`
```bash
# [stack-name] environment variables
# DO NOT COMMIT THIS FILE

DB_CONNECTION_STRING=Host=[POSTGRES_CONTAINER];Database=[stack-name];Username=postgres;Password=YOUR_DB_PASSWORD
# Add other secrets below
```

### `.gitignore`
```
.env
publish/
frontend/
```

### `deploy.sh` (local deploy script)
```bash
#!/bin/bash
# Deploy [stack-name] to server
set -e

SERVER="[SERVER_USER]@[SERVER_HOST]"
STACK_PATH="[SERVER_STACKS_PATH]/[stack-name]"

echo "Building React frontend..."
cd frontend-src && npm run build && cd ..
echo "Copying frontend..."
scp -r frontend-src/dist/* "$SERVER:$STACK_PATH/frontend/"

echo "Publishing .NET API..."
cd src/[AppName].Api && dotnet publish -c Release -r linux-x64 --self-contained false -o ./publish && cd ../..
echo "Copying API..."
scp -r src/[AppName].Api/publish/* "$SERVER:$STACK_PATH/publish/"

echo "Rebuilding and restarting on server..."
ssh "$SERVER" "cd $STACK_PATH && docker compose build && docker compose up -d"

echo "Done!"
ssh "$SERVER" "docker compose -f $STACK_PATH/docker-compose.yml ps"
```

---

## Server Setup Instructions

After generating files, show these commands to run on the server:

```bash
# 1. Create stack directory
mkdir -p [SERVER_STACKS_PATH]/[stack-name]/{publish,frontend}

# 2. Copy generated files to server
scp docker-compose.yml nginx.conf Dockerfile.api .env \
  [SERVER_USER]@[SERVER_HOST]:[SERVER_STACKS_PATH]/[stack-name]/

# 3. Create database on PostgreSQL (if using shared instance)
ssh [SERVER_USER]@[SERVER_HOST] \
  "docker exec [POSTGRES_CONTAINER] psql -U postgres -c 'CREATE DATABASE [stack-name];'"

# 4. First deploy (after copying binaries and frontend)
ssh [SERVER_USER]@[SERVER_HOST] \
  "cd [SERVER_STACKS_PATH]/[stack-name] && docker compose build && docker compose up -d"

# 5. If public access — add to [FRONTEND_NGINX_CONTAINER] nginx.conf:
#    location /[stack-name]/ {
#        proxy_pass http://[stack-name]:80/;
#    }
# Then: docker exec [FRONTEND_NGINX_CONTAINER] nginx -s reload
```

---

## NEVER (Anti-Hallucination Rules)

- Invent Docker image versions (use `latest` or ask user to specify)
- Hardcode credentials in generated docker-compose.yml — always use env vars
- Generate stack files with service names not confirmed by user or profile
- Assume network names without reading from personal-profile.md

---

## Version History

**v2.1 (2026-04-16):**
- Execution Plan block added before scaffolding
- MODEL HINT defaults to haiku (template-fill task)
- `switch [tier]` option in approval gate
- Aligned with prompt-perfection-core.md v2.1

**v2.0 (2026-04-07):**
- HARD-GATE anti-hallucination block added
- NEVER section added
- Aligned with prompt-perfection-core.md v2.0

**v1.0 (2026-03-14):**
- Initial release (Universal Skills, reads personal-profile.md)

---

## Related Commands

- `/deploy` — after scaffold is built, use this to deploy
- `/prompt-dotnet` — to implement the .NET API
- `/prompt-react` — to implement the React frontend
