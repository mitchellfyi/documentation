# Usage

Detailed examples and patterns for using the documentation framework.

## CLI tool usage

### Basic generation

```bash
# Generate README with interactive setup
./generate

# Force overwrite without prompting
./generate --force

# Use remote template (downloads fresh copy)
./generate --remote

# Show help
./generate --help
```

### Remote usage

```bash
# One-liner for any project
curl -sSL https://raw.githubusercontent.com/mitchellfyi/documentation/main/generate | bash

# Install locally first
curl -sSL https://raw.githubusercontent.com/mitchellfyi/documentation/main/generate -o generate
chmod +x generate
./generate
```

## Interactive setup

When no `docs/context.yaml` exists, the tool guides you through project setup:

```
Project name: My Awesome Project
Domain (e.g., web app, CLI tool): web application
Primary audience: developers, product managers
Interfaces: REST API, web dashboard
Runtime requirements: Node.js 18+, PostgreSQL 14+
Storage backends: PostgreSQL, Redis
Deployment targets: Docker, Kubernetes
Status: stable
License: MIT
Support channel: GitHub Issues
```

This creates a `docs/context.yaml` file used for README generation.

## Manual template usage

### Using README-TEMPLATE.md directly

1. Copy the template:
   ```bash
   cp README-TEMPLATE.md README.md
   ```

2. Create context file:
   ```bash
   mkdir -p docs
   cat > docs/context.yaml << EOF
   project: Your Project Name
   domain: your-domain
   audience: your-audience
   # ... other fields
   EOF
   ```

3. Replace placeholders manually:
   ```bash
   # Find all placeholders
   grep -n "{{.*}}" README.md
   
   # Find bracket placeholders
   grep -n "\[.*\]" README.md
   ```

### Template customisation

The template includes these sections:
- **Demo** - Live examples or screenshots
- **TL;DR** - Elevator pitch
- **Context** - Machine-readable metadata
- **Quickstart** - Fastest path to success
- **Usage** - Common examples
- **Features** - Capabilities and benefits
- **Requirements** - Dependencies and constraints
- **Configuration** - Key options
- **Differentiation** - Why choose this
- **Architecture** - High-level design
- **Roadmap** - Future plans
- **Support** - Getting help
- **Contributing** - How to contribute
- **Security** - Vulnerability reporting
- **Licence** - Legal terms

## Documentation structure

### Recommended file organisation

```
.
├── README.md                    # Main project documentation
├── LICENSE                      # Legal terms
├── docs/
│   ├── context.yaml            # Machine-readable metadata
│   ├── QUICKSTART.md           # Getting started guide
│   ├── USAGE.md                # Detailed usage examples
│   ├── INSTALL.md              # Installation instructions
│   ├── CONFIGURATION.md        # Configuration reference
│   ├── ARCHITECTURE.md         # System design
│   ├── ROADMAP.md              # Future plans
│   ├── CONTRIBUTING.md         # Contribution guidelines
│   ├── CODE_OF_CONDUCT.md      # Community standards
│   └── SECURITY.md             # Security policy
└── .github/
    ├── ISSUE_TEMPLATE.md       # Issue template
    └── PULL_REQUEST_TEMPLATE.md # PR template
```

### Documentation types (Diátaxis model)

Organise content by user intent:

- **Tutorials** (learning-oriented) - Step-by-step lessons
- **How-to guides** (problem-oriented) - Recipes for specific tasks
- **Reference** (information-oriented) - Technical specifications
- **Explanation** (understanding-oriented) - Concepts and design decisions

## Advanced usage

### Custom placeholders

Add your own placeholders to the template:

```markdown
# {{CUSTOM_PLACEHOLDER}}
This will be replaced: {{MY_VARIABLE}}
```

Then update the generate script to handle them:

```bash
sed -i "s/{{CUSTOM_PLACEHOLDER}}/My Value/g" README.md
```

### Multiple project types

The framework adapts to different project types:

**Web applications:**
```yaml
domain: web application
interfaces: REST API, GraphQL
runtime: Node.js 18+, React 18
storage: PostgreSQL, Redis
deployment: Docker, Vercel
```

**CLI tools:**
```yaml
domain: command-line tool
interfaces: CLI, config files
runtime: Python 3.11+
storage: local filesystem
deployment: pip, homebrew
```

**Libraries/SDKs:**
```yaml
domain: software library
interfaces: API, SDK
runtime: language-agnostic
storage: none
deployment: npm, pypi, maven
```

## Troubleshooting

### Common issues

**Script fails to download:**
```bash
# Check internet connection
curl -I https://github.com

# Try wget instead
wget https://raw.githubusercontent.com/mitchellfyi/documentation/main/generate
```

**Permission denied:**
```bash
# Make script executable
chmod +x generate
```

**Template not found:**
```bash
# Use remote template
./generate --remote
```

**Context file issues:**
```bash
# Validate YAML syntax
python -c "import yaml; yaml.safe_load(open('docs/context.yaml'))"
```

### Getting help

- Check the [QUICKSTART.md](QUICKSTART.md) guide
- Review [INSTALL.md](INSTALL.md) for setup issues
- Open an issue with the `help-wanted` label
- Include error output and your system details
