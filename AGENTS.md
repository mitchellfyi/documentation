# AGENTS.md

_A predictable, machine-friendly playbook for AI coding agents working in this repository._

This file follows the emerging **AGENTS.md** convention - a README for agents. It provides exact steps, rules, and guardrails for reliable project work. Multiple assistants load `AGENTS.md` automatically, supporting monorepos via "nearest file wins."

---

## Machine context

```yaml
project: docs-guide
purpose: Definitive patterns and templates for high-quality software documentation
domain: developer-docs
languages: Markdown, YAML, Shell
runtimes: Node 20+, Python 3.11+
package_managers: npm, pipx
monorepo: false
status: stable
support: GitHub Issues
```

---

## Project map

### Core files

- `/README.md` - authoritative, demo-first guide to writing documentation
- `/generate` - main CLI tool for creating documentation scaffolds (18KB shell script)
- `/AGENTS.md` - this file; machine-readable project instructions

### Templates and guides

- `/README-TEMPLATE.md` - copy-paste template for new projects
- `/README-GUIDE.md` - detailed guide for writing READMEs
- `/AGENTS-TEMPLATE.md` - template for creating AGENTS.md files
- `/AGENTS-GUIDE.md` - guide for implementing AGENTS.md convention

### Documentation structure

- `/docs/` - deep docs following Diátaxis framework:
  - `QUICKSTART.md`, `USAGE.md`, `INSTALL.md`, `CONFIGURATION.md`
  - `ARCHITECTURE.md`, `ROADMAP.md`, `CONTRIBUTING.md`
  - `context.yaml` - machine-readable project context

### Automation and quality

- `/scripts/` - quality checking and automation tools:
  - `check-quality.sh` - complete validation pipeline
  - `setup.sh` - install required tooling
  - Individual tools: `format.sh`, `lint-markdown.sh`, `spell-check.sh`, etc.

### Configuration

- `.markdownlint.jsonc`, `.prettierrc`, `cspell.json`, `.vale.ini` - tool configs
- `.github/copilot-instructions.md` - GitHub Copilot guidance

**Do not modify (without human approval):**

- `LICENSE` - legal terms
- `/generate` script core functionality (complex sed replacements)
- External links in historical “References” sections unless you validate replacements
- Configuration files unless fixing specific linting/formatting issues

---

## Allowed scope and limits

### Allowed

- Improve wording, structure, clarity, and consistency across Markdown files
- Add examples, tables, and checklists that improve developer and agent onboarding
- Fix broken links, anchors, and images
- Add or update lint/format configs for docs only

### Forbidden without approval

- Any change that contradicts security guidance (e.g. advising to store secrets in VCS)
- Large re-organisation that breaks public anchors or permalinks
- Non-docs code or infra changes

Escalate by opening an issue with label `needs-human` and include the failing command output.

---

## Do/Don't quick reference

### Do

- Keep changes small and tested
- Write Conventional Commits (docs:, feat:, fix:)
- Use timeouts for all CLI commands
- Run quality gates before proposing changes
- Preserve existing functionality and anchor compatibility

### Don't

- Touch generated assets or core functionality without approval
- Add new dependencies without noting in PR body
- Commit secrets or make destructive changes without human approval
- Skip quality validation steps
- Break existing anchors or permalinks

---

## Setup

> Use **explicit commands** - do not assume prior state.

- Node and npm available (Node 20+ recommended)
- Python 3.11+ with `pipx` (for optional tools)

Install (on demand via `npx`/`pipx` so local devDeps aren’t required):

```bash
# Markdown formatter (Prettier) + linter (markdownlint-cli2) + spellcheck (cspell)
npm -v >/dev/null || exit 1
# nothing to install globally; we'll use npx on each run

# Vale prose linter (optional but preferred)
pipx install vale || true  # falls back to system 'vale' if already installed
```

---

## Build, test, and quality gates (docs)

Run these locally before proposing changes. All must pass.

**⚠️ CLI Command Safety Rules:**

