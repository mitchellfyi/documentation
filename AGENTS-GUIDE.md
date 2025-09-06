# How to Write a Definitive `AGENTS.md`

*A practical, code-agnostic standard your AI coding agents can actually follow.*

---

## Why `AGENTS.md`

`AGENTS.md` is the **README for agents** - a predictable, Markdown file that tells AI coding tools exactly how to work with your repo: how to set up, build, test, lint, commit, and stay within guardrails. It consolidates scattered “rules files” into one source of truth and is already being adopted widely across open-source projects. ([agents.md][1], [GitHub][2], [devcenter.upsun.com][3], [InfoQ][4])

**Core outcomes**

* Reduce ambiguity - explicit, copy-pastable commands.
* Raise reliability - agents verify changes locally before proposing PRs.
* Enforce standards - the same checks humans use, encoded once.
* Scale to monorepos - local `AGENTS.md` files override root guidance. ([AIMultiple][5])

---

## File placement and discovery

* Put **`AGENTS.md` at the repo root**.
* For large repos or monorepos, **add nested `AGENTS.md`** in key subdirectories; agents use the *nearest* file to the code being changed. Keep root for global rules, leaf files for tech-specific rules. ([AIMultiple][5], [Rimusz Blog][6])

---

## Minimum viable sections (MVS)

Keep it short, explicit, and machine-parsable. Use H2/H3 headings and bullet lists of commands in backticks.

1. **Project map** - the high-level structure and “what lives where”.
2. **Setup & environment** - exact steps to run locally.
3. **Build & test** - the one true way to compile and validate.
4. **Style & conventions** - formatters, linters, naming rules.
5. **Git & PR rules** - branch names, commit format, PR checklist.
6. **Security & “do not touch”** - secrets handling, sensitive paths.
7. **Gotchas** - non-obvious pitfalls and special steps.
8. **Task workflow** - what to do before, during, after every task.
9. **Scope limits** - what the agent must not attempt.

> Tools load and use `AGENTS.md` as startup context; concise, actionable lists are easier for agents to follow than prose. ([docs.factory.ai][7], [OpenAI Platform][8])

---

## Before, During, After - the agent workflow

### 1) Before every task

* **Sync & context**

  * Read the nearest `AGENTS.md`.
  * Identify target package/module and relevant tests.
* **Environment ready**

  * `{{setup:install_deps}}`
  * `{{setup:env_start}}`
  * `{{setup:seed_or_migrate}}`
* **Health check**

  * `{{build:command}}`
  * `{{test:command}}` - must pass on main before editing.

> Agents should load project rules up front and verify a clean baseline - the same principle as human onboarding. ([OpenAI][9])

### 2) During the task

* **Plan first** - list intended edits and impacted files.
* **Follow standards**

  * Use formatter: `{{style:format}}`
  * Run linter: `{{style:lint}}`
* **Local verification loop**

  * Rebuild: `{{build:command}}`
  * Run focused tests: `{{test:single_or_filter}}`
  * Expand to full test suite if interfaces changed: `{{test:command}}`
* **Security posture**

  * Never add secrets or log PII.
  * Do not modify protected paths: `{{security:protected_glob}}`.

> Encoding this “tight loop” makes agents predictable and reduces review churn. ([OpenAI][9])

### 3) After the task

* **Full validation**

  * `{{style:format}} && {{style:lint}}`
  * `{{build:command}} && {{test:command}}`
* **Artefacts**

  * Update docs and changelog if behaviour changed.
  * Generate commit message using your convention.
* **PR readiness**

  * Include summary, rationale, test evidence, and rollback plan.
  * Confirm all required checks are green.

> Make “all tests pass and style checks clean” the mandatory success criterion agents must meet before proposing changes. ([docs.factory.ai][7])

---

## Standards to encode in `AGENTS.md`

### Project map

* Purpose, boundaries, key directories, where tests live.
* Ownership hints if relevant (who reviews what).
* “Place files here” vs “never edit here” lists.
  *(Helps agents put code in the right place.)* ([docs.factory.ai][7])

### Setup & environment

* Single source of truth for local setup:

  * OS or runtime versions, package manager.
  * Dependency install command.
  * Env vars and secrets policy - never commit secrets.
  * DB bootstrap or seeding commands. ([docs.factory.ai][7])

