---
name: ship
description: "End-to-end ship protocol — branch, verify, commit, push, PR. Use when starting or finishing work."
argument-hint: "[#issue] [description] — start new work; or no args to ship current branch"
---

# Ship — Start-to-Finish Delivery

## Purpose

Handle the full lifecycle from "starting work" to "PR is up." Detects which phase you're in: if you're on the base branch, it preps a new feature branch (mission prep). If you're on a feature branch with changes, it ships (verify, commit, push, PR).

"A clean delivery pipeline is not a luxury, sir. It is the minimum standard of professional conduct." — Alfred

## Safety Constraints

### NEVER
- Force push (`--force`, `--force-with-lease`) — not even once
- Push without explicit user approval — show what will be pushed and wait
- Stage files with `git add -A` or `git add .` — stage specific files only
- Discard uncommitted changes — offer stash/commit/abort if the tree is dirty during prep
- Create a PR from main/dev/master — must be on a feature branch
- Amend commits without explicit user request

### ALWAYS
- Detect mode automatically (prep vs ship) based on current branch
- Confirm branch names with the user before creating
- Show the full commit diff before committing
- Require explicit user approval before pushing
- Use HEREDOC format for commit messages
- Offer session bookend skills (`/journal`, `ce:compound`) after shipping

## Execution Protocol

### Step 1: Detect Mode

```bash
git branch --show-current
git remote show origin 2>/dev/null | grep 'HEAD branch' | awk '{print $NF}'
```

**If on base branch** → Prep mode (Steps 2-4)
**If on feature branch** → Ship mode (Steps 5-9)

### --- PREP MODE ---

### Step 2: Identify the Work

Parse `$ARGUMENTS` for task context. Issue reference, freeform description, or ask the user.

### Step 3: Pre-flight and Sync

```bash
git status --short
git pull origin {base_branch}
```

### Step 4: Create Feature Branch

Derive: `{type}/{issue-number}-{slug}` or `{type}/{slug}`. Confirm with user, then create.

### --- SHIP MODE ---

### Step 5: Ship Pre-flight

Verify on feature branch with shippable changes.

### Step 6: Quality Gate

Delegate to `/verify`. P1 → Block. P2 → Warn. P3 → Pass.

### Step 7: Stage and Commit

```bash
git add {specific files}
git commit -m "$(cat <<'EOF'
{subject}

{body}

Co-Authored-By: Alfred <alex.salmon@telusinternational.com>
Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

### Step 8: Push and PR

Show what will be pushed, require approval, then:
```bash
git push -u origin {branch}
gh pr create --title "{title}" --body "..."
gh pr merge {number} --squash --auto
```

### Step 9: Ship Report

Display branch, commits, PR URL, verify verdict. Offer `/journal` and `ce:compound`.

## Completion Criteria

### Prep mode
- [ ] Working tree clean before branching
- [ ] Base branch synced
- [ ] Feature branch created with confirmed name

### Ship mode
- [ ] Pre-flight confirmed
- [ ] `/verify` verdict respected (P1 blocks)
- [ ] Changes staged file-by-file
- [ ] Commit with conventional message and Co-Authored-By
- [ ] Push with explicit user approval
- [ ] PR created with summary and test plan
