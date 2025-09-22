#!/bin/sh

set -e

# Change to workspace directory
cd "$GITHUB_WORKSPACE"

# Run the main Node.js script
exec node /app/index.js