# /new-stack

Scaffolds a new Docker stack following the established pattern: nginx + .NET API + React frontend + stack-internal network. Reads server config from `personal-profile.md` so no values need to be hardcoded.

::: tip New in v4.5
- **Universal config** — reads all server details from `~/.claude/memory/personal-profile.md`
- **Port conflict prevention** — checks `ALLOCATED_PORTS` list to suggest the next free port
- **Complete scaffold** — generates `docker-compose.yml`, `nginx.conf`, `Dockerfile.api`, `.env`, `.gitignore`, `deploy.sh`
:::

## Overview

| Aspect | Details |
|--------|---------|
| **Speed** | ~5 seconds |
| **Version** | v4.5 |
| **Format** | `.claude/skills/new-stack/SKILL.md` |
| **Best For** | Starting a new application to deploy on a Linux home server |
| **Related** | `/deploy` to deploy the stack, `/prompt-dotnet` and `/prompt-react` to implement |

## Prerequisites

Create `~/.claude/memory/personal-profile.md` with your server details:

```bash
SERVER_HOST=your.server.ip
SERVER_USER=your-ssh-username
SERVER_STACKS_PATH=~/path/to/stacks
POSTGRES_STACK=postgres-stack-name
POSTGRES_CONTAINER=postgresql-container-name
FRONTEND_NGINX_CONTAINER=your-nginx-container-name
FRONTEND_NETWORK=your-frontend-network-name
ALLOCATED_PORTS=3000,3001,3002
```

If this file is missing, `/new-stack` stops and shows exactly what to add.

## Usage

```bash
/new-stack             # asks for stack name and components
/new-stack my-app      # stack name provided, asks for components
```

## How It Works

### Step 1 — Load Server Config

Reads `personal-profile.md` for all server details. Uses `ALLOCATED_PORTS` to suggest the next available port automatically.

### Step 2 — Gather Requirements

Asks only what's needed:

1. **Stack name** (if not provided) — lowercase kebab-case, used as directory name, container prefix, nginx alias, subdomain
2. **Components** — .NET API, React frontend (Vite SPA), PostgreSQL, nginx reverse proxy
3. **Access** — public via reverse proxy, local only, or both
4. **Port** — suggests next available based on `ALLOCATED_PORTS`

### Step 3 — Generate Scaffold

Generates all files for the new stack:

**`docker-compose.yml`**
```yaml
services:
  my-app-nginx:
    image: nginx:alpine
    volumes:
      - ./nginx.conf:/etc/nginx/conf.d/default.conf:ro
      - ./frontend:/usr/share/nginx/html:ro
    ports:
      - "3006:80"
    networks:
      - frontend
      - my-app-internal
    depends_on:
      - my-app-api
    restart: unless-stopped

  my-app-api:
    image: my-app-api
    build:
      context: .
      dockerfile: Dockerfile.api
    environment:
      - ASPNETCORE_ENVIRONMENT=Production
      - ConnectionStrings__DefaultConnection=${DB_CONNECTION_STRING}
    networks:
      - my-app-internal
      - postgres-stack-internal
    restart: unless-stopped

networks:
  frontend:
    external: true
  my-app-internal:
    driver: bridge
  postgres-stack-internal:
    external: true
```

**`nginx.conf`** — API proxy + React SPA routing with `try_files` fallback

**`Dockerfile.api`** — uses .NET version detected from `.csproj` (or asks if not found)

**`.env`** — DB connection string template, marked `DO NOT COMMIT`

**`.gitignore`** — excludes `.env`, `publish/`, `frontend/`

**`deploy.sh`** — local deploy script with server details filled in

### Step 4 — Server Setup Commands

After generating files, shows the commands to run on the server:

```bash
# 1. Create stack directory
mkdir -p ~/stacks/my-app/{publish,frontend}

# 2. Copy generated files to server
scp docker-compose.yml nginx.conf Dockerfile.api .env \
  user@server:~/stacks/my-app/

# 3. Create database (if using shared PostgreSQL)
ssh user@server "docker exec postgresql psql -U postgres -c 'CREATE DATABASE my-app;'"

# 4. First deploy
ssh user@server "cd ~/stacks/my-app && docker compose build && docker compose up -d"

# 5. If public access — add location block to frontend nginx config
#    location /my-app/ { proxy_pass http://my-app:80/; }
#    docker exec nginx nginx -s reload
```

## Generated File Structure

```
my-app/
├── docker-compose.yml
├── nginx.conf
├── Dockerfile.api
├── .env                  # DO NOT COMMIT
├── .gitignore
└── deploy.sh
```

## Tips

### Naming Convention

Stack name becomes everything — be consistent:

```
my-app → container: my-app-api, my-app-nginx
       → network: my-app-internal
       → directory: ~/stacks/my-app/
       → subdomain: my-app.yourdomain.com
```

### Port Management

Keep `ALLOCATED_PORTS` in `personal-profile.md` up to date so `/new-stack` always suggests the correct next port.

## Related Commands

- [/deploy](/commands/deploy) — deploy the stack after scaffolding
- [/prompt-dotnet](/commands/prompt-dotnet) — implement the .NET API
- [/prompt-react](/commands/prompt-react) — implement the React frontend