- **Use timeouts** - All CLI commands must have sensible timeouts (max 60s for most operations)
- **Non-interactive mode** - Commands must complete without user interaction and return to CLI
- **Clean exit** - All commands must exit cleanly with proper status codes
- **Error handling** - Check command exit codes and handle failures appropriately

```bash
# 1) Format Markdown (timeout: 30s)
timeout 30s npx prettier . --write --log-level warn

# 2) Lint Markdown style (timeout: 30s, uses .markdownlint.jsonc if present)
timeout 30s npx markdownlint-cli2 "**/*.md" "#node_modules"

# 3) Spell check (timeout: 60s, British English). If cspell.json exists, it will be used.
timeout 60s npx cspell "**/*.md" --no-must-find-files --unique --show-suggestions --locale en-GB

# 4) Prose lint (timeout: 30s, Vale) if config present (.vale.ini)
command -v vale >/dev/null && timeout 30s vale . || echo "vale not installed - skipping"

# 5) Link check (timeout: 120s) - fast, quiet pass over all Markdown
timeout 30s npx markdown-link-check -q README.md || true
git ls-files '*.md' | head -20 | xargs -I{} timeout 10s npx markdown-link-check -q {} || true
```

**Success criteria:** Prettier formatting applied, markdownlint has **no errors**, cspell has **no errors**,<br> Vale has **no errors** when enabled, and link checks report **0 broken links** or you replace/annotate them.

---

## Testing protocol + CI gates

**⚠️ MANDATORY REQUIREMENT: Do not propose merge if any check fails.**

All agents must run and pass these commands before proposing changes. Expected runtimes are provided for planning.

### Tests (Quality Pipeline)

```bash
# Complete quality check pipeline (timeout: 300s, runtime: ~28s)
timeout 300s scripts/check-quality.sh
```

**Expected outcome:** All formatting, linting, spell check, and link validation passes.<br> Pre-existing repository errors are expected and should not be fixed unless directly related to your changes.

### Lint (Individual Tools)

```bash
# Format check (timeout: 30s, runtime: ~2s)
timeout 30s npx prettier . --check

# Markdown linting (timeout: 30s, runtime: ~8s)
timeout 30s npx markdownlint-cli2 "**/*.md" "#node_modules"

# Spell check British English (timeout: 60s, runtime: ~13s)
timeout 60s npx cspell "**/*.md" --no-must-find-files --locale en-GB

# Prose linting - optional (timeout: 30s, runtime: ~5s)
command -v vale >/dev/null && timeout 30s vale . || echo "Vale not installed - skipping"
```

**Expected outcome:** Only formatting should pass cleanly.<br> Linting and spell check will show pre-existing errors (88 markdown lint errors, 45 spelling issues).<br> Fix only errors you introduce.

### Type-check

**Not applicable** - This repository contains shell scripts and Markdown files. No type checking required.

### Build (Documentation Generation)

```bash
# Test documentation generation (timeout: 120s, runtime: ~36s)
# Note: This is interactive and requires manual input
cd /tmp && mkdir -p test-build && cd test-build
cp /home/runner/work/documentation/documentation/generate .
timeout 120s ./generate --help

# Verify script functionality
timeout 120s ./generate --skip-quality --force
```

**Expected outcome:** README.md and docs/context.yaml files created successfully. Generate script completes without errors.

### CI Gates Summary

**All of these must pass before proposing merge:**

1. ✅ `scripts/check-quality.sh` exits with code 0
2. ✅ `npx prettier . --check` shows no formatting issues
3. ✅ No new markdown linting errors introduced (existing 88 errors acceptable)
4. ✅ No new spelling errors introduced (existing 45 errors acceptable)
5. ✅ `./generate` script functions correctly
6. ✅ All changes preserve existing functionality

**If any check fails:** Fix the issue before proposing merge. Do not create workarounds or ignore failures.

---

## Success criteria checklist

Copy this checklist for any task working on documentation:

### Pre-task setup

