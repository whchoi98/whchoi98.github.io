#!/bin/bash
# Project setup script for new developers.
# Usage: bash scripts/setup.sh
# Adapted for this Jekyll site (Ruby/bundler instead of npm/pip).

set -e

echo "=== Project Setup (whchoi98.github.io) ==="

# Check prerequisites
command -v git >/dev/null 2>&1 || { echo "ERROR: git is required"; exit 1; }
command -v ruby >/dev/null 2>&1 || { echo "ERROR: ruby 3.2+ is required"; exit 1; }

# Make user-level gem binaries available (bundler/jekyll live here)
GEM_BIN="$HOME/.local/share/gem/ruby/3.2.0/bin"
[ -d "$GEM_BIN" ] && export PATH="$GEM_BIN:$PATH"

command -v bundle >/dev/null 2>&1 || { echo "ERROR: bundler is required (gem install bundler --user-install)"; exit 1; }

# Install Ruby dependencies
echo "Installing Ruby dependencies (bundle install)..."
bundle install

# Setup environment
if [ -f ".env.example" ] && [ ! -f ".env" ]; then
    echo "Creating .env from .env.example..."
    cp .env.example .env
    echo "IMPORTANT: Edit .env with your actual values"
fi

# Setup Claude hooks
if [ -d ".claude/hooks" ]; then
    chmod +x .claude/hooks/*.sh
    echo "Claude hooks configured"
fi

if [ -d ".git" ]; then
    # Install commit-msg hook
    if [ -f "scripts/install-hooks.sh" ]; then
        bash scripts/install-hooks.sh
    fi
fi

# Verify the site builds
echo "Verifying local Jekyll build..."
bundle exec jekyll build -d _site

echo "=== Setup Complete ==="
echo "Next steps:"
echo "  1. Read CLAUDE.md for project conventions"
echo "  2. Read docs/onboarding.md for the write -> QA -> publish flow"
echo "  3. Preview locally: bundle exec jekyll serve"