### Build, test, and quality gates

* One canonical build command **with timeout** (e.g., `timeout 60s npm run build`).
* One canonical full test command and how to run subsets **with timeouts** (e.g., `timeout 120s npm test`).
* Linters, type-checkers, coverage thresholds, mutation tests if any **with appropriate timeouts**.
* **CLI safety requirements:**
  * All commands must use timeouts (max 60s for most operations)
  * Commands must complete without user interaction
  * Must exit cleanly with proper status codes
  * Error handling with meaningful messages
* Explicit expectation: **fail the task if these fail.**
  *(Agents use exactly what you list.)* ([docs.factory.ai][7])

### Style & conventions

* Formatter and invocation.
* Linter rules that matter most.
* Naming, file layout, error handling, logging norms.
* Language or framework specifics (eg React hooks only, DTO patterns).
  *(Keep this to the deltas agents cannot infer from generic style guides.)*

### Git & PR rules

* Branch naming scheme.
* Commit message convention (eg Conventional Commits).
* PR checklist: tests, docs, screenshots, migrations, perf notes.
* Labels or reviewers if relevant.

### Security & safety

* Never commit secrets - use env or secret store.
* Banned APIs, unsafe patterns, or data-handling rules.
* Protected files or directories agents must not touch.
* **Never make destructive changes without explicit human approval** - always ask and clarify what will happen before:
  * Deleting files or directories
  * Overwriting existing content
  * Modifying core functionality
  * Changing configuration that affects other users
* **CLI command safety rules:**
  * Use timeouts for all commands (max 60s for most operations)
  * Force non-interactive mode with appropriate flags
  * Ensure clean exit with proper status codes
  * Handle errors gracefully with meaningful messages
  *(Treat `AGENTS.md` like README in terms of public visibility - no secrets.)* ([All About Artificial][10])

### Scope limits

* What the agent must not attempt (eg cloud infra changes, data migrations without approval).
* Escalation path - when to hand off to a human.

### Operational guidelines

* **Research and validation requirements:**
  * Always check documentation first before making changes
  * Look up current best practices for the technology being used
  * Validate external sources and references
  * Cross-reference against relevant standards and style guides
* **CI/CD and workflow compliance:**
  * Run all pre-commit hooks and ensure they pass
  * Verify CI workflows will pass before submitting
  * Fix issues properly (root causes, not workarounds)
  * Preserve existing functionality while making improvements
  * Test thoroughly in clean environments

---

## Style for machines

* Prefer **bullets over prose**. One command per bullet in backticks.
* Keep under \~150 lines if possible - link out for depth.
* Use stable headings: “Setup”, “Build & test”, “Style”, “Git & PR”, “Security”, “Gotchas”.
* Use relative links to repo docs - agents may not fetch the web.
* Avoid “do the usual” - spell out the command.
  *(Agents ingest this as context and perform better with concise, explicit steps.)* ([docs.factory.ai][7])

---

## Keeping it current

* Update `AGENTS.md` **in the same PR** when build, test, or style commands change.
* Add CI that runs the documented commands to catch drift.
* Review `AGENTS.md` in release checklists.
* In monorepos, keep local files aligned with root defaults. ([AIMultiple][5])

---

## How to ensure rules are followed

**Automate enforcement**

* Pre-commit hooks: formatter + linter.
* CI required checks: build, full tests, coverage threshold, type check.
* PR templates mirroring the after-task checklist.
* Fail the pipeline if any documented command fails.

**Design for agent loops**

* Make commands **idempotent** and fast.
* Provide a small **offline demo** dataset or target to run tests without secrets.
* Prefer one “full suite” command rather than many variants.

**Human in the loop**

* Require code review for protected areas.
* Reject PRs that skip the documented proof steps.

> The aim is parity: agents use the same enforcement pipeline humans do. ([OpenAI][9])

---

## Example `AGENTS.md` skeleton

