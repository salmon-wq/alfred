# Alfred Project

@SOUL.md
@DOCTRINE.md
@GOALS.md

## How I Work

I follow a default flow for every piece of work. Simple tasks compress the phases; complex tasks expand them. I do not skip steps.

**Plan** → **Document** → **Develop** → **Test** → **Validate**

Detailed methodology for each phase lives in `.claude/rules/`:
- `sdlc.md` — Phase definitions and done conditions
- `execution.md` — Retry limits (3 syntax, 5 test, 2 integration), evidence requirements, no phantom ops
- `sessions.md` — Journal/recap protocol, three-layer persistence, compaction recovery
- `safety.md` — Protected artifacts, approval gates, pre-flight checks, data boundary
- `knowledge.md` — KB documentation triggers, entry format, tag cross-linking

## Project Structure

- `scripts/` — Shell launcher function (source into `.bashrc`/`.zshrc` to invoke Alfred from anywhere)
- `.claude/rules/` — Execution discipline, safety constraints, session continuity, SDLC workflow, knowledge compounding
- `.claude/skills/` — Repeatable workflows (verify, journal, recap, ship, getting-started, and more as I grow)
- `.claude/knowledge/` — Domain reference (curated, loaded at startup)
- `.claude/agents/` — Read-only subagents (researcher, implementer)
- `docs/solutions/` — Knowledge base (institutional memory, grows through operation)
- `.local/` — Ephemeral artifacts (git-ignored)

## Subagents

Native subagents live in `.claude/agents/` and operate as read-only research or implementation assistants.

**Key constraint**: Subagents return findings/text only. Alfred orchestrates all final decisions and file writes.

## Plugin Skills

You have access to specialist skills provided by domain expert plugins. These are purpose-built tools that produce better results than manual investigation — they run deterministic scanners, apply domain-specific checklists, and produce grounded, file:line cited findings.

Before doing security, QA, design, documentation, or performance work yourself, check your available skills. When a task involves code auditing, test quality, accessibility, wiki health, issue triage, or frontend design, invoke the relevant specialist skill rather than doing the analysis manually. Plugin skills appear with a namespace prefix (e.g., `warden:gitleaks`, `harden:anti-pattern-detector`, `impeccable:polish`). You are not alone — use your specialists.

---

### compound-engineering (EveryInc) — Core development workflow engine
- **`ce:plan`** — Transform feature descriptions into structured implementation plans
- **`ce:work`** — Execute work plans efficiently while maintaining quality
- **`ce:review`** — Structured code review using tiered persona agents
- **`ce:compound`** — Document solved problems into `docs/solutions/`
- **`ce:ideate`** — Generate and critically evaluate improvement ideas

### impeccable (pbakaus) — Frontend design quality
- **`impeccable:polish`** — Final quality pass on alignment, spacing, and micro-detail
- **`impeccable:audit`** — Technical quality checks across accessibility, performance, and theming
- **`impeccable:animate`** — Add purposeful animations and micro-interactions
- **`impeccable:typeset`** — Fix font choices, hierarchy, sizing, and readability

### playground (claude-plugins-official) — Interactive HTML playgrounds
- **`playground:playground`** — Create self-contained interactive HTML explorers

### ARDEN Security & Quality Fleet (fuelix/arden-plugins)
- **`warden:security-review`** — Assess code changes for security risks (entry point)
- **`warden:gitleaks`** — Detect leaked secrets in git history
- **`warden:dependency-audit`** — Check for known CVEs and license violations
- **`harden:anti-pattern-detector`** — Detect test anti-patterns (entry point)
- **`harden:coverage-analyzer`** — Analyze test coverage from lcov data
- **`jorden:axe-core-runner`** — WCAG 2.2 AA accessibility audit (entry point)
- **`jorden:color-contrast`** — Check color contrast ratios
- **`garden:stale-detector`** — Flag outdated documentation (entry point)
- **`garden:content-gap`** — Find undocumented services and modules
- **`barden:issue-classifier`** — Classify GitHub issues by type (entry point)
- **`barden:sprint-plan`** — Create sprint-ready GitHub issues from implementation plans

## Skills

Built-in workflows that ship with the workspace:

- **`/getting-started`** — Interactive orientation and reference guide. Run on first session for a walkthrough, or jump to any topic: `setup`, `sessions`, `plugins`, `knowledge`, `first-missions`, `fleet`, `troubleshooting`.
- **`/verify`** — Pre-commit quality gate. Run tests, lint, and build checks. P1 blocks commit, P2 blocks merge, P3 advisory.
- **`/journal`** — Capture session working state at natural boundaries. Creates entries in `memory/sessions/` for cross-session continuity.
- **`/recap`** — Warm-start a new session from journals and git state. Matched pair with `/journal`.
- **`/ship`** — End-to-end delivery. On base branch: preps a feature branch. On feature branch: verify → commit → push → PR. One skill for the full cycle.

## Key Patterns

- **Commit style**: Imperative subject, short body, Co-Authored-By trailer
- **Two-phase orchestration**: Sub-agents research → Alfred synthesizes and writes
- **Retry limits**: 3 syntax, 5 tests, 2 integration — then escalate
- **Protected artifacts**: SOUL.md, DOCTRINE.md, GOALS.md, CLAUDE.md, docs/solutions/
