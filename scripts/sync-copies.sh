#!/usr/bin/env bash
# Write the copies from their sources (see AGENTS.md). With --check, only report copies that differ.
set -euo pipefail
cd "$(dirname "$0")/.."
check=false; [ "${1:-}" = "--check" ] && check=true
bad=0
tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
want() { # want DEST < content
  cat > "$tmp/x"
  if $check; then
    cmp -s "$tmp/x" "$1" || { echo "out of date: $1 (run scripts/sync-copies.sh)"; bad=1; }
  else mkdir -p "$(dirname "$1")"; cp "$tmp/x" "$1"; fi
}
for d in plugins/smartypants/skills/*/; do
  name="$(basename "$d")"
  want "rules/agents-skills/$name/SKILL.md" < "$d/SKILL.md"
done
want claude-code/skills/smartypants/SKILL.md < plugins/smartypants/skills/smartypants/SKILL.md
rules=rules/smartypants-rules.md
want rules/codex/AGENTS.md < "$rules"
{ printf -- '---\ndescription: Using Smarty Pants for cheap exact open-model AI calls, half-price batches, sealed workspaces and Mac runners\nglobs:\nalwaysApply: false\n---\n\n'; cat "$rules"; } | want rules/cursor/.cursor/rules/smartypants.mdc
{ printf -- '---\napplyTo: "**"\ndescription: Using Smarty Pants for cheap exact open-model AI calls, half-price batches, sealed workspaces and Mac runners\n---\n\n'; cat "$rules"; } | want rules/copilot/.github/instructions/smartypants.instructions.md
exit $bad
