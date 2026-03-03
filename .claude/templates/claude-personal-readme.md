# claude-personal — Private Claude Configuration

Private repository for personal Claude Code configuration.
**Do NOT make this repo public** — contains server credentials and personal data.

## What's in this repo

```
claude-personal/
├── README.md                    # This file
├── memory/
│   └── personal-profile.md     # Server IP, SSH user, ports, Cloudflare token
├── restore.ps1                  # New PC restore script (Windows)
└── restore.sh                   # New PC restore script (Linux/Mac)
```

## New PC Setup

### 1. Install claude-ideas (public skills library)

```powershell
# Install Claude Commands Library
iwr -useb https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-commands.ps1 | iex

# Install statusline
iwr -useb https://raw.githubusercontent.com/Tadzesi/claude-ideas/main/install-claude-statusline.ps1 | iex
```

### 2. Restore personal config

```powershell
git clone https://github.com/YOUR_USERNAME/claude-personal.git
cd claude-personal
.\restore.ps1
```

### 3. Done

Claude now knows your server details. Skills `/deploy`, `/new-stack` will use them automatically.

---

## Updating personal-profile.md

When you add a new stack to the server, update `ALLOCATED_PORTS` in `personal-profile.md`, then commit and push:

```powershell
cd claude-personal
git add memory/personal-profile.md
git commit -m "add port for new-stack-name"
git push
```

## Files NOT in this repo (per-project, not global)

These stay in each project's `.claude/memory/project-profile.md` and are committed to that project's repo (they don't contain secrets):
- Project name, tech stack, Docker containers
- Code conventions, known gotchas
- API endpoints, URL patterns

Use template: https://github.com/Tadzesi/claude-ideas/blob/main/.claude/templates/project-profile-dotnet-react.md
