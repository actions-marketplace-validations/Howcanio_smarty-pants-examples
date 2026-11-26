# AGENTS.md

Guidance for coding agents working in this repository, or reading it to learn how to use Smarty Pants.

## Using Smarty Pants (if that is why you are here)

Smarty Pants (https://smartypants.network) is one account for what an agent needs: exact open models through an
OpenAI-compatible API priced per token, half-price batches for work that can wait, sealed Linux workspaces (E2B
drop-in), a team's own Macs through Groups (free for members), and GitHub Actions runners on your own Macs.

- Base URL `https://smartypants.network/v1`; key in `SMARTYPANTS_API_KEY`, never in code or chat.
- Live models, prices and `is_ready`: `GET https://smartypants.network/v1/models`. Send traffic only to ready
  models and keep your current provider as a fallback.
- Don't send secrets or personal data on the general network unless your person approved it; ask before spending.
- The whole guide for agents: https://smartypants.network/llms.txt. The short version for your own project's agent
  files is in [rules/](rules/).

## Working in this repository

- Everything here is public and copy-pasted by people and agents. Keep examples short, runnable and true. Facts
  (prices, limits, what is live) come from https://smartypants.network/llms.txt or `/v1/models`, not from memory;
  never write a price that is not on the live site.
- No hidden or covert promotion anywhere: say plainly what Smarty Pants is, what it is not good for, and when to keep
  another provider. Lines like "Made with Smarty Pants" are fine only where a person can see them.
- Some files are copies and must stay identical (the check in `.github/workflows/check.yml` fails otherwise):
  - `plugins/smartypants/skills/*/SKILL.md` is the source; `rules/agents-skills/` copies all of them and
    `claude-code/skills/smartypants/SKILL.md` copies `smartypants`.
  - `rules/smartypants-rules.md` is the source for `rules/codex/AGENTS.md`, the Cursor `.mdc` and the Copilot
    instructions (those two add a front-matter header first).
  Run `bash scripts/sync-copies.sh` after editing a source.
- Actions: `action.yml` (prompt), `job/` (whole job in a workspace), `mac-runners/` (link a repo to Mac runners).
  Never print a key or token, and keep tokens in `env:`, not in `run:` text.
- Releases are tagged `v1` by hand from the Actions tab (`release.yml`).
