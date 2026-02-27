#!/usr/bin/env bash
set -euo pipefail

echo "Installing pyenv..."
if [ ! -d "$HOME/.pyenv" ]; then
  curl -fsSL https://pyenv.run | bash
  echo "pyenv installed successfully"
else
  echo "pyenv already installed"
fi

# Add pyenv shell integration to .zshrc if not already present
if ! grep -q 'PYENV_ROOT' ~/.zshrc 2>/dev/null; then
  echo '' >> ~/.zshrc
  echo '# pyenv' >> ~/.zshrc
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
  echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
  echo 'eval "$(pyenv init - zsh)"' >> ~/.zshrc
  echo "pyenv shell integration added to ~/.zshrc"
else
  echo "pyenv shell integration already in ~/.zshrc"
fi

# Set up shell environment for the current session
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

echo "pyenv version: $(pyenv --version)"
