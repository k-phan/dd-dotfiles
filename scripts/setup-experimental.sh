#!/usr/bin/env bash
# Clone the DataDog/experimental repo.
# Run this manually after install.sh — it requires access to the private repo.

set -euo pipefail

EXPERIMENTAL_DIR="$HOME/dd/experimental"
if [ ! -d "$EXPERIMENTAL_DIR" ]; then
  git clone git@github.com:DataDog/experimental.git "$EXPERIMENTAL_DIR"
  echo "Cloned experimental repo to $EXPERIMENTAL_DIR"
else
  echo "experimental repo already exists at $EXPERIMENTAL_DIR"
fi