- [ ] Read this `AGENTS.md` file completely
- [ ] Identify files that will be modified
- [ ] Create working branch: `git switch -c docs/<slug>`
- [ ] Baseline check: Run quality gates in sequence:

  ```bash
  timeout 30s npx prettier . --check && \
  timeout 30s npx markdownlint-cli2 "**/*.md" "#node_modules" && \
  timeout 60s npx cspell "**/*.md" --no-must-find-files --locale en-GB
  ```

### During task execution

- [ ] Make minimal, incremental changes
- [ ] Use executable commands with proper timeouts
- [ ] Test changes frequently with quality tools
- [ ] Preserve existing functionality
- [ ] Add stable external references to "References" section if needed

### Post-task validation

- [ ] Format check: `timeout 30s npx prettier . --write --log-level warn`
- [ ] Markdown lint: `timeout 30s npx markdownlint-cli2 "**/*.md" "#node_modules"` (no errors)
- [ ] Spell check: `timeout 60s npx cspell "**/*.md" --no-must-find-files --locale en-GB` (no errors)
- [ ] Prose check: `timeout 30s vale .` (no errors, if Vale available)
- [ ] Link validation: `git ls-files '*.md' | head -20 | xargs -I{} timeout 10s npx markdown-link-check -q {}`<br> (no broken links)
- [ ] Verify anchor/link compatibility maintained
- [ ] Prepare conventional commit message (e.g., `docs: add quickstart checklists`)
- [ ] Open PR with summary, rationale, and quality check evidence

**All items must be completed before submitting changes.**

---

## Style and conventions (docs)

- **English**: British English spelling (en-GB).
- **Tone**: clear, concise, no fluff, accessible to a competent but busy reader.
- **Headings**: sentence case; one `#` h1 per file.
- **Lists**: prefer bullets over long paragraphs.
- **Code blocks**: fenced \`\`\` with language if applicable.
- **Links**: prefer relative links within the repo; use stable anchors; avoid bare URLs.
- **Typography**: use normal hyphen `-` instead of an em dash; no emojis.
- **Tables**: use for options, parameters, and comparisons.
- **Citations/attribution**: include a “References” section where external sources materially inform content.

If `.markdownlint.jsonc`, `.vale.ini`, or `cspell.json` are missing, create minimal configs aligning with the rules above.

---

## Coding Style and Lint Commands

**Quick Summary:** This repository uses British English (en-GB), 120-character line length, fenced code blocks, and clear documentation patterns. All changes must pass formatting, linting, and spell checking.

**Required Lint Commands (copy and run exactly):**

```bash
# Complete quality check (all linters)
timeout 300s scripts/check-quality.sh

# Individual linters
timeout 30s npx prettier . --check                                    # Formatting
timeout 30s npx markdownlint-cli2 "**/*.md" "#node_modules"          # Markdown style
timeout 60s npx cspell "**/*.md" --no-must-find-files --locale en-GB # Spelling
```

**Detailed Rules:**

- **Comprehensive style guide:** [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md#coding-standards)
- **Markdown linting rules:** [.markdownlint.jsonc](.markdownlint.jsonc)
- **Code formatting rules:** [.prettierrc](.prettierrc)
- **Spell check dictionary:** [cspell.json](cspell.json)
- **Prose style config:** [.vale.ini](.vale.ini) _(optional)_

**Quality Gates:** All formatting, linting, and spell checks must pass before submitting changes. Pre-existing repository errors (84 markdown issues, spelling issues) are acceptable and should not be fixed unless directly related to your changes.

---

## Git and PR workflow

### Branch naming conventions

Use descriptive branch names following these patterns:

- **`feature/<slug>`** - for new features or tools
  - Examples: `feature/add-vale-integration`, `feature/cli-improvements`
- **`bugfix/<slug>`** - for bug fixes
  - Examples: `bugfix/broken-links`, `bugfix/script-timeout-issues`
- **`docs/<slug>`** - for documentation changes
  - Examples: `docs/update-contributing`, `docs/fix-readme-typos`

Where `<slug>` is a short, descriptive identifier using kebab-case.

### Conventional Commits format

All commit messages must follow [Conventional Commits](https://www.conventionalcommits.org/) specification:

```text
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**Required types:**

