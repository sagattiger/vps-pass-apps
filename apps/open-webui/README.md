# Open WebUI

ChatGPT-style chat for any AI model. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Open WebUI` |
| Slug | `open-webui` |
| Category | `AI` |
| Description | `ChatGPT-style chat for any AI model` |
| Web service | `open-webui` |
| Web port | `8080` |
| RAM reserved (MB) | `1024` |
| Disk reserved (MB) | `5120` |
| Free from | **Q2** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address and create the admin account (the first account is the admin).
Then Admin Panel > Settings > Connections: add your OpenAI-compatible API key or Ollama server.
```

## Image tags

`ghcr.io/open-webui/open-webui:main` (the recommended stable image; GHCR is the primary registry, `vX.Y.Z` tags exist for pinning). The full image (~1.6 GB) includes the local embedding, speech and document models, so document chat (RAG) works out of the box. `:slim` (~200 MB, ~300 MB RAM) would fit Q1, but document search then needs an external embedding engine (`RAG_EMBEDDING_ENGINE=openai` plus a key).

## First login

1. Open the address and create the admin account (the first account is the admin; sign-up closes after it).
2. **Admin Panel → Settings → Connections**: add an OpenAI-compatible API (OpenAI, OpenRouter, OmniRoute…) or an Ollama server.
3. To invite others: Admin → Authentication → enable *New Sign Ups*; new users wait as *Pending* until approved.

## Admin checks

- `WEBUI_URL` and `CORS_ALLOW_ORIGIN` are the public HTTPS address; Open WebUI warns that WebSockets fail silently when `CORS_ALLOW_ORIGIN` doesn't match.
- `WEBUI_SECRET_KEY` is fixed per install, so users stay logged in across restarts and reinstalls.
- `ENABLE_OLLAMA_API: false`: no local Ollama in the VM, so Open WebUI doesn't keep trying `localhost:11434`. It's a first-start setting; the customer can turn Ollama on later in the admin panel. The VPS Pass **Ollama** app works as the server (its address plus its API key as Bearer key).
- **Streaming:** Open WebUI needs responses unbuffered and long timeouts (≥300 s). Traefik doesn't buffer; if answers arrive all at once or cut off after a minute, check Zoraxy's buffering/timeouts.
- RAM 1 GB: the app plus the local embedding model when documents are used. Free from Q2, like the other AI apps.

## Paid products

Needs a **Q1 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q2 and Q3. Price not set yet.
