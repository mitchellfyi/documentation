#!/bin/bash
# Spell check all Markdown files using British English
# Part of the documentation linting toolkit

set -euo pipefail

echo "🔤 Spell checking with cspell (British English)..."

# Check if npm is available
if ! command -v npm >/dev/null 2>&1; then
    echo "❌ Error: npm is not installed or not in PATH"
    exit 1
fi

# Spell check with timeout
if timeout 60s npx cspell "**/*.md" --no-must-find-files --unique --show-suggestions --locale en-GB; then
    echo "✅ Spell checking passed"
    exit 0
else
    echo "❌ Spell checking failed or timed out"
    exit 1
fi