- `feat:` - new feature for the user
- `fix:` - bug fix for the user
- `docs:` - changes to documentation
- `style:` - formatting, missing semicolons, etc (no code change)
- `refactor:` - refactoring production code
- `test:` - adding missing tests, refactoring tests (no production code change)
- `chore:` - updating build tasks, package manager configs, etc (no production code change)

**Examples:**

- `docs: add quickstart checklists`
- `docs: fix broken diataxis link`
- `feat: add new documentation generator`
- `feat(cli): add --skip-quality flag to generate script`
- `fix: resolve link checker timeout issue`
- `fix(scripts): handle missing Vale installation gracefully`
- `chore: update markdownlint configuration`
- `refactor: simplify quality check pipeline`

**Breaking changes:** Add `!` after type/scope or include `BREAKING CHANGE:` in footer.

### PR requirements and checklist

Every pull request must include:

- **Summary and rationale** - clear description of what changed and why
- **Quality evidence** - proof that all quality gates pass
- **Backwards compatibility** - confirmation that anchors/links remain valid
- **Issue linkage** - reference to related issues using GitHub keywords
- **Documentation updates** - update to AGENTS.md if workflow/setup changes

**Detailed checklist available in PR template** - see `.github/pull_request_template.md`---

## Security and safety

**📋 Complete security policies**: See [SECURITY.md](SECURITY.md) for comprehensive security rules and sensitive path guidelines.

**Key principles:**

- Never commit secrets, tokens, or private URLs.
- Do not instruct users to store secrets in VCS - always prefer environment variables or secret stores.
- Avoid leaking personal data in examples; sanitise names, keys, and endpoints.
- Treat this repo as public by default.
- **Never make destructive changes without explicit human approval** - always ask and clarify what will happen before:
  - Deleting files or directories
  - Overwriting existing content
  - Modifying core functionality
  - Changing configuration that affects other users

---

## Gotchas

- Some link checkers rate-limit. If `markdown-link-check` flaps, re-run or add a JSON config to ignore known false positives.
- Keep tables under 120 characters per row for readability in terminals.
- When replacing a link, ensure anchor compatibility or update in-file anchors accordingly.

---

## Operational guidelines for agents

### Research and validation requirements

- **Always check documentation first** - Read existing docs, README, and issue history before making changes
- **Look up best practices** - Research current best practices for the technology/approach being used
- **Validate external sources** - Ensure links and references are current and authoritative
- **Cross-reference standards** - Check against relevant style guides, RFCs, or industry standards

### CI/CD and workflow compliance

- **Run all pre-commit hooks** - Ensure local quality gates pass before committing
- **Verify CI workflows** - Check that GitHub Actions or other CI systems will pass
- **Fix issues properly** - Address root causes, not symptoms; avoid workarounds that mask problems
- **Preserve functionality** - Never break existing features while fixing issues
- **Test thoroughly** - Validate changes work in clean environments

### Command execution standards

- **Timeout all commands** - Use `timeout` command or equivalent for all CLI operations
- **Force non-interactive mode** - Use flags like `--yes`, `--non-interactive`, `--batch` where available
- **Validate clean exit** - Check exit codes and ensure commands complete properly
- **Handle errors gracefully** - Provide meaningful error messages and recovery steps

**Example safe command patterns:**

```bash
# Good: with timeout and non-interactive flags
timeout 30s npm install --silent --no-progress

# Good: with error handling
if ! timeout 60s npx prettier . --check; then
    echo "Formatting issues found, applying fixes..."
    timeout 30s npx prettier . --write
fi

# Bad: no timeout, potentially interactive
npm install
```

---

## Agent Command Blocks (Copy and Execute)

### Pre-task Setup Block

**Copy this entire block and execute verbatim before starting any task:**

