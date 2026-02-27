#!/usr/bin/env bash
# Sync zshmarks bookmarks from the experimental repo.
# Requires the experimental repo to be cloned first (setup-experimental.sh).

set -euo pipefail

SYNC_SCRIPT="$HOME/dd/experimental/users/khai.phan/bookmarks/sync.sh"

if [ ! -f "$SYNC_SCRIPT" ]; then
  echo "Bookmarks sync script not found at $SYNC_SCRIPT — skipping"
  exit 0
fi

bash "$SYNC_SCRIPT"
