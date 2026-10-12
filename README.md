# Project-Tracker

A lightweight daily status board for a postdoc juggling several research projects at once. Apple Reminders is the board (desktop widget, phone sync, hand edits), and a manual-run Claude Code routine refreshes it from local folders, Claude/Codex session transcripts and HPC job queues, re-estimating each project's finish date every run.

- **Board**: Apple Reminders list "Projects" (shown on the desktop via the Reminders widget → Edit Widget → list "Projects").
- **Routine**: scheduled task `project-pulse` (manual run from the Scheduled sidebar). It refreshes every reminder's note from local folders, Claude/Codex transcripts and cluster queues, and writes `pulse/pulse_<date>.md`.
- **Rebuild from scratch**: `osascript tools/seed_projects_reminders.applescript` (only if the list is lost; it recreates the 7 items with their 2026-10-01 status).
- Project map and rules: see `CLAUDE.md`.

## What is in this repo
Only the generic parts: project map (`CLAUDE.md`), a sanitised copy of the scheduled-task prompt (`tasks/`), and a helper to rewrite one reminder (`tools/update_reminder.sh`). Daily briefs (`pulse/`) and the seed script with full status text stay local.
