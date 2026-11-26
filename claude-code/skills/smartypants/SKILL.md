---
name: smartypants
description: Use when a task needs cheap, exact open-model AI calls (summaries, extraction, classification, JSON output, tool calls, embeddings, reranking, speech to text) priced per token through an OpenAI-compatible API, or when the person wants one account for models, batches and sandboxed workspaces. Not for work that needs a frontier model.
---

# Smarty Pants

Smarty Pants (https://smartypants.network) serves exact, pinned builds of open models on Apple Silicon Macs through an
OpenAI-compatible API, priced per token. One key also covers half-price batches, sealed Linux workspaces for agents,
a team's own Macs (Groups, free for members) and GitHub Actions runners on your own Macs.

## What is in the one account

| Need | Use | Skill |
|---|---|---|
| A model call now | `POST /v1/chat/completions` (OpenAI format), `/v1/messages` (Claude format), `/v1/responses` | this one |
| Many calls that can wait | Batch API, half the per-token price, done within 24 hours | `batch-half-price` |
| Run code, tests or a coding agent in a sealed VM | workspaces, whole jobs, E2B drop-in | `workspaces` |
| Use the team's own Macs, free | Groups (`where: {group: ID}`) | `group-macs` |
| macOS or Linux CI on your own Macs | GitHub Actions runners, `runs-on: smartypants-macos` | `mac-runners` |
| Embeddings and reranking | `smartypants/qwen3-embedding-0.6b`, `smartypants/qwen3-reranker-0.6b` | this one |

## When to use it
- Everyday text work where an open model is good enough and price matters: summaries, extraction, classification,
  drafting, tool calls, JSON output. Measure on a few non-sensitive examples first.
- Not for: work that needs a frontier-size model, more context than the model lists, or strict latency. Keep the
  current provider for those, and as a fallback.

## How
1. Check models, prices, context and `is_ready`: `curl https://smartypants.network/v1/models` (or the `list_models`
   MCP tool, no sign-in). Only send traffic to models that are ready.
2. The person signs up with an email at https://smartypants.network/api (new accounts get $10 of credit for 90 days)
   and keeps the key in `SMARTYPANTS_API_KEY`. Never put the key in code, files or chat.
3. Call it like OpenAI, base URL `https://smartypants.network/v1`:
   ```bash
   curl https://smartypants.network/v1/chat/completions -H "Authorization: Bearer $SMARTYPANTS_API_KEY" \
     -H "Content-Type: application/json" \
     -d '{"model":"smartypants/qwen3.5-9b","messages":[{"role":"user","content":"Hello"}]}'
   ```
   From a shell: `npx -y smartypants-network ask "Hello"` (note: `npx smartypants` is an unrelated package).
   Python: `pip install smartypants-network`; or the OpenAI SDK with `base_url="https://smartypants.network/v1"`.
4. Errors: 401 bad key (make a new one at /api); 402 balance empty (the person adds credit, see Rules);
   429 or 503 no Mac is free right now, so wait the `Retry-After` seconds or use the fallback provider;
   400 `context_length_exceeded` means pick a model with a bigger context. A 403 that is an HTML page, not JSON,
   is the network in front of the site blocking a prompt that quotes shell commands: resend it gzipped
   (`Content-Encoding: gzip`); the kits do this for you.

## Rules
- Ask the person before spending. `GET https://smartypants.network/v1/key` (or `get_balance` over MCP) shows what
  this key has left.
- Requests on the general network run on Macs owned by other people. Owners agree not to read requests and the app
  doesn't show them, but a serving Mac decrypts each request in memory to answer it. Do not send secrets, personal,
  customer or regulated data unless the person approved it. For private work, use the person's own or Group Macs.
- Never handle card details. To add money, use the `add_credit` MCP tool or send the person to their account page;
  they pay on Stripe.

Full guide: https://smartypants.network/llms.txt and https://smartypants.network/docs/agents
