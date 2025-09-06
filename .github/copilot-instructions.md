# GitHub Copilot Instructions for Documentation Repository

Always reference these instructions first and only fallback to additional search or context gathering if the information here is incomplete or found to be incorrect.

## Project Overview

This is a documentation templates and guidance repository that provides:

- A CLI tool (`generate`) that creates production-grade READMEs and documentation scaffolds
- Shell scripts for documentation quality checking and validation
- Templates and patterns for high-quality software documentation
- AI-friendly documentation structure and context files

**Key Point**: This is NOT a traditional software project with builds/tests - it's a documentation tooling repository.

## Working Effectively

### Initial Setup (First-time use - 3 minutes)

Run the setup script to install required tooling:

```bash
chmod +x scripts/setup.sh
scripts/setup.sh
```

**NEVER CANCEL**: Setup takes ~3 minutes including Vale installation. Set timeout to 240+ seconds.

### Primary Workflow Commands

**CRITICAL TIMING**: All commands below have been validated and timed. Use the exact timeout values specified.

#### 1. Complete Quality Check Pipeline (28 seconds total)

```bash
timeout 300s scripts/check-quality.sh
```

**NEVER CANCEL**: Complete quality check takes ~28 seconds but network issues can extend this to 5+ minutes. Always set timeout to 300+ seconds.

This runs:

- Format check (~2 seconds)
- Markdown linting (~8 seconds)
- Spell checking (~13 seconds)
- Prose linting (fails if Vale not configured - expected)
- Link checking (~5 seconds, many expected failures due to external links)

#### 2. Individual Quality Commands

Use these for focused validation during development:

```bash
# Format check/fix (2 seconds)
timeout 30s npx prettier . --check
timeout 30s npx prettier . --write

# Markdown linting (8 seconds)
timeout 30s npx markdownlint-cli2 "**/*.md" "#node_modules"

# Spell checking (13 seconds)
timeout 60s npx cspell "**/*.md" --no-must-find-files --unique --show-suggestions --locale en-GB

# Link checking (varies by network, 5-30 seconds per file)
timeout 30s npx markdown-link-check -q README.md
```

#### 3. Generate Script Testing (36 seconds)

The main CLI tool for creating documentation:

```bash
# Test the generate script
timeout 120s ./generate --help

# NEVER CANCEL: Interactive README generation takes ~36 seconds
# Requires manual input for project questions
timeout 120s ./generate --skip-quality --force
```

**Manual Validation Required**: Always test the generate script by creating a test project in `/tmp/test-project` and running through the interactive questionnaire.

### Validation Scenarios

**CRITICAL**: After making ANY changes, always run these complete validation scenarios:

#### Scenario 1: Documentation Quality Pipeline

1. Run `timeout 300s scripts/check-quality.sh`
2. Verify formatting passes (should be ✅)
3. Note that linting/spelling failures are expected in this repository
4. Verify link checking completes (many failures expected due to external links)

#### Scenario 2: Generate Script Functionality

1. Create test directory: `mkdir -p /tmp/test-copilot && cd /tmp/test-copilot`
2. Copy tools: `cp /path/to/repo/generate . && cp /path/to/repo/README-TEMPLATE.md .`
3. Run interactively: `timeout 120s ./generate --skip-quality --force`
4. Provide test inputs when prompted:
   - Project name: TestProject
   - Domain: CLI tool
   - Audience: developers
   - Interfaces: CLI
   - Runtime: Python 3.11+
   - Storage: filesystem
   - Deployment: Docker
   - Status: stable
   - License: MIT
   - Support: GitHub Issues
5. Verify README.md and docs/context.yaml are created
6. Verify placeholders like `[Add your one-line project description]` exist for customization

#### Scenario 3: Repository Structure Validation

- Verify core files exist: `README.md`, `generate`, `scripts/`, `docs/`, `AGENTS.md`
- Check scripts are executable: `ls -la scripts/`
- Validate AGENTS.md follows the established format

## Repository Navigation

### Key Locations

- `/generate` - Main CLI tool for README generation (18KB shell script)
- `/scripts/` - Quality checking tools (setup.sh, check-quality.sh, format.sh, etc.)
- `/docs/` - Example documentation structure following Diátaxis framework
- `/AGENTS.md` - Comprehensive instructions for AI agents (EXISTING - do not duplicate)
- `/README-TEMPLATE.md` - Template used by generate script
- `.markdownlint.jsonc`, `.prettierrc`, `cspell.json`, `.vale.ini` - Tool configurations

### Do NOT Modify Without Approval

- `LICENSE` - Legal terms
- External links in "References" sections unless validated
- The generate script's core functionality (complex sed replacements)

## Common Issues and Workarounds

### Vale Prose Linting

- **Issue**: Vale fails with "path does not exist" error
- **Status**: Expected behavior - Vale not fully configured
- **Action**: Document as "prose linting will fail until Vale styles configured"

### External Link Failures

- **Issue**: Many external links return Status: 0 in link checking
- **Status**: Expected due to network restrictions/rate limiting
- **Action**: Document as "expected external link failures in sandboxed environment"

### Markdown Linting Errors

- **Issue**: 88 linting errors across repository files
- **Status**: Existing issues in repository, not caused by new changes
- **Action**: Only fix linting errors you introduce, ignore existing ones

### NPX Package Installation

- **First Run**: NPX tools (prettier, markdownlint-cli2, cspell) download on first use (~2-8 seconds extra)
- **Subsequent Runs**: Tools run immediately from cache

## Timeout Guidelines

**CRITICAL**: Never use default timeouts. Always specify explicit timeouts to prevent premature cancellation:

- Setup script: 240+ seconds (includes Vale installation)
- Complete quality check: 300+ seconds (network-dependent)
- Generate script: 120+ seconds (interactive input required)
- Individual linting tools: 30-60 seconds each
- Format checking: 30 seconds
- Spell checking: 60 seconds
- Link checking: 30+ seconds per file

## Build/Test Status

**There are NO traditional builds or tests** in this repository. The "build" process is documentation generation and validation:

1. **"Build"**: Generate documentation with `./generate`
2. **"Test"**: Validate with `scripts/check-quality.sh`
3. **"Deploy"**: Documentation files are the deliverable

## Expected Command Outcomes

### Successful Operations

- `scripts/setup.sh` → Installs tools, exits with code 0
- `npx prettier . --check` → "All matched files use Prettier code style!"
- `./generate --help` → Shows usage information
- Interactive generate → Creates README.md and docs/context.yaml

### Expected Failures (Do Not Fix)

- Markdown linting → 88 errors (pre-existing repository issues)
- Spell checking → ~50 spelling issues (technical terms, proper names)
- Vale prose linting → Runtime error (configuration missing)
- Link checking → Many Status: 0 failures (external links in sandbox)

### Failure Indicators to Fix

- Generate script → Does not create output files
- Format check → Files have formatting issues
- Scripts → Permission denied (need chmod +x)
- Timeout errors → Commands cancelled prematurely (increase timeout)
