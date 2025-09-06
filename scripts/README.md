# Documentation scripts

Helper scripts for linting, formatting, and quality checking documentation files, as specified in the project's `AGENTS.md`.

## Available scripts

### Individual tools

- **`format.sh`** - Format all Markdown files using Prettier
- **`lint-markdown.sh`** - Lint Markdown files for style issues using markdownlint-cli2
- **`spell-check.sh`** - Spell check using cspell with British English
- **`prose-lint.sh`** - Check prose quality using Vale (optional, requires Vale installation)
- **`link-check.sh`** - Check for broken links in Markdown files

### Workflow scripts

- **`setup.sh`** - Install and configure required tooling
- **`check-quality.sh`** - Run all quality checks (recommended for CI/CD)
- **`fix-and-check.sh`** - Auto-fix formatting issues then run quality checks

## Usage

All scripts follow the safety requirements from `AGENTS.md`:

- Use timeouts to prevent hanging
- Run in non-interactive mode
- Provide clear success/failure feedback
- Exit with appropriate status codes

### Quick start

```bash
# Setup tooling (first time only)
./scripts/setup.sh

# Check documentation quality
./scripts/check-quality.sh

# Auto-fix and check
./scripts/fix-and-check.sh
```

### Individual checks

```bash
# Format files
./scripts/format.sh

# Check Markdown style
./scripts/lint-markdown.sh

# Check spelling
./scripts/spell-check.sh

# Check prose quality (if Vale installed)
./scripts/prose-lint.sh

# Check links
./scripts/link-check.sh
```

## Configuration files

The scripts use these configuration files (created automatically):

- **`.prettierrc`** - Prettier formatting rules
- **`.markdownlint.jsonc`** - Markdown linting rules
- **`cspell.json`** - Spell checking configuration (British English)
- **`.vale.ini`** - Prose linting rules (optional)

## Requirements

- **Node.js 20+** with npm (required)
- **Python 3.11+** with pipx (optional, for Vale prose linting)

All npm tools are installed automatically via `npx` on first use.

## Integration with AGENTS.md

These scripts implement the quality gates defined in `AGENTS.md`:

1. **Format check** - Prettier formatting applied
2. **Markdown lint** - markdownlint has no errors
3. **Spell check** - cspell has no errors (British English)
4. **Prose lint** - Vale has no errors (when enabled)
5. **Link check** - 0 broken links or annotated exceptions

Success criterion: All checks pass before committing changes.
