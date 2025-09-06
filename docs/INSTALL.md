# Installation

Multiple ways to install and use the documentation framework.

## Quick install (recommended)

### One-line remote setup

```bash
curl -sSL https://raw.githubusercontent.com/mitchellfyi/documentation/main/generate | bash
```

This works in any project directory and:
- Downloads the script
- Runs interactive setup
- Generates README.md and docs structure
- Provides next steps

### Download and run locally

```bash
# Download the generator
curl -sSL https://raw.githubusercontent.com/mitchellfyi/documentation/main/generate -o generate
chmod +x generate

# Run with options
./generate --help
./generate --force
./generate --remote
```

## Manual installation

### From GitHub repository

1. **Clone the repository:**
   ```bash
   git clone https://github.com/mitchellfyi/documentation.git
   cd documentation
   ```

2. **Copy files to your project:**
   ```bash
   # Copy template and generator
   cp README-TEMPLATE.md /path/to/your/project/
   cp generate /path/to/your/project/
   
   # Make generator executable
   chmod +x /path/to/your/project/generate
   ```

3. **Run in your project:**
   ```bash
   cd /path/to/your/project
   ./generate
   ```

### Template-only approach

If you only need the template:

```bash
# Download just the template
curl -sSL https://raw.githubusercontent.com/mitchellfyi/documentation/main/README-TEMPLATE.md -o README-TEMPLATE.md

# Copy and customise manually
cp README-TEMPLATE.md README.md
# Edit README.md to replace {{PLACEHOLDERS}}
```

## System requirements

### Minimum requirements

- **Operating system:** Linux, macOS, or Windows with WSL
- **Shell:** bash 4.0+
- **Tools:** curl or wget
- **Text editor:** Any editor for customisation

### Optional tools for quality gates

- **Node.js 20+** - For Prettier formatting and markdownlint
- **Python 3.11+** - For Vale prose linting (via pipx)

Install optional tools:

```bash
# Check Node.js
node --version  # Should be 20+

# Install Vale (optional)
pipx install vale
```

## Installation verification

### Test the generator

```bash
# Check script is executable
ls -la generate

# Show help (should display usage)
./generate --help

# Test in empty directory
mkdir test-project
cd test-project
../generate --force
ls -la  # Should see README.md and docs/
```

### Validate generated output

```bash
# Check README was created
test -f README.md && echo "README.md exists"

# Check docs structure
test -d docs && echo "docs/ directory exists"
test -f docs/context.yaml && echo "context.yaml exists"

# Look for remaining placeholders
grep -c "\[.*\]" README.md || echo "No bracket placeholders found"
```

## Docker usage

### Run in container

```bash
# Create Dockerfile
cat > Dockerfile << 'EOF'
FROM node:20-alpine
WORKDIR /workspace
RUN apk add --no-cache curl bash
COPY . .
CMD ["./generate"]
EOF

# Build and run
docker build -t docs-generator .
docker run -it -v $(pwd):/workspace docs-generator
```

### Use pre-built image

```bash
# Run from Docker Hub (when available)
docker run -it -v $(pwd):/workspace mitchellfyi/docs-generator
```

## CI/CD integration

### GitHub Actions

```yaml
# .github/workflows/docs.yml
name: Generate Documentation
on:
  workflow_dispatch:
  
jobs:
  generate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Generate README
        run: |
          curl -sSL https://raw.githubusercontent.com/mitchellfyi/documentation/main/generate | bash
      - name: Commit changes
        run: |
          git config --local user.email "action@github.com"
          git config --local user.name "GitHub Action"
          git add -A
          git diff --staged --quiet || git commit -m "docs: update generated documentation"
          git push
```

### GitLab CI

```yaml
# .gitlab-ci.yml
generate-docs:
  stage: build
  image: node:20-alpine
  before_script:
    - apk add --no-cache curl bash
  script:
    - curl -sSL https://raw.githubusercontent.com/mitchellfyi/documentation/main/generate | bash
  artifacts:
    paths:
      - README.md
      - docs/
```

## Troubleshooting

### Common installation issues

**Permission denied:**
```bash
chmod +x generate
```

**curl/wget not found:**
```bash
# On Ubuntu/Debian
sudo apt-get install curl

# On macOS
brew install curl

# On Alpine
apk add curl
```

**Script not found:**
```bash
# Verify URL is accessible
curl -I https://raw.githubusercontent.com/mitchellfyi/documentation/main/generate

# Download to specific location
curl -sSL https://raw.githubusercontent.com/mitchellfyi/documentation/main/generate -o ./generate
```

**Network issues:**
```bash
# Test connectivity
ping github.com

# Use alternative download method
wget https://raw.githubusercontent.com/mitchellfyi/documentation/main/generate
```

### Platform-specific notes

**Windows (WSL):**
- Use WSL2 for best compatibility
- Ensure line endings are LF, not CRLF
- Install curl in WSL: `sudo apt install curl`

**macOS:**
- Use Homebrew for additional tools: `brew install node`
- May need to allow script execution in Security preferences

**Linux:**
- Most distributions include curl by default
- Use package manager for Node.js: `sudo apt install nodejs npm`

## Uninstallation

To remove the framework files:

```bash
# Remove generated files
rm -f README.md
rm -rf docs/

# Remove generator
rm -f generate

# Remove template (if copied)
rm -f README-TEMPLATE.md
```

## Getting help

- Check [USAGE.md](USAGE.md) for detailed examples
- Review [QUICKSTART.md](QUICKSTART.md) for quick setup
- Open an issue with installation details
- Include your OS, shell version, and error messages
