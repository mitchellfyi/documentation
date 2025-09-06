# The Definitive Guide to a High-Impact GitHub README

A practical, language-agnostic playbook for READMEs that are clear, persuasive, and easy for both humans and AI agents to parse.

---

## Table of contents

- [Who this is for](#who-this-is-for)
- [Core principles](#core-principles)
- [Canonical README structure](#canonical-readme-structure)
- [Linking out to deeper docs](#linking-out-to-deeper-docs)
- [AI-readability checklist](#ai-readability-checklist)
- [Light marketing without the cringe](#light-marketing-without-the-cringe)
- [Copy-paste templates](#copy-paste-templates)
- [Badges, visuals, and extras](#badges-visuals-and-extras)
- [Pre-release checklist](#pre-release-checklist)
- [Maintenance checklist](#maintenance-checklist)
- [References and examples](#references-and-examples)

---

## Who this is for

Any code project that needs to:

- Explain what it is, who it is for, and why it matters.
- Onboard users fast with a minimal Quickstart.
- Persuade with clear differentiation and proof.
- Invite adoption, collaboration, and contributions.

Works for open source, internal tools, research code, libraries, CLIs, services, and apps.

---

## Core principles

1. **Demo first** - lead with a live link and a 15 to 60 second GIF. Prove value in seconds.
2. **Clarity** - plain English, minimal assumptions, short sentences.
3. **Skimmable** - headings, bullets, and examples over prose.
4. **Fast start** - a working Quickstart within 60 seconds.
5. **Split depth** - README for overview, `docs/` for detail.
6. **Slight sell** - why this over alternatives, shown not hyped.
7. **AI-ready** - structured sections, explicit labels, stable links.
8. **Truthful and current** - keep it accurate or mark status clearly.

---

## Canonical README structure

Use the sections below in this order. Omit what you do not need, but keep the top six.

### 1) Title and one-line tagline

- Project name as `# Heading`.
- One sentence that states category and outcome.
- Optional 3 bullets for highlights or constraints.

```
# Chronos
Time-series toolkit for anomaly detection and forecasting.
- Production pipelines
- Pluggable models
- Works with Postgres and S3
```

### 2) Demo — live and visual

- **Live link** to a running instance, playground, notebook, or package example.
- **One short GIF** or screenshot showing the core flow. Keep it under 5 MB, 15 to 60 seconds.
- Optional quick captions for what the viewer is seeing.

```markdown
**Live demo**: https://demo.example.com  
![Detect anomalies from a CSV in 15 seconds](docs/assets/demo.gif)
```

If you cannot host a live demo, provide a reproducible local demo script that runs offline with bundled sample data.

### 3) TL;DR

- Who it is for, the problem, the outcome. One short paragraph.

> For data engineers who need fast anomaly detection, Chronos is a time-series toolkit that turns raw CSVs into actionable signals in under a minute.

### 4) Quickstart

- Fastest path to a running example. Prefer one command per step.

```bash
# Install
pip install chronos-ts

# Run a demo
chronos demo ./data/retail.csv
```

If there are multiple install methods, show the simplest here and link others:

- Docker
- From source
- Package managers

### 5) Basic usage example

- One minimal example with expected output.

```bash
chronos detect --input data.csv --column revenue
# -> prints timestamped anomalies and scores
```

More examples: link to `docs/USAGE.md` or tutorials.

### 6) Differentiation

- 3 to 5 bullets on what makes it different or better.
- Optional short comparison table linking to alternatives doc.

### 7) Features

- Capabilities and outcomes, not internals. Group by user goal if useful.

### 8) Requirements and compatibility

- Supported OS, runtime versions, CPU or GPU needs.
- Breaking version notes if relevant.

### 9) Configuration

- Table of key options and defaults. Link to full reference.

### 10) Architecture snapshot (optional)

- One diagram or paragraph. Link to `docs/ARCHITECTURE.md` for depth.

### 11) Roadmap and status

- Current status: experimental, beta, stable, maintenance, archived.
- Short roadmap bullets or link to milestones.

### 12) Support

- Primary channel: issues, discussions, email, chat.
- Response expectations if you want to set them.

### 13) Contributing

- Invite contributions. Link to `docs/CONTRIBUTING.md` and `docs/CODE_OF_CONDUCT.md`.

### 14) Security

- How to report vulnerabilities. Link to `docs/SECURITY.md`.

### 15) License

- License name and link to `LICENSE`.

### 16) Acknowledgements and credits

- People, projects, or sponsors to credit.

---

## Linking out to deeper docs

Keep the README lean. Put depth in `docs/` and reference it clearly.

Recommended layout:

```
.
├─ README.md
├─ LICENSE
├─ docs/
│  ├─ QUICKSTART.md
│  ├─ USAGE.md
│  ├─ INSTALL.md
│  ├─ CONFIGURATION.md
│  ├─ ARCHITECTURE.md
│  ├─ ROADMAP.md
│  ├─ CONTRIBUTING.md
│  ├─ CODE_OF_CONDUCT.md
│  └─ SECURITY.md
└─ .github/
   ├─ ISSUE_TEMPLATE.md
   └─ PULL_REQUEST_TEMPLATE.md
```

Use stable relative links so they work on and off GitHub.

---

## AI-readability checklist

- Clear section headings that match common labels: Demo, TL;DR, Quickstart, Usage, Features, Requirements, License, Security, Contributing.
- Short **context block** near the top:

```yaml
project: Chronos
domain: time-series analysis
audience: data engineers, ML engineers
interfaces: CLI, Python API
runtime: Python 3.10+
storage: local FS, S3
status: beta
license: MIT
support: GitHub Issues
```

- One minimal working command that does not require secrets.
- Explicit versions, not “latest”.
- Tables for options and outputs with clear headers.
- Stable links to deeper docs and demo.
- Explicit status: active, maintenance, or archived.

---

## Light marketing without the cringe

You are positioning, not pitching.

- **Positioning statement**: “For \[audience] who need \[outcome], \[project] is a \[category] that \[value]. Unlike \[alternatives], it \[differentiator].”
- **Social proof**: small badge row for stars, releases, CI passing, coverage, package downloads.
- **Evidence**: short benchmarks, a 20–60 second GIF, a link to a case study or blog post.
- **Honest constraints**: what it does not do yet. Builds trust.

---

## Copy-paste templates

### A) Minimal README (internal tools or small utilities)

```markdown
# <Project Name>

<TL;DR one sentence: what, who, outcome>

## Quickstart

<One command install or run>
<One command demo>

## Usage

<Smallest useful example with expected output>

## Features

- <Cap 1>
- <Cap 2>
- <Cap 3>

## Requirements

<OS/runtime versions, hardware if relevant>

## Support

<Issues link or internal channel>

## License

<License name> – see [LICENSE](LICENSE).
```

### B) Standard README (open source library or CLI)

````markdown
# <Project Name>

<One-line tagline>

> TL;DR: <who it is for> get <outcome> using a <category> that <how>.

[Quickstart](#quickstart) · [Usage](#usage) · [Features](#features) · [Docs](docs/QUICKSTART.md) · [Contributing](docs/CONTRIBUTING.md)

## Differentiation

- <Why this over alternatives 1>
- <… 2>
- <… 3>

## Quickstart

```bash
# install
<command>
# hello world
<command>
```
````

## Usage

```bash
<command example>
```

Expected:

```
<short output>
```

## Features

- <Feature with benefit>
- <…>
- <…>

## Requirements

- \<runtime, OS, versions>

## Support

- Issues: <link>
- Discussions: <link>

## Contributing

See [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md). Please read our [Code of Conduct](docs/CODE_OF_CONDUCT.md).

## Security

Please see [docs/SECURITY.md](docs/SECURITY.md) for reporting instructions.

## License

<License> – see [LICENSE](LICENSE).

## Acknowledgements

- <Credits>

````

### C) Service or app README

Add a brief architecture snapshot and deployment link:

```markdown
## Architecture
- API: <stack>
- Worker: <stack>
- Storage: <DBs, buckets>
- Infra: <orchestration, CI/CD>

## Deploy
- Docker: [docs/INSTALL.md](docs/INSTALL.md)
- Cloud template: [docs/DEPLOY.md](docs/DEPLOY.md)
````

---

## Badges, visuals, and extras

### Badges

Place under the title. Only what helps decision-making.

```markdown
[![CI](https://img.shields.io/github/actions/workflow/status/<org>/<repo>/ci.yml)](…) [![PyPI](https://img.shields.io/pypi/v/<pkg>)](…) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
```

### Visuals

- One clean screenshot or a short GIF that demonstrates the core flow.
- Keep images in `docs/assets/` and reference with relative paths.
- Provide alt text.

```markdown
![Detect anomalies from a CSV in 15 seconds](docs/assets/demo.gif)
```

### Comparison table (optional)

```markdown
| Feature                | This project | Alt A | Alt B |
| ---------------------- | ------------ | ----- | ----- |
| Streaming              | Yes          | No    | Yes   |
| Pluggable models       | Yes          | No    | No    |
| Zero-config quickstart | Yes          | No    | No    |
```

---

## Pre-release checklist

- [ ] Demo section is directly under the title and works.
- [ ] GIF is 15 to 60 seconds, under 5 MB, clearly shows core flow.
- [ ] Quickstart is a copy-paste that works.
- [ ] One minimal usage example with expected output.
- [ ] Differentiation is clear and honest.
- [ ] Features state outcomes, not internals.
- [ ] Requirements list exact versions.
- [ ] Support and contribution links work.
- [ ] License is declared and file exists.
- [ ] Security policy and contact are present if relevant.
- [ ] All `docs/` links resolve.

---

## Maintenance checklist

- [ ] Update demo and GIF when UX changes.
- [ ] Review Quickstart quarterly.
- [ ] Validate links automatically in CI.
- [ ] Keep status current: active, maintenance, archived.
- [ ] Rotate badges if they no longer add value.
- [ ] Compress images and GIFs to keep repo lean.
