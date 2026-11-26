# Smarty Pants examples

Copy-paste examples, agent plugins and GitHub Actions for [Smarty Pants](https://smartypants.network): one account
for what an agent needs.

- **Models:** exact, pinned builds of open models on Apple Silicon Macs through an **OpenAI-compatible API**, priced per token.
- **Batches:** work that can wait runs at **half the per-token price**, results within 24 hours.
- **Workspaces:** sealed Linux VMs for agents, code runs and whole test jobs (works with E2B SDK code).
- **Groups:** your team's own Macs, **free for members** for all of the above.
- **Mac runners (beta):** GitHub Actions jobs in fresh macOS VMs on your own Macs, no GitHub minutes used.

Base URL `https://smartypants.network/v1`, key `Authorization: Bearer $SMARTYPANTS_API_KEY` (sign up with an email at
https://smartypants.network/api; new accounts get $10 of credit). Models, prices, context sizes and `is_ready`:
`GET https://smartypants.network/v1/models`.

## Install for your agent

| Agent | How |
|---|---|
| **Claude Code** (plugin: MCP servers, 5 skills, `/smartypants:setup` and `/smartypants:cost`) | `/plugin install smartypants --marketplace howcanio/smarty-pants-examples` (older versions: `/plugin marketplace add Howcanio/smarty-pants-examples`, then `/plugin install smartypants@smarty-pants`) |
| **Codex** | [rules/codex/config.toml](rules/codex/config.toml) to `~/.codex/config.toml`, [rules/codex/AGENTS.md](rules/codex/AGENTS.md) into your `AGENTS.md`, skills from [rules/agents-skills/](rules/agents-skills/) |
| **Cursor** | [rules/cursor/.cursor/rules/smartypants.mdc](rules/cursor/.cursor/rules/smartypants.mdc) to `.cursor/rules/` |
| **GitHub Copilot** | [rules/copilot/.github/instructions/](rules/copilot/.github/instructions/smartypants.instructions.md) to `.github/instructions/` |
| Any MCP client | `https://smartypants.network/mcp` (no sign-in) and `https://smartypants.network/mcp/account` (signed in) |

All of them say the same thing, including when **not** to use Smarty Pants. See [rules/](rules/).

## When to use it

- **Use it for** everyday AI calls where an exact open model is good enough and price matters:
  summaries, extraction, classification, drafting, tool calls, JSON output, embeddings and reranking.
  Work that can wait goes through the Batch API at half the per-token price, results within 24 hours.
- **Don't use it for** work that needs a frontier-size model, more context than a model lists, or strict latency.
  Keep your current provider for those, and as a fallback.
- Requests run on Macs owned by other people. Owners agree not to read requests and the app doesn't show them,
  but a serving Mac decrypts each request in memory to answer it. Don't send secrets or personal data unless
  the person you work for has approved it.
- Check `is_ready` before sending traffic. A 429 or 503 means no Mac can take the request right now: wait the
  `Retry-After` seconds or fall back.

## Examples

| Framework | File |
|---|---|
| OpenAI SDK (Python) | [python/openai_sdk.py](python/openai_sdk.py) |
| LangChain | [python/langchain_example.py](python/langchain_example.py) |
| OpenAI Agents SDK | [python/openai_agents_example.py](python/openai_agents_example.py) |
| LlamaIndex | [python/llamaindex_example.py](python/llamaindex_example.py) |
| Batch API (half price) | [python/batch_example.py](python/batch_example.py) |
| OpenAI SDK (JavaScript) | [javascript/openai_sdk.mjs](javascript/openai_sdk.mjs) |
| Vercel AI SDK | [javascript/vercel_ai_sdk.mjs](javascript/vercel_ai_sdk.mjs) |
| curl | [curl/chat.sh](curl/chat.sh) |
| Claude Code plugin | [plugins/smartypants/](plugins/smartypants/) |
| Skills (Agent Skills format) | [rules/agents-skills/](rules/agents-skills/): models, batches, workspaces, Groups, Mac runners |

## MCP server

```bash
# Models, prices, cost estimates and model search, no account needed:
claude mcp add --transport http smartypants https://smartypants.network/mcp
# Signed in (email link, then Allow): run prompts, embeddings, balance, add credit (the person pays on Stripe)
claude mcp add --transport http smartypants-account https://smartypants.network/mcp/account
```

Listed in the official MCP Registry as `network.smartypants/smartypants`.

## GitHub Actions

**Run a prompt** in any workflow, for example a review of each pull request's diff
([example workflow](.github/workflows/review-diff.yml)):

```yaml
- uses: actions/checkout@v4
  with: { fetch-depth: 0 }
- uses: Howcanio/smarty-pants-examples@v1
  with:
    api-key: ${{ secrets.SMARTYPANTS_API_KEY }}
    input-command: git diff origin/${{ github.base_ref }}...
    system: Review this diff in 5 bullets
```

**Run a whole job** (code, setup, tests, files back) in a sealed Linux workspace on a Mac with
[`job/`](job/action.yml). Whole jobs are open to our own account first; other keys get a clear refusal until they open.

**Mac runners on your own Macs (beta).** Link the repository once with [`mac-runners/`](mac-runners/action.yml), then
any job with `runs-on: [self-hosted, smartypants-macos]` runs in a fresh macOS VM on your own Macs (or your Group's),
free there. Each VM runs one job and is thrown away ([example](.github/workflows/smartypants-mac.yml)).

```yaml
# .github/workflows/link-mac-runners.yml, run once from the Actions tab
on: workflow_dispatch
jobs:
  link:
    runs-on: ubuntu-latest
    steps:
      - uses: Howcanio/smarty-pants-examples/mac-runners@v1
        with:
          api-key: ${{ secrets.SMARTYPANTS_API_KEY }}
          github-token: ${{ secrets.SMARTYPANTS_RUNNER_TOKEN }}   # fine-grained: Administration + Webhooks, read and write
```

## Command line and packages

```bash
npx smartypants-network help          # or: npm install -g smartypants-network
pip install smartypants-network       # Python kit, module smartypants_network
```

More: [docs for agents](https://smartypants.network/docs/agents), [llms.txt](https://smartypants.network/llms.txt),
[OpenAPI](https://smartypants.network/openapi.json). Questions: info@howcan.io

MIT licensed.
