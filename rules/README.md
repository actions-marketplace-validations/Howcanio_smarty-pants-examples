# Smarty Pants rule pack for coding agents

The same short, honest guidance for every coding agent: when Smarty Pants fits, how to call it, what it costs and
what not to send. Copy the file for your agent into your project. Nothing here runs by itself or changes your code.

| Agent | Copy | To |
|---|---|---|
| Codex, Jules, Amp, Aider and other AGENTS.md readers | [codex/AGENTS.md](codex/AGENTS.md) | a section of your project's `AGENTS.md` |
| Codex settings (provider + MCP) | [codex/config.toml](codex/config.toml) | `~/.codex/config.toml` |
| Cursor | [cursor/.cursor/rules/smartypants.mdc](cursor/.cursor/rules/smartypants.mdc) | `.cursor/rules/smartypants.mdc` |
| GitHub Copilot | [copilot/.github/instructions/smartypants.instructions.md](copilot/.github/instructions/smartypants.instructions.md) | `.github/instructions/` |
| Skills (Codex, Claude Code and other Agent Skills readers) | [agents-skills/](agents-skills/) | `.agents/skills/` or `~/.agents/skills/` |
| Claude Code | the plugin: `/plugin marketplace add Howcanio/smarty-pants-examples`, then `/plugin install smartypants@smarty-pants` | |

One command does the copying for Cursor and AGENTS.md readers:

```bash
curl -fsSL https://raw.githubusercontent.com/Howcanio/smarty-pants-examples/main/rules/cursor/.cursor/rules/smartypants.mdc \
  --create-dirs -o .cursor/rules/smartypants.mdc
curl -fsSL https://raw.githubusercontent.com/Howcanio/smarty-pants-examples/main/rules/codex/AGENTS.md >> AGENTS.md
```

The text is the same in each file ([smartypants-rules.md](smartypants-rules.md) is the source). MIT licensed.
