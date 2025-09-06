# Contributing

Thank you for your interest in contributing to the documentation framework! This guide will help you get started.

## Quick start

1. **Fork the repository** on GitHub
2. **Clone your fork** locally
3. **Create a branch** for your changes
4. **Make your changes** following our guidelines
5. **Test your changes** using our quality tools
6. **Submit a pull request** with a clear description

## Ways to contribute

### 🐛 Report bugs

Found a bug? Please create an issue with:
- Clear description of the problem
- Steps to reproduce
- Expected vs actual behaviour
- Your system details (OS, shell, Node.js version)
- Error messages or logs

**Use the bug report template:**
```markdown
**Bug description**
A clear description of what the bug is.

**Steps to reproduce**
1. Run command '...'
2. See error

**Expected behaviour**
What you expected to happen.

**System info**
- OS: [e.g. macOS 14.1]
- Shell: [e.g. bash 5.2]
- Node.js: [e.g. 20.10.0]

**Additional context**
Any other context about the problem.
```

### 💡 Suggest features

Have an idea? Open a feature request with:
- Clear problem statement
- Proposed solution
- Alternative approaches considered
- Impact on existing users

### 📝 Improve documentation

Documentation improvements are always welcome:
- Fix typos and grammar
- Add examples and clarifications
- Improve structure and organisation
- Translate to other languages

### 🛠 Code contributions

We welcome code contributions for:
- Bug fixes
- New features (discuss first in issues)
- Performance improvements
- Quality tool enhancements

## Development setup

### Prerequisites

- **Git** - Version control
- **Node.js 20+** - For quality tools
- **Bash 4.0+** - For script execution
- **Text editor** - VS Code recommended

### Local setup

1. **Fork and clone:**
   ```bash
   git clone https://github.com/yourusername/documentation.git
   cd documentation
   ```

2. **Install quality tools:**
   ```bash
   # Check Node.js version
   node --version  # Should be 20+
   
   # Install Vale (optional)
   pipx install vale
   ```

3. **Verify setup:**
   ```bash
   # Test the generator
   ./generate --help
   
   # Run quality checks
   npx prettier . --check
   npx markdownlint-cli2 "**/*.md" "#node_modules"
   npx cspell "**/*.md" --no-must-find-files --locale en-GB
   ```

### Development workflow

1. **Create a feature branch:**
   ```bash
   git checkout -b feat/your-feature-name
   # or
   git checkout -b fix/bug-description
   # or  
   git checkout -b docs/improvement-description
   ```

2. **Make your changes:**
   - Follow our coding standards
   - Add tests for new functionality
   - Update documentation as needed

3. **Test your changes:**
   ```bash
   # Format code
   npx prettier . --write
   
   # Lint markdown
   npx markdownlint-cli2 "**/*.md" "#node_modules"
   
   # Check spelling
   npx cspell "**/*.md" --no-must-find-files --locale en-GB
   
   # Test generator functionality
   mkdir test-project
   cd test-project
   ../generate --force
   cd ..
   rm -rf test-project
   ```

4. **Commit your changes:**
   ```bash
   git add .
   git commit -m "feat: add new template variant"
   ```

5. **Push and create PR:**
   ```bash
   git push origin feat/your-feature-name
   ```

## Coding standards

### Bash scripting

- **Style:** Follow Google Shell Style Guide
- **Error handling:** Use `set -e` and proper error checking
- **Functions:** Document with comments
- **Variables:** Use descriptive names, quote properly

**Example:**
```bash
#!/bin/bash
set -e

# Function to validate user input
validate_input() {
    local input="$1"
    if [[ -z "$input" ]]; then
        echo "Error: Input cannot be empty" >&2
        return 1
    fi
}
```

### Documentation

- **Language:** British English (en-GB)
- **Tone:** Clear, concise, helpful
- **Structure:** Use headings, lists, and code blocks
- **Links:** Prefer relative links within repo

**Markdown style:**
```markdown
# Main heading (only one per file)

## Section heading

Use **bold** for emphasis, `code` for commands.

### Subsection

- Use bullet points for lists
- Keep lines under 80 characters when possible
- End files with a newline
```

### Commit messages

Use Conventional Commits format:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**Types:**
- `feat` - New feature
- `fix` - Bug fix
- `docs` - Documentation changes
- `style` - Formatting changes
- `refactor` - Code refactoring
- `test` - Test additions/changes
- `chore` - Build/tool changes

