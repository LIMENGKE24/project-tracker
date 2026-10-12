# Project-Tracker — cross-project status board (created 2026-10-02)

Tracks all of Mengke's concurrent research projects. The **source of truth is the Apple Reminders
list "Projects"** (iCloud account), one undated-or-dated reminder per project, named `N · <title>`
where N is the priority rank. The body of each reminder has fixed lines:
`Tool/folders | Now: | Next: | Open: (optional) | Est. finish | Updated YYYY-MM-DD`.

## Projects (rank = priority)
| # | Project | Tool | Local folder(s) | Cluster |
|---|---|---|---|---|
| 1 | Paper: bottleneck pre-opening (own, Nature draft, deadline 2026-10-07) | Codex | `~/Documents/ChatGPT/paper-bottleneck-pre-open`, `~/Documents/AIMD-NaSbWS`, `~/Documents/Other-superionic-bottleneck` (text in Overleaf) | fornax |
| 2 | CRP PVDF-HFP/PAN MD + Li DFT binding | Claude | `ClaudeCode/CRP-Polymer-Electrolytes/{CRP-Cooperate,CRP-DFT-binding}` | vanda |
| 3 | MOF rotor cooperation | Codex | `~/Documents/MOF-Cooperate` | vanda |
| 4 | NaCaSbS AIMD cooperation | Codex | `~/Documents/ChatGPT/NaCaSbS-AIMD-Cooperate` | vanda/hopper |
| 5 | TFSI/BOB Na+ in PEO | Claude | `ClaudeCode/CRP-Polymer-Electrolytes/TFSI-BOB` | vanda |
| 6 | HiTPoly high-throughput with solvent (own) | Claude | `ClaudeCode/CRP-Polymer-Electrolytes/{HiTPoly-fornax,CRP-high-throughput-screening}` | hopper H200, fornax |
| 7 | HPC server benchmark / Pareto front | Claude | `ClaudeCode/pareto-front`, repo `LIMENGKE24/hpc-benchmark` | all |

## Pieces
- `tools/seed_projects_reminders.applescript` — creates the list and the 7 reminders from scratch (re-run only to rebuild).
- `pulse/pulse_YYYY-MM-DD.md` — daily briefs written by the manual-run scheduled task **project-pulse**
  (`~/.claude/scheduled-tasks/project-pulse/SKILL.md`; start it from the Scheduled sidebar → Run now).
- Updating one reminder from any session:
  `osascript -e 'tell application "Reminders" to tell list "Projects" to set body of (first reminder whose name starts with "2 ·") to "..."'`

## Rules
- Never complete/delete/rename reminders or change priorities from scripts; only rewrite bodies and, with justification, due dates.
- Never cat whole Claude/Codex transcripts (up to 90 MB); stream and extract the last user/assistant messages.
- Say explicitly when a cluster could not be reached; never invent job status.
