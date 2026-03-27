---
name: recap
description: Warm-start a session by reconstructing context from journals and git state. Use at the start of new sessions.
argument-hint: "[N] — read last N journal entries (default: 1)"
---

# Recap — Session Context Reconstruction

## Purpose

Warm-start a new session by synthesizing context from session journals, git history, and repo state. Eliminates the manual "where were we?" dance at the start of every conversation.

"Before we proceed, allow me to consult the records. I find they remember things I've forgotten." — Alfred

## Safety Constraints

### NEVER
- Modify any files (this is a read-only operation)
- Make assumptions about what the user wants to do next — present the state, let them decide
- Skip git status checks (uncommitted work is critical context)

### ALWAYS
- Read the most recent journal entry by default
- Include current git state (branch, status, recent commits)
- Present a structured, scannable briefing
- Note any gaps or inconsistencies

## Execution Protocol

### Step 1: Locate Journal Entries

```bash
ls memory/sessions/*.md | sort -r
```

Select entries to read:
- **Default**: Most recent 1 entry
- **If user specifies N**: Last N entries
- **If gap > 3 days**: Automatically read last 2 entries

### Step 2: Read Journal Entries

Extract: summary, key decisions, changed files, next steps.

### Step 3: Gather Git State

Run in parallel:
1. `git branch --show-current`
2. `git status --short`
3. `git log --oneline -10`

### Step 4: Detect Discrepancies

Check for branch mismatches, files mentioned in "Next" that have since changed, commits made after the journal.

### Step 5: Synthesize Briefing

Display in conversation (do NOT write to file):

```markdown
## Session Briefing

### Last Session ({date}, branch: {branch})
{Summary}
**Next steps**: {Next from journal}

### Recent Commits
- {hash} {message}

### Current State
- **Branch**: {current branch}
- **Uncommitted**: {list or "clean"}
- **Discrepancies**: {any mismatches}

### Open Questions
{From journal, if any}
```

## Completion Criteria

- [ ] Journal entries located and read (or noted as absent)
- [ ] Git state gathered
- [ ] Discrepancies identified
- [ ] Briefing displayed
- [ ] No files modified
