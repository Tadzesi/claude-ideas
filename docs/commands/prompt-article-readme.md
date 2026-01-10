# /prompt-article-readme

Generate comprehensive README files for your project.

## Overview

| Aspect | Details |
|--------|---------|
| **Speed** | ~30 seconds |
| **Complexity** | Medium |
| **Best For** | Project documentation, open source READMEs |

## Usage

```bash
/prompt-article-readme
```

No arguments needed - analyzes current project.

## What It Does

1. **Scans Project Structure**
   - Detects tech stack
   - Identifies main files
   - Finds existing documentation

2. **Analyzes package.json / requirements.txt**
   - Extracts dependencies
   - Identifies frameworks
   - Determines project type

3. **Generates README**
   - Project description
   - Installation instructions
   - Usage examples
   - Configuration guide
   - Contributing guidelines

## Example Output

```bash
/prompt-article-readme
```

```
Analyzing project...

Detected:
- Type: Node.js Web Application
- Framework: Express.js
- Database: PostgreSQL (Prisma)
- Testing: Jest
- Package Manager: npm

README Style:
- Minimal (badge, description, install, usage)
- Standard (+ configuration, API docs, contributing)
- Comprehensive (+ architecture, FAQ, troubleshooting)

Choose style: [1/2/3] 2

Generating README...

# My Awesome Project

![Node.js](https://img.shields.io/badge/Node.js-18+-green)
![License](https://img.shields.io/badge/License-MIT-blue)

A brief description of your project.

## Features

- Feature 1: Description
- Feature 2: Description
- Feature 3: Description

## Prerequisites

- Node.js 18 or higher
- PostgreSQL 14+
- npm or yarn

## Installation

```bash
# Clone repository
git clone https://github.com/username/project.git
cd project

# Install dependencies
npm install

# Set up database
npx prisma migrate dev

# Start development server
npm run dev
```

## Configuration

Create `.env` file:

```env
DATABASE_URL=postgresql://...
JWT_SECRET=your-secret
PORT=3000
```

## Usage

### Development

```bash
npm run dev
```

### Production

```bash
npm run build
npm start
```

## API Documentation

### Authentication

| Endpoint | Method | Description |
|----------|--------|-------------|
| /api/auth/login | POST | User login |
| /api/auth/register | POST | User registration |

### Users

| Endpoint | Method | Description |
|----------|--------|-------------|
| /api/users | GET | List users |
| /api/users/:id | GET | Get user |

## Testing

```bash
npm test
npm run test:coverage
```

## Contributing

1. Fork the repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Open Pull Request

## License

MIT License - see LICENSE file

---

Generated with Claude Commands Library
```

## Style Options

### Minimal

- Project badge
- One-line description
- Install command
- Basic usage

### Standard (Recommended)

- Badges
- Description with features
- Prerequisites
- Installation
- Configuration
- Usage examples
- API overview
- Testing
- Contributing
- License

### Comprehensive

Everything in Standard, plus:
- Architecture overview
- Directory structure
- Detailed API docs
- FAQ
- Troubleshooting
- Changelog
- Roadmap

## Tips

### Run from Project Root

```bash
cd /path/to/your/project
claude
/prompt-article-readme
```

### Include package.json

The more complete your package.json, the better the README:

```json
{
  "name": "my-project",
  "description": "A brief description",
  "keywords": ["api", "express", "typescript"],
  "author": "Your Name",
  "license": "MIT"
}
```

### Review and Customize

The generated README is a starting point. Customize:
- Project-specific details
- Unique setup steps
- Team conventions
- Branding

## Related Commands

- [/prompt-article](/commands/prompt-article) - For other written content
- [/session-end](/commands/session-end) - Save after generating README
