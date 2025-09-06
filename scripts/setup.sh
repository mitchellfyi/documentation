#!/bin/bash
# Setup script for documentation tooling
# Installs required tools as specified in AGENTS.md

set -euo pipefail

echo "🛠️  Setting up documentation tooling..."
echo

# Check Node.js and npm
echo "Checking Node.js and npm..."
if ! command -v node >/dev/null 2>&1; then
    echo "❌ Node.js is not installed. Please install Node.js 20+ first."
    exit 1
fi

if ! command -v npm >/dev/null 2>&1; then
    echo "❌ npm is not installed. Please install npm first."
    exit 1
fi

NODE_VERSION=$(node --version | sed 's/v//')
echo "✅ Node.js version: $NODE_VERSION"
echo "✅ npm version: $(npm --version)"
echo

# Check Python and pipx for Vale (optional)
echo "Checking Python and pipx for Vale..."
if command -v python3 >/dev/null 2>&1; then
    PYTHON_VERSION=$(python3 --version | cut -d' ' -f2)
    echo "✅ Python version: $PYTHON_VERSION"
    
    if command -v pipx >/dev/null 2>&1; then
        echo "✅ pipx is available"
        echo "Installing Vale..."
        if pipx install vale 2>/dev/null; then
            echo "✅ Vale installed successfully"
        else
            echo "⚠️  Vale may already be installed or installation failed"
        fi
    else
        echo "⚠️  pipx not found. Install with: python3 -m pip install --user pipx"
        echo "   Then add pipx to PATH and run: pipx install vale"
    fi
else
    echo "⚠️  Python 3 not found. Vale prose linting will be skipped."
fi
echo

# Test basic tools (they'll be installed on first use via npx)
echo "Testing npm tools availability..."
echo "✅ prettier, markdownlint-cli2, cspell, and markdown-link-check will be installed via npx on first use"
echo

echo "🎉 Setup complete!"
echo
echo "Available scripts:"
echo "  scripts/format.sh           - Format Markdown files"
echo "  scripts/lint-markdown.sh    - Lint Markdown style"
echo "  scripts/spell-check.sh      - Check spelling (British English)"
echo "  scripts/prose-lint.sh       - Check prose quality (requires Vale)"
echo "  scripts/link-check.sh       - Check for broken links"
echo "  scripts/check-quality.sh    - Run all quality checks"
echo "  scripts/fix-and-check.sh    - Auto-fix and check quality"
echo
echo "Run 'scripts/check-quality.sh' to validate your documentation!"
