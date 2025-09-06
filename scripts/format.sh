#!/bin/bash
# Format all Markdown files using Prettier
# Part of the documentation linting toolkit

set -euo pipefail

echo "🎨 Formatting Markdown files with Prettier..."

# Check if npm is available
if ! command -v npm >/dev/null 2>&1; then
    echo "❌ Error: npm is not installed or not in PATH"
    exit 1
fi

# Format with timeout and proper logging
if timeout 30s npx prettier . --write --log-level warn; then
    echo "✅ Formatting completed successfully"
    exit 0
else
    echo "❌ Formatting failed or timed out"
    exit 1
fi
