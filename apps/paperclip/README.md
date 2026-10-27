# Paperclip

Run a company of AI agents. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Paperclip` |
| Slug | `paperclip` |
| Category | `AI` |
| Description | `Run a company of AI agents` |
| Web service | `paperclip` |
| Web port | `3100` |
| RAM reserved (MB) | `1024` |
| Disk reserved (MB) | `4096` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address right away, create your account and choose "Claim this instance" (the board-claim link is also in Logs). Add your AI provider key in the settings.
```

## Image tags

`ghcr.io/paperclipai/paperclip:latest` (date-based release tags like `2026.1023.0` exist: pin once tested), `postgres:17-alpine`.

## First login

1. Open the address **right away**, create your account and choose **Claim this instance** (until it's claimed, the first signed-in user becomes the admin). The board-claim link is also in **Logs**.
2. Add an AI provider key (Anthropic / OpenAI) in the settings.

## Admin checks

- Agents only run with the customer's own AI provider key.
- RAM 1 GB covers Paperclip + Postgres with a small agent team. Agents that run coding tools in their workspaces use much more; heavy users belong on Q2/Q3.
- Public sign-up stays possible after the claim. To close it, add `PAPERCLIP_AUTH_DISABLE_SIGN_UP: "true"` to the template (consider making that the default after a test).
- `BETTER_AUTH_SECRET` must not change after users exist (it signs every session).

## Paid products

None: free in every plan.
