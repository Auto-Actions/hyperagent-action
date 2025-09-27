#!/bin/sh

set -e

# Ensure we're in the workspace directory
cd "${GITHUB_WORKSPACE}"

# Verify git repository
if [ ! -d ".git" ]; then
    echo "Error: No .git directory found in workspace"
    exit 1
fi

# Set git safe directory
git config --global --add safe.directory "${GITHUB_WORKSPACE}"

# Run the main Node.js script
exec node /app/index.js