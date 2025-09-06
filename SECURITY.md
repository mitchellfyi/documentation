# Security and Secrets Rules for Agents

This document outlines security policies and rules that all AI coding agents must follow when working in this repository.

## Core Security Principles

### Never Commit Secrets

**ABSOLUTE RULE**: Never commit secrets, credentials, tokens, private keys, or sensitive configuration to version control.

**Prohibited items include:**

- API keys and tokens
- Database passwords and connection strings
- Private keys (SSH, TLS, signing keys)
- OAuth client secrets
- Personal access tokens
- Service account credentials
- Internal URLs and endpoints
- User personal information

### Use Environment Variables

**REQUIRED**: All sensitive configuration must use environment variables or dedicated secret management systems.

**Best practices:**

- Reference environment variables in documentation: `DATABASE_URL`, `API_KEY`
- Provide `.env.example` files with placeholder values
- Never commit actual `.env` files containing real values
- Use descriptive variable names that indicate their purpose

### Environment File Guidelines

**For new projects created with the `generate` script:**

- Always create `.env.example` with placeholder values
- Add `.env` to `.gitignore` to prevent accidental commits
- Document required environment variables in README or CONFIGURATION.md
- Use safe placeholder values like `your-api-key-here` or `https://example.com`

**Example `.env.example`:**

```bash
# Database connection
DATABASE_URL=postgresql://user:password@localhost:5432/database

# External services
API_KEY=your-api-key-here
WEBHOOK_SECRET=your-webhook-secret-here

# Optional: development overrides
DEBUG=false
LOG_LEVEL=info
```

## Credential Request Procedures

### For Documentation Projects

If your task requires access to external services or private repositories:

1. **Document the requirement** - Explain why credentials are needed
2. **Request through issues** - Open a GitHub issue with label `credentials-needed`
3. **Specify minimal scope** - Request only the permissions required
4. **Propose alternatives** - Suggest public examples or mock data if possible

### For Code Projects

When working on repositories that require credentials:

1. **Check for `.env.example`** - Look for existing environment variable templates
2. **Follow project conventions** - Use the same variable naming patterns
3. **Document new requirements** - Update `.env.example` and README when adding new variables
4. **Validate configuration** - Ensure the application gracefully handles missing credentials

## Sensitive Paths and Read-Only Files

### Completely Prohibited (Never Modify)

**Security-related files:**

- `**/keys/`, `**/private/`, `**/secrets/` - Any directory containing credentials
- `*.key`, `*.pem`, `*.p12`, `*.pfx` - Private keys and certificates
- `*.env` (except `.env.example`) - Environment files with real values
- `**/.ssh/` - SSH configuration and keys
- `**/tokens/` - Token storage directories

**Generated or managed files:**

- `**/node_modules/` - Package manager dependencies
- `**/dist/`, `**/build/`, `**/target/` - Build artifacts
- `**/.next/`, `**/.nuxt/` - Framework build caches
- `**/coverage/` - Test coverage reports
- `**/*.log` - Log files
- `**/tmp/`, `**/temp/` - Temporary directories

**Configuration requiring approval:**

- `Dockerfile`, `docker-compose.yml` - Container configuration
- `.github/workflows/` - CI/CD pipeline definitions
- `package.json`, `requirements.txt`, `go.mod` - Dependency manifests
- Database migration files
- Infrastructure as code files (Terraform, CloudFormation)

### Read-Only in This Repository

**Core functionality:**

- `/generate` - Main CLI script (complex logic requiring careful review)
- `/scripts/` - Quality checking and automation tools

**Legal and licensing:**

- `LICENSE` - Legal terms and conditions
- `SECURITY.md` - This file (security policies)

**Configuration files:**

- `.markdownlint.jsonc`, `.prettierrc`, `cspell.json`, `.vale.ini`
- `.gitignore`, `.gitattributes`

## Security Validation Checklist

Before proposing any changes, verify:

- [ ] No secrets, tokens, or credentials in modified files
- [ ] No hardcoded passwords or API keys
- [ ] Environment variables used for all sensitive configuration
- [ ] `.env.example` updated if new variables added
- [ ] No modifications to prohibited paths listed above
- [ ] No sensitive information in commit messages or PR descriptions
- [ ] External links verified as safe and appropriate

## Incident Response

### If Secrets Are Accidentally Committed

1. **Stop immediately** - Do not continue with the current approach
2. **Do not attempt to fix** - Agents cannot safely handle this scenario
3. **Escalate to humans** - Open an issue with label `security-incident`
4. **Provide context** - Explain what was committed and in which commits

**Important**: Git history rewriting requires force-push capabilities that agents do not have.

### If Sensitive Data Is Discovered

1. **Document the finding** - Note the location and type of sensitive data
2. **Do not expose details** - Avoid copying sensitive values in issues or PRs
3. **Escalate appropriately** - Use `security-incident` label for immediate attention
4. **Suggest remediation** - Propose moving to environment variables

## Compliance and Monitoring

### Regular Security Practices

- Review all file modifications for sensitive content
- Validate that new documentation follows security guidelines
- Ensure example code uses placeholder values
- Check that `.gitignore` files prevent credential commits

### Tool Integration

Some repositories may include automated security scanning:

- **Secret scanning** - GitHub Advanced Security features
- **Dependency scanning** - Dependabot alerts for vulnerable packages
- **Code scanning** - CodeQL or similar static analysis tools

**Agent responsibility**: Acknowledge and respect security tool outputs, but do not attempt to bypass or disable security measures.

## Examples and Templates

### Safe Documentation Examples

**Good - uses environment variables:**

```bash
# Connect to database
DATABASE_URL=${DATABASE_URL} npm start
```

**Bad - hardcoded credentials:**

```bash
# Connect to database
DATABASE_URL=postgresql://admin:secret123@prod.db.company.com:5432/app npm start
```

### Safe Configuration Templates

**Good - `.env.example`:**

```bash
# Required: Database connection
DATABASE_URL=postgresql://username:password@host:port/database

# Optional: External API
WEATHER_API_KEY=your-weather-api-key-here
```

**Bad - actual values:**

```bash
DATABASE_URL=postgresql://admin:prod_password_2024@db-cluster.internal:5432/production
WEATHER_API_KEY=sk_live_AbCdEf123456789
```

## Questions and Exceptions

### When These Rules May Not Apply

- **Public demonstration projects** - Where fake/demo credentials are educational
- **Historical documentation** - Referencing past security practices (with clear warnings)
- **Security education** - Teaching about security anti-patterns (with clear context)

### Getting Clarification

If you're unsure whether something violates these security rules:

1. **Err on the side of caution** - When in doubt, don't include it
2. **Ask for guidance** - Open an issue with label `security-question`
3. **Provide context** - Explain your use case and why you need the information
4. **Suggest alternatives** - Propose safer approaches to achieve the same goal

---

## References

- **GitHub Secret Scanning Documentation**: [GitHub Docs](https://docs.github.com/en/enterprise-cloud@latest/code-security/secret-scanning)
- **Environment Variable Best Practices**: [12-Factor App Config](https://12factor.net/config)
- **OWASP Secure Coding Practices**: [OWASP Guide](https://owasp.org/www-project-secure-coding-practices-quick-reference-guide/)
