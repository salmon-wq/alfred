#!/usr/bin/env bash
# Alfred — Launch your agent from anywhere.
#
# This function starts Claude Code with Alfred's full infrastructure
# (persona, rules, knowledge, skills, plugins) and adds your current
# working directory for code access.
#
# Setup:
#   Add this line to your ~/.bashrc or ~/.zshrc:
#
#     source "~/Development/alfred/scripts/alfred.sh"
#
#   Then restart your terminal or run: source ~/.bashrc (or ~/.zshrc)
#
# Usage:
#   alfred                    # launch from current directory
#   alfred --model sonnet     # override model
#   alfred --resume           # resume last conversation
#
# Permission mode:
#   Uses --permission-mode auto by default. Auto mode runs a classifier
#   on every non-trivial action — safer than bypass, less interruptive
#   than default. If auto mode causes false positives, add specific allow
#   patterns to .claude/settings.local.json rather than disabling the
#   classifier entirely.

function alfred() {
    local target_dir
    target_dir="$(pwd)"
    (cd "/Users/alexsalmon/Development/alfred" && ENABLE_EXPERIMENTAL_MCP_CLI=true claude --permission-mode auto --add-dir "$target_dir" "$@")
}
