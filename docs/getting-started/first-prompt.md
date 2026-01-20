# Your First Prompt

Let's walk through a complete example of transforming a vague idea into a perfect prompt.

## The Scenario

You want to add user authentication to your web application. You know you need login functionality, but you haven't decided on the details.

## Step 1: Start Simple

Type your initial thought:

```bash
/prompt-technical Add login to my app
```

## Step 2: Phase 0 Analysis

Claude begins Phase 0 - the prompt perfection process:

```
Phase 0: Prompt Perfection

Detected:
- Language: English
- Type: Feature Implementation
- Domain: Technical (Authentication)
- Complexity Score: 12 (Complex)

Spawning Explore Agent to analyze codebase...
```

## Step 3: Agent Exploration

The Explore Agent scans your codebase:

```
Agent Analysis Complete

Project Context:
- Framework: Express.js + React
- Database: PostgreSQL with Prisma ORM
- Existing Auth: None detected
- Similar Patterns: JWT tokens used in payment-service.js

Relevant Files:
- src/routes/api.js (API routes)
- src/models/User.js (User model exists)
- src/middleware/ (middleware folder available)
```

## Step 4: Clarifying Questions

Claude identifies what's missing:

```
Before I proceed, I need to clarify:

1. Authentication Method
   - Option A: JWT tokens (Recommended for your SPA)
   - Option B: Session cookies
   - Option C: OAuth providers (Google, GitHub)

2. Features Needed
   - [x] Login
   - [ ] Registration?
   - [ ] Password reset?
   - [ ] Remember me?

3. Security Level
   - Option A: Standard (password hashing, HTTPS)
   - Option B: Enhanced (+ rate limiting, 2FA ready)
   - Option C: Enterprise (+ audit logging, session management)

4. Token Storage
   - Option A: HttpOnly cookie (more secure)
   - Option B: LocalStorage (easier CORS handling)

Please answer: 1A, which features, 3B, 4A
```

## Step 5: Your Response

```
1A, login and registration, 3B, 4A
```

## Step 6: Perfected Prompt

Claude generates the structured prompt:

```
Perfected Prompt:

GOAL
Implement JWT-based authentication with login and registration

CONTEXT
- Express.js backend with React frontend
- PostgreSQL database using Prisma ORM
- Existing User model in src/models/User.js

SCOPE
Files to create:
- src/routes/auth.js (login, register endpoints)
- src/middleware/auth.js (JWT verification)
- src/services/auth.service.js (business logic)

Files to modify:
- src/routes/api.js (mount auth routes)
- prisma/schema.prisma (add password field)

REQUIREMENTS
1. Login endpoint: POST /api/auth/login
   - Accepts email + password
   - Returns JWT token in HttpOnly cookie
   - Rate limited: 5 attempts per minute

2. Register endpoint: POST /api/auth/register
   - Validates email format
   - Password: min 8 chars, requires number
   - Returns JWT token in HttpOnly cookie

3. Auth middleware
   - Verifies JWT from cookie
   - Attaches user to req.user
   - Returns 401 for invalid/expired tokens

CONSTRAINTS
- Use bcrypt for password hashing (cost factor 12)
- JWT expiration: 24 hours
- Follow existing pattern from payment-service.js
- No breaking changes to existing endpoints

EXPECTED RESULT
Working authentication with:
- /api/auth/login - returns token
- /api/auth/register - creates user, returns token
- Protected routes using auth middleware
- Proper error handling and validation

Proceed with this implementation? [Yes / Modify / Cancel]
```

## Step 7: Approval

```
Yes
```

Claude now implements exactly what you specified.

## What Made This Work?

### Phase 0 Validation

Instead of guessing, Claude:
- Detected the request type
- Identified missing information
- Asked specific questions
- Waited for your answers

### Agent Exploration

The Explore Agent found:
- Your tech stack
- Existing patterns to follow
- Files that need changes
- Related implementations

### Structured Output

The perfected prompt has:
- Clear goal
- Precise context
- Defined scope
- Specific requirements
- Explicit constraints
- Measurable expected result

## Compare: Without the Library

If you had just typed "Add login to my app":

```
You: Add login to my app
Claude: *implements session-based auth*
You: No, I need JWT
Claude: *refactors to JWT*
You: And use HttpOnly cookies
Claude: *changes token storage*
You: Also add registration
Claude: *adds registration*
You: It needs rate limiting
Claude: *adds rate limiting*
```

**Result:** 5 iterations, inconsistent implementation, wasted tokens.

## Try It Yourself

Now try with your own task:

```bash
/prompt-technical [your feature idea]
```

Answer the clarifying questions, and watch the magic happen.

## Common Patterns

### Bug Fix
```bash
/prompt Fix the null pointer in UserService.getById()
```

### Refactoring
```bash
/prompt-technical Refactor payment processing to use strategy pattern
```

### New Feature
```bash
/prompt-technical Add real-time notifications using WebSockets
```

### Research
```bash
/prompt-research Analyze our API for potential security vulnerabilities
```

## Next Steps

- [Browse all commands](/commands/) - Complete reference
- [Understand the architecture](/architecture/) - How it works
- [Read best practices](/reference/best-practices) - Expert tips
