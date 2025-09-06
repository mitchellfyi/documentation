#!/bin/bash
# Lint prose quality using Vale (optional)
# Part of the documentation linting toolkit

set -euo pipefail

echo "📖 Checking prose quality with Vale..."

# Check if Vale is available
if command -v vale >/dev/null 2>&1; then
    echo "Vale found, running prose lint..."
    if timeout 30s vale .; then
        echo "✅ Prose linting passed"
        exit 0
    else
        echo "❌ Prose linting failed or timed out"
        exit 1
    fi
else
    echo "⚠️  Vale not installed - skipping prose linting"
    echo "Install with: pipx install vale"
    exit 0
fi
