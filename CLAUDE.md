# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository that gets applied when provisioning new Datadog devservers. The goal is to set up a new devserver with minimal effort — shell environment, git config, editor settings, and utilities are all deployed automatically.

## Key Files

- `install.sh` — Workspace bootstrap script: symlinks all dotfiles (files starting with `.`) from `~/dotfiles` to `$HOME`, installs zshmarks plugin, runs `setup-nvm.sh`, installs Graphite CLI globally via npm, runs `setup-worktrunk.sh`, and runs `setup-pyenv.sh`. Runs automatically when a workspace is created.
- `scripts/setup-nvm.sh` — Installs nvm (v0.40.4) and Node.js 24. Called by `install.sh`.
- `scripts/setup-worktrunk.sh` — Installs worktrunk (v0.27.0) and its zsh shell integration. Called by `install.sh`.
- `post-install.sh` — Runs post-bootstrap setup that requires manual intervention (e.g., private repo access). Invokes `scripts/setup-experimental.sh`, `scripts/setup-bookmarks.sh`, and `scripts/setup-pgsm.sh`. Can be re-run safely. Aliased as `ws-install`.
- `scripts/setup-experimental.sh` — Clones the private `DataDog/experimental` repo. Called by `post-install.sh`.
- `scripts/setup-bookmarks.sh` — Syncs zshmarks bookmarks by running the sync script from `experimental/users/khai.phan/bookmarks/sync.sh`. Called by `post-install.sh`.
- `scripts/setup-pyenv.sh` — Installs pyenv via the recommended automatic installer (pyenv.run). Called by `install.sh`.
- `.zshrc` — Shell config: oh-my-zsh with "robbyrussell" theme, git + zshmarks plugins, direnv integration
- `.my-aliases` — Shell aliases for kubectl, Bazel tidy, Claude Code, zshmarks bookmarks, workspace post-install (`ws-install`), and ddtool auth
- `.gitconfig` — Git config with SSH commit signing, URL rewrite for private DataDog repos (`git@github.com:DataDog/` instead of `https://`)
- `etc/config.yaml` — Devserver workspace config (shell, region, VS Code extensions)
- `etc/workspace-template.code-workspace` — VS Code multi-root workspace template targeting dd-source with Ruff/Python formatting

## Architecture

The `install.sh` script is the entry point. It uses `find` to locate all dotfiles in the repo root and symlinks them to equivalent paths under `$HOME`. This means any file starting with `.` added to the repo root will be automatically deployed.

The `scripts/` directory holds helper scripts called by `install.sh` or run manually (e.g., `setup-experimental.sh`).

The `etc/` directory holds non-dotfile configuration that isn't symlinked automatically — workspace and editor templates.

## Workflow

Whenever files in this repo are added, removed, or modified, update this CLAUDE.md to reflect the changes (add/remove/update entries in Key Files, Architecture, etc.). Keep CLAUDE.md as the single source of truth for what's in the repo.
