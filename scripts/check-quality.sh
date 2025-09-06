#!/bin/bash
# Complete quality check pipeline for documentation
# Runs all linting, formatting, and validation tools
# Based on AGENTS.md quality gates

set -euo pipefail

echo "🚀 Running complete documentation quality check..."
echo "This includes: formatting, linting, spell check, prose check, and link validation"
echo

# Track overall success
OVERALL_SUCCESS=true

# 1) Check formatting (don't auto-fix, just verify)
echo "1️⃣  Checking formatting..."
if timeout 30s npx prettier . --check; then
    echo "✅ Formatting is correct"
else
    echo "❌ Formatting issues found. Run 'scripts/format.sh' to fix."
    OVERALL_SUCCESS=false
fi
echo

# 2) Lint Markdown style
echo "2️⃣  Linting Markdown style..."
if timeout 30s npx markdownlint-cli2 "**/*.md" "#node_modules"; then
    echo "✅ Markdown linting passed"
else
    echo "❌ Markdown linting failed"
    OVERALL_SUCCESS=false
fi
echo

# 3) Spell check
echo "3️⃣  Spell checking..."
if timeout 60s npx cspell "**/*.md" --no-must-find-files --locale en-GB; then
    echo "✅ Spell checking passed"
else
    echo "❌ Spell checking failed"
    OVERALL_SUCCESS=false
fi
echo

# 4) Prose linting (optional)
echo "4️⃣  Checking prose quality..."
if command -v vale >/dev/null 2>&1; then
    if timeout 30s vale .; then
        echo "✅ Prose linting passed"
    else
        echo "❌ Prose linting failed"
        OVERALL_SUCCESS=false
    fi
else
    echo "⚠️  Vale not installed - skipping prose linting"
    echo "   Install with: pipx install vale"
fi
echo

# 5) Link checking
echo "5️⃣  Checking links..."
LINK_ISSUES=false

# Check README.md first
echo "   Checking README.md..."
if ! timeout 30s npx markdown-link-check -q README.md 2>/dev/null; then
    echo "   ⚠️  Issues found in README.md"
    LINK_ISSUES=true
fi

# Check other files
git ls-files '*.md' | head -20 | while read -r file; do
    if [ "$file" != "README.md" ]; then
        echo "   Checking $file..."
        if ! timeout 10s npx markdown-link-check -q "$file" 2>/dev/null; then
            echo "   ⚠️  Issues found in $file"
            LINK_ISSUES=true
        fi
    fi
done

if [ "$LINK_ISSUES" = "false" ]; then
    echo "✅ Link checking passed"
else
    echo "⚠️  Some link issues found (may be temporary)"
fi
echo

# Final result
if [ "$OVERALL_SUCCESS" = "true" ]; then
    echo "🎉 All quality checks passed!"
    exit 0
else
    echo "💥 Some quality checks failed. Please review and fix the issues above."
    exit 1
fi
