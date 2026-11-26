---
name: mac-runners
description: Use when a GitHub Actions workflow needs macOS (Xcode, Swift, iOS or Mac builds) or Linux arm64 runners and the person owns Apple Silicon Macs; Smarty Pants runs each job in a fresh VM on their own or their Group's Macs, free there, instead of paid GitHub macOS minutes.
---

# GitHub Actions runners on your own Macs (beta)

Every job whose `runs-on` names `smartypants-macos` gets a fresh macOS VM on one of the person's own Macs (or their
Group's). The VM runs that one job and is thrown away; nothing is kept between jobs. `smartypants-linux` gives a fresh
Ubuntu 24.04 arm64 VM with Docker where the account has it. It is free on the person's own and Group Macs, and it
uses no GitHub minutes. By Apple's macOS licence these runners only ever use the person's own or Group Macs, never
strangers' Macs.

## Set it up (once per repository)
1. The person makes a fine-grained GitHub token for the repository with **Administration: read and write** (for
   runners) and, so the site can add the webhook itself, **Webhooks: read and write**.
2. Link the repository, either with the Action (`Howcanio/smarty-pants-examples/mac-runners@v1`, see its README) or
   directly:
   ```bash
   curl https://smartypants.network/v1/github-runners -H "Authorization: Bearer $SMARTYPANTS_API_KEY" \
     -H "Content-Type: application/json" -d '{"repo":"owner/name","token":"'"$GITHUB_RUNNER_TOKEN"'","where":"mine"}'
   ```
   Use `"where": {"group": "GROUP_ID"}` for a Group's Macs. Without the webhook permission the answer gives a webhook
   URL and secret to add by hand (Settings, Webhooks, JSON, "Workflow jobs" only).
3. In the workflow:
   ```yaml
   jobs:
     build:
       runs-on: [self-hosted, smartypants-macos]
   ```

## Good habits
- It is beta: keep a fallback. A job that waits too long can be re-run on `macos-latest`.
- `GET /v1/github-runners` lists linked repositories; `DELETE /v1/github-runners/{id}` removes a link and its webhook.
- The token is kept encrypted on the site and never goes to a Mac. Never paste it into chat or a file; read it from
  an environment variable or a repository secret.

Docs: https://smartypants.network/docs/agents