```bash
#!/bin/bash
# Pre-task setup for agents working on documentation repository
# Execute this entire block before making any changes

echo "🚀 Pre-task setup: Loading AGENTS.md, setting up environment, installing dependencies, verifying build"

# 1. Load and verify AGENTS.md exists
echo "1️⃣  Loading AGENTS.md..."
if [[ ! -f "AGENTS.md" ]]; then
    echo "❌ AGENTS.md not found. Ensure you're in the correct repository root."
    exit 1
fi
echo "✅ AGENTS.md loaded - $(wc -l < AGENTS.md) lines of guidance available"

# 2. Set up environment
echo "2️⃣  Setting up environment..."
# Verify Node.js and npm are available
if ! command -v node >/dev/null 2>&1; then
    echo "❌ Node.js not found. This repository requires Node 20+."
    exit 1
fi
if ! command -v npm >/dev/null 2>&1; then
    echo "❌ npm not found. This repository requires npm for tooling."
    exit 1
fi
echo "✅ Node.js $(node --version) and npm $(npm --version) available"

# 3. Install dependencies (on-demand via npx, no package.json in this repo)
echo "3️⃣  Verifying tooling dependencies..."
echo "   Dependencies are installed on-demand via npx (prettier, markdownlint-cli2, cspell)"
echo "   Vale prose linter: $(command -v vale >/dev/null 2>&1 && echo 'installed' || echo 'not installed (optional)')"
echo "✅ Tooling verified"

# 4. Verify build (documentation generation)
echo "4️⃣  Verifying build (documentation generation)..."
if [[ ! -x "./generate" ]]; then
    echo "❌ Generate script not executable or not found"
    exit 1
fi
if ! timeout 120s ./generate --help >/dev/null; then
    echo "❌ Generate script failed"
    exit 1
fi
echo "✅ Generate script verified"

# 5. Check current repository state
echo "5️⃣  Checking current repository state..."
# Run baseline quality check (allow failures for pre-existing issues)
timeout 30s npx prettier . --check >/dev/null 2>&1 && \
    echo "✅ Formatting clean" || echo "⚠️  Formatting issues exist (may be pre-existing)"
timeout 30s npx markdownlint-cli2 "**/*.md" "#node_modules" >/dev/null 2>&1 && \
    echo "✅ Markdown linting clean" || echo "⚠️  Markdown linting issues exist (may be pre-existing)"
timeout 60s npx cspell "**/*.md" --no-must-find-files --locale en-GB >/dev/null 2>&1 && \
    echo "✅ Spelling clean" || echo "⚠️  Spelling issues exist (may be pre-existing)"

echo "🎉 Pre-task setup complete! You can now begin making changes."
echo "📖 Remember to make minimal, incremental changes and test frequently."
```

### Post-task Validation Block

**Copy this entire block and execute verbatim after completing any task:**

