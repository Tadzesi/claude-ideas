# /prompt-react

React project-aware prompt perfection. Scans your project files before asking any questions — React version, TypeScript config, router, state management, and base path are pre-filled automatically.

::: tip New in v4.4
- **Project Scan on startup** — reads `package.json`, `vite.config.ts`, `tsconfig.json`, `src/` structure, `.env`
- **Zero repeated questions** — detects React version, TS strict mode, router, state, data fetching, base path
- **Stack-aware best practices** — applies React, TanStack Query, Vite, SPA subpath rules based on what you actually use
- **Consistency-first recommendations** — suggests libraries and patterns already in your project
:::

## Overview

| Aspect | Details |
|--------|---------|
| **Speed** | ~3 seconds |
| **Version** | v4.4 |
| **Format** | `.claude/skills/prompt-react/SKILL.md` |
| **Best For** | Components, hooks, routing, state management, Vite config, API integration |
| **Related** | `/prompt-dotnet` for the .NET backend, `/prompt-technical` for architecture |

## Usage

```bash
/prompt-react [describe what you want to implement or fix]
```

## How It Works

### Step 1 — Project Scan (always first)

Before any analysis, the skill reads your project:

1. `package.json` — React version, key dependencies (Router, Query, Zustand, etc.), scripts
2. `vite.config.ts` / `vite.config.js` — base path, plugins, proxy config, build output
3. `tsconfig.json` — strict mode, path aliases, target
4. `src/` structure — pages/, components/, hooks/, services/, types/
5. `.env` / `.env.production` — API URL patterns
6. `.claude/memory/project-profile.md` (if present)

Output displayed before analysis:

```
PROJECT SCAN COMPLETE
React: 19.0.0 | TypeScript: yes, strict: yes
Router: React Router v6
State: Zustand
Data fetching: TanStack Query
Base path: /appname/
API proxy: /api → http://localhost:5000
Build output: dist/
```

### Step 2 — Completeness Check (pre-filled)

| Criterion | Status | Source |
|-----------|--------|--------|
| React version + TypeScript | ✓ pre-filled | `package.json` |
| Routing library | ✓ pre-filled | dependencies |
| State management | ✓ pre-filled | dependencies |
| Base path / API URL | ✓ pre-filled | `vite.config` |
| Specific goal | ❓ from user | |
| Component location | ❓ inferred or asked | |
| Expected behavior | ❓ from user | |

### Step 3 — Clarification (only unknown items)

Only asks for what the scan cannot determine. If multiple valid approaches exist, marks ⭐ the one matching your existing project patterns.

### Step 4 — Best Practices Applied Automatically

Based on the detected stack, applies rules without asking:

**General React:**
- Functional components only
- Custom hooks for reusable logic (`use` prefix)
- Proper `useEffect` cleanup (abort controllers, subscriptions)
- Stable `key` props on lists — never array index

**If TypeScript detected:**
- `interface` for props, `type` for unions/aliases
- No `any` — use `unknown` and narrow, or generics
- Strict null checks — handle `undefined` / `null` explicitly

**If React Router v6 detected:**
- `useNavigate` not `useHistory`
- `<Outlet />` for nested routes
- `Navigate` component for declarative redirects

**If TanStack Query detected:**
- `useQuery` for reads, `useMutation` for writes
- Hierarchical `queryKey` arrays: `['items', id]`
- Invalidate related queries after mutations

**If Vite detected:**
- `import.meta.env.VITE_*` for environment variables
- `import.meta.env.BASE_URL` for asset paths
- `React.lazy()` + dynamic imports for code splitting

**If SPA under subpath (`base: '/appname/'`) detected:**
- Router `basename` must match: `<BrowserRouter basename="/appname">`
- All `href` and navigation relative — no hardcoded `/` roots

## Examples

### New Component

```bash
/prompt-react Add a paginated item list with search and filter
```

**Scan detects:** React 19, TypeScript strict, TanStack Query, React Router v6, base `/appname/`

**Output:**
```
PROJECT SCAN COMPLETE
React: 19.0.0 | TypeScript: yes, strict: yes
Router: React Router v6 | Data fetching: TanStack Query
Base path: /appname/

Clarification:
1. Where in src/ should this component live? (pages/Items or components/shared)
2. What fields to filter by? (category, status, date range, other)
3. Should URL reflect current page/filters (shareable URL)?

✨ Perfected React Prompt:

Goal: Add ItemList page with server-side pagination, search, and filter

Project Context (from scan):
- React 19 + TypeScript strict
- TanStack Query for data fetching
- React Router v6, base: /appname/

Scope:
- Create: src/pages/Items/ItemList.tsx
- Create: src/hooks/useItems.ts (TanStack Query)
- Modify: src/router.tsx (add route)

Best Practices:
- useQuery with queryKey: ['items', { page, search, filter }]
- URL search params via useSearchParams (shareable)
- TypeScript: interface ItemListParams, type FilterState
- React.lazy for code splitting on route

Proceed? [y / modify / no]
```

