---
description: Estimate what a task would cost on Smarty Pants models, live and as a half-price batch
argument-hint: "[what you plan to run, e.g. 'summarize 2,000 support emails']"
---

Estimate the cost of this work on Smarty Pants: $ARGUMENTS

1. Work out roughly how many requests, input tokens and output tokens it needs. Say your assumptions.
2. Use the `estimate_cost` and `find_model` tools from the `smartypants` MCP server (no sign-in needed) to price it on
   the two or three ready models that fit, live and as a batch (half the per-token price, within 24 hours).
3. Give a short table and a recommendation. If an open model may not be good enough for this task, say so and suggest
   testing a few non-sensitive examples first.

Don't run or spend anything in this command.
