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

## Git and PR workflow

- **Branch naming**:
  - `docs/<slug>` - for documentation changes
  - `feature/<slug>` - for new features or tools
  - `bugfix/<slug>` - for bug fixes
- **Commit messages**: Conventional Commits for clarity, e.g.
  - `docs: add quickstart checklists`
  - `docs: fix broken diataxis link`
  - `feat: add new documentation generator`
  - `fix: resolve link checker timeout issue`

- **PR checklist**:
  - Summary and rationale
  - What changed and why
  - Evidence: lints/spell/link checks passing (paste condensed output)
  - Backwards-compatibility of anchors confirmed
  - “References” updated if you cite new sources

---

## Security and safety

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
