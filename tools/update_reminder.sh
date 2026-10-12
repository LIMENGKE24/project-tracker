#!/bin/zsh
# Usage: tools/update_reminder.sh <rank> "<body text with \n newlines>"
# Rewrites the body of the reminder named "<rank> · ..." in the Apple Reminders list "Projects".
set -e
rank="$1"; body="$2"
[[ -z "$rank" || -z "$body" ]] && { echo "usage: $0 <rank> <body>"; exit 1; }
esc=${body//\\/\\\\}; esc=${esc//\"/\\\"}
osascript -e "tell application \"Reminders\" to tell list \"Projects\" to set body of (first reminder whose name starts with \"$rank ·\") to \"$esc\""
