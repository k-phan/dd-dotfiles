#!/usr/bin/env bash
# Run after install.sh to set up components that require manual intervention
# (e.g., private repo access). Can be re-run safely at any time.

set -euo pipefail

DOTFILES_PATH="$HOME/dotfiles"

"$DOTFILES_PATH/scripts/setup-experimental.sh"
"$DOTFILES_PATH/scripts/setup-bookmarks.sh"
"$DOTFILES_PATH/scripts/setup-pgsm.sh"

