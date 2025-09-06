# Pull Request

## Summary

<!-- Provide a brief description of what this PR does -->

## Related Issue(s)

<!-- Link to the issue this PR addresses using GitHub keywords -->

Fixes #

<!-- or: Closes #, Resolves #, etc. -->

## Changes Made

<!-- Describe the specific changes in this PR -->

-
-
-

## Quality Checklist

- [ ] **Tests run**: All relevant quality checks have been executed
  - [ ] Format check: `timeout 30s npx prettier . --check`
  - [ ] Markdown linting: `timeout 30s npx markdownlint-cli2 "**/*.md" "#node_modules"`
  - [ ] Spell check: `timeout 60s npx cspell "**/*.md" --no-must-find-files --locale en-GB`
  - [ ] Link validation: Checked for broken links (external failures expected)
- [ ] **Lint run**: All linting checks pass (no new errors introduced)
- [ ] **Documentation updated**: AGENTS.md updated if workflow/setup changes were made
- [ ] **Issue linked**: Related issue(s) properly referenced above
- [ ] **Conventional Commits**: All commit messages follow Conventional Commits format
- [ ] **Backwards compatibility**: Confirmed that anchors/links remain valid

## Evidence

<!-- Paste condensed output from quality checks to show they pass -->

### Format Check

```text
<!-- Output from prettier check -->
```

### Linting Results

```text
<!-- Output from markdownlint, noting only new errors (if any) -->
```

### Spell Check

```text
<!-- Output from cspell, noting only new errors (if any) -->
```

## Additional Notes

<!-- Any other context about the PR -->

---

<!--
Instructions for reviewers:
- Verify all quality checks pass
- Ensure no destructive changes without approval
- Confirm documentation is clear and accurate
- Check that changes align with repository conventions
-->
