# Paperless-AI

AI tagging and chat for Paperless-ngx documents. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Paperless-AI` |
| Slug | `paperless-ai` |
| Category | `AI` |
| Description | `AI tagging and chat for Paperless-ngx documents` |
| Web service | `paperless-ai` |
| Web port | `3000` |
| RAM reserved (MB) | `768` |
| Disk reserved (MB) | `2048` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address right away and complete the setup: create your login, then connect Paperless-ngx (URL + API token) and an AI provider.
```

## Image tags

`clusterzx/paperless-ai:latest` (official image of the project).

## First login

1. Open the address **right away**: the setup page creates the login (first visitor sets it).
2. Paperless-ngx: its address (e.g. the Paperless-ngx app on this VPS Pass, `https://…apps.qsync.net`) and an API token (Paperless → profile → API token).
3. AI: OpenAI, Ollama (the VPS Pass Ollama app with its API key), or any OpenAI-compatible API (OmniRoute, OpenRouter…).

## Admin checks

- It talks to Paperless-ngx over HTTPS, so the two can be on the same or different VPS Pass.
- RAM ~0.5–1 GB: the Node app plus its Python RAG service for document chat.
- AI usage is billed by the customer's own provider.

## Paid products

None: free in every plan.
