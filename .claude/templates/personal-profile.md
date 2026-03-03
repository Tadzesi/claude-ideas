# Personal Profile
# Stored in ~/.claude/memory/personal-profile.md (NOT in any project repo)
# This file contains server credentials and personal config — keep PRIVATE.
#
# Recovery: Store this file in a private GitHub repo (e.g. github.com/YOU/claude-personal)
# New PC restore: git clone your private repo → copy this file to ~/.claude/memory/

---

## Server Access

SERVER_HOST=192.168.1.X
SERVER_USER=your_username
SERVER_STACKS_PATH=~/server/stacks

# SSH key path (if non-default)
# SSH_KEY=~/.ssh/id_ed25519

---

## Server Infrastructure

OS=Ubuntu 24.04 LTS
DOCKER_VERSION=25.0.x
COMPOSE_VERSION=v2.x

# Shared networks (external, created with docker network create)
FRONTEND_NETWORK=frontend
INFRASTRUCTURE_NETWORK=infrastructure
IOT_NETWORK=iot

# Shared PostgreSQL instance (stack that hosts the shared DB)
POSTGRES_STACK=linkvault
POSTGRES_CONTAINER=postgresql-db
POSTGRES_USER=postgres

---

## Allocated Ports

# Format: PORT=STACK_NAME — update when adding new stacks
PORT_3001=uptime-kuma
PORT_3002=linkvault
PORT_3003=umami
PORT_3004=vinnegpt
PORT_3005=invoiceparser
PORT_3006=signalfinder
# PORT_3007=your-next-stack

---

## Cloudflare

CF_ZONE_ID=
CF_API_TOKEN=
# Public domain served via Cloudflare Tunnel:
PUBLIC_DOMAIN=lab463.com

---

## Local Domain

LOCAL_DOMAIN=463.vinne
# Wildcard DNS: *.463.vinne → SERVER_HOST

---

## Personal Preferences

# Language for AI responses (Slovak/English)
LANGUAGE=Slovak
# Code language
CODE_LANG=English

# Default tech stack for new projects
DEFAULT_BACKEND=dotnet10
DEFAULT_FRONTEND=react-vite-typescript
DEFAULT_DB=postgresql
