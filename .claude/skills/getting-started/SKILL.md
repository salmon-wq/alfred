---
name: getting-started
description: Interactive orientation and reference guide for Alfred. Use when onboarding, learning features, or looking up how to do something.
argument-hint: "[--topic setup|sessions|plugins|knowledge|first-missions|fleet|troubleshooting] [--full]"
---

# Getting Started — Alfred Orientation

## Purpose

Walk new owners through their first session and serve as an ongoing reference for Alfred's capabilities. First-run mode covers the essentials step by step. After that, jump to any topic by name.

## Safety Constraints

### NEVER
- Modify agent configuration files during orientation — this is informational only
- Install plugins without explicit user confirmation
- Run commands that affect external services without asking first

### ALWAYS
- Detect first-run vs returning user (check `.local/.orientation-complete`)
- Present information in scannable chunks — no walls of text
- Offer to skip sections the user already knows
- Write `.local/.orientation-complete` marker after completing the walkthrough

## Execution Protocol

### Step 1: Detect Mode

1. If `--topic <name>` provided: jump directly to that topic
2. If `--full` provided: run full walkthrough regardless of marker
3. If `.local/.orientation-complete` exists: show topic menu (reference mode)
4. Otherwise: start full walkthrough (first-run mode)

### Step 2: Welcome (First-Run Only)

Greet the user in Alfred's voice. Cover 6 essentials: shell setup, first conversation, plugin safety, knowledge growth, first missions, fleet CI.

### Step 3: Shell Function Setup (`setup`)

1. Show `scripts/alfred.sh` — explain what it does
2. Setup instruction: `source ~/Development/alfred/scripts/alfred.sh`
3. Test: navigate to any project and type `alfred`
4. Explain `--add-dir`: Alfred's persona loads from workspace; your code is accessible via `--add-dir`

### Step 4: First Conversation (`sessions`)

1. What loads automatically — CLAUDE.md imports SOUL.md, DOCTRINE.md, GOALS.md via `@`
2. The SDLC flow — Plan → Document → Develop → Test → Validate
3. Session continuity — `/journal` at end, `/recap` at start
4. Three-layer model: journals (weeks), MEMORY.md (indefinite), KB (permanent)

### Step 5: Plugin Safety (`plugins`)

1. What plugins are — specialist skills extending Alfred's capabilities
2. Key rule — vet public plugins with `warden:security-review` before installing
3. Quick reference: `claude plugin list` / `claude plugin install <name>`

### Step 6: Growing Alfred (`knowledge`)

1. Domain knowledge (`.claude/knowledge/`) — loaded at startup; one file per topic
2. Knowledge base (`docs/solutions/`) — grows through operation; use `ce:compound`
3. Skills live in `.claude/skills/<name>/SKILL.md`
4. Rules in `.claude/rules/` govern every session

### Step 7: First Missions (`first-missions`)

**Mission 1**: Convention Capture — share branching strategy, code style, deployment process with Alfred. Ask it to write conventions as rule files.

**Mission 2**: Codebase Survey — point Alfred at a project and ask it to write a domain reference file in `.claude/knowledge/` covering architecture, patterns, dependencies.

**Mission 3**: Problem Journal — after your first non-trivial task, run `ce:compound` to document the problem and solution.

### Step 8: Fleet CI (`fleet`)

ARDEN agents review PRs automatically — WARDEN, HARDEN, JORDEN, GARDEN, BARDEN. P1 blocks, P2 warns, P3 advises. Push fixes to same branch for re-review.

### Step 9: Troubleshooting (`troubleshooting`)

| Issue | Cause | Fix |
|-------|-------|-----|
| Context getting heavy | Long session | `/journal` then fresh session with `/recap` |
| Permission prompts | Classifier blocking legitimate action | Add to `autoMode.allow` in `.claude/settings.local.json` |
| Plugin skills not used | Missing "you are not alone" instruction | Check CLAUDE.md Plugin Skills section |
| Fleet CI not triggering | Missing `ANTHROPIC_API_KEY` | `gh secret set ANTHROPIC_API_KEY -R <org>/<repo>` |
| `@` imports not working | Syntax error in CLAUDE.md | Each import on its own line, prefixed with `@` |

### Step 10: Wrap Up (First-Run Only)

Write `.local/.orientation-complete` marker. Summarize quick reference:
- Launch: `alfred` from any directory
- End of session: `/journal`
- Start of session: `/recap`
- Capture knowledge: `ce:compound`
- This guide: `/getting-started --topic <name>`

## Completion Criteria

- [ ] Mode detected correctly
- [ ] All requested sections presented clearly
- [ ] Shell setup instructions accurate for workspace path
- [ ] `.local/.orientation-complete` marker written (first-run only)
- [ ] No files modified other than the marker
