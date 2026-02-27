#!/usr/bin/env bash
# Set up PGSM (postgres_alembic) PYTHONPATH.
# Delegates to the experimental repo where the actual paths are kept private.

set -euo pipefail

SETUP_SCRIPT="$HOME/dd/experimental/users/khai.phan/datadog/setup-pgsm.sh"

if [ ! -f "$SETUP_SCRIPT" ]; then
  echo "PGSM setup script not found at $SETUP_SCRIPT — skipping"
  exit 0
fi

bash "$SETUP_SCRIPT"
