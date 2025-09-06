# Configuration

Configuration options for the documentation framework and quality tools.

## Generator configuration

### Command-line options

| Option     | Description                           | Default |
|------------|---------------------------------------|---------|
| `--help`   | Show usage information               | -       |
| `--version`| Show version number                  | -       |
| `--remote` | Download fresh template from GitHub | false   |
| `--force`  | Overwrite existing files without asking | false |

### Environment variables

| Variable              | Description                    | Default |
|-----------------------|--------------------------------|---------|
| `TEMPLATE_URL`        | Custom template URL           | GitHub raw URL |
| `DOCS_GENERATOR_DEBUG`| Enable debug output           | false   |

Example usage:

```bash
# Use custom template
TEMPLATE_URL="https://example.com/my-template.md" ./generate

# Enable debug mode
DOCS_GENERATOR_DEBUG=1 ./generate --remote
```

## Context file configuration

The `docs/context.yaml` file drives README generation:

### Required fields

```yaml
project: "Your Project Name"        # Project title
domain: "web application"           # Project category
audience: "developers"              # Primary users
interfaces: "REST API, CLI"         # How users interact
runtime: "Node.js 18+"              # Runtime requirements
storage: "PostgreSQL"               # Data storage
deployment: "Docker, Kubernetes"    # Deployment targets
status: "stable"                    # Development status
license: "MIT"                      # Licence type
support: "GitHub Issues"            # Support channel
```

### Optional fields

```yaml
# Extended project information
description: "Detailed project description"
homepage: "https://example.com"
repository: "https://github.com/user/repo"
documentation: "https://docs.example.com"

# Technical details
languages: ["JavaScript", "TypeScript"]
frameworks: ["React", "Express"]
databases: ["PostgreSQL", "Redis"]
testing: ["Jest", "Cypress"]

# Organisational
team: "Platform Engineering"
maintainers: ["@username1", "@username2"]
created: "2024-01-01"
updated: "2024-12-01"
```

### Status values

| Status        | Description                           |
|---------------|---------------------------------------|
| `experimental`| Early development, APIs may change    |
| `beta`        | Feature-complete, testing in progress |
| `stable`      | Production-ready, stable APIs         |
| `maintenance` | Bug fixes only, no new features       |
| `archived`    | No longer maintained                  |

## Quality tool configuration

### Prettier formatting

Create `.prettierrc`:

```json
{
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false,
  "semi": true,
  "singleQuote": false,
  "quoteProps": "as-needed",
  "trailingComma": "es5",
  "bracketSpacing": true,
  "arrowParens": "avoid",
  "proseWrap": "preserve",
  "endOfLine": "lf"
}
```

### Markdown linting

Create `.markdownlint.jsonc`:

```jsonc
{
  // Disable rules that conflict with Prettier
  "MD013": false,  // Line length
  "MD033": false,  // HTML tags
  "MD041": false,  // First line heading
  
  // Configure other rules
  "MD007": { "indent": 2 },           // Unordered list indentation
  "MD024": { "allow_different_nesting": true }, // Duplicate headings
  "MD025": { "front_matter_title": "" },        // Single H1
  "MD029": { "style": "ordered" },              // Ordered list style
  
  // Enable stricter rules
  "MD046": { "style": "fenced" },     // Code block style
  "MD048": { "style": "backtick" }    // Code fence style
}
```

### Spell checking

Create `cspell.json`:

```json
{
  "version": "0.2",
  "language": "en-GB",
  "words": [
    "API",
    "APIs",
    "CLI",
    "JSON",
    "YAML",
    "GitHub",
    "README",
    "changelog",
    "config",
    "configs",
    "frontend",
    "backend",
    "middleware",
    "auth",
    "oauth",
    "webhooks",
    "microservice",
    "microservices",
    "containerised",
    "Kubernetes",
    "kubectl",
    "namespace",
    "namespaces"
  ],
  "ignorePaths": [
    "node_modules/**",
    ".git/**",
    "*.min.*",
    "coverage/**",
    "dist/**",
    "build/**"
  ],
  "ignoreRegExpList": [
    "\\bhttps?://[^\\s]+",
    "\\b[A-Z0-9]{32,}\\b",
    "\\b[a-f0-9]{40}\\b"
  ]
}
```

### Vale prose linting

Create `.vale.ini`:

```ini
StylesPath = .vale/styles
MinAlertLevel = suggestion

[*.md]
BasedOnStyles = Vale, Microsoft
Vale.Terms = YES
Microsoft.Contractions = NO
Microsoft.FirstPerson = NO
Microsoft.We = NO

# Custom rules
Vale.Repetition = YES
Vale.Spelling = NO  # Use cspell instead
```

