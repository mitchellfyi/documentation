#!/bin/bash
# Auto-fix issues and then run quality checks
# Based on AGENTS.md workflow recommendations

set -euo pipefail

echo "🔧 Auto-fixing documentation issues and running quality checks..."
echo

# 1) Format first
echo "1️⃣  Formatting Markdown files..."
if timeout 30s npx prettier . --write --log-level warn; then
    echo "✅ Formatting applied"
else
    echo "❌ Formatting failed"
    exit 1
fi
echo

# 2) Run quality checks
echo "2️⃣  Running quality checks..."
exec "$(dirname "$0")/check-quality.sh"