**Examples:**
```
feat(generator): add support for custom templates
fix: resolve template download timeout issue
docs: improve installation instructions
style: format markdown files with prettier
```

## Testing guidelines

### Manual testing

Test the generator with different scenarios:

1. **Fresh installation:**
   ```bash
   # Test remote installation
   curl -sSL https://raw.githubusercontent.com/mitchellfyi/documentation/main/generate | bash
   ```

2. **Interactive setup:**
   ```bash
   # Test with no existing context
   rm -f docs/context.yaml
   ./generate
   ```

3. **Edge cases:**
   ```bash
   # Test with existing README
   echo "# Existing" > README.md
   ./generate --force
   
   # Test with malformed context
   echo "invalid: yaml: content" > docs/context.yaml
   ./generate
   ```

### Quality checks

All contributions must pass:

```bash
# Formatting
npx prettier . --check

# Markdown linting  
npx markdownlint-cli2 "**/*.md" "#node_modules"

# Spell checking
npx cspell "**/*.md" --no-must-find-files --locale en-GB

# Link checking
git ls-files '*.md' | xargs -I{} npx markdown-link-check -q {}
```

### Test checklist

Before submitting a PR:

- [ ] Generator runs without errors
- [ ] Interactive setup works correctly
- [ ] Generated README is properly formatted
- [ ] Template artifacts are cleaned up
- [ ] All quality checks pass
- [ ] Documentation is updated
- [ ] Commit messages follow conventions

## Pull request process

### Before submitting

1. **Check existing issues/PRs** - Avoid duplicates
2. **Discuss large changes** - Open an issue first
3. **Test thoroughly** - Run all quality checks
4. **Update documentation** - Keep docs in sync with code

### PR requirements

Your pull request should include:

1. **Clear title and description**
2. **Reference to related issues** (if any)
3. **Summary of changes made**
4. **Testing evidence** - Show quality checks pass
5. **Breaking change notes** (if applicable)

**PR template:**
```markdown
## Description
Brief description of changes and why they're needed.

## Type of change
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update

## Testing
- [ ] Manual testing completed
- [ ] Quality checks pass (paste output below)
- [ ] Edge cases considered

## Quality check output
```
npx prettier . --check
npx markdownlint-cli2 "**/*.md" "#node_modules"  
npx cspell "**/*.md" --no-must-find-files --locale en-GB
```

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] No breaking changes (or clearly documented)
```

### Review process

1. **Automated checks** - CI/CD runs quality tools
2. **Maintainer review** - Code and approach review
3. **Community feedback** - Others may provide input
4. **Approval and merge** - Once approved by maintainers

**Review criteria:**
- Functionality works as expected
- Code quality meets standards
- Documentation is clear and complete
- No breaking changes without justification
- Fits with project goals and architecture

## Community guidelines

### Code of conduct

We are committed to providing a welcoming and inclusive experience for everyone. Please read our [Code of Conduct](CODE_OF_CONDUCT.md).

### Communication

- **Be respectful** - Treat others with kindness
- **Be constructive** - Provide helpful feedback
- **Be patient** - Reviews take time
- **Be collaborative** - Work together toward solutions

### Getting help

- **Documentation** - Check existing docs first
- **GitHub Discussions** - Ask questions and share ideas
- **Issues** - Report bugs and request features
- **Email** - Contact maintainers for sensitive issues

## Recognition

### Contributors

All contributors are recognised in:
- GitHub contributors page
- Release notes for significant contributions
- Special recognition for major features

### Maintainers

Current maintainers:
- **@mitchellfyi** - Project creator and lead maintainer

Interested in becoming a maintainer? Regular contributors who demonstrate:
- Technical expertise
- Community engagement
- Commitment to project values

May be invited to join the maintainer team.

## Development roadmap

See [ROADMAP.md](ROADMAP.md) for planned features and priorities.

**Current focus areas:**
- Template variants for different project types
- Quality tool integration improvements
- CI/CD integration examples
- Performance optimisations

## License

By contributing, you agree that your contributions will be licensed under the same [MIT License](../LICENSE) as the project.

---

Thank you for contributing to the documentation framework! Your help makes this project better for everyone. 🙏