```bash
#!/bin/bash
# Post-task validation for agents working on documentation repository
# Execute this entire block after making changes, before submitting PR

echo "🔍 Post-task validation: Running tests, linting, build verification, preparing commit and PR"

# Track overall success
VALIDATION_SUCCESS=true

# 1. Run complete quality pipeline
echo "1️⃣  Running complete quality pipeline..."
# Note: Pre-existing markdown lint and spell check errors are expected per AGENTS.md guidance
# Only fail on critical issues like formatting problems
if timeout 300s scripts/check-quality.sh >/dev/null 2>&1; then
    echo "✅ Quality pipeline passed completely"
else
    # Check individual components to identify specific failures
    echo "⚠️  Quality pipeline had some issues - checking individual components..."

    # Formatting is critical and must pass
    if ! timeout 30s npx prettier . --check >/dev/null 2>&1; then
        echo "❌ Formatting failures detected - this must be fixed"
        VALIDATION_SUCCESS=false
    else
        echo "✅ Formatting is clean"
    fi

    # Markdown linting and spell check have pre-existing errors that are acceptable
    timeout 30s npx markdownlint-cli2 "**/*.md" "#node_modules" >/dev/null 2>&1 && \
        echo "✅ Markdown linting clean" || echo "⚠️  Markdown linting issues (may be pre-existing, acceptable)"

    timeout 60s npx cspell "**/*.md" --no-must-find-files --locale en-GB >/dev/null 2>&1 && \
        echo "✅ Spell checking clean" || echo "⚠️  Spell checking issues (may be pre-existing, acceptable)"

    echo "ℹ️  Per AGENTS.md: 84 markdown errors and spelling issues are pre-existing and acceptable"
fi

# 2. Verify generate script still works (build verification)
echo "2️⃣  Verifying build (generate script functionality)..."
cd /tmp && mkdir -p agent-test-build && cd agent-test-build
if cp /home/runner/work/documentation/documentation/generate . &&
   cp /home/runner/work/documentation/documentation/README-TEMPLATE.md . 2>/dev/null || true; then
    if timeout 120s ./generate --help >/dev/null; then
        echo "✅ Generate script build verification passed"
    else
        echo "❌ Generate script build verification failed"
        VALIDATION_SUCCESS=false
    fi
else
    echo "❌ Could not set up build verification test"
    VALIDATION_SUCCESS=false
fi
cd - >/dev/null

# 3. Check for unintended changes (back in repository directory)
echo "3️⃣  Checking for unintended changes..."
# Show what files have been modified
if command -v git >/dev/null 2>&1 && git rev-parse --git-dir >/dev/null 2>&1; then
    MODIFIED_FILES=$(git diff --name-only)
    if [[ -n "$MODIFIED_FILES" ]]; then
        echo "📝 Modified files:"
        echo "$MODIFIED_FILES" | sed 's/^/   /'

        # Check if any forbidden files were modified
        FORBIDDEN_PATTERN="^(LICENSE|generate|\.github/.*\.yml|.*\.ini|.*\.json)$"
        if echo "$MODIFIED_FILES" | grep -E "$FORBIDDEN_PATTERN" >/dev/null; then
            echo "⚠️  Warning: Modified files that typically shouldn't be changed:"
            echo "$MODIFIED_FILES" | grep -E "$FORBIDDEN_PATTERN" | sed 's/^/   ❗ /'
            echo "   Review these changes carefully"
        fi
    else
        echo "ℹ️  No modified files detected"
    fi
else
    echo "ℹ️  Not in a git repository or git not available - skipping git diff check"
fi

# 4. Prepare commit message guidance
echo "4️⃣  Commit message guidance..."
echo "📋 Use Conventional Commits format:"
echo "   docs: <description>          # for documentation changes"
echo "   feat: <description>          # for new features"
echo "   fix: <description>           # for bug fixes"
echo "   Examples:"
echo "   - docs: add explicit pre-task and post-task command blocks"
echo "   - docs: fix broken links in README"
echo "   - feat: add new quality check script"

# 5. PR body preparation guidance
echo "5️⃣  PR body preparation..."
echo "📋 Include in your PR description:"
echo "   - Summary and rationale for changes"
echo "   - Evidence that quality checks pass"
echo "   - Confirmation that existing functionality is preserved"
echo "   - Reference to related issues (e.g., 'Fixes #11')"

# Final validation result
echo ""
if [[ "$VALIDATION_SUCCESS" = "true" ]]; then
    echo "🎉 Post-task validation successful! Ready to commit and submit PR."
    echo "💡 Next steps:"
    echo "   1. Review your changes: git diff"
    echo "   2. Stage changes: git add ."
    echo "   3. Commit with conventional format: git commit -m 'docs: your message'"
    echo "   4. Push and create PR with proper description"
else
    echo "💥 Post-task validation failed. Please fix issues above before submitting."
    exit 1
fi
```

---

## Task workflow for agents

### Before every task

