#!/bin/bash
#
# Slack Notifications via Staging Atlas for Claude Code
#

# This ensures the script exits immediately if any command fails,
# preventing subsequent commands from running after an error.
set -e


SETTINGS_FILE="$HOME/.claude/settings.json"

NOTIFICATION_HOOKS='{
  "hooks": {
    "Notification": [
      {
        "matcher": "permission_prompt|idle_prompt|elicitation_dialog",
        "hooks": [{"type": "command", "command": "(atlas workflow start --workflow-type slack.SlackService_PostDirectMessage --context staging --task-queue slack --request-email khai.phan@datadoghq.com --request-message \"{\\\"text\\\":\\\"Need your input\\\"}\" >/dev/null 2>&1 &) >/dev/null 2>&1"}]
      }
    ],
    "Stop": [
      {
        "hooks": [{"type": "command", "command": "(atlas workflow start --workflow-type slack.SlackService_PostDirectMessage --context staging --task-queue slack --request-email khai.phan@datadoghq.com --request-message \"{\\\"text\\\":\\\"Task completed\\\"}\" >/dev/null 2>&1 &) >/dev/null 2>&1"}]
      }
    ]
  }
}'


echo "Configuring Claude Code notifications..."
mkdir -p "$HOME/.claude"

if [ -f "$SETTINGS_FILE" ]; then
  echo "Backing up existing settings to $SETTINGS_FILE.bak"
  cp "$SETTINGS_FILE" "$SETTINGS_FILE.bak"
  echo "Merging with existing settings..."
  jq -s '.[0] * .[1]' "$SETTINGS_FILE" <(echo "$NOTIFICATION_HOOKS") > /tmp/claude-settings.json
  mv /tmp/claude-settings.json "$SETTINGS_FILE"
else
  echo "Creating new settings file..."
  echo "$NOTIFICATION_HOOKS" > "$SETTINGS_FILE"
fi

echo ""
echo "Done!"
echo ""
echo "You'll now receive notifications in Slack"
echo "  - 'Need your input'  - when Claude needs permission or is waiting"
echo "  - 'Task completed'   - when Claude finishes working"
echo ""
[ -f "$SETTINGS_FILE.bak" ] && echo ""
[ -f "$SETTINGS_FILE.bak" ] && echo "Backup saved: $SETTINGS_FILE.bak"