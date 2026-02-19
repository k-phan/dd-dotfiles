## Agents

Agent prompt files are at ~/.claude/agents/. When asked to orchestrate, plan, or work on a ticket, read the relevant prompt file and follow its instructions. Run artifacts go to ~/.claude/agents/.runs/<ticket-id>/.

Available agents:
- `~/.claude/agents/orchestrator.md` — Top-level orchestrator for parallel ticket execution
- `~/.claude/agents/planner.md` — Engineering lead that builds dependency graphs and assigns work
- `~/.claude/agents/ticket-worker.md` — Implements a single ticket end-to-end
- `~/.claude/agents/worktree-manager.md` — Manages git worktree lifecycle