Create `.vale/styles/Custom/TechnicalTerms.yml`:

```yaml
extends: substitution
message: "Use '%s' instead of '%s'"
level: warning
ignorecase: true
swap:
  API's: API's → APIs
  Github: Github → GitHub
  Javascript: Javascript → JavaScript
  Typescript: Typescript → TypeScript
  NodeJS: NodeJS → Node.js
  PostgreSQL: PostgreSQL → PostgreSQL
```

## Git configuration

### Commit message format

Use Conventional Commits:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

Types:
- `feat`: New feature
- `fix`: Bug fix  
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Test changes
- `chore`: Build/tooling changes

Examples:
```
docs: add API reference documentation
feat(auth): implement OAuth2 integration
fix: resolve memory leak in worker process
```

### Branch naming

Use descriptive branch names:

```bash
# Feature branches
git checkout -b feat/user-authentication
git checkout -b feat/payment-integration

# Documentation branches  
git checkout -b docs/api-reference
git checkout -b docs/deployment-guide

# Bug fix branches
git checkout -b fix/memory-leak
git checkout -b fix/validation-error
```

## IDE configuration

### VS Code settings

Create `.vscode/settings.json`:

```json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "markdown.validate.enabled": true,
  "cSpell.enabled": true,
  "cSpell.language": "en-GB",
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true,
  "files.trimFinalNewlines": true
}
```

### VS Code extensions

Recommended extensions in `.vscode/extensions.json`:

```json
{
  "recommendations": [
    "esbenp.prettier-vscode",
    "davidanson.vscode-markdownlint", 
    "streetsidesoftware.code-spell-checker",
    "yzhang.markdown-all-in-one",
    "shd101wyy.markdown-preview-enhanced"
  ]
}
```

## CI/CD configuration

### GitHub Actions

Create `.github/workflows/docs.yml`:

```yaml
name: Documentation Quality

on:
  push:
    paths: ["**.md", "docs/**"]
  pull_request:
    paths: ["**.md", "docs/**"]

jobs:
  lint-docs:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          
      - name: Format check
        run: npx prettier . --check
        
      - name: Lint Markdown
        run: npx markdownlint-cli2 "**/*.md" "#node_modules"
        
      - name: Spell check
        run: npx cspell "**/*.md" --no-must-find-files --locale en-GB
        
      - name: Link check
        run: |
          git ls-files '*.md' | xargs -I{} npx markdown-link-check -q {}
```

### Pre-commit hooks

Install pre-commit hooks:

```bash
# Install pre-commit
pip install pre-commit

# Create .pre-commit-config.yaml
cat > .pre-commit-config.yaml << 'EOF'
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files
      
  - repo: https://github.com/prettier/prettier
    rev: v3.0.0
    hooks:
      - id: prettier
        types_or: [markdown, yaml]
        
  - repo: https://github.com/igorshubovych/markdownlint-cli
    rev: v0.35.0
    hooks:
      - id: markdownlint
EOF

# Install hooks
pre-commit install
```

## Troubleshooting

### Configuration validation

```bash
# Test Prettier config
npx prettier --check .

# Test markdownlint config
npx markdownlint-cli2 "**/*.md"

# Test cspell config
npx cspell "**/*.md" --no-must-find-files

# Test Vale config (if installed)
vale --config .vale.ini .
```

### Common issues

**Prettier conflicts with markdownlint:**
- Disable MD013 (line length) in markdownlint config
- Use `proseWrap: "preserve"` in Prettier config

**Spell check false positives:**
- Add technical terms to `cspell.json` words array
- Use ignore patterns for URLs and hashes

**Vale performance issues:**
- Limit to specific file types: `[*.md]`
- Exclude large directories in `.vale.ini`

## Advanced configuration

### Custom template variables

Extend the generator with custom variables:

```bash
# In generate script, add custom replacements
sed -i "s/{{CUSTOM_VAR}}/custom-value/g" "$OUTPUT_FILE"
```

### Multi-language documentation

Structure for multiple languages:

```
docs/
├── en/
│   ├── README.md
│   └── USAGE.md
├── es/
│   ├── README.md
│   └── USAGE.md
└── context.yaml  # Shared metadata
```

### Documentation as code

Treat documentation with same rigour as code:
- Version control all config files
- Use semantic versioning for major doc changes  
- Automate quality checks in CI/CD
- Review documentation changes like code reviews