```markdown
# AGENTS.md

## Project map
- Purpose: {{one-line}}
- Key dirs:
  - /src – app code
  - /tests – test suites
  - /docs – docs
- Do not modify: /public/**, /generated/**

## Setup
- Install deps: `{{install_cmd}}`
- Start services: `{{services_cmd}}`
- Env: set `FOO_API_KEY` in your shell – never commit secrets

## Build & test
- Build: `{{build_cmd}}`
- Full tests: `{{test_cmd}}`
- Focused tests: `{{test_filter_cmd}}`
- Type check: `{{types_cmd}}`
- Lint & format: `{{format_cmd}} && {{lint_cmd}}`
- Success criterion: all commands above pass

## Style & conventions
- Formatter: run `{{format_cmd}}` before commit
- Lint rules that matter: {{brief}}
- Naming/layout: {{brief}}

## Git & PR
- Branch: `feature/<slug>` or `fix/<slug>`
- Commits: Conventional Commits – e.g. `feat(api): add login`
- PR checklist: summary, tests, screenshots, docs, changelog

## Security
- Never commit secrets or `.env` files
- Do not log PII
- Protected: `/secrets/**`, `/migrations/**` (approval required)

## Gotchas
- After adding a model: run `{{migrate_cmd}}`
- Frontend uses pnpm, not npm

## Task workflow
### Before
- `{{install_cmd}}` → `{{build_cmd}}` → `{{test_cmd}}` must pass on main
### During
- Plan edits, then loop: edit → `{{format_cmd}}` → `{{lint_cmd}}` → `{{build_cmd}}` → focused tests
### After
- Run full suite and type check
- Prepare commit and PR body using the rules above
```

---

## Anti-patterns

* Long essays - agents need commands, not prose.
* Multiple conflicting sources of truth - consolidate here and link out.
* Hidden prereqs - if it isn’t in `AGENTS.md`, assume the agent won’t know.
* Secrets in the file - treat it as public. ([All About Artificial][10])

---

## References

* **AGENTS.md - open format and examples**. ([agents.md][1])
* **OpenAI GitHub `openai/agents.md`** - minimal examples and positioning. ([GitHub][2])
* **Why unify agent rules into one file** - background on replacing tool-specific configs. ([devcenter.upsun.com][3])
* **Monorepos and local overrides** - nearest-file behaviour. ([AIMultiple][5], [Rimusz Blog][6])
* **Agent safety and predictable execution** - OpenAI’s practical agent guidance. ([OpenAI][9])
* **OpenAI Codex note on using `AGENTS.md`** - agent guidance from within repos. ([OpenAI][11])

---

**Licence for this guide**
You can copy and adapt this guide in your repos. Keep a link back to the references above if you publish it.

[1]: https://agents.md/?utm_source=chatgpt.com "AGENTS.md"
[2]: https://github.com/openai/agents.md?utm_source=chatgpt.com "AGENTS.md — a simple, open format for guiding coding ..."
[3]: https://devcenter.upsun.com/posts/why-your-readme-matters-more-than-ai-configuration-files/?utm_source=chatgpt.com "Why your README matters more than AI configuration files"
[4]: https://www.infoq.com/news/2025/08/agents-md/?utm_source=chatgpt.com "AGENTS.md Emerges as Open Standard for AI Coding ..."
[5]: https://research.aimultiple.com/agents-md/?utm_source=chatgpt.com "Agents.md: The README for Your AI Coding Agents"
[6]: https://rimusz.net/unlocking-the-power-of-ai-coding-agents-a-deep-dive-into-openais-agents-md-format/?utm_source=chatgpt.com "Unlocking the Power of AI Coding Agents: A Deep Dive into ..."
[7]: https://docs.factory.ai/factory-cli/configuration/agents-md?utm_source=chatgpt.com "AGENTS.md"
[8]: https://platform.openai.com/docs/guides/agents?utm_source=chatgpt.com "OpenAI Agents API documentation"
[9]: https://cdn.openai.com/business-guides-and-resources/a-practical-guide-to-building-agents.pdf?utm_source=chatgpt.com "A practical guide to building agents"
[10]: https://allaboutartificial.com/agents-md-a-new-standard-to-teach-ai-coding-agents-what-humans-know/?utm_source=chatgpt.com "AGENTS.md: GitHub's AI Coding Agent Standard - AI Tools"
[11]: https://openai.com/index/introducing-codex/?utm_source=chatgpt.com "Introducing Codex"
