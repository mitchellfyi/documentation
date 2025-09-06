#!/bin/bash
# Lint Markdown files for style issues
# Part of the documentation linting toolkit

set -euo pipefail

echo "📝 Linting Markdown files with markdownlint-cli2..."

# Check if npm is available
if ! command -v npm >/dev/null 2>&1; then
    echo "❌ Error: npm is not installed or not in PATH"
    exit 1
fi

# Lint with timeout
if timeout 30s npx markdownlint-cli2 "**/*.md" "#node_modules"; then
    echo "✅ Markdown linting passed"
    exit 0
else
    echo "❌ Markdown linting failed or timed out"
    exit 1
fi
