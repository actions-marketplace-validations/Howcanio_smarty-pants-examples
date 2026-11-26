---
description: Check this Smarty Pants setup (key, balance, what this key can use) and show the cheapest ready models
---

Check the person's Smarty Pants setup and report it in a few plain lines:

1. If `SMARTYPANTS_API_KEY` is not set, say so and point them to https://smartypants.network/api to create a key
   (new accounts get $10 of credit). Do not ask them to paste the key into chat.
2. Run `npx -y smartypants-network doctor` and summarize what it says this key can use (models, batches,
   workspaces, Groups, Mac runners).
3. Use the `list_models` tool from the `smartypants` MCP server (or `curl -s https://smartypants.network/v1/models`)
   and show the ready text models with their prices per million tokens, cheapest first, plus the embedding and
   reranking models.
4. Mention in one line each: half-price batches for work that can wait, sealed workspaces, free use of the team's
   own Macs through a Group, and GitHub Actions runners on their own Macs. Point to the matching skill.

Don't spend money in this command.
