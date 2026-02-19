# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository that gets applied when provisioning new Datadog devservers. The goal is to set up a new devserver with minimal effort — shell environment, git config, editor settings, and utilities are all deployed automatically.

## Key Files

- `install.sh` — Workspace bootstrap script: symlinks all dotfiles (files starting with `.`) from `~/dotfiles` to `$HOME`, installs zshmarks plugin. Runs automatically when a workspace is created.
- `.zshrc` — Shell config: oh-my-zsh with "apple" theme, git + zshmarks plugins, direnv integration
- `.my-aliases` — Shell aliases for kubectl, Bazel tidy, Claude Code, zshmarks bookmarks, and ddtool auth
- `.gitconfig` — Git config with SSH commit signing, URL rewrite for private DataDog repos (`git@github.com:DataDog/` instead of `https://`)
- `etc/config.yaml` — Devserver workspace config (shell, region, VS Code extensions)
- `etc/workspace-template.code-workspace` — VS Code multi-root workspace template targeting dd-source with Ruff/Python formatting
- `scripts/setup-claude-slack-notifications.sh` — Configures Claude Code hooks to send Slack notifications via Atlas when Claude needs input or completes a task
- `agents/` — Markdown-based agent prompts for multi-agent automation via Claude Code
  - `orchestrator.md` — Orchestrator prompt: delegates to the planner, then creates worktrees and dispatches ticket-workers based on the roadmap
  - `planner.md` — Planner prompt: reads a Jira ticket's children, explores the codebase for file overlap, builds a dependency graph with engineer assignments (2–4), and flags merge conflict risks
  - `ticket-worker.md` — Worker prompt: implements a ticket end-to-end without plan mode, commits incrementally, and pushes a draft PR. Supports operating in a worktree directory.
  - `worktree-manager.md` — Worktree manager prompt: creates and tears down git worktrees in `.worktrees/` for parallel sub-ticket execution
  - `.runs/<ticket-id>/` — Runtime artifacts per orchestrator run (gitignored): `plan/roadmap.json`, `plan/comments.md`, `worktrees.json`, `status.md`

## Architecture

The `install.sh` script is the entry point. It uses `find` to locate all dotfiles in the repo root and symlinks them to equivalent paths under `$HOME`. This means any file starting with `.` added to the repo root will be automatically deployed.

The `etc/` directory holds non-dotfile configuration that isn't symlinked automatically — workspace and editor templates.

The `scripts/` directory holds standalone utilities meant to be run manually.

## Workflow

Whenever files in this repo are added, removed, or modified, update this CLAUDE.md to reflect the changes (add/remove/update entries in Key Files, Architecture, etc.). Keep CLAUDE.md as the single source of truth for what's in the repo.
