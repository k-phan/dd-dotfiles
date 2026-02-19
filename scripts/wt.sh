#!/usr/bin/env bash

set -euo pipefail

# Directory where worktrees live (change as desired)
WORKTREE_BASE="${HOME}/worktrees"

# Ensure the worktree base directory exists
if [ ! -d "$WORKTREE_BASE" ]; then
    mkdir -p "$WORKTREE_BASE"
fi

if [[ $# -ne 1 ]]; then
    echo "Usage: wt <branch-name>"
    exit 1
fi

BRANCH="$1"
WORKTREE_PATH="$WORKTREE_BASE/$BRANCH"

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || true)"
if [[ -z "$REPO_ROOT" ]]; then
    echo "Error: Must be run inside a git repository."
    exit 2
fi

git fetch origin

TARGET_PATH="$WORKTREE_PATH/$BRANCH"

if git worktree list | grep -qw "$TARGET_PATH"; then
    echo "Worktree already exists at $TARGET_PATH"
    cd "$TARGET_PATH"
    # Symlink .claude/settings.local.json
    CLAUDE_DIR="$TARGET_PATH/.claude"
    SETTINGS_SRC="$HOME/settings.local.json"
    SETTINGS_DEST="$CLAUDE_DIR/settings.local.json"
    if [ -f "$SETTINGS_SRC" ]; then
        mkdir -p "$CLAUDE_DIR"
        ln -sf "$SETTINGS_SRC" "$SETTINGS_DEST"
        echo "Symlinked $SETTINGS_SRC to $SETTINGS_DEST"
    fi
    exit 0
fi

git worktree add -b "$BRANCH" "$TARGET_PATH" origin/main
echo "Worktree created at $TARGET_PATH"
cd "$TARGET_PATH"

# Symlink .claude/settings.local.json
CLAUDE_DIR="$TARGET_PATH/.claude"
SETTINGS_SRC="$HOME/settings.local.json"
SETTINGS_DEST="$CLAUDE_DIR/settings.local.json"
if [ -f "$SETTINGS_SRC" ]; then
    mkdir -p "$CLAUDE_DIR"
    ln -sf "$SETTINGS_SRC" "$SETTINGS_DEST"
    echo "Symlinked $SETTINGS_SRC to $SETTINGS_DEST"
fi
