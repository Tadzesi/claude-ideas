# /prompt-dotnet

.NET project-aware prompt perfection. Scans your project files before asking any questions — framework version, architecture, auth, ORM, and Docker are pre-filled automatically.

::: tip Updated in v4.6
- **HARD-GATE** — verifies `.csproj` was read before stating any .NET version or package names
- **Project Scan on startup** — reads `.csproj`, `Program.cs`, `appsettings.json`, `Dockerfile`, `docker-compose.yml`
- **Zero repeated questions** — detects framework, auth, ORM, DB, Docker without asking
- **Stack-aware best practices** — applies detected .NET version, EF Core, PostgreSQL, JWT rules automatically
- **Consistency-first recommendations** — suggests patterns already in use in your project
:::

## Overview

| Aspect | Details |
|--------|---------|
| **Speed** | ~3 seconds |
| **Version** | v2.0 |
| **Format** | `.claude/skills/prompt-dotnet/SKILL.md` |
| **Best For** | C# APIs, EF Core migrations, middleware, auth, .NET features |
| **Related** | `/prompt-react` for the React frontend, `/prompt-technical` for architecture |

## Usage

```bash
/prompt-dotnet [describe what you want to implement or fix]
```

## How It Works

### Step 1 — Project Scan (always first)

Before any analysis, the skill reads your project:

1. `.csproj` — TargetFramework, key NuGet packages
2. `Program.cs` — Minimal API vs controllers, DI registrations, middleware, auth setup
3. `appsettings.json` — connection strings, config keys
4. `Dockerfile` (if present) — build/runtime image
5. `docker-compose.yml` (if present) — service name, ports, networks
6. `.claude/memory/project-profile.md` (if present)

Output displayed before analysis:

```
PROJECT SCAN COMPLETE
Framework: net10.0
Architecture: Minimal API
Auth: JWT
ORM: EF Core | DB: PostgreSQL — ConnectionStrings:Default
Docker: yes — stack: myapp
Packages: FluentValidation, Serilog, MediatR
```

### Step 2 — Completeness Check (pre-filled)

| Criterion | Status | Source |
|-----------|--------|--------|
| Framework version | ✓ pre-filled | `.csproj` |
| Architecture pattern | ✓ pre-filled | `Program.cs` |
| Auth mechanism | ✓ pre-filled | `Program.cs` |
| ORM / DB access | ✓ pre-filled | packages |
| Specific goal | ❓ from user | |
| Affected files | ❓ inferred or asked | |
| Expected behavior | ❓ from user | |

### Step 3 — Clarification (only unknown items)

Only asks for what the scan cannot determine. If multiple valid approaches exist, marks ⭐ the one consistent with your existing project (consistency over personal preference).

### Step 4 — Best Practices Applied Automatically

Based on the detected stack, applies rules without asking:

**General .NET 10:**
- Async/await throughout — no `.Result` or `.Wait()`
- `CancellationToken` on all async IO methods
- `ILogger<T>` injection, not static logging
- `record` types for DTOs where appropriate
- `IResult` return types for Minimal API endpoints

**If EF Core detected:**
- `ToListAsync()`, `FirstOrDefaultAsync()`, `SaveChangesAsync()`
- `AsNoTracking()` for read-only queries
- Explicit `.Include()` — no lazy loading in APIs

**If PostgreSQL detected:**
- `snake_case` naming convention if configured
- `Npgsql.EntityFrameworkCore.PostgreSQL` provider conventions

**If JWT detected:**
- `[Authorize]` attribute usage
- Claims extraction patterns
- Token validation in middleware, not controllers

**If Docker detected:**
- No hardcoded connection strings — env vars / `IConfiguration`
- Health check endpoints (`/health`) if missing
- Port from `ASPNETCORE_URLS`

## Examples

### Add an API Endpoint

```bash
/prompt-dotnet Add a PATCH endpoint for updating user profile
```

**Scan detects:** `net10.0`, Minimal API, JWT, EF Core + PostgreSQL, Docker

