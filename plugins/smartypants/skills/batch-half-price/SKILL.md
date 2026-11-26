---
name: batch-half-price
description: Use when there are many model calls (chat, embeddings, reranking) or code jobs that can wait up to 24 hours, such as labeling a dataset, summarizing many files or embedding a corpus; Smarty Pants batches run them at half the per-token price, in OpenAI's Batch API format.
---

# Half-price batches on Smarty Pants

Work that can wait goes through the Batch API at **half the normal per-token price**, with results within 24 hours on
Macs that are otherwise idle (live work always comes first). It is OpenAI's Batch API format, so existing batch code
works with the base URL changed.

## How
1. Write one JSON line per request: `{"custom_id": "row-1", "method": "POST", "url": "/v1/chat/completions", "body": {...}}`.
   Endpoints: `/v1/chat/completions`, `/v1/embeddings`, `/v1/rerank`, and `/v1/cpu/jobs` (code jobs, normal CPU price).
2. Upload it: `POST https://smartypants.network/v1/files` (multipart, `purpose=batch`), or skip the file and send
   `requests: [{custom_id, body}]` inline.
3. Start it: `POST https://smartypants.network/v1/batches` with `input_file_id`, `endpoint` and `completion_window: "24h"`.
4. Poll `GET /v1/batches/{id}`; when done, read `GET /v1/files/{output_file_id}/content`.

```python
from openai import OpenAI
import os
client = OpenAI(base_url="https://smartypants.network/v1", api_key=os.environ["SMARTYPANTS_API_KEY"])
f = client.files.create(file=open("requests.jsonl", "rb"), purpose="batch")
b = client.batches.create(input_file_id=f.id, endpoint="/v1/chat/completions", completion_window="24h")
print(b.id)
```

## Useful extras
- `max_spend_usd` stops the batch at that cost. Set it, and tell the person what you set.
- `check` (`{json: true, required: ["field"], schema, retries}` for chat) marks each result `passed` or
  `needs_review`; `GET /v1/batches/{id}/summary` gives counts, cost and what needs review, and
  `POST /v1/batches/{id}/rerun` reruns only what failed.
- `notify_url` (https) gets a signed POST when the batch is done.
- Up to 10,000 requests per batch and 10 unfinished batches per key.
- On a Group's own Macs, the parts the Group's Macs answer are free (see the `group-macs` skill).

Ask the person before starting a large batch, and give them the estimated cost (`estimate_cost` MCP tool).
Docs: https://smartypants.network/llms.txt