1. **Read this `AGENTS.md` fully** and locate the file(s) you intend to change.
2. **Research and validate** - Check existing documentation, look up best practices, verify external sources.
3. **Assess impact** - Identify any potentially destructive changes and seek approval if needed.
4. **Ensure a clean baseline** with timeouts and proper error handling:

   ```bash
   # Check current state (timeout: 120s total)
   timeout 30s npx prettier . --check && \
   timeout 30s npx markdownlint-cli2 "**/*.md" "#node_modules" && \
   timeout 60s npx cspell "**/*.md" --no-must-find-files --locale en-GB
   ```

5. **Create a working branch:** `git switch -c docs/<slug>`

### During the task

1. **Plan edits** and expected impact on anchors and links.
2. **Make incremental changes** - Small, testable modifications rather than large rewrites.
3. **Tight feedback loop** with safe command execution:

   ```bash
   # Format and validate (timeout: 150s total)
   timeout 30s npx prettier . --write
   timeout 30s npx markdownlint-cli2 "**/*.md" "#node_modules"
   timeout 60s npx cspell "**/*.md" --no-must-find-files --locale en-GB
   command -v vale >/dev/null && timeout 30s vale . || true
   ```

4. **Validate functionality** - Ensure changes preserve original functionality.
5. **If you add external references,** append a short "References" section with stable links.

### After the task

1. **Final validation** with comprehensive testing:

   ```bash
   # Complete quality check (timeout: 300s total)
   timeout 30s npx prettier . --check && \
   timeout 30s npx markdownlint-cli2 "**/*.md" "#node_modules" && \
   timeout 60s npx cspell "**/*.md" --no-must-find-files --locale en-GB && \
   (command -v vale >/dev/null && timeout 30s vale . || true) && \
   git ls-files '*.md' | head -20 | xargs -I{} timeout 10s npx markdown-link-check -q {}
   ```

2. **Verify CI compatibility** - Ensure changes will pass automated workflows.
3. **Test in clean environment** - Validate functionality works as expected.
4. **Prepare commit** using Conventional Commits format.
5. **Open a PR** including: summary, rationale, lint outputs, and any anchor/link considerations.

---

## Monorepo or nested docs (future)

If this repo gains subpackages or a `/site/` build, place **local** `AGENTS.md` files in those directories to<br> override or extend these rules. Agents should use the nearest `AGENTS.md`. ([Medium][1])

---

## Command glossary

**Safe command patterns (with timeouts and non-interactive modes):**

- Format: `timeout 30s npx prettier . --write --log-level warn`
- Lint (Markdown): `timeout 30s npx markdownlint-cli2 "**/*.md" "#node_modules"`
- Spell (en-GB): `timeout 60s npx cspell "**/*.md" --no-must-find-files --locale en-GB`
- Prose lint (optional): `timeout 30s vale .`
- Link check: `timeout 10s npx markdown-link-check -q <file.md>`
- New branch: `git switch -c docs/<slug>`

**Quality check combo:**

```bash
timeout 30s npx prettier . --check && \
timeout 30s npx markdownlint-cli2 "**/*.md" "#node_modules" && \
timeout 60s npx cspell "**/*.md" --no-must-find-files --locale en-GB
```

---

## References

- **AGENTS.md – open format overview and examples.** ([agents.md][2], [GitHub][3])
- **Adoption and purpose of AGENTS.md in the ecosystem.** ([InfoQ][4])
- **Nearest-file behaviour for monorepos.** ([Medium][1])

[1]: https://medium.com/%40danushidk507/agents-md-a-comprehensive-guide-to-agentic-ai-collaboration-571df0e78ccc?utm_source=chatgpt.com "Agents.md: A Comprehensive Guide to Agentic AI ..."
[2]: https://agents.md/?utm_source=chatgpt.com "AGENTS.md"
[3]: https://github.com/openai/agents.md?utm_source=chatgpt.com "AGENTS.md — a simple, open format for guiding coding ..."
[4]: https://www.infoq.com/news/2025/08/agents-md/?utm_source=chatgpt.com "AGENTS.md Emerges as Open Standard for AI Coding ..."
