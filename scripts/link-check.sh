#!/bin/bash
# Check for broken links in Markdown files
# Part of the documentation linting toolkit

set -euo pipefail

echo "🔗 Checking links in Markdown files..."

# Check if npm is available
if ! command -v npm >/dev/null 2>&1; then
    echo "❌ Error: npm is not installed or not in PATH"
    exit 1
fi

# Check README.md first (most important)
echo "Checking README.md..."
if ! timeout 30s npx markdown-link-check -q README.md; then
    echo "⚠️  Issues found in README.md"
fi

# Check other Markdown files (limit to first 20 for performance)
echo "Checking other Markdown files..."
git ls-files '*.md' | head -20 | while read -r file; do
    if [ "$file" != "README.md" ]; then
        echo "Checking $file..."
        timeout 10s npx markdown-link-check -q "$file" || echo "⚠️  Issues found in $file"
    fi
done

echo "✅ Link checking completed"
