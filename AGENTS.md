# AGENTS.md

_A predictable, machine-friendly playbook for AI coding agents working in this repository._

This file follows the emerging **AGENTS.md** convention - think of it as a README for agents. It gives you the exact steps, rules, and guardrails needed to work reliably on this project. Multiple assistants recognise and load `AGENTS.md` automatically, and the format supports monorepos via “nearest file wins.” :contentReference[oaicite:0]{index=0}

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
````

---

## Project map

* `/README.md` - authoritative, demo-first guide to writing documentation
* `/README-TEMPLATE.md` - copy-paste template for new projects
* `/docs/` - deep docs (QUICKSTART, USAGE, INSTALL, CONFIGURATION, ARCHITECTURE, ROADMAP, CONTRIBUTING, CODE\_OF\_CONDUCT, SECURITY, context.yaml)
* `/scripts/` - optional helper scripts for linting and link checks (create if missing)

**Do not modify (without human approval):**

* `LICENSE` - legal terms
* External links in historical “References” sections unless you validate replacements

---

## Allowed scope and limits

**Allowed**

* Improve wording, structure, clarity, and consistency across Markdown files
* Add examples, tables, and checklists that improve developer and agent onboarding
* Fix broken links, anchors, and images
* Add or update lint/format configs for docs only

**Forbidden without approval**

* Any change that contradicts security guidance (e.g. advising to store secrets in VCS)
* Large re-organisation that breaks public anchors or permalinks
* Non-docs code or infra changes

Escalate by opening an issue with label `needs-human` and include the failing command output.

---

## Setup

> Use **explicit commands** - do not assume prior state.

* Node and npm available (Node 20+ recommended)
* Python 3.11+ with `pipx` (for optional tools)

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

```bash
# 1) Format Markdown
npx prettier . --write --log-level warn

# 2) Lint Markdown style (uses .markdownlint.jsonc if present)
npx markdownlint-cli2 "**/*.md" "#node_modules"

# 3) Spell check (British English). If cspell.json exists, it will be used.
npx cspell "**/*.md" --no-must-find-files --unique --show-suggestions --locale en-GB

# 4) Prose lint (Vale) if config present (.vale.ini)
command -v vale >/dev/null && vale . || echo "vale not installed - skipping"

# 5) Link check - fast, quiet pass over all Markdown
npx markdown-link-check -q README.md || true
git ls-files '*.md' | xargs -I{} npx markdown-link-check -q {} || true
```

**Success criterion:** Prettier formatting applied, markdownlint has **no errors**, cspell has **no errors**, Vale has **no errors** when enabled, and link checks report **0 broken links** or you replace/annotate them.

---

## Style and conventions (docs)

* **English**: British English spelling (en-GB).
* **Tone**: clear, concise, no fluff, accessible to a competent but busy reader.
* **Headings**: sentence case; one `#` h1 per file.
* **Lists**: prefer bullets over long paragraphs.
* **Code blocks**: fenced \`\`\` with language if applicable.
* **Links**: prefer relative links within the repo; use stable anchors; avoid bare URLs.
* **Typography**: use normal hyphen `-` instead of an em dash; no emojis.
* **Tables**: use for options, parameters, and comparisons.
* **Citations/attribution**: include a “References” section where external sources materially inform content.

If `.markdownlint.jsonc`, `.vale.ini`, or `cspell.json` are missing, create minimal configs aligning with the rules above.

---

## Git and PR workflow

* **Branch**: `docs/<slug>`
* **Commit messages**: Conventional Commits for clarity, e.g.

  * `docs: add quickstart checklists`
  * `docs: fix broken diataxis link`
* **PR checklist**:

  * Summary and rationale
  * What changed and why
  * Evidence: lints/spell/link checks passing (paste condensed output)
  * Backwards-compatibility of anchors confirmed
  * “References” updated if you cite new sources

---

## Security and safety

* Never commit secrets, tokens, or private URLs.
* Do not instruct users to store secrets in VCS - always prefer environment variables or secret stores.
* Avoid leaking personal data in examples; sanitise names, keys, and endpoints.
* Treat this repo as public by default.

---

## Gotchas

* Some link checkers rate-limit. If `markdown-link-check` flaps, re-run or add a JSON config to ignore known false positives.
* Keep tables under 120 characters per row for readability in terminals.
* When replacing a link, ensure anchor compatibility or update in-file anchors accordingly.

---

## Task workflow for agents

### Before every task

1. Read this `AGENTS.md` fully and locate the file(s) you intend to change.
2. Ensure a clean baseline:

   ```bash
   npx prettier . --check && \
   npx markdownlint-cli2 "**/*.md" "#node_modules" && \
   npx cspell "**/*.md" --no-must-find-files --locale en-GB
   ```
3. Create a working branch: `git switch -c docs/<slug>`

### During the task

1. Plan edits and expected impact on anchors and links.
2. Tight loop:

   ```bash
   npx prettier . --write
   npx markdownlint-cli2 "**/*.md" "#node_modules"
   npx cspell "**/*.md" --no-must-find-files --locale en-GB
   command -v vale >/dev/null && vale . || true
   ```
3. If you add external references, append a short “References” section with stable links.

### After the task

1. Final validation:

   ```bash
   npx prettier . --check && \
   npx markdownlint-cli2 "**/*.md" "#node_modules" && \
   npx cspell "**/*.md" --no-must-find-files --locale en-GB && \
   (command -v vale >/dev/null && vale . || true) && \
   git ls-files '*.md' | xargs -I{} npx markdown-link-check -q {}
   ```
2. Prepare commit using Conventional Commits.
3. Open a PR including: summary, rationale, lint outputs, and any anchor/link considerations.

---

## Monorepo or nested docs (future)

If this repo gains subpackages or a `/site/` build, place **local** `AGENTS.md` files in those directories to override or extend these rules. Agents should use the nearest `AGENTS.md`. ([Medium][1])

---

## Command glossary

* Format: `npx prettier . --write`
* Lint (Markdown): `npx markdownlint-cli2 "**/*.md" "#node_modules"`
* Spell (en-GB): `npx cspell "**/*.md" --no-must-find-files --locale en-GB`
* Prose lint (optional): `vale .`
* Link check: `npx markdown-link-check -q <file.md>`
* New branch: `git switch -c docs/<slug>`

---

## References

* **AGENTS.md – open format overview and examples.** ([agents.md][2], [GitHub][3])
* **Adoption and purpose of AGENTS.md in the ecosystem.** ([InfoQ][4])
* **Nearest-file behaviour for monorepos.** ([Medium][1])

```

[1]: https://medium.com/%40danushidk507/agents-md-a-comprehensive-guide-to-agentic-ai-collaboration-571df0e78ccc?utm_source=chatgpt.com "Agents.md: A Comprehensive Guide to Agentic AI ..."
[2]: https://agents.md/?utm_source=chatgpt.com "AGENTS.md"
[3]: https://github.com/openai/agents.md?utm_source=chatgpt.com "AGENTS.md — a simple, open format for guiding coding ..."
[4]: https://www.infoq.com/news/2025/08/agents-md/?utm_source=chatgpt.com "AGENTS.md Emerges as Open Standard for AI Coding ..."
