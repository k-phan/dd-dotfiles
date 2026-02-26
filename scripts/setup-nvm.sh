#!/usr/bin/env bash
set -euo pipefail

echo "Installing nvm..."
if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
  echo "nvm installed successfully"
else
  echo "nvm already installed"
fi

# Remove prefix setting from .npmrc that conflicts with nvm
sed -i '/^prefix=/d' "$HOME/.npmrc" 2>/dev/null || true

# Load nvm in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"

echo "Installing Node.js 24..."
nvm install 24

echo "Node.js version: $(node -v)"
echo "npm version: $(npm -v)"
