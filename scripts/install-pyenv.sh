#!/usr/bin/env bash
set -euo pipefail

echo "Installing pyenv..."
if [ ! -d "$HOME/.pyenv" ]; then
  curl -fsSL https://pyenv.run | bash
  echo "pyenv installed successfully"
else
  echo "pyenv already installed"
fi

# Set up shell environment for the current session
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

echo "pyenv version: $(pyenv --version)"