### Custom Hook

```bash
/prompt-react Extract authentication state into a reusable hook
```

**Output:**
```
PROJECT SCAN COMPLETE
State: Zustand | TypeScript: yes, strict: yes

Analysis: Auth state likely in Zustand store. Hook should wrap store access.

Clarification:
1. Where is current auth state stored? (Zustand store name, context, other)
2. What should the hook expose? (user, isAuthenticated, login, logout, all)

✨ Perfected React Prompt:

Goal: Create useAuth hook that wraps Zustand auth store

Best Practices:
- Return typed interface: { user: User | null, isAuthenticated: boolean, login, logout }
- Memoize selectors to avoid unnecessary re-renders
- AbortController in any async login flow

Proceed? [y / modify / no]
```

### API Integration

```bash
/prompt-react Add form that submits to POST /api/items with error handling
```

**Output:**
```
PROJECT SCAN COMPLETE
Data fetching: TanStack Query | TypeScript: strict
API proxy: /api → http://localhost:5000

Analysis: TanStack Query useMutation is the right approach.

Clarification:
1. What fields does the form have?
2. Should it redirect after success or stay on page?

✨ Perfected React Prompt:

Goal: Create ItemForm component using useMutation for POST /api/items

Best Practices:
- useMutation with onSuccess: invalidate ['items'] query
- Error state displayed in UI (not just console.error)
- TypeScript: CreateItemRequest interface matching API contract
- AbortController on submit if navigating away

Proceed? [y / modify / no]
```

### Bug Fix

```bash
/prompt-react Fix the useEffect running twice on mount in development
```

**Output:**
```
Detected: React 19 (StrictMode double-invoke behavior in dev)

Analysis: React 19 StrictMode runs effects twice in development
to detect side effects. This is expected behavior.

Clarification:
1. Is this causing actual bugs, or just noisy console output?
2. Which effect specifically? (data fetch, subscription, analytics, other)

Perfected Prompt: Add cleanup function to useEffect so double-invoke
is safe. If data fetch: use AbortController pattern.
```

## Comparison

| Feature | /prompt | /prompt-react | /prompt-technical |
|---------|---------|---------------|-------------------|
| Project scan | No | React files | Codebase-wide |
| Pre-fills context | Memory only | package.json + vite.config | Agent exploration |
| React best practices | No | Yes (auto) | Manual |
| Speed | ~2s | ~3s | 5-30s |
| Agent spawning | No | No | Yes (complex) |

## When to Use

### Good For

- New components, pages, and hooks
- API integration with TanStack Query or SWR
- State management with Zustand or Context
- React Router setup and navigation
- Vite configuration and environment variables
- TypeScript type definitions for React code
- Fixing React-specific bugs (stale closures, infinite loops, key issues)

### Not Ideal For

- .NET / C# backend work → Use `/prompt-dotnet`
- Deep architectural decisions across many files → Use `/prompt-technical`
- Security audits → Use `/prompt-research`

## Tips

### Let the Scan Do the Work

Don't include stack details in your prompt — the scan handles it:

```bash
# Not needed
/prompt-react Add component using TanStack Query with TypeScript interface and useNavigate

# Just describe what you want
/prompt-react Add product detail page that loads from API
```

### Pair with /prompt-dotnet for Full-Stack Work

```bash
# Backend first
/prompt-dotnet Add GET /api/products/{id} endpoint

# Then frontend
/prompt-react Add product detail page that fetches from GET /api/products/{id}
```

### Subpath SPAs

If your app is served under a subpath (e.g. `/appname/`), the scan detects the `base` in `vite.config` and automatically includes the correct `basename` prop for React Router and warns about hardcoded `/` paths.

## Related Commands

- [/prompt-dotnet](/commands/prompt-dotnet) — for the .NET backend
- [/prompt-technical](/commands/prompt-technical) — for broader architectural decisions
- [/prompt-hybrid](/commands/prompt-hybrid) — for complex cross-cutting changes
- [/prompt-research](/commands/prompt-research) — for security audits and deep analysis
