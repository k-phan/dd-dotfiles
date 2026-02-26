#!/usr/bin/env bash
set -euo pipefail

echo "Installing worktrunk..."
if [ ! -f "$HOME/.cargo/bin/wt" ]; then
  curl --proto '=https' --tlsv1.2 -LsSf https://github.com/max-sixty/worktrunk/releases/download/v0.27.0/worktrunk-installer.sh | sh
  echo "worktrunk installed successfully"
else
  echo "worktrunk already installed"
fi

# Ensure the binary is on PATH for the rest of this script
export PATH="$HOME/.cargo/bin:$PATH"

echo "Installing worktrunk shell integration..."
wt config shell install zsh --yes
echo "worktrunk shell integration installed"
