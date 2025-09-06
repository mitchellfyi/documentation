````markdown
<!--
AGENTS.md TEMPLATE
Purpose: a definitive, machine-friendly playbook for AI coding agents working in this repository.
Audience: AI agents first, humans second. Keep commands explicit and copy-pastable.
How agents read this: most tools load the nearest AGENTS.md in the directory tree; local files override root.
Guidance: keep this file concise. Put deep detail into docs/ and link to it. Update this file whenever commands change.
Replace all {{PLACEHOLDERS}}. Delete guidance comments once filled.
-->

# AGENTS.md

## Machine context
<!-- A short, structured context block helps agents reason quickly. Keep it accurate. -->
```yaml
project: {{PROJECT_NAME}}
repo: {{GITHUB_ORG}}/{{REPO}}
domain: {{DOMAIN}}                             # e.g. e-commerce, data platform, web app, CLI
languages: {{LANGS}}                           # e.g. Python, TypeScript, Go
monorepo: {{true|false}}
entrypoints:
  cli: {{CLI_ENTRY}}                           # e.g. ./bin/cli
  service: {{SERVICE_ENTRY}}                   # e.g. src/server.ts
package_managers: {{PKG_MGRS}}                 # e.g. pip, pnpm, cargo
runtimes: {{RUNTIMES}}                         # e.g. Python 3.11+, Node 20+, Java 21
services:
  - name: {{DB_NAME}}                          # e.g. Postgres
    start: "{{DB_START_CMD}}"                  # e.g. docker compose up -d db
    url: "{{DB_URL_ENV}}"                      # e.g. DATABASE_URL
ports: {{PORTS}}                               # e.g. 3000, 5432
status: {{experimental|beta|stable|maintenance|archived}}
support: {{SUPPORT_CHANNEL}}                   # e.g. GitHub Issues, Discussions URL
````

---

## Project map

<!-- Show the lay of the land. Help agents put files in the right place. -->

* Purpose: {{ONE\_LINE\_PURPOSE}}
* Key directories:

  * `/src` - {{DESCRIPTION}}
  * `/tests` - {{TEST\_DESC}} - place new tests here
  * `/docs` - {{DOCS\_DESC}}
  * {{MORE\_DIRS}}
* Do not modify:

  * `{{PROTECTED_GLOB_1}}` - {{WHY}}
  * `{{PROTECTED_GLOB_2}}` - {{WHY}}
* Ownership hints:

  * Area → reviewers: {{AREA}} → {{GITHUB\_HANDLES}}

---

## Allowed tasks and scope limits

<!-- Be explicit. Agents will respect these boundaries. -->

**Allowed**

* Bug fixes in {{AREAS}}
* Small features behind flags in {{AREAS}}
* Test improvements, doc updates, build and CI fixes

**Forbidden without approval**

* Breaking API changes
* Database schema migrations
* Secrets, infra or costs-affecting changes
* Large refactors across modules

Escalate by opening an issue with label `needs-human` and summarising blockers.

---

## Setup

<!-- A clean baseline before any edits. Make it deterministic. -->

* Prerequisites:

  * OS and tools: {{OS\_REQUIREMENTS}}, {{TOOLING}} installed
  * Runtimes: {{RUNTIMES}}
* Install dependencies:

  * `{{INSTALL_CMD}}`                         # e.g. pip install -r requirements.txt / pnpm i
* Environment:

  * Copy example env: `{{CP_ENV_CMD}}`        # e.g. cp .env.example .env
  * Set required vars in your shell: `{{EXPORT_ENV_EXAMPLE}}`
  * Never commit secrets or .env files
* Start services:

  * `{{SERVICES_UP_CMD}}`                     # e.g. docker compose up -d
* Seed or migrate data if needed:

  * `{{SEED_OR_MIGRATE_CMD}}`

Health check:

* Build: `{{BUILD_CMD}}`
* Smoke tests: `{{SMOKE_CMD}}`
* Full tests: `{{TEST_CMD}}` - must be green on main before editing

---

## Build, test, quality gates

<!-- One true way to build and validate. Agents run these before PR. -->

**⚠️ CLI Command Safety Rules:**
* **Use timeouts** - All CLI commands must have sensible timeouts (max 60s for most operations)
* **Non-interactive mode** - Commands must complete without user interaction and return to CLI
* **Clean exit** - All commands must exit cleanly with proper status codes
* **Error handling** - Check command exit codes and handle failures appropriately

**Commands with timeouts:**
* Build: `timeout {{BUILD_TIMEOUT|60}}s {{BUILD_CMD}}`
* Unit tests: `timeout {{TEST_TIMEOUT|120}}s {{TEST_UNIT_CMD}}`
* Integration tests: `timeout {{INT_TEST_TIMEOUT|300}}s {{TEST_INT_CMD}}`
* Run a subset: `timeout {{TEST_TIMEOUT|120}}s {{TEST_FILTER_CMD}}`          # e.g. pytest -k "name" / pnpm test -- <pattern>
* Type check: `timeout {{TYPECHECK_TIMEOUT|30}}s {{TYPECHECK_CMD}}`
* Lint: `timeout {{LINT_TIMEOUT|30}}s {{LINT_CMD}}`
* Format: `timeout {{FORMAT_TIMEOUT|30}}s {{FORMAT_CMD}}`
* Coverage threshold: {{COVERAGE\_MIN}}% - enforce with `timeout {{COVERAGE_TIMEOUT|60}}s {{COVERAGE_CMD}}`

**Success criterion:** format + lint + type check + build + all tests + coverage ≥ threshold must pass.

---

## Style and conventions

<!-- Keep to deltas agents cannot infer. -->

* Formatting: run `{{FORMAT_CMD}}` before commit
* Lint rules that matter: {{LINT\_HIGHLIGHTS}}  # e.g. no unused vars, no console.log in prod
* Naming and layout: {{NAMING\_RULES}}          # e.g. snake\_case for files, PascalCase for components
* Error handling and logging: {{ERROR\_LOGGING}} # e.g. use structured logging, no PII
* Docs: update {{DOC\_TOUCHPOINTS}} when behaviour changes

Full details: [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md)

---

## Git and PR workflow

<!-- Align agent output with team process. -->

* Branch naming: `{{BRANCH_PATTERN}}`          # e.g. feature/<slug>, fix/<slug>
* Commit messages: {{CONV\_COMMITS|OTHER}}       # e.g. Conventional Commits

  * Example: `feat(api): add login`
* PR checklist (all required):

  * Summary of change and rationale
  * Screenshots or logs where relevant
  * New or updated tests
  * Docs and changelog updated if user-facing
  * All checks green

PR template: [docs/PULL\_REQUEST\_TEMPLATE.md](docs/PULL_REQUEST_TEMPLATE.md)

---

## Security and safety

<!-- Guardrails agents must uphold. -->

* Never commit secrets or credentials - use environment variables or secret store
* Do not log PII or secrets - scrub in tests and fixtures
* Do not modify protected paths: `{{PROTECTED_GLOB_1}}`, `{{PROTECTED_GLOB_2}}`
* Approved licences only: {{ALLOWED\_LICENSES}} - denylist: {{DENIED\_LICENSES}}
* **Never make destructive changes without explicit human approval** - always ask and clarify what will happen before:
  * Deleting files or directories
  * Overwriting existing content
  * Modifying core functionality
  * Changing configuration that affects other users
* Dependency hygiene:

  * Audit: `{{DEP_AUDIT_CMD}}`
  * Update policy: `{{DEP_UPDATE_POLICY}}`

Security policy: [docs/SECURITY.md](docs/SECURITY.md)

---

## Performance and observability (optional)

* Performance budget: {{PERF\_BUDGET}}          # e.g. p95 < 200ms for endpoint /foo
* Benchmarks: `{{BENCH_CMD}}`
* Logging level: {{LOG\_LEVELS}}                 # e.g. info in dev, warn in CI
* Metrics and tracing: {{METRICS\_NOTES}}

---

## Gotchas

<!-- Non-obvious pitfalls. Keep tight and high value. -->

* {{GOTCHA\_1}}  # e.g. After adding a model, run {{MIGRATE\_CMD}}
* {{GOTCHA\_2}}  # e.g. Frontend uses pnpm, not npm
* {{GOTCHA\_3}}

---

## Operational guidelines for agents

### Research and validation requirements

* **Always check documentation first** - Read existing docs, README, and issue history before making changes
* **Look up best practices** - Research current best practices for the technology/approach being used
* **Validate external sources** - Ensure links and references are current and authoritative
* **Cross-reference standards** - Check against relevant style guides, RFCs, or industry standards

### CI/CD and workflow compliance

* **Run all pre-commit hooks** - Ensure local quality gates pass before committing
* **Verify CI workflows** - Check that GitHub Actions or other CI systems will pass
* **Fix issues properly** - Address root causes, not symptoms; avoid workarounds that mask problems
* **Preserve functionality** - Never break existing features while fixing issues
* **Test thoroughly** - Validate changes work in clean environments

### Command execution standards

* **Timeout all commands** - Use `timeout` command or equivalent for all CLI operations
* **Force non-interactive mode** - Use flags like `--yes`, `--non-interactive`, `--batch` where available
* **Validate clean exit** - Check exit codes and ensure commands complete properly
* **Handle errors gracefully** - Provide meaningful error messages and recovery steps

**Example safe command patterns:**
```bash
# Good: with timeout and non-interactive flags
timeout 30s {{PKG_INSTALL_CMD}} --silent --no-progress

