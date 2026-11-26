---
name: workspaces
description: Use when an agent needs to run code, install packages, run a test suite or a coding agent in a sealed, throwaway Linux VM (an agent sandbox), or already has code written for the E2B SDK; Smarty Pants workspaces run on Apple Silicon Macs, free on your own or your Group's Macs.
---

# Sealed workspaces on Smarty Pants

A workspace is one sealed Linux VM on a Mac that keeps its files across many commands, then is wiped. A whole job
(code in, setup, tests, files back) runs in one and ends by itself. On your own Macs or your Group's Macs they are
free; check `smartypants prices` for the rest.

## Pick the shape
- **One program, then wiped:** `npx -y smartypants-network run python -c "print(6*7)"`.
- **Many commands, one VM:** `smartypants ws new --minutes 10` prints an id; then `ws exec ID sh -c "pytest -q"`,
  `ws put`, `ws get`, `ws end`. Python: `with sp.workspace(minutes=10) as ws: ws.run("sh", "pytest -q")`.
- **A whole job (clone, set up, test, files back):**
  `smartypants job --repo https://github.com/you/repo --setup "npm ci" --test "npm test" --out results/`.
  Exit code 0 means it passed. In GitHub Actions use `Howcanio/smarty-pants-examples/job@v1`.
- **A coding task:** `smartypants job --repo URL --task "Add a test for add()" --test "npm test"` runs Claude Code
  in the workspace on Smarty Pants models and brings back `changes.patch` (or a draft pull request).
- **Already using E2B?** Change only the address and key:
  `E2B_API_URL=https://smartypants.network/e2b E2B_SANDBOX_URL=https://smartypants.network/e2b-sandbox E2B_API_KEY=$SMARTYPANTS_API_KEY`.
  `Sandbox.create()`, `run_code`, `files.write`, `files.read` and `kill` work as before.

## Rules
- Workspaces are open to accounts as they are turned on; a key that can't use them yet gets a clear refusal. Run
  `smartypants doctor` to see what this key can use.
- Set `--minutes` and `--budget` to what the task needs, and tell the person.
- Internet inside a workspace is off or limited to listed hosts (`--internet`). Don't put secrets in the files you
  send; use the account's saved secrets (`smartypants agent-setup save --secret NAME@HOST`).

Live numbers: https://smartypants.network/reliability (start times and failures) and
https://smartypants.network/v1/results/jobs. Docs: https://smartypants.network/workspaces/
