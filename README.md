# Docs: The Definitive Guide to Software Project Documentation

A demo-first, language-agnostic guide that helps teams ship **clear, persuasive, and AI-readable** documentation - from README to deep docs.

## Demo

Generate a production-grade README in 60 seconds with our CLI tool:

```bash
# Remote usage (works in any project)
curl -sSL https://raw.githubusercontent.com/mitchellfyi/documentation/main/generate | bash

# Or install locally and run
./generate
```

The tool will:

1. **Guide you through setup** - Interactive questions to create `docs/context.yaml`
2. **Generate README.md** - Populated from template with your project details
3. **Create docs scaffold** - Standard documentation structure
4. **Show next steps** - Remaining customizations needed

![CLI Demo](docs/assets/demo.gif)  
<sub>Interactive README generation with guided questions</sub>

---

> **TL;DR** This repository is a single source of truth for writing excellent documentation. It gives you a demo-first README pattern, a docs scaffold, **AI-friendly context**, and opinionated checklists backed by the best public guidance. See: Make a README, Awesome README, Diátaxis, and Google/Microsoft style guides. ([Make a README][1], [GitHub][2], [Diátaxis][3], [Google for Developers][4], [Microsoft Learn][5])

## Contents

- [Quickstart](#quickstart)
- [Usage](#usage)
- [Principles](#principles)
- [Structure](#structure)
- [AI-readability](#ai-readability)
- [Style](#style)
- [Governance](#governance)
- [Checklists](#checklists)
- [References](#references)

---

## Quickstart

**Option 1: Use the CLI tool (recommended)**

```bash
# In any project directory
curl -sSL https://raw.githubusercontent.com/mitchellfyi/documentation/main/generate | bash
```

**Option 2: Manual setup**

1. **Download and run the generator**

   ```bash
   curl -sSL https://raw.githubusercontent.com/mitchellfyi/documentation/main/generate -o generate
   chmod +x generate
   ./generate
   ```

2. **Follow the interactive prompts** The tool will ask about your project and create `docs/context.yaml` automatically.

3. **Customize the generated README** Review the output and replace any remaining `[placeholders]` with your specific details.

**Additional setup:**

4. **Pick a licence** and add `LICENSE` If you don't add a licence, others cannot legally use or modify your code. Use **choosealicense.com** to decide. ([GitHub Docs][6], [Choose a License][7])

5. **Add a security policy** in `docs/SECURITY.md` Tell users how to report vulnerabilities; GitHub can surface this automatically in the Security tab. ([GitHub Docs][8])

6. **Adopt versioning and change logs** Follow **SemVer** for versions and **Keep a Changelog** for human-readable release notes. ([Semantic Versioning][9], [keepachangelog.com][10])

---

## Usage

### CLI Tool

The `generate` script works in any project directory:

```bash
# Remote one-liner (installs and runs)
curl -sSL https://raw.githubusercontent.com/mitchellfyi/documentation/main/generate | bash

# Or download first, then run
./generate [OPTIONS]
```

**Options:**

- `--remote` - Download fresh template from GitHub
- `--force` - Overwrite existing files without asking
- `--help` - Show usage information

**Interactive Setup:** If no `docs/context.yaml` exists, the tool will ask guided questions:

- Project name and description
- Domain and audience
- Technical requirements
- License and support channels

**Output:**

- `README.md` - Generated from template with your details
- `docs/context.yaml` - Machine-readable project metadata
- `docs/` - Documentation scaffold structure

### README anatomy (demo-first)

1. **Title & one-line tagline** – what it is and the outcome.
2. **Demo** – live link or 15–60s GIF/screenshot showing the core flow.
3. **TL;DR** – audience, problem, outcome.
4. **Quickstart** – the smallest copy-paste that works.
5. **Usage** – a minimal example with expected output.
6. **Differentiation** – why this over alternatives.
7. **Features** – capabilities as user benefits.
8. **Requirements** – exact versions and constraints.
9. **Configuration** – key options; link to full reference.
10. **Architecture (optional)** – 1 paragraph or diagram; link to deep dive.
11. **Roadmap & status** – honest signal of maturity.
12. **Support** – where to ask; response expectations.
13. **Contributing / Code of Conduct** – invite and set expectations.
14. **Security** – reporting path and expectations.
15. **Licence** – name and link. This pattern reflects community examples and guidance from curated README lists. ([GitHub][2])

### Documentation model (Diátaxis)

Organise deeper docs into the four complementary types:

- **Tutorials** – learning-oriented, step-by-step.
- **How-to guides** – goal-oriented recipes.
- **Reference** – accurate, comprehensive API/config facts.
- **Explanation** – concepts, rationale, trade-offs. This separation matches user needs and reduces doc drift. ([Diátaxis][3])

---

## Principles

- **Demo first** – show value in seconds; then let readers dig.
- **Clarity over cleverness** – short sentences, concrete examples.
- **Split depth** – README for overview; `docs/` for detail.
- **Evidence-based** – benchmarks, links, or screenshots instead of claims.
- **Accessibility** – alt text, headings, tables, and copy-pastable code.
- **Legal and safety basics** – licence, security policy, versioning, changelog. ([GitHub Docs][6], [Semantic Versioning][9], [keepachangelog.com][10])

---

## Structure

Recommended repository layout:

```
.
├─ README.md
├─ README-TEMPLATE.md
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
│  ├─ SECURITY.md
│  └─ context.yaml
└─ .github/
   ├─ ISSUE_TEMPLATE.md
   └─ PULL_REQUEST_TEMPLATE.md
```

**Notes**

- Use _relative links_ so docs render in and out of GitHub.
- GitHub recognises and surfaces README content and common community health files automatically. ([GitHub Docs][11])

---

## AI-readability

Help agents (and new teammates) get context without guessing.

1. **Include `docs/context.yaml`** (see Demo).
2. **Use standard section names** in README: Demo, Quickstart, Usage, Features, Requirements, Configuration, Support, Contributing, Security, Licence.
3. **Prefer explicit versions** – “Python 3.11+”, not “latest”.
4. **Provide one minimal offline demo** – no secrets required.
5. **Tabular options and outputs** with stable headers.
6. **Stable anchors** – keep headings and filenames stable over time.
7. **Follow a recognised style guide** for consistent language that machine translation and extractors handle well. ([Google for Developers][4], [Microsoft Learn][12])

---

## Style

Adopt an established developer documentation style; don’t invent your own.

- **Google developer documentation style guide** – voice/tone, terminology, grammar. ([Google for Developers][4])
- **Microsoft Writing Style Guide** – concise, task-oriented, inclusive language; quick-start guidance for contributors. ([Microsoft Learn][5])

**Practices**

- Use second person (“you”), present tense, and active voice.
- Prefer concrete nouns and verbs over abstractions.
- Use consistent terminology and casing.
- Keep paragraphs short; prefer lists and examples. (See style guides above for specifics.)

---

## Governance

### Licensing

Add a `LICENSE` file and name the licence in README. Use **choosealicense.com** to compare and pick an OSI-approved option that matches your goals. ([Choose a License][7])

### Security policy

Add `docs/SECURITY.md` describing how to report vulnerabilities and what to expect. GitHub can surface this in the **Security** tab. ([GitHub Docs][8])

### Versioning and change management

- **Semantic Versioning (SemVer)** clarifies the meaning of version numbers (MAJOR.MINOR.PATCH). ([Semantic Versioning][9])
- **Keep a Changelog** provides a consistent human-readable format for release notes. ([keepachangelog.com][10])

---

## Checklists

### Pre-release

- [ ] README has **Demo**, **Quickstart**, **Usage** with expected output.
- [ ] `docs/` scaffold created and linked from README.
- [ ] `LICENSE` present; licence named in README. ([Choose a License][7])
- [ ] `docs/SECURITY.md` with reporting path. ([GitHub Docs][8])
- [ ] Versioning policy (SemVer) and `CHANGELOG.md` in place. ([Semantic Versioning][9], [keepachangelog.com][10])
- [ ] Screenshots/GIFs have alt text; code blocks are copy-pastable.
- [ ] Relative links resolve; anchors are stable. ([GitHub Docs][11])

### Maintenance

- [ ] Update demo/GIF when UX changes.
- [ ] Review Quickstart quarterly.
- [ ] Validate links in CI.
- [ ] Keep status current (active, maintenance, archived).
- [ ] Review `context.yaml` on each release.

---

## References

- **Make a README** – what, why, and section guidance (with template). ([Make a README][1])
- **Awesome README** – curated examples and patterns. ([GitHub][2])
- **How to write a good README** – practical, persuasive approach. ([GitHub][13])
- **Diátaxis** – tutorials, how-tos, reference, explanation framework. ([Diátaxis][3])
- **Google developer documentation style guide** – editorial standards. ([Google for Developers][4])
- **Microsoft Writing Style Guide** – concise, inclusive, task-first writing. ([Microsoft Learn][5])
- **Choose a Licence** – selecting an OS licence. ([Choose a License][7])
- **Keep a Changelog** – changelog format and rationale. ([keepachangelog.com][10])
- **Semantic Versioning** – versioning rules and expectations. ([Semantic Versioning][9])

---

## Licence

MIT - see [LICENSE](LICENSE).

---

## Acknowledgements

Thanks to the documentation community and resources above for shaping best practices.

[1]: https://www.makeareadme.com/?utm_source=chatgpt.com "Make a README"
[2]: https://github.com/matiassingers/awesome-readme?utm_source=chatgpt.com "matiassingers/awesome-readme: A curated list of ..."
[3]: https://diataxis.fr/?utm_source=chatgpt.com "Diátaxis"
[4]: https://developers.google.com/style?utm_source=chatgpt.com "About this guide | Google developer documentation style ..."
[5]: https://learn.microsoft.com/en-us/style-guide/welcome/?utm_source=chatgpt.com "Welcome - Microsoft Writing Style Guide"
[6]: https://docs.github.com/articles/licensing-a-repository?utm_source=chatgpt.com "Licensing a repository"
[7]: https://choosealicense.com/?utm_source=chatgpt.com "Choose an open source license | Choose a License"
[8]: https://docs.github.com/en/code-security/getting-started/adding-a-security-policy-to-your-repository?utm_source=chatgpt.com "Adding a security policy to your repository"
[9]: https://semver.org/?utm_source=chatgpt.com "Semantic Versioning 2.0.0 | Semantic Versioning"
[10]: https://keepachangelog.com/en/1.1.0/?utm_source=chatgpt.com "Keep a Changelog"
[11]: https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-readmes?utm_source=chatgpt.com "About the repository README file - GitHub Docs"
[12]: https://learn.microsoft.com/en-us/style-guide/global-communications/writing-tips?utm_source=chatgpt.com "Writing tips - Microsoft Style Guide"
[13]: https://github.com/banesullivan/README?utm_source=chatgpt.com "How to write a good README"