# Good: with error handling
if ! timeout 60s {{BUILD_CMD}}; then
    echo "Build failed, checking logs..."
    {{BUILD_LOGS_CMD}}
    exit 1
fi

# Bad: no timeout, potentially interactive
{{PKG_INSTALL_CMD}}
```

---

## Task workflow for agents

<!-- The predictable loop agents should follow. -->

### Before every task

1. Read the nearest AGENTS.md and identify target module
2. Ensure clean baseline:

   * `{{FORMAT_CMD}} && {{LINT_CMD}}`
   * `{{BUILD_CMD}} && {{TEST_CMD}}` must pass on main
3. Create a working branch: `{{GIT_BRANCH_CMD}}`

### During the task

1. Plan edits and impacted files - summarise in the PR body draft
2. Loop until done:

   * Edit files
   * `{{FORMAT_CMD}} && {{LINT_CMD}}`
   * Rebuild: `{{BUILD_CMD}}`
   * Focused tests: `{{TEST_FILTER_CMD}}`
   * If interfaces changed, run full tests: `{{TEST_CMD}}`
3. Respect guardrails:

   * Do not touch protected paths
   * No secrets, no PII logging
   * Keep changes minimal and isolated

### After the task

1. Final validation:

   * `{{FORMAT_CMD}} && {{LINT_CMD}} && {{TYPECHECK_CMD}}`
   * `{{BUILD_CMD}} && {{TEST_CMD}} && {{COVERAGE_CMD}}`
2. Update docs and changelog if behaviour changed
3. Prepare commit:

   * Message: `{{COMMIT_EXAMPLE}}`
4. Open PR with:

   * Summary, rationale, risks, test evidence, rollback plan
   * Confirm all CI checks are green

---

## Monorepo and local overrides

<!-- Local AGENTS.md files can override sections for subprojects. -->

* This root file sets global rules. Subproject overrides live at:

  * `{{SUBPATH}}/AGENTS.md` - {{SCOPE}}
  * `{{SUBPATH_2}}/AGENTS.md` - {{SCOPE\_2}}
* Agents should prefer the nearest AGENTS.md to the modified files.

---

## Escalation and human handoff

* If blocked by unavailable secrets, flaky tests, unclear requirements, or forbidden scope, stop and open an issue:

  * Title prefix: `[needs-human]`
  * Include: summary, attempted steps, logs, failing commands
* Contact: {{HUMAN\_CONTACTS\_OR\_TEAM}}  # e.g. @owner1 @owner2

---

## Command glossary

<!-- Keep all invoked commands in one place to reduce drift. -->

* Install deps: `{{INSTALL_CMD}}`
* Services up: `{{SERVICES_UP_CMD}}`
* Build: `{{BUILD_CMD}}`
* Tests (full): `{{TEST_CMD}}`
* Tests (filter): `{{TEST_FILTER_CMD}}`
* Type check: `{{TYPECHECK_CMD}}`
* Lint: `{{LINT_CMD}}`
* Format: `{{FORMAT_CMD}}`
* Coverage: `{{COVERAGE_CMD}}`
* Benchmarks: `{{BENCH_CMD}}`
* New branch: `{{GIT_BRANCH_CMD}}`

---

## Links

* README: [README.md](README.md)
* Quickstart: [docs/QUICKSTART.md](docs/QUICKSTART.md)
* Usage: [docs/USAGE.md](docs/USAGE.md)
* Contributing: [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md)
* Architecture: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)
* Security: [docs/SECURITY.md](docs/SECURITY.md)
* Changelog: [CHANGELOG.md](CHANGELOG.md)

<!-- End of template -->
