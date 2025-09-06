<!--
README-TEMPLATE.md
Copy to README.md and replace all {{PLACEHOLDERS}}.
Keep it demo-first, skimmable, and link depth to docs/.
Remove any section marked optional if not relevant.
-->

# {{PROJECT_NAME}}
{{PROJECT_TAGLINE}}  
<!-- One sentence. Category and outcome. Example: "Time-series toolkit for fast anomaly detection in production." -->

<!-- Badges — keep only those that help decisions -->
<!--
[![CI](https://img.shields.io/github/actions/workflow/status/{{GITHUB_ORG}}/{{REPO}}/ci.yml?branch=main)](https://github.com/{{GITHUB_ORG}}/{{REPO}}/actions)
[![Release](https://img.shields.io/github/v/release/{{GITHUB_ORG}}/{{REPO}})](https://github.com/{{GITHUB_ORG}}/{{REPO}}/releases)
[![Coverage](https://img.shields.io/codecov/c/github/{{GITHUB_ORG}}/{{REPO}})](https://codecov.io/gh/{{GITHUB_ORG}}/{{REPO}})
[![License: {{LICENSE_SHORT}}](https://img.shields.io/badge/License-{{LICENSE_SHORT}}-green.svg)](LICENSE)
[![Pkg](https://img.shields.io/{{PKG_ECOSYSTEM}}/v/{{PKG_NAME}})]({{PKG_URL}})
-->

## Demo
**Live demo**: {{DEMO_URL}}  
![{{DEMO_GIF_ALT}}](docs/assets/{{DEMO_GIF_FILENAME}})  
<sub>{{DEMO_CAPTION}}</sub>

> If you cannot host a live demo, provide an offline demo script with bundled sample data.

---

> **TL;DR**  
> For {{AUDIENCE}}, {{PROJECT_NAME}} is a {{CATEGORY}} that {{PRIMARY_OUTCOME}}. Unlike {{ALT_1}} and {{ALT_2}}, it {{KEY_DIFFERENTIATOR}}.

---

## Contents
- [Quickstart](#quickstart)
- [Usage](#usage)
- [Features](#features)
- [Requirements](#requirements)
- [Configuration](#configuration-optional)
- [Differentiation](#differentiation)
- [Architecture](#architecture-optional)
- [Roadmap and status](#roadmap-and-status)
- [Support](#support)
- [Contributing](#contributing)
- [Security](#security)
- [License](#license)
- [Acknowledgements](#acknowledgements)

---

## Context for humans and AI
<!-- Keep this short and explicit. Good for newcomers and tooling. -->
```yaml
project: {{PROJECT_NAME}}
domain: {{DOMAIN}}                  # e.g. time-series, web app, compiler, ops tool
audience: {{PRIMARY_AUDIENCE}}      # e.g. data engineers, SREs, app developers
interfaces: {{INTERFACES}}          # e.g. CLI, REST API, SDKs
runtime: {{RUNTIME_REQS}}           # e.g. Python 3.11+, Node 20+, JVM 17
storage: {{STORAGE_BACKENDS}}       # e.g. Postgres, S3, local FS
deployment: {{DEPLOY_TARGETS}}      # e.g. Docker, K8s, serverless
status: {{STATUS}}                  # experimental, beta, stable, maintenance, archived
license: {{LICENSE_SHORT}}          # e.g. MIT, Apache-2.0
support: {{PRIMARY_SUPPORT_CHANNEL}}# e.g. GitHub Issues, Discussions, email
````

---

## Quickstart

<!-- Fastest path to "it works" in under a minute. Prefer one command per step. -->

```bash
# Install
{{INSTALL_CMD}}    # e.g. pip install chronos-ts

# Run a demo
{{DEMO_CMD}}       # e.g. chronos demo ./data/sample.csv
```

Other installs:

* Docker: see [docs/INSTALL.md](docs/INSTALL.md#docker)
* From source: see [docs/INSTALL.md](docs/INSTALL.md#from-source)
* Package managers: see [docs/INSTALL.md](docs/INSTALL.md#packages)

---

## Usage

<!-- Show the most common path. Include expected output briefly. -->

```bash
{{USAGE_EXAMPLE_CMD}}   # e.g. chronos detect --input data.csv --column revenue
```

Expected:

```
{{EXPECTED_OUTPUT_SNIPPET}}
```

More examples and tutorials: see [docs/USAGE.md](docs/USAGE.md)

---

## Features

<!-- Capabilities and outcomes, not internals. Aim for 5–7 bullets, grouped if useful. -->

* {{FEATURE\_1}} - {{FEATURE\_1\_BENEFIT}}
* {{FEATURE\_2}} - {{FEATURE\_2\_BENEFIT}}
* {{FEATURE\_3}} - {{FEATURE\_3\_BENEFIT}}
* {{FEATURE\_4}} - {{FEATURE\_4\_BENEFIT}}
* {{FEATURE\_5}} - {{FEATURE\_5\_BENEFIT}}

Optional highlights:

* Performance: {{PERF\_CLAIM}}
* Scale: {{SCALE\_CLAIM}}
* Extensibility: {{EXTENSIBILITY\_CLAIM}}

---

## Requirements

<!-- Be exact to reduce surprises. -->

* OS: {{SUPPORTED\_OS}}
* Runtime: {{RUNTIME\_VERSIONS}}
* Hardware: {{CPU\_GPU\_REQUIREMENTS}}
* External deps: {{EXTERNAL\_DEPENDENCIES}}  <!-- e.g. Postgres 14+, CUDA 12, Java 17 -->

Compatibility notes and breaking changes: see [docs/COMPATIBILITY.md](docs/COMPATIBILITY.md)

---

## Configuration (optional)

<!-- Keep key options here. Put full reference in docs. -->

| Option         | Default         | Description         |
| -------------- | --------------- | ------------------- |
| `{{OPTION_1}}` | `{{DEFAULT_1}}` | {{OPTION\_1\_DESC}} |
| `{{OPTION_2}}` | `{{DEFAULT_2}}` | {{OPTION\_2\_DESC}} |
| `{{OPTION_3}}` | `{{DEFAULT_3}}` | {{OPTION\_3\_DESC}} |

Full configuration reference: [docs/CONFIGURATION.md](docs/CONFIGURATION.md)

---

## Differentiation

<!-- Why this over alternatives. Keep it honest. Link to more if needed. -->

* {{DIFF\_POINT\_1}}
* {{DIFF\_POINT\_2}}
* {{DIFF\_POINT\_3}}

<details>
<summary>Quick comparison</summary>

| Feature             | {{PROJECT\_NAME}} | {{ALT\_A}} | {{ALT\_B}} |
| ------------------- | ----------------- | ---------- | ---------- |
| {{FEATURE\_ROW\_1}} | ✅                 | ❌          | ✅          |
| {{FEATURE\_ROW\_2}} | ✅                 | ✅          | ❌          |
| {{FEATURE\_ROW\_3}} | ✅                 | ❌          | ❌          |

More: [docs/ALTERNATIVES.md](docs/ALTERNATIVES.md)

</details>

---

## Architecture (optional)

<!-- One diagram or short paragraph. Put depth in docs. -->

{{ARCHITECTURE\_ONE\_PARAGRAPH}}

![{{ARCH\_DIAGRAM\_ALT}}](docs/assets/{{ARCH_DIAGRAM_FILENAME}})

Deep dive: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)

---

## Roadmap and status

Status: **{{STATUS}}**
Upcoming:

* {{ROADMAP\_ITEM\_1}}
* {{ROADMAP\_ITEM\_2}}
* {{ROADMAP\_ITEM\_3}}

Milestones and issues: {{MILESTONES\_URL}}

---

## Support

* Issues: {{ISSUES\_URL}}
* Discussions or chat: {{DISCUSSIONS\_OR\_CHAT\_URL}}
* Documentation index: [docs/](docs/)

Response expectations: {{SLA\_OR\_EXPECTATIONS}}
Commercial support: {{COMMERCIAL\_SUPPORT\_CONTACT}}  <!-- optional -->

---

## Contributing

We welcome issues, discussions, and pull requests.

* Start here: [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md)
* Please read our [docs/CODE\_OF\_CONDUCT.md](docs/CODE_OF_CONDUCT.md)

Dev setup: [docs/DEVELOPMENT.md](docs/DEVELOPMENT.md)
PR guidelines: [docs/CONTRIBUTING.md#pull-requests](docs/CONTRIBUTING.md#pull-requests)

---

## Security

If you believe you have found a vulnerability, please follow our
security policy: [docs/SECURITY.md](docs/SECURITY.md) and email **{{SECURITY\_CONTACT}}**.

Responsible disclosure is appreciated.

---

## License

{{LICENSE\_LONG}} - see [LICENSE](LICENSE).

---

## Acknowledgements

* {{CREDIT\_1}}
* {{CREDIT\_2}}
* {{SPONSOR\_OR\_GRANT}}

<!-- Optional extras — remove if not needed -->

## Deploy (optional)

* Docker: [docs/INSTALL.md#docker](docs/INSTALL.md#docker)
* Cloud template: [docs/DEPLOY.md](docs/DEPLOY.md)

## Maintainers (optional)

* {{MAINTAINER\_NAME}} - {{CONTACT\_OR\_HANDLE}}
* {{MAINTAINER\_NAME}} - {{CONTACT\_OR\_HANDLE}}

```