**Output:**
```
PROJECT SCAN COMPLETE
Framework: net10.0 | Architecture: Minimal API
Auth: JWT | ORM: EF Core | DB: PostgreSQL
Docker: yes

What changes do you want to make to the user profile?
(framework, auth, ORM pre-filled — only asking about specifics)

Clarification:
1. Which fields should be patchable? (name, email, avatar, all)
2. Should the endpoint validate ownership (user can only edit own profile)?

✨ Perfected .NET Prompt:

Goal: Add PATCH /users/{id}/profile endpoint that updates user profile fields

Project Context (from scan):
- Framework: net10.0, Minimal API pattern
- Auth: JWT — ownership validated via claims
- ORM: EF Core async + AsNoTracking for reads

Scope:
- Modify: Program.cs (route registration)
- Create: Features/Users/UpdateProfileHandler.cs
- Modify: Data/AppDbContext.cs (if new query needed)

Best Practices:
- async/await with CancellationToken
- IResult return type
- [Authorize] on endpoint
- FluentValidation for request body (already in project)

Proceed? [y / modify / no]
```

### EF Core Migration

```bash
/prompt-dotnet Add CreatedAt and UpdatedAt audit columns to all entities
```

**Output:**
```
PROJECT SCAN COMPLETE
Framework: net10.0 | ORM: EF Core | DB: PostgreSQL
snake_case convention: yes

Clarification:
1. Should CreatedAt be set automatically (shadow property vs explicit)?
2. Update UpdatedAt via SaveChanges override or manually?

✨ Perfected .NET Prompt:

Goal: Add audit columns to all entities via base class or interface

Best Practices:
- IAuditableEntity interface pattern
- Override SaveChangesAsync in DbContext
- PostgreSQL: timestamp with time zone (not DateTime)
- Migration: dotnet ef migrations add AddAuditColumns

Proceed? [y / modify / no]
```

### Bug Fix

```bash
/prompt-dotnet Fix N+1 query on the orders endpoint
```

**Output:**
```
Detected: EF Core + PostgreSQL, Minimal API

Analysis: N+1 typically caused by missing .Include() on navigation properties.

Clarification:
1. Which endpoint? (GET /orders, GET /orders/{id}, other)
2. Which navigation properties are loaded (OrderItems, Customer, etc.)?

✨ Perfected .NET Prompt:
Add explicit .Include() chain, verify with AsNoTracking(), consider projection to DTO.
```

## Comparison

| Feature | /prompt | /prompt-dotnet | /prompt-technical |
|---------|---------|----------------|-------------------|
| Project scan | No | .NET files | Codebase-wide |
| Pre-fills context | Memory only | .csproj + Program.cs | Agent exploration |
| .NET best practices | No | Yes (auto) | Manual |
| Speed | ~2s | ~3s | 5-30s |
| Agent spawning | No | No | Yes (complex) |

## When to Use

### Good For

- Adding API endpoints, services, repositories
- EF Core migrations and query optimization
- Middleware and DI configuration
- JWT auth implementation
- Fixing .NET-specific bugs (N+1, async pitfalls, DI issues)
- Docker / deployment preparation

### Not Ideal For

- React/frontend work → Use `/prompt-react`
- Deep architectural decisions across many files → Use `/prompt-technical`
- Security audits → Use `/prompt-research`

## Tips

### Let the Scan Do the Work

Don't include stack details in your prompt — the scan handles it:

```bash
# Not needed
/prompt-dotnet Add endpoint using EF Core with async/await and CancellationToken for PostgreSQL

# Just describe what you want
/prompt-dotnet Add endpoint to export user activity as CSV
```

### Pair with /prompt-react for Full-Stack Work

```bash
# Backend
/prompt-dotnet Add POST /api/items endpoint with FluentValidation

# Frontend
/prompt-react Add form that calls POST /api/items with error handling
```

## Related Commands

- [/prompt-react](/commands/prompt-react) — for the React frontend
- [/prompt-technical](/commands/prompt-technical) — for broader architectural decisions
- [/prompt-hybrid](/commands/prompt-hybrid) — for complex cross-cutting changes
- [/prompt-research](/commands/prompt-research) — for security audits and deep analysis
