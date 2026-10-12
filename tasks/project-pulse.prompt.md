# project-pulse — scheduled-task prompt (sanitised copy)

The live copy is `~/.claude/scheduled-tasks/project-pulse/SKILL.md`; cluster user names, collaborator names and project codes are replaced here.

---

You are running the daily "project pulse" for a postdoc . Work from /Users/mengkeli/Documents/ClaudeCode/Project-Tracker (read its CLAUDE.md first; it holds the project map and rules). Do everything with Bash; do not ask questions; do not modify project files. The only thing you write is the Apple Reminders list "Projects" and a brief file.

## 1. Read the board
Run: osascript -e 'tell application "Reminders" to tell list "Projects" to get {name, body, due date} of every reminder whose completed is false'
Each reminder name starts with "N ·" (N = priority rank). The body has lines "Tool: ... | folders ...", "Now: ...", "Next: ...", "Open: ..." (optional), "Est. finish ...", "Updated YYYY-MM-DD". Keep this structure when you rewrite a body.

## 2. Project → sources map
1 Paper bottleneck pre-opening (Codex): /Users/mengkeli/Documents/ChatGPT/paper-bottleneck-pre-open, /Users/mengkeli/Documents/AIMD-NaSbWS, /Users/mengkeli/Documents/Other-superionic-bottleneck. Manuscript lives in Overleaf (not local). Hard deadline 2026-10-07.
2 CRP PVDF-HFP/PAN MD + Li DFT binding (Claude): /Users/mengkeli/Documents/ClaudeCode/CRP-Polymer-Electrolytes/CRP-Cooperate and CRP-DFT-binding (read their CLAUDE.md). Cluster: vanda.
3 MOF rotor cooperation (Codex): /Users/mengkeli/Documents/MOF-Cooperate. Cluster: vanda.
4 NaCaSbS AIMD (collaborator) (Codex): /Users/mengkeli/Documents/ChatGPT/NaCaSbS-AIMD-Cooperate. Cluster: vanda/hopper.
5 TFSI/BOB Na+ in PEO (Claude): .../CRP-Polymer-Electrolytes/TFSI-BOB (CLAUDE.md). Cluster: vanda, project <code>.
6 HiTPoly high-throughput with solvent (Claude): .../CRP-Polymer-Electrolytes/HiTPoly-fornax and CRP-high-throughput-screening (CLAUDE.md, CAMPAIGN_NOTES.md). Cluster: hopper (H200), fornax backup.
7 HPC server benchmark / pareto-front (Claude): Claude project folder /Users/mengkeli/Documents/ClaudeCode/pareto-front and transcripts /Users/mengkeli/.claude/projects/-Users-mengkeli-Documents-ClaudeCode-pareto-front/*.jsonl; repo github.com/LIMENGKE24/hpc-benchmark. Cluster: fornax CPU queues.

## 3. Collect signals (fast, ~2 min total)
a) Local change: for each folder, `find <folder> -type f -mtime -1 -not -path '*/.git/*' | head` and newest mtime.
b) Claude transcripts: for each Claude project dir under /Users/mengkeli/.claude/projects/ matching the folder (CRP-Polymer-Electrolytes, pareto-front), list *.jsonl modified in the last 1 day. For those, extract ONLY the last 2 user messages and last 2 assistant text blocks with python streaming line by line (lines are JSON with "type" user/assistant and message.content list of {type:text,text}). Never cat whole files (they can be 30 MB). Match them to a project by folder name / keywords.
c) Codex transcripts: /Users/mengkeli/.codex/sessions/YYYY/MM/DD/rollout-*.jsonl, files modified in the last 1 day (`find -mtime -1`; names use START time so check mtime, not the path date). The cwd is in a "cwd":"..." field near the top (head -c 20000 | grep -o). Extract the last 2 user messages and last 2 assistant output_text blocks via python streaming (payload.type == "message", role, content[].text). Map cwd to project.
d) Cluster queues, one SSH each, 20 s timeout, never fail the whole run if one is down:
   ssh -o ConnectTimeout=20 -o BatchMode=yes vanda 'qstat -u <user>' 
   ssh -o ConnectTimeout=20 -o BatchMode=yes hopper 'qstat -u <user>'
   ssh -o ConnectTimeout=20 -o BatchMode=yes fornax 'qstat -u <user>'
   Note job IDs, state (Q/R/H/E), queue, walltime used. Attribute jobs to projects by job name / queue / what the reminder "Now:" line says. Hopper hold jobs <held job ids> belong to project 6 (credit exhausted).

## 4. Update the board
For every project, rewrite the reminder body (keep the same line structure) only if something changed; always refresh "Updated <today>". Rules:
- "Now:" = one or two sentences on the current state including running/queued/finished job IDs and last activity date.
- "Next:" = the 2–3 most concrete next actions.
- Re-estimate "Est. finish" on EVERY run from current progress: count the concrete steps left in "Next:", add known compute wait (queued/running jobs, walltime left) and ~1 day per analysis/writing step, and weigh recent velocity (days since last activity; an idle project slips, not stays). Write it as "Est. finish <D Mon> (was <D Mon>; <one-line reason>)" and set the reminder's due date to the new estimate. If the user set a hard deadline (project 1: 2026-10-07), keep it in a separate "Deadline:" line and still give the honest estimate. List every date change (old → new, reason) in the brief.
- Never mark a reminder completed; never delete reminders; never change names or priorities.
Update with: osascript -e 'tell application "Reminders" to tell list "Projects" to set body of (first reminder whose name starts with "N ·") to "<text with \n newlines>"' (escape quotes; use a heredoc into a .applescript file if the text is long).
If a job finished or failed overnight, or a project has had no activity for 7+ days, add a sub-line "⚠ ..." at the start of "Now:".

## 5. Brief
Write /Users/mengkeli/Documents/ClaudeCode/Project-Tracker/pulse/pulse_<YYYY-MM-DD>.md (mkdir -p pulse) with: date; a 7-row table (rank, project, last activity, jobs R/Q/H, flag); then "Attention today" = at most 5 bullets ordered by priority (deadlines within 7 days first, then failed/finished jobs, then idle projects, then blockers such as Hopper credit). End your reply with that same brief (under 300 words). Say explicitly which clusters could not be reached and which transcripts were unreadable; do not invent status.
